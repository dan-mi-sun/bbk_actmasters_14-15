require 'pry-byebug'
# class Network
#
#   attr_reader :iterations, :dampner
#
#   def initialize(number_of_iterations, dampner)
#     @iterations, @dampner = number_of_iterations, dampner
#   end
#
# end
#
#
# class Person
#
#   attr_accessor :rank, :dangler
#
#   def initialize(id, rank, trusts, dangler)
#     @id, @rank, @trusts, @dangler = id, rank, trusts, dangler
#   end
#
# end

#Read in epionions data and emit in hadoop streaming format

# ARGF.each do |recommendation|
f = File.open("/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/test.txt", "r")

f.each_line do |recommendation|
  r = recommendation.chomp!
  (key, value) = r.split(/\t/)
  puts key + "\t" + value + "\t"

end
