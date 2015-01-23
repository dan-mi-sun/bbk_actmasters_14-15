require 'pry-byebug'

Person = Struct.new(:person_id, :pagerank, :number_of_outlinks, :adjacency_list) do

  #this would actually need to be input from STDIN
  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/temp"
  end

  def import_network_map
    temp = File.open(self.test_file_path, "r")
    temp.each_line do |r|
      person_data = r.chomp!
      (person_id, data) = person_data.split(/\t/)

      person_id = person_id.to_i
      recommended = data.gsub!(/[^0-9a-z ]/i, ' ').split(' ')
      page_rank = recommended.slice!(0).to_f
      number_of_outlinks = recommended.slice!(0).to_i

      if recommended.include? "nil"
        counter = Hash.new(0)
        # recommended.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
        recommended.each {|value| counter[value] += 1 }
        danglers = counter["nil"]
        number_of_outlinks = number_of_outlinks - danglers
      end
      person = Person.new(person_id, page_rank, number_of_outlinks, recommended )
      returns person
    end
  end

end

def set_initial_page_rank
  #need to intake the Network.create_map and the go through each Person
  #this is the starting PR / #outlinks
  p = Person.new.import_network_map
  binding.pry
  puts "help set the PR"
  network_map = p.import_network_map
  # puts "this is the network_map: #{network_map}"
  network_map.each do |person, data|
    page_rank = nil
    # initial_pagerank = data.first[0].to_i
    data.each do |initial_pagerank, link_data|
      total_outlinks = link_data.first[0].to_i
      page_rank = (initial_pagerank.to_f) / total_outlinks
      #set new pagerank within person's data
      # puts "this is inside the inner_map"
    end
    #now need to set new value within the refreshed network map
    data = data.inject({ }){ |x, (k,v)| x[k = page_rank] = v; x }
    network_map[person] = data
    # puts "this is inside the map #{page_rank}"
  end
  # puts "#{network_map}"
  return network_map
end

# def remove_counted_danglers
#   #take output from remove_danglers and subtract #danglers from the total
#   network = Network.new.remove_danglers
#
#   total_minus_danglers = nil
#   #{person-key,{PR,{#out-links,[adjacency-list]}}}
#   network.each do |person_id, data|
#     counter = 0
#     data.each do |pagerank, outlink_info|
#       outlink_info.each do |count, adjacency_list|
#         adjacency_list.each do |i|
#           if i == nil  
#             counter +=1 
#             # binding.pry
#             puts "this is here"
#           else
#             # binding.pry
#             puts "this is from the else"
#           end
#         end
#         total_minus_danglers = count - counter
#       end
#     end
#     temp = network.first[1].first[1]
#     temp = temp.inject({ }){ |x, (k,v)| x[k = total_minus_danglers] = v; x }
#     binding.pry
#     puts "help"
#   end 
#   puts "#{network}"
#   return network
# end
#
p = Person.new.set_initial_page_rank
