require_relative './board'

module Chess
  class Game
    def initialize
    end

    def play
      board = Board.new

      player = :white
      until board.game_over?(player)
        board.show_grid

        while true
          begin
            start_pos, end_pos = get_input(player)
            board.move(start_pos, end_pos, player)
          rescue InvalidMoveException => e
            puts e.message
            next
          end

          break
        end

        player = next_player(player)
      end

      board.show_grid
      if board.checkmate?(:white)
        puts "Black won!"
      else
        puts "White won!"
      end

    end

    private

    def get_input(player)
      puts "#{player.to_s.capitalize}: Enter move."
      grid_map = {  "h" => 7, "g" => 6, "f" => 5, "e" => 4,
                    "d" => 3, "c" => 2, "b" => 1, "a" => 0,
                    "1" => 7, "2" => 6, "3" => 5, "4" => 4,
                    "5" => 3, "6" => 2, "7" => 1, "8" => 0 }

      input = gets.chomp.gsub(/[^12345678abcdefghq]/, "")
      # input = gets.chomp
      if input == "q"
        exit
      end

      original = [grid_map[input[1]], grid_map[input[0]]]
      target = [grid_map[input[3]], grid_map[input[2]]]

      [original, target]
    end

    def next_player(player)
      (player == :white ? :black : :white)
    end
  end
end


chess = Chess::Game.new
chess.play