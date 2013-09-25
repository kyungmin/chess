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
      new_board.move!(position, pos, color)

      !new_board.check?(color)
    end

    def dup(new_board)
      self.class.new(self.color, position.dup, new_board)
    end


    private

    def opponent_color
      (color == :white ? :black : :white)
    end
  end
end