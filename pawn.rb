require "./piece"

module Chess
  class Pawn < Piece
    def to_s
      (color == :white) ? "\u2659" : "\u265F"
    end
  end
end