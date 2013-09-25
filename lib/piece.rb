module Chess

  class Piece
    attr_reader :color, :board
    attr_accessor :position

    def initialize(color, position, board)
      @color, @position, @board = color, position, board
    end

    def valid_moves
      moves.select do |pos|
        valid_move?(pos)
      end
    end

    def valid_move?(pos)
      new_board = @board.dup

      new_board.grid[position[0]][position[1]] = nil
      new_board.grid[pos[0]][pos[1]] = self

      !new_board.check?(color)# == :white ? :black : :white)
    end


    private

    def opponent_color
      (color == :white ? :black : :white)
    end
  end
end