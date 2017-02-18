require './main.rb'
filepath = ARGV.first
file = File.basename filepath

pizza = Pizza.new(filepath)
cutter = PizzaCutter.new(pizza)
cutter.cut_pizza

cutter.save_result("output/%s" % file.gsub(/\..+/, '.txt'))
