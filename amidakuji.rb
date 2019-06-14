module Amidakuji
  class Tree
    def initialize(num_choices, steps = nil)
      @num_choices = num_choices
      @steps = steps || []
    end

    def to_matrix
      cols = @num_choices + (@num_choices - 1)
      rows = @num_choices + 2
      matrix = Matrix.new(rows, cols)
      (0...@num_choices).each do |i|
        if @steps.count == @num_choices
          head = i.to_s
          tail = ('a'..'z').to_a[i]
        else
          head = '█'
          tail = '█'
        end
        
        matrix[[i * 2, 0]] = head
        matrix[[i * 2, @num_choices + 1]] = tail
        (0...@num_choices).each do |j|
          matrix[[i * 2, j + 1]] = '│'
        end
      end
      @steps.each do |step|
        matrix[[step[0] * 2 + 1, step[1] + 1]] = '─'
      end
      matrix
    end

    def next_step
      loop do
        step = rand(@num_choices - 1), rand(@num_choices)
        unless @steps.include?(step) || @steps.include?([step[0] - 1, step[1]]) || @steps.include?([step[0] + 1, step[1]])
          return Tree.new(
            @num_choices, @steps + [step]
          )
        end
      end
    end

    def to_s
      to_matrix.to_s
    end

    private

    def max_choice
      @num_choices - 1
    end
  end

  class Matrix
    def initialize(rows, cols)
      @width = cols
      @matrix = Array.new(rows * cols, ' ')
    end

    def []=(coords, value)
      @matrix[coords_to_index(coords)] = value
    end

    def [](coords)
      @matrix[coords_to_index(coords)]
    end

    def to_s
      s = ''
      @matrix.each_index do |i|
        s << "\n" if i > 0 && (i % @width).zero?
        s << @matrix[i]
      end
      s
    end

    private

    def coords_to_index(coords)
      coords[1] * @width + coords[0]
    end
  end
end

