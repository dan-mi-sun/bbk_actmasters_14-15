require 'pry'
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

  #split line into words
  line.split(' ').each do |word|

    #if hash has word key
    if h.has_key?(word) 
      #if word key has neighbour
      if h.word(neighbour)
        #add 1 to neighbour count
        h[neighbour] = {:example => 'ADD_VALUE_TO_COUNT'} 
        #else add neighbour key & set count at 1

      end
      #else add word with {} && add neighbour key && set count at 1
    else 
      h[word] = {}
      h[word] = :neighbour  
    end

  end


end
