require 'pry-byebug'
# Ruby code for Stripes method map.rb
#

#Read in each line of text.
# ARGF.each do |line|
#
#Test code locally
f = File.open("/Users/dan_mi_sun/projects/bbk_actmasters_14-15/cloudcomputing_BBK_BUCI029H7_1415/question_1/simple-words-test.txt", "r")

#0.Split paragraph into lines 
f.each_line do |line|
  #Create Associative Array
  h = {}
  #remove new line character
  line = line.chomp
  #split line into array of lower cased words
  word_array = line.split(' ').map!{ |w| w.downcase}
  #iterate over array of words
  word_array.each_with_index {|word, i|
    #check to see if we should duck out the interation and return the associative hash
    if i == (word_array.size) -1 
      print h
    else
      #assign neighbour
      neighbour = word_array[i + 1] 
      #if hash has word key
      if h.has_key?(word) 
        #and if word key has neighbour
        if h[word].has_key?(neighbour)
          #find out current value of neighbour
          v = h[word][neighbour] 
          #add 1 to neighbour count
          h[word] = {neighbour => (v + 1) } 
          #else append neighbour key & set count at 1
        else 
          h[word].merge!(neighbour => 1)
        end
        #else add word with {} && add neighbour key && set count at 1
      else 
        h[word] = {} && h[word] = {neighbour => 1}
      end
    end
  }
  #output to STDOUT
  #<key><tab><value><newline>
  h_array = h.to_a
  h_array.each { |pairs|
    key = pairs[0]
    value =  pairs[1]
    puts key + "\t" + value.to_s
  }
end
