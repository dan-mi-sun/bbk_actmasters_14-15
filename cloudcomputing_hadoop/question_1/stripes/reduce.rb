require 'pry-byebug'

# Ruby code for Stripes method reduce.rb
#

#create data structure within which to do internal corresponding value addition
#
merging_container = {}

#Read in each line of text.
ARGF.each do |line|

  # remove any newline
  line = line.chomp

  # split key and value on tab character
  (key, value) = line.split(/\t/)


  #remove non-alphanumeric chars from value string and turn into array
  a = value.gsub!(/[^0-9a-z ]/i, ' ').split(' ')

  #turn values array into a hash of key value pairs
  h = Hash[a.each_slice(2).to_a]

  #if the key already exists then append
  #
  if merging_container.has_key?(key)

    #set top level key for use within inner hash loop
    _key = key

    #look to see if the h contains an existing inner key with an additional value 
    #
    h.each do |key, value|

      if merging_container[_key].has_key?(key)
        #if key exists in inner hash then add the value to the existing entry within the merging container
        merging_container[_key][key] =  merging_container[_key][key].to_i + value.to_i

      else
        merging_container[_key].merge!(key => value)
      end
    end

  else
    #if the key does not already exist then make new entry
    #add key and values to merging container
    #set top level key for use within inner hash loop
    _key = key

    #add key value pairs to data structure
    h.each do |key, value|
      #add top level key to merging container
      #
      merging_container[_key] ||= {}

      #add inner key and value to top level key
      #
      merging_container[_key].merge!(key => value)
      # merging_container[_key][key] = value

    end
  end
end

merging_container.each do |key, value|
  # if key == "1500"
  _key = key
  value.each do |k, v|
    puts _key + "\t" + k + "\t" + v.to_s
  end
end
