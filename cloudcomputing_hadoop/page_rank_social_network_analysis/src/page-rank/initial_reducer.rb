require "pry-byebug"


class Network

  # attr_reader :iterations, :dampner

  def initialize #(number_of_iterations, dampner)
    # @iterations, @dampner = number_of_iterations, dampner
  end

  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/output.txt"
  end

  def output_recommendations
    adjacency_list = {}
    recommendation = File.open(self.test_file_path, "r")
    recommendation.each_line do |r|
      trusts = r.chomp!
      (key, value) =  trusts.split(/\t/)
      if adjacency_list.has_key?(key)
        #if it has the key then add it on to the end 
      else
        adjacency_list[key] ||= {}
        #input the value here   <-----WORKING ON THIS
        binding.pry
        puts "this is the else"
      end
      adjacency_list = adjacency_list.merge!(key => value)
    end
    return adjacency_list
  end
end


class Person

  # attr_accessor :rank, :dangler

  def initialize #(id, rank, trusts, dangler)
    # @id, @rank, @trusts, @dangler = id, rank, trusts, dangler
  end

  def create_adjacency_list
    n = Network.new
    network_recommendations = n.output_recommendations
    puts "this is #{network_recommendations}"
  end

end

#KEY:  gathers person keys
#
#VALUE: creates adjacency list for trusts (links-out)
# => calculates total number of trusts for person
# => logs pagerank for person
# => creates adjacency list of danglers
# => removes mentions of danglers from trusts adjacency list
# => logs total_nodes (N) - #_of_danglers



p = Person.new
p.create_adjacency_list
