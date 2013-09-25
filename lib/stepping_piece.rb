require "./piece"

module Chess
  class SteppingPiece < Piece
    def moves
      moves_array = []

      move_offsets.each do |x_offset, y_offset|
        new_x = position[0] + x_offset
        new_y = position[1] + y_offset

        if on_board?([new_x, new_y]) && !position_occupied_by_us?([new_x, new_y])
          moves_array << [new_x, new_y]
        end
      end

      moves_array
    end
  end


  class King < SteppingPiece
    def to_s
      (color == :white) ? "\u2654" : "\u265A"
    end


    private

    def move_offsets
      [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    end
  end


  class Knight < SteppingPiece
    def to_s
      (color == :white) ? "\u2658" : "\u265E"
    end


    private

    def move_offsets
      [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    end
  end
end