require 'pry-byebug'

Person = Struct.new(:intermediate_id, :attributes) do

  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/hjt"
  end

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

  def sum_pagerank(data)
    thing = {}
    data.each do |d|
      if thing.has_key? d.intermediate_id
        begin
          thing[d.intermediate_id] += d[:attributes][:pagerank]
        rescue NoMethodError => ex
          puts "Exception: #{ex.message} hit on the following id: #{d.intermediate_id} with attribute: #{d.attributes[:pagerank]}"
        end
      else
        thing[d.intermediate_id] = d[:attributes][:pagerank]
      end
    end
    thing[:info] = data
    return thing
  end

  def update_referer_pagerank(data)
    set = data[:info]
    data.each do |d|
      set.each_with_index do |thing, i|
        if (d[0] == thing[:attributes][:id])
          set[i][:attributes][:pagerank] = d[1]
        end
      end
    end
    return set
  end

  def remove_duplicates(data)
    output = [] 
    data.each do |p|
      temp = p.attributes.tap { |hs| hs.delete(:intermediate_id) }
      if output.empty?
        output << temp
      elsif output.include? temp
        #do nothing
      else 
        output << temp
      end
    end
    return output
  end

  def emit(person)
    person.each do |p|
      puts "#{p}"
    end
  end

end

p = Person.new
p.emit(p.remove_duplicates(p.update_referer_pagerank(p.sum_pagerank(p.import_data))))
