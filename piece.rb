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

    def on_board?(pos)
      pos[0].between?(0, 7) && pos[1].between?(0, 7)
    end

    def position_occupied?(pos)
      position_occupied_by_us?(pos) || position_occupied_by_other?(pos)
    end

    def position_occupied_by_us?(pos)
      piece = board.piece(pos)

      return false if piece.nil?

      piece.color == self.color
    end

    def position_occupied_by_other?(pos)
      piece = board.piece(pos)

      return false if piece.nil?

      piece.color != self.color
    end
  end
end