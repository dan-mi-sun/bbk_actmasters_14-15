# Ruby code for Stripes method reduce.rb

#create data structure within which to do internal corresponding value addition
merging_container = {}

ARGF.each do |line|
  # remove any newline
  line = line.chomp

  # split key and value on tab character
  (key, value) = line.split(/\t/)

  #remove non-alphanumeric chars from value string and turn into array
  values = value.gsub!(/[^0-9a-z ]/i, ' ').split(' ')

  #turn values array into a hash of key value pairs
  values_hash_map = Hash[values.each_slice(2).to_a]

  #set top level key for use within inner hash loop
  _key = key

  if merging_container.has_key?(key)
    #look to see if the values_hash_map contains an existing inner key with an additional value 
    values_hash_map.each do |key, value|

      if merging_container[_key].has_key?(key)
        #if key exists in inner hash then add the value to the existing entry within the merging container
        merging_container[_key][key] =  merging_container[_key][key].to_i + value.to_i
      else
        merging_container[_key].merge!(key => value)
      end
    end

  else
    #if the key does not already exist then make new entry
    values_hash_map.each do |key, value|
      #add top level key to merging container
      merging_container[_key] ||= {}

      #add inner key and value to top level key
      merging_container[_key].merge!(key => value)
    end
  end
end

w_count = {}
key_total = 0

merging_container.each do |key, value|
  key_total = 0
  w_count[key] = {}
  prev_inner_key = nil
  value.each do |k, v|
    key_total += v.to_i
    if key_total > 1
      #why the fuck is this not working
      w_count[key].inject({ }){ |x, (k,v)| x[k = key_total] = v; x }
      w_count[key][prev_inner_key].merge!(k => v)
      puts "if the key total is bigger than 1"
    else
      # key_total = key_total.to_s
      w_count[key][key_total] ||= {}
      w_count[key][key_total].merge!(k => v)
      binding.pry
      puts "this is inside the else"
    end
    prev_inner_key = key_total·
    puts "this is the end my freind"
  end
  # puts _key + "\t" + k + "\t" + v.to_s
end

#calculate the conditional probability that a word w′ occurs immediately after another word w, i.e.,
##Pr[w′|w] = count(w, w′)/count(w)
##for each two-word-sequence (w,w′)
