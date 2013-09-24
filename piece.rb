module Chess

  class Piece
    attr_reader :color, :position

    def initialize(color, position)
      @color, @position = color, position
    end

    def valid_moves
      moves.select do |pos|
        valid_move?(pos)
      end
    end

    def valid_move?(pos)
      # duplicate board
      # make the move
      # valid if not in check
    end
  end
end