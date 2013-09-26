require_relative "./piece"
require_relative "./constants"

module Chess
  class SlidingPiece < Piece
    def moves
      moves_array = []

      move_offsets.each do |offset|
        new_x = position[0] + offset[0]
        new_y = position[1] + offset[1]

        while board.on_board?([new_x, new_y]) &&
          !board.position_occupied_by_color?([new_x, new_y], color)
          moves_array << [new_x, new_y]

          # check if occupied by other
          break if board.position_occupied_by_color?([new_x, new_y], opponent_color)

          new_x += offset[0]
          new_y += offset[1]
        end
      end

      moves_array
    end
  end


  class Queen < SlidingPiece
    def to_s
      (color == :white) ? Constants::QUEEN_WHITE : Constants::QUEEN_BLACK
    end


    private

    def move_offsets
      # clockwise from midnight
      [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    end
  end


  class Rook < SlidingPiece
    def initialize(color, position, board)
      super(color, position, board)
      @moved = false
    end

    def to_s
      (color == :white) ? Constants::ROOK_WHITE : Constants::ROOK_BLACK
    end

    def position=(pos)
      @moved = true
      super(pos)
    end

    def moved?
      @moved
    end

    private

    def move_offsets
      # clockwise from midnight
      [[0, 1], [1, 0], [0, -1], [-1, 0]]
    end
  end


  class Bishop < SlidingPiece
    def to_s
      (color == :white) ? Constants::BISHOP_WHITE : Constants::BISHOP_BLACK
    end


    private

    def move_offsets
      # clockwise from midnight
      [[1, 1], [1, -1], [-1, -1], [-1, 1]]
    end
  end
end
