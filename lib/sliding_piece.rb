require "./piece"

module Chess
  class SlidingPiece < Piece
    def moves
      moves_array = []

      move_offsets.each do |offset|
        new_x = position[0] + offset[0]
        new_y = position[1] + offset[1]

        while on_board?([new_x, new_y]) && !position_occupied_by_us?([new_x, new_y])
          moves_array << [new_x, new_y]

          # check if occurpied by other
          break if position_occupied_by_other?([new_x, new_y])

          new_x += offset[0]
          new_y += offset[1]
        end
      end

      moves_array
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
