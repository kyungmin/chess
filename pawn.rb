require "./piece"

module Chess
  class Pawn < Piece
    def initialize(color, position, board)
      super(color, position, board)
      @direction = ((position[0] == 1) ? :+ : :-)
      @moved = false
    end

    def moves
      moves_array = []
      new_position = [position[0].send(@direction, 1), position[1]]

      if on_board?(new_position) && !position_occupied?(new_position)
        moves_array << new_position
        next_position = [new_position[0].send(@direction, 1), new_position[1]]
        if !@moved && !position_occupied?(new_position) &&
          (on_board?(next_position) && !position_occupied?(next_position))
          moves_array << next_position
        end
      end

      diagonal_positions = [[position[0].send(@direction, 1), position[1] - 1],
                          [position[0].send(@direction, 1), position[1] + 1]]
      diagonal_positions.each do |diagonal_position|
        if on_board?(diagonal_position) && position_occupied_by_other?(diagonal_position)
          moves_array << diagonal_position
        end
      end

      moves_array
    end

    def position=(pos)
      @moved = true
      super(pos)
    end

    def to_s
      (color == :white) ? "\u2659" : "\u265F"
    end
  end
end