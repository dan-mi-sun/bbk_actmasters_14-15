require 'pry-byebug'
#Read in epionions data and emit in hadoop streaming format

# ARGF.each do |recommendation|
f = File.open("/Users/dan_mi_sun/projects/msc_advanced_computing_technologies/cloudcomputing_hadoop/page_rank_social_network_analysis/src/page-rank/test.txt", "r")

f.each_line do |recommendation|
  r = recommendation.chomp!
  (key, value) = r.split(/\t/)
  puts key + "\t" + value + "\t"

end
