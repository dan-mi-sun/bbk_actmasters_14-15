require "pry-byebug"

#KEY:  gathers person keys
#
#{person_id,{PR,{#out-links,[adjacency-list]}}
#VALUE: creates adjacency list for trusts (links-out)
# => calculates total number of trusts for person
# => logs pagerank for person
# => creates adjacency list of danglers
# => removes mentions of danglers from trusts adjacency list
# => logs total_nodes (N) - #_of_danglers

class Network

  def initialize
  end

  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/epinions.txt"
  end

  def create_map
    network_map = {}
    pagerank = 1
    outlink = 1

    recommendation = File.open(self.test_file_path, "r")
    recommendation.each_line do |r|
      trusts = r.chomp!
      (key, value) =  trusts.split(/\t/)

      if network_map.has_key?(key)
        #{person-key,{PR,{#out-links,[adjacency-list]}}
        #if it has the key then add it on to the end increase outlink counter by one
        outlink = outlink += 1
        temp = network_map[key][pagerank]
        #change outlink counter key
        network_map[key][pagerank] = temp.inject({ }){ |x, (k,v)| x[k = outlink] = v; x }
        #append the destination (value) to the adjacencylist array
        network_map[key][pagerank][outlink].push(value)
      else
        outlink = 1
        network_map[key] ||= {}
        network_map[key].merge!(pagerank => {})
        network_map[key][pagerank].merge!(outlink => [value])
      end
    end
    return network_map
  end

  def create_danglers_library
    #go through all people and if # is missing then add to map
    n = Network.new
    network_map = n.create_map

    danglers_library = []
    counter = 0

    network_map.each do |person, data|
      #each time counter is incremented and there is not a matching person_id
      #add to the danglers_library
      if person.to_i == counter
        #if counter is the same as person then do nothing
      elsif person.to_i > counter
        #add one to the counter until level with person_id
        until counter == person.to_i do 
          danglers_library << counter
          counter += 1
        end
      end
    end
    return danglers_library
  end

  def remove_danglers
    n = Network.new
    network_map = n.create_map
    danglers = n.create_danglers_library

    #{person-key,{PR,{#out-links,[adjacency-list]}}
    network_map.each do |person, data|
      data.each do |pagerank, outlink_info|

        adjacency_list = outlink_info.values[0]
        #compare adjacencey_library (AL) with danglers (D)
        #if AL contains a D remove it
        #if AL does NOT contain a D then do nothing
        adjacency_list.each_index do |i|
          if danglers.include? network_map[person][pagerank].values[0][i].to_i
            network_map[person][pagerank].values[0][i] = nil
          end
        end
      end
    end
    return network_map
  end

  # def total_active_nodes
  #   # => logs total_nodes (N) - #_of_danglers
  #   nodes = 75879
  #   danglers = Network.new.create_danglers_library.length
  #   total = nodes - danglers 
  #   return total
  # end

  def output_network_map
    network = Network.new.remove_danglers
    network.each do |person_id, data|
      puts "#{person_id} #{"\t"} #{data} #{"\t"}"
    end
  end

end

n = Network.new.output_network_map
