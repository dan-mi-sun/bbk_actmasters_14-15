require 'pry-byebug'

Person = Struct.new(:id, :pagerank, :number_of_outlinks, :adjacency_list) do

  #this would actually need to be input from STDIN
  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/temp"
  end

  def import_person_data
    temp = File.open(self.test_file_path, "r")
    person = nil
    temp.each_line do |r|
      person_data = r.chomp!
      (person_id, data) = person_data.split(/\t/)

      id = person_id.to_i
      adjacency_list = data.gsub!(/[^0-9a-z ]/i, ' ').split(' ')
      page_rank = adjacency_list.slice!(0).to_f
      number_of_outlinks = adjacency_list.slice!(0).to_i

      #smell to remove any danglers from counted outlinks

      if adjacency_list.include? "nil"
        counter = Hash.new(0)
        adjacency_list.each {|value| counter[value] += 1 }
        danglers = counter["nil"]
        number_of_outlinks = number_of_outlinks - danglers
      end
      person = Person.new(id, page_rank, number_of_outlinks, adjacency_list )
    end

    return person
  end

  #this should take in the exact same as import data outputs
  def set_intermediate_referee_pagerank
    person = Person.new.import_person_data
    person.pagerank = person.pagerank / person.number_of_outlinks
    return person
  end

  # def set_intermediate_key_pagerank
  #   person = Person.new.set_intermediate_referee_pagerank
  #   al = person.adjacency_list
  #   pr = person.pagerank
  #   person.adjacency_list = Hash[al.map {|key| [key, pr]}]
  #   return person
  # end

  #TODO <---- the aim is to figure out what should be the 
  #output format for the mapper to the reducer

  # def emit
  #   #need k_1
  #   #PR for k_1
  #   #value from step 1
  #   #iteration #
  #   person = Person.new.set_intermediate_key_pagerank
  #   al = person.adjacency_list
  #   al.each do |id, pr|
  #     binding.pry
  #     puts "#{id}"
  #
  #   end
  # end
  #
  # def output_network_map
  #   network = Network.new.remove_danglers
  #   network.each do |person_id, data|
  #     puts "#{person_id} #{"\t"} #{data} #{"\t"}"
  #   end
  # end

end

p = Person.new.set_intermediate_key_pagerank
