require 'pry-byebug'

Person = Struct.new(:intermediate_id, :attributes) do

  #this would actually need to be input from STDIN
  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/t4p"
  end

  #gathers all keys
  #sum all k_1 values
  #update PR of the given referee withiin the attributes
  def import_data
    person = []
    temp = File.open(self.test_file_path, "r")
    temp.each_line do |r|

      data = r.chomp!

      (intermediate_id, attributes) = data.split(/\t/)

      attributes = eval(attributes)

      person << Person.new(intermediate_id.to_i, attributes)
    end
    return person
  end

  #if intermediate key exists then add to the total
  #if int_key DOES NOT extist then create entry and pull out pagerank
  def sum_pagerank(data)
    thing = {}
    data.each do |d|
      if thing.has_key? d.intermediate_id
        begin
          thing[d.intermediate_id] += d.attributes[:attributes][:pagerank]
        rescue NoMethodError => ex
          puts "Exception: #{ex.message} hit on the following id: #{d.intermediate_id} with attribute: #{d.attributes[:pagerank]}"
        end
      else
        thing[d.intermediate_id] = d.attributes[:attributes][:pagerank]
      end
    end
    thing[:info] = data
    return thing
  end

  def update_referer_pagerank(data)
    set = data[:info]
    data.each do |d|
      set.each_with_index do |thing, i|
        if d[0] == thing[:attributes][:id]
          set[i][:attributes][:pagerank] = d[1]
        end
      end
    end
    return set
  end


  def attributes
    result = {}
    members.each do |name|
      result[name] =  self[name]
    end
    result
  end

  #TODO <------- work on this as it needs to output same form as step 1
  def emit(person)
    person.each do |p|
      binding.pry
      p.adjacency_list.each do |k|
        binding.pry
        puts "#{k} #{"\t"} #{p.attributes} #{"\t"}"
      end
    end
  end
end

p = Person.new
# p.emit(p.sum_pagerank(p.import_data))
# p.sum_pagerank(p.import_data)
p.update_referer_pagerank(p.sum_pagerank(p.import_data))
