require "./piece"

module Chess
  class SlidingPiece < Piece
    def moves
      offsets = move_offsets
    end
  end


  class Queen < SlidingPiece
    def to_s
      (color == :white) ? "\u2655" : "\u265B"
    end


    private

    def move_offsets
      # clockwise from midnight
      [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    end
  end


  class Rook < SlidingPiece
    def to_s
      (color == :white) ? "\u2656" : "\u265C"
    end


    private

    def move_offsets
      # clockwise from midnight
      [[0, 1], [1, 0], [0, -1], [-1, 0]]
    end
  end


  class Bishop < SlidingPiece
    def to_s
      (color == :white) ? "\u2657" : "\u265D"
    end


    private

    def move_offsets
      # clockwise from midnight
      [[1, 1], [1, -1], [-1, -1], [-1, 1]]
    end
  end
end
