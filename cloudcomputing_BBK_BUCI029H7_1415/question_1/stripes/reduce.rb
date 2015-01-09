require 'pry-byebug'
# Ruby code for Stripes method reduce.rb
#

#
#Test code locally
f = File.open("/Users/dan_mi_sun/projects/bbk_actmasters_14-15/cloudcomputing_BBK_BUCI029H7_1415/question_1/test-txt-files/reduce-input-sorted.txt", "r")

prev_key = nil
key_total = 0
#create data structure within which to do internal corresponding value addition
#
merging_container = {}

f.each_line do |line|
  #Read in each line of text.
  # ARGF.each do |line|

  # remove any newline
  line = line.chomp

  # split key and value on tab character
  (key, value) = line.split(/\t/)

  puts "This is key #{key}"
  puts "This is value #{value}"

  #remove non-alphanumeric chars from value string and turn into array
  a = value.gsub!(/[^0-9a-z ]/i, ' ').split(' ')

  #turn values array into a hash of key value pairs
  h = Hash[a.each_slice(2).to_a]
  puts "This is h #{h}"

  #add key value pairs to data structure
  h.each do |key, value|

    if merging_container.has_key?(key)
      #find out the total of the value & add currency value to it
      merging_container[key] = merging_container[key].to_i + value.to_i
    else
      merging_container[key] = value
    end

    puts "This is merging container #{merging_container}"
    puts "#{'-' *30}"
  end


end


