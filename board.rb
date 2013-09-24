require "./piece"

module Chess
  class Board
    def initialize
      @grid = init_grid
    end

    def move(pos1, pos2)
    end

    def show_grid
      puts "  0 1 2 3 4 5 6 7"
      @grid.each_with_index do |row, index|
        print "#{index} "
        row.each do |piece|
          print piece ? piece : " "
          print " "
        end
        puts
      end
    end

    def dup
      raise "Cannot yet duplicate the board"
    end

    private

    def init_grid
      grid = Array.new(8) do
        Array.new(8) { nil }
      end

      {:black => [0, 1], :white => [7, 6]}.each do |color, row|
        8.times do |column|
          grid[row[1]][column] = Pawn.new(color, [row[1], column])
        end

        grid[row[0]][0] = Rook.new(color, [row[0], 0])
        grid[row[0]][1] = Knight.new(color, [row[0], 1])
        grid[row[0]][2] = Bishop.new(color, [row[0], 2])
        grid[row[0]][3] = Queen.new(color, [row[0], 3])
        grid[row[0]][4] = King.new(color, [row[0], 4])
        grid[row[0]][5] = Bishop.new(color, [row[0], 5])
        grid[row[0]][6] = Knight.new(color, [row[0], 6])
        grid[row[0]][7] = Rook.new(color, [row[0], 7])
      end

      grid
    end
  end
end