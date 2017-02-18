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

  def tomatoes_count
    @pizza_arr.flatten.count('T')
  end

  def mushrooms_count
    @pizza_arr.flatten.count('M')
  end
end

class PizzaCutter
  attr_reader :slices, :pizza, :pizza_left, :pointer

  def initialize(pizza)
    @pizza = pizza.pizza_arr
    @tomatoes = pizza.tomatoes_count
    @mushrooms = pizza.mushrooms_count
    @slices = []
    @settings = pizza.settings
    @pointer = [0, 0] #start in the bottom left corner of the pizza, so that it resembles the coordinate system
    @FINAL_POINTER = [@settings[:rows]-1, @settings[:columns]-1]
    @pizza_left = @settings[:rows] * @settings[:columns]
    # testing
    pizza.verify_size
  end

  def cut_pizza
    until @pizza_left.zero? || out_of_moves || @mushrooms < @settings[:min_ings] || @tomatoes < @settings[:min_ings] do
      take_slice 
    end 
    @slices.count
  end

  def take_slice
    slice = find_slice(@settings[:max_cells])
    if slice
      cut_slice(slice) 
      serve_slice(slice)
    end
    set_pointer
  end

  private

    def find_slice(area)
      # find the first possible slice
      rects = all_possible_rectangles(area)
      pointer_row = @pointer[0]
      pointer_col = @pointer[1]
      rects.map! { |r| [pointer_row, pointer_col, 
                        pointer_row + r[0] - 1, 
                        pointer_col + r[1] - 1] }
      rects.detect { |r| is_valid?(r) }
    end

    def cut_slice(slice)
      #slice represented as an array [x0, x1, y0, y1]
      x0, y0, x1, y1 = slice
      (x0..x1).each do |x| 
        rows_to_cut = y1 - y0 + 1
        @pizza[x][y0..y1] = Array.new(rows_to_cut)
        @pizza_left -= rows_to_cut 
        @tomatoes = @pizza.flatten.count('T')
        @mushrooms = @pizza.flatten.count('M')
      end
    end

    def serve_slice(slice)
      @slices << slice
    end

    def is_valid?(slice)
      #slice represented as an array [x0, x1, y0, y1]
      return false unless in_range?(slice)
      x0, y0, x1, y1 = slice
      section = @pizza[x0..x1]
      ing_count = [0, 0]
      section.each do |row|
        subsection = row[y0..y1]
        return false unless subsection.all? # no holes
        ing_count[0] += subsection.count('T')
        ing_count[1] += subsection.count('M')
      end
      ing_count.min == @settings[:min_ings] and (x1 - x0) * (y1 - y0) <= @settings[:max_cells]
    end

    def in_range?(slice)
      r0, c0, r1, c1 = slice
      r1 < @settings[:rows] && c1 < @settings[:columns]
    end 

    def possible_rectangles(area)
      ary = (1..area).find_all {|x| area % x == 0}
      ary.map! {|x| [x, ary.pop]}
      ary += ary.map(&:reverse)
      ary.sort_by {|rectangle| rectangle.reduce(:+)}
    end

    def all_possible_rectangles(area)
      ary = []
      (2..area).each do |i|
        ary += possible_rectangles(i)
      end
      ary.uniq.sort.reverse
    end

    def out_of_moves
      @pointer == @FINAL_POINTER
    end

    def d_set_pointer
      # Todo: find the next available pointer greater than current one
      @pizza.each_with_index do |row, r|
        c = row.find_index { |x| x }
        @pointer = [r,c]
        return @pointer if c
      end
    end

    def set_pointer
      return @pointer if out_of_moves 
      pointer_r, pointer_c = @pointer[0], @pointer[1]
      if @pointer[1] == @settings[:columns]-1
        pointer_r += 1
        pointer_c = 0
      else
        pointer_c += 1
      end

      @pointer = [pointer_r, pointer_c]
      set_pointer unless @pizza[pointer_r][pointer_c]
      @pointer
    end

end

