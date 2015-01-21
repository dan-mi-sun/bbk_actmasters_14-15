require "pry-byebug"

class Network

  attr_reader :iterations, :dampner

  def initialize #(number_of_iterations, dampner)
    # @iterations, @dampner = number_of_iterations, dampner
  end

  def test_file_path
    "/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/output.txt"
  end

  def output_recommendations
    recommendation = File.open(self.test_file_path, "r")
    recommendation.each_line do |r|
      trusts = r.chomp!
      (key, value) =  trusts.split(/\t/)
      puts key + "\t" + value + "\t"
    end
  end
end


class Person

  attr_accessor :rank, :dangler

  def initialize(id, rank, trusts, dangler)
    @id, @rank, @trusts, @dangler = id, rank, trusts, dangler
  end

end

#KEY:  gathers person keys
#VALUE: creates adjacency list for trusts (links-out)
# => calculates total number of trusts for person
# => logs pagerank for person
# => creates adjacency list of danglers
# => removes mentions of danglers from trusts adjacency list
# => logs total_nodes (N) - #_of_danglers


# ARGF.each do |recommendation|
# f = File.open("/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/output.txt", "r")
#
# f.each_line do |recommendation|
#   r = recommendation.chomp!
#   puts key + "\t" + value + "\t"
#
# end

n = Network.new 
n.output_recommendations
