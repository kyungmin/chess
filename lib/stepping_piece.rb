require_relative "./piece"
require_relative "./constants"

module Chess
  class SteppingPiece < Piece
    def moves
      moves_array = []

      move_offsets.each do |x_offset, y_offset|
        new_x = position[0] + x_offset
        new_y = position[1] + y_offset

        if board.on_board?([new_x, new_y]) &&
          !board.position_occupied_by_color?([new_x, new_y], color)
          moves_array << [new_x, new_y]
        end
      end

      moves_array
    end
  end


  class King < SteppingPiece
    def to_s
      (color == :white) ? Constants::KING_WHITE : Constants::KING_BLACK
    end


    private

    def move_offsets
      [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    end
  end


  class Knight < SteppingPiece
    def to_s
      (color == :white) ? Constants::KNIGHT_WHITE : Constants::KNIGHT_BLACK
    end


    private

    def move_offsets
      [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    end
  end
end