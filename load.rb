f = File.readlines(ARGV.first)
rows, columns, min, max = f.shift.split.map {|x| x.to_i} #bo w pierwszej linii są parametry
pizza = f.map {|x| x.strip.chars}
