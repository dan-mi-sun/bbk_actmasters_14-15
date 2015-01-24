require 'pry-byebug'

Person = Struct.new(:id, :pagerank, :number_of_outlinks, :adjacency_list) do

  #this would actually need to be input from STDIN
  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/temp"
  end

  def import_person_data
    temp = File.open(self.test_file_path, "r")
    person = []
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
      person << Person.new(id, page_rank, number_of_outlinks, adjacency_list )
    end
    return person
  end

  def set_intermediate_referee_pagerank(person)
    intermediate_pagerank = []
    person.each do |p|
      p.pagerank = p.pagerank / p.number_of_outlinks
      intermediate_pagerank << p
    end
    return intermediate_pagerank
  end

  def attributes
    result = {}
    members.each do |name|
      result[name] =  self[name]
    end
    result
  end

  def emit(person)
    person.each do |p|
      puts "#{p.attributes}"
    end
  end


end

p = Person.new
p = p.emit(p.set_intermediate_referee_pagerank(p.import_person_data))

