require "pry-byebug"

Network = Struct.new(:id, :pagerank, :number_of_outlinks, :adjacency_list, :number_of_nodes) do

  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/epinions.txt"
  end

  def create_map
    network_map = []
    pagerank = 1
    number_of_nodes = 75879
    counter = 0

    recommendation = File.open(self.test_file_path, "r")
    recommendation.each_line do |r|
      trusts = r.chomp!
      (key, value) =  trusts.split(/\t/)
      id = key.to_i

      if network_map.empty? # then set the first item
        outlink = 1
        network_map << Network.new(id, pagerank, outlink, [value.to_i], number_of_nodes)

      elsif network_map[counter][:id] == id
        network_map[counter][:number_of_outlinks] += 1
        network_map[counter][:adjacency_list] << value.to_i

      else 
        outlink = 1
        counter += 1
        network_map << Network.new(id, pagerank, outlink, [value.to_i], number_of_nodes)
      end
    end
    return network_map
  end

  def create_referers_library(data)
    referers_library = []
    data.each do |d|
      if referers_library.include? d[:id]
        #do nothing
      else
        referers_library << d[:id]
      end
    end
    return referers_library
  end

  def create_danglers_library(data, referers)
    # number_of_nodes = data[0][:number_of_nodes] 
    number_of_nodes = 1000 
    referers_library = referers
    danglers_library = []
    counter = 0

    number_of_nodes.times do |i|

      if referers_library.include? i
        #do nothing
        counter += 1
      else
        danglers_library << counter
        counter += 1
      end
    end
    return danglers_library
  end

  def remove_danglers(data, danglers)
    danglers = danglers

    data.each do |d|
      d[:adjacency_list].each_with_index do |person, i|

        if danglers.include? person
          d[:adjacency_list][i] = nil
        end
      end
    end
    return data
  end

  # def total_active_nodes
  #   # => logs total_nodes (N) - #_of_danglers
  #   nodes = 75879
  #   danglers = Network.new.create_danglers_library.length
  #   total = nodes - danglers 
  #   return total
  # end

  def attributes
    result = {}
    members.each do |name|
      result[name] =  self[name]
    end
    result
  end

  def emit(data)
    data.each do |d|
      puts "#{d.attributes}"
    end
  end

end

n = Network.new
n.emit(n.remove_danglers(n.create_map, n.create_danglers_library(n.create_map, n.create_referers_library(n.create_map))))
