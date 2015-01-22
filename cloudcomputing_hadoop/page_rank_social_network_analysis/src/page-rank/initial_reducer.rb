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
end

class Person

  # attr_accessor :rank, :dangler

  def initialize #(id, rank, trusts, dangler)
    # @id, @rank, @trusts, @dangler = id, rank, trusts, dangler
  end

  def import_network_map
    n = Network.new
    network_map = n.create_map
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
# => logs total_nodes (N) - #_of_danglers

p = Person.new
p.set_initial_page_rank
