require "pry-byebug"

class Network

  # attr_reader :iterations, :dampner

  def initialize #(number_of_iterations, dampner)
    # @iterations, @dampner = number_of_iterations, dampner
  end

  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/output.txt"
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
        #if it has the key then add it on to the end 
        #increase outlink counter by one
        outlink = outlink += 1
        temp = network_map[key][pagerank]
        #change outlink counter key
        network_map[key][pagerank] = temp.inject({ }){ |x, (k,v)| x[k = outlink] = v; x }
        #append the destination (value) to the adjacencylist array
        network_map[key][pagerank][outlink].push(value)
        # binding.pry
        # puts "this is the if with key #{key}"
      else
        #{person-key,{PR,{#out-links,[adjacency-list]}}
        outlink = 1
        network_map[key] ||= {}
        network_map[key].merge!(pagerank => {})
        network_map[key][pagerank].merge!(outlink => [value])
        # binding.pry
        # puts "this is the else"
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
        until counter == (person.to_i - 1) do 
          counter += 1
          danglers_library << counter
        end
      end
    end
    # puts "#{danglers_library}"
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
        adjacency_list.each do |recommended|
          if danglers.include? recommended.to_i
            network_map[person][pagerank].values[0].delete(recommended)
          else
            #
          end
        end
      end
    end
    # puts "#{network_map}"
    return network_map
  end
  
  def total_active_nodes
    # => logs total_nodes (N) - #_of_danglers
    nodes = 3
    danglers = Network.new.create_danglers_library.length
    total = nodes - danglers 
    return total
  end

end

class Person

  # attr_accessor :rank, :dangler

  def initialize #(id, rank, trusts, dangler)
    # @id, @rank, @trusts, @dangler = id, rank, trusts, dangler
  end

  def import_network_map
    n = Network.new
    network_map = n.remove_danglers
    return network_map
  end

  def set_initial_page_rank
    #need to intake the Network.create_map and the go through each Person
    #this is the starting PR / #outlinks
    p = Person.new
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
    puts "#{network_map}"
    return network_map
  end

end

#KEY:  gathers person keys
#
#{person-key,{PR,{#out-links,[adjacency-list]}}
#VALUE: creates adjacency list for trusts (links-out)
# => calculates total number of trusts for person
# => logs pagerank for person
# => creates adjacency list of danglers
# => removes mentions of danglers from trusts adjacency list
# => logs total_nodes (N) - #_of_danglers    <------------- NOW FIGURE OUT THIS do this at the network level

# p = Person.new
# p.set_initial_page_rank
n = Network.new
n.total_active_nodes

