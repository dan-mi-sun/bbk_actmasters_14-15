require 'pry-byebug'
# Ruby code for Stripes method reduce.rb
#

#
#Test code locally
 f = File.open("/Users/dan_mi_sun/projects/bbk_actmasters_14-15/cloudcomputing_BBK_BUCI029H7_1415/question_1/test-txt-files/reduce-input.txt", "r")

prev_key = nil
key_total = 0
f.each_line do |line|
  binding.pry

#Read in each line of text.
# ARGF.each do |line|
  # remove any newline
  line = line.chomp

  # split key and value on tab character
  (key, value) = line.split(/\t/)

  # check for new key
  if prev_key && key != prev_key && key_total > 0

    # output total for previous key

    # <key><tab><value><newline>
    puts prev_key + "\t" + key_total.to_s

    # reset key total for new key
    prev_key = key
    key_total = 0

  elsif ! prev_key
    prev_key = key

  end

  # add to count for this current key
  key_total += value.to_i
end


