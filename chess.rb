require './board'

module Chess
  class Game
    def initialize
    end

    def play
      board = Board.new

      until board.game_over?
        board.show_grid
        start_pos, end_pos = get_input
        board.move(start_pos, end_pos)
      end

      if board.checkmate?(:white)
        puts "Black won!"
      else
        puts "White won!"
      end

    end

    private

    def get_input
      puts "Enter move."
      grid_map = {  "h" => 7, "g" => 6, "f" => 5, "e" => 4,
                    "d" => 3, "c" => 2, "b" => 1, "a" => 0,
                    "1" => 7, "2" => 6, "3" => 5, "4" => 4,
                    "5" => 3, "6" => 2, "7" => 1, "8" => 0 }

      input = gets.chomp.gsub(/[^12345678abcdefgh]/, "")

      original = [grid_map[input[1]], grid_map[input[0]]]
      target = [grid_map[input[3]], grid_map[input[2]]]

      [original, target]
    end

  end
end


chess = Chess::Game.new
chess.play