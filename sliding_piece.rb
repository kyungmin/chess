require "./piece"

module Chess
  class SlidingPiece < Piece
    # queen, rook, bishop
  end


  class Queen < SlidingPiece
    def to_s
      (color == :white) ? "\u2655" : "\u265B"
    end
  end

  class Rook < SlidingPiece
    def to_s
      (color == :white) ? "\u2656" : "\u265C"
    end
  end

  class Bishop < SlidingPiece
    def to_s
      (color == :white) ? "\u2657" : "\u265D"
    end
  end
end