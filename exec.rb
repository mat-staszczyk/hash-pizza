require './main.rb'

pizza = Pizza.new(ARGV.first)
cutter = PizzaCutter.new(pizza)
cutter.take_slice
