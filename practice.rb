$LOAD_PATH << '.'
require 'testing_module.rb'
require 'pry'

hash = Hash.new
hash["boobs"] = "tristan"
p hash
hash["Rosie"] = "the best"
p hash
hash["boobs"]["second"] = "second level"
p hash
