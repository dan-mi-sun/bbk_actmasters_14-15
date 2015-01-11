require 'pry-byebug'
# Ruby code for Stripes method map.rb
# 
#Read in text from STDIN and set split point as paragraphs as denoted by newline
begin
  paragraphs = ARGF.each("\r\n\r\n")
rescue NoMethodError => e
  puts "Exception: #{e.message} hit on the following paragraphs: #{paragraphs}"
end

#remove non alphanumeric characters and carriage returns at the end of the line
paragraphs = paragraphs.map{|p| p.gsub("/\W|\r\n"," ")}

paragraphs.each do |text|

  #Create Associative Array
  associative_map = {}

  #split text into paragraphs and convert all words to lowercase
  #remove non-alphanumeric characters and create a word array
  #
  begin
    words = text.gsub!(/[^0-9a-z ]/i, ' ')
  rescue NoMethodError => ex
    puts "Exception: #{ex.message} hit on the following words: #{text}"
    puts "Exception: #{ex.message} hit on the following words: #{text.class}"
  end

  begin
    splitted = words.split(" ")
  rescue NoMethodError => ex
    puts "Exception: #{ex.message} hit on the following words: #{text}"
    puts "Exception: #{ex.message} hit on the following words: #{text.class}"
  end

  begin
    paragraph = splitted.map!{ |w| w.downcase}
  rescue NoMethodError => ex
    puts "Exception: #{ex.message} hit on the following words: #{text}"
    puts "Exception: #{ex.message} hit on the following words: #{text.class}"
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
      if associative_map.has_key?(word) 
        #and if word key has neighbour
        #
        if associative_map[word].has_key?(neighbour)
          #find out current value of neighbour
          #
          v = associative_map[word][neighbour] 
          #add 1 to neighbour count
          #
          associative_map[word] = {neighbour => (v + 1) } 
          #else append neighbour key & set count at 1
          #
        else 
          associative_map[word].merge!(neighbour => 1)
        end
        #else add word with {} && add neighbour key && set count at 1
        #
      else 
        associative_map[word] = {} && associative_map[word] = {neighbour => 1}
      end
    end
  }
  #output to STDOUT
  #<key><tab><value><newline>
  #
  map_output = associative_map.to_a
  map_output.each { |pairs|
    key = pairs[0]
    value =  pairs[1]
    puts key + "\t" + value.to_s
  }
end
