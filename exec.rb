require 'yaml'
require './main.rb'

filepath = ARGV.first
file = File.basename filepath, ".*"

pizza = Pizza.new(filepath)
cutter = PizzaCutter.new(pizza)
begin
cutter.cut_pizza
rescue SignalException => e
	File.write("output/%s.yml" % file, YAML.dump(cutter))
	puts e.class
end

cutter.save_result("output/%s.txt" % file)
