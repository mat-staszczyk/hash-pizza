class Pizza
  attr_reader :pizza_arr, :settings

  def initialize(file_path)
    data = File.readlines(file_path)
    @settings = {}
    @settings[:rows], @settings[:columns], @settings[:min_ings], @settings[:max_cells] = data.shift.split.map(&:to_i)
    @pizza_arr = data.map { |x| x.strip.chars }
  end

  def verify_size
    puts "#{@pizza_arr.size} x #{@pizza_arr.first.size}"
  end
end

class PizzaCutter
  def initialize(pizza)
    @pizza = pizza.pizza_arr.dup
    @slices = []
    @temp_slices = []
    @settings = pizza.settings
    # testing
    pizza.verify_size
  end

  def take_slice
    right_slices = find_slices(@settings[:min_ings], @settings[:max_cells])
    best_slice = choose_best_slices(right_slices)
    cut_slice(best_slice)
    add_slice(best_slice)
  end

  private 

    def find_slices(min_ings, max_cells)
      # find the best possible slice
    end

    def compare_slices(slices)
      # choose the best possible slice of the current try 
    end

    def cut_slice(slice)
      # replaces chosen 'M's and 'T's with nils
    end

    def add_slice(slice)
      @slices << slice
    end 
end

pizza = Pizza.new(ARGV.first)
cutter = PizzaCutter.new(pizza)
