require 'pry-byebug'
# Ruby code for Stripes method map.rb
#

#Read in text.
# ARGF.each do |text|
# as paragraphs and replace new line characters with " "
paragraphs = ARGF.each("\r\n\r\n").map{|p| p.gsub("\r\n"," ")}

#iterate throug the paragraphs
paragraphs.each do |text|

  #Test code locally
  # f = File.open("/Users/dan_mi_sun/projects/bbk_actmasters_14-15/cloudcomputing_BBK_BUCI029H7_1415/question_1/test-txt-files/jane-test.txt")

  #0.Split text into lines 
  # f.each_line do |text|

  #Create Associative Array
  #
  h = {}
  #split text into paragraphs and convert all words to lowercase
  #
  # paragraph = text.gsub!(/[^0-9a-z ]/i, '').split(" ").map!{ |w| w.downcase}
  #remove non-alphanumeric characters and create a word array
  #
  begin
  words = text.gsub!(/[^0-9a-z ]/i, ' ')
  rescue NoMethodError => ex
    puts "Exception: #{ex.message} hit on the following words: #{words}"
    splitted = words.split(" ")
  rescue NoMethodError => ex
    puts "Exception: #{ex.message} hit on the following words: #{words}"
  rescue NoMethodError => ex
    puts "Exception: #{ex.message} hit on the following words: #{words}"
  end

  if paragraph.size == 0 
    word_array = ['']
  else
    # word_array = paragraph[0].gsub!(/[^0-9a-z ]/i, '')
    word_array = paragraph
  end
  #iterate over array of words
  #
  word_array.each_with_index {|word, i|
    #check to see if we should duck out the interation and return the associative hash
    #
    if i == (word_array.size) -1 
      break
    else
      #assign neighbour
      #
      neighbour = word_array[i + 1] 
      #if hash has word key
      #
      if h.has_key?(word) 
        #and if word key has neighbour
        #
        if h[word].has_key?(neighbour)
          #find out current value of neighbour
          #
          v = h[word][neighbour] 
          #add 1 to neighbour count
          #
          h[word] = {neighbour => (v + 1) } 
          #else append neighbour key & set count at 1
          #
        else 
          h[word].merge!(neighbour => 1)
        end
        #else add word with {} && add neighbour key && set count at 1
        #
      else 
        h[word] = {} && h[word] = {neighbour => 1}
      end
    end
  }
  #output to STDOUT
  #<key><tab><value><newline>
  #
  h_array = h.to_a
  h_array.each { |pairs|
    key = pairs[0]
    value =  pairs[1]
    puts key + "\t" + value.to_s
  }
end
