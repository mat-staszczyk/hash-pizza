class Pizza
  attr_reader :rows, :columns, :min_ings, :max_cols, :pizza_arr

  def initialize(file_path)
    data = File.readlines(file_path)
    @rows, @columns, @min_ings, @max_cols = data.shift.split.map(&:to_i)
    @pizza_arr = data.map { |x| x.strip.chars }
    @slices = []
  end

  def verify_size
    puts "#{@pizza_arr.size} x #{@pizza_arr.first.size}"
  end
end

pizza = Pizza.new(ARGV.first)
pizza.verify_size
