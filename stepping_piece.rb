require "./piece"

module Chess
  class SteppingPiece < Piece
    private

    def find_moves(offsets)
      moves_array = []

      offsets.each do |x_offset, y_offset|
        new_x = position[0] + x_offset
        new_y = position[1] + y_offset

        if new_x.between?(0, 7) && new_y.between?(0, 7)
          moves_array << [new_x, new_y]
        end
      end

      moves_array
    end
  end


  class King < SteppingPiece
    def moves
      offsets     = [[0, 1],
                     [0, -1],
                     [1, 0],
                     [-1, 0],
                     [-1, -1],
                     [-1, 1],
                     [1, -1],
                     [1, 1] ]
      find_moves(offsets)
    end

    def to_s
      (color == :white) ? "\u2654" : "\u265A"
    end
  end


  class Knight < SteppingPiece
    def moves
      offsets     = [[1, 2],
                     [2, 1],
                     [2, -1],
                     [1, -2],
                     [-1, -2],
                     [-2, -1],
                     [-2, 1],
                     [-1, 2] ]
      find_moves(offsets)
    end

    def to_s
      (color == :white) ? "\u2658" : "\u265E"
    end
  end
end