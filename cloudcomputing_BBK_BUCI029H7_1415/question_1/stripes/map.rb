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
  line = line.chomp
  #split line into array of words
  word_array = line.split(' ')
  #iterate over array of words
  word_array.each_with_index {|word, i|
    #change word to lower case
    word = word.downcase
    #assign neighbour
    neighbour = word_array[i + 1] unless i = (word_array.length) - 2
    #catch error if neighbour is nil
    # next if neighbour.nil?

    #if hash has word key
    if h.has_key?(word) 
      #if word key has neighbour
      if h[word].has_key?(neighbour)
        #find out current value of neighbour
        v = h[word][neighbour] 
        #add 1 to neighbour count
        h[word] = {neighbour => (v + 1) } 
        #else add neighbour key & set count at 1
      else 
        h[word] = {neighbour => 1}
      end
      #else add word with {} && add neighbour key && set count at 1
    else 
      h[word] = {} && h[word] = {neighbour => 1}
    end
  }
print h
end
