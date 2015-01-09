require 'pry-byebug'
# Ruby code for Stripes method reduce.rb
#

#
#Test code locally
f = File.open("/Users/dan_mi_sun/projects/bbk_actmasters_14-15/cloudcomputing_BBK_BUCI029H7_1415/question_1/test-txt-files/reduce-input-sorted.txt", "r")

#create data structure within which to do internal corresponding value addition
#
merging_container = {}

f.each_line do |line|
  #Read in each line of text.
  # ARGF.each do |line|

  # remove any newline
  line = line.chomp
  puts "this is the line: #{line}"

  # split key and value on tab character
  (key, value) = line.split(/\t/)

  puts "This is key #{key}"
  puts "This is value #{value}"

  #remove non-alphanumeric chars from value string and turn into array
  a = value.gsub!(/[^0-9a-z ]/i, ' ').split(' ')

  #turn values array into a hash of key value pairs
  h = Hash[a.each_slice(2).to_a]

  #if the key already exists then append
  #
  if merging_container.has_key?(key)
    puts "HELLO"
    puts "this is the key: #{key}"

    #set top level key for use within inner hash loop
    _key = key

    #look to see if the h contains an existing inner key with an additional value 
    #
    h.each do |key, value|
      puts "WHY HELLO"
      puts "this is the key:#{key}"
      puts "this is the _key:#{_key}"
      puts "this is the value:#{value}"

      if merging_container[_key].has_key?(key)
        puts "WHY WHY HELLO"
        #if key exists in inner hash then add the value to the existing entry within the merging container
        merging_container[_key][key] =  merging_container[_key].values.first.to_i + value.to_i
        puts "This is merging container #{merging_container}"
        puts "#{'-' *30}"

      else

      end
    end

  else
    #if the key does not already exist then make new entry
    #add key and values to merging container
    #
    puts "HELLO ELSE"
    puts "This is h #{h}"

    #set top level key for use within inner hash loop
    _key = key

    #add key value pairs to data structure
    h.each do |key, value|
      puts "WHY HELLO"
      puts "this is the key:#{key}"
      puts "this is the _key:#{_key}"
      puts "this is the value:#{value}"
      #add top level key to merging container
      #
      merging_container[_key] = {}

      #add inner key and value to top level key
      #
      merging_container[_key].merge!(key => value)

      puts "This is merging container #{merging_container}"
      puts "#{'-' *30}"
    end
  end
end
