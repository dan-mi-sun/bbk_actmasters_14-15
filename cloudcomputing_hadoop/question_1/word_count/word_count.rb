class Phrase
  attr_accessor :words

  def initialize(words)
    @words = words
  end

  def word_count
    each_word.each_with_object(Hash.new(0)) { |word, hash| hash[word] += 1 }
  end

  private
  def each_word
    words.downcase.scan(/\w+/)
  end

end
