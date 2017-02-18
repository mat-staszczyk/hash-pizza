require './main.rb'

pizza = Pizza.new(ARGV.first)
cutter = PizzaCutter.new(pizza)
cutter.cut_pizza
cutter.save_result("output/%s" % ARGV.first.gsub(/\..+/, '.txt'))
