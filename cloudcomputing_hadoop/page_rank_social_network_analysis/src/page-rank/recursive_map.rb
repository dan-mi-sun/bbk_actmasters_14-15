require 'pry-byebug'

Person = Struct.new(:id, :pagerank, :number_of_outlinks, :adjacency_list) do

  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/oipoi"
  end

  def import_person_data
    temp = File.open(self.test_file_path, "r")
    person = []
    temp.each_line do |r|
      person_data = r.chomp!
      data = person_data.split(/\t/)
      attributes = eval(data[0])

      id = attributes[:id]
      adjacency_list = attributes[:adjacency_list]
      page_rank = attributes[:pagerank]
      number_of_outlinks = attributes[:number_of_outlinks]

      person << Person.new(id, page_rank, number_of_outlinks, adjacency_list )
    end
    return person
  end

  def remove_adjacency_list_nil_counts(data)
    counter = 0
    data.each do |d|
      d[:adjacency_list].each do |l|
        if l == nil
          counter += 1
        end
      end
      d[:number_of_outlinks] = d[:number_of_outlinks] - counter 
      counter = 0
    end
    return data
  end

  def set_intermediate_referee_pagerank(person)
    intermediate_pagerank = []
    person.each do |p|
    p.pagerank = p.pagerank.to_f / p.number_of_outlinks
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
      p.adjacency_list.each do |k|
        if k != nil
          puts "#{k} #{"\t"} #{p.attributes} #{"\t"}"
        end
      end
    end
  end


end

p = Person.new
p = p.emit(p.set_intermediate_referee_pagerank(p.remove_adjacency_list_nil_counts(p.import_person_data)))
