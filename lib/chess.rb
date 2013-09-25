require_relative './board'
require_relative './human_player'

module Chess
  class Game
    GRID_MAP = {  "h" => 7, "g" => 6, "f" => 5, "e" => 4,
                  "d" => 3, "c" => 2, "b" => 1, "a" => 0,
                  "1" => 7, "2" => 6, "3" => 5, "4" => 4,
                  "5" => 3, "6" => 2, "7" => 1, "8" => 0 }
    def initialize
    end

    def play
      board = Board.new

      players = [HumanPlayer.new(:white), HumanPlayer.new(:black)]
      current_player = 0
      until board.game_over?(players[current_player].color)
        # puts board
        board.show_grid

        while true
          begin
            start_pos, end_pos = get_input(players[current_player])
            board.move(start_pos, end_pos, players[current_player].color)
          rescue InvalidMoveException => e
            puts e.message
            next
          end

          break
        end

        current_player = next_player(current_player)
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
      puts "#{player.name}: Enter move."

      # input = gets.chomp.gsub(/[^12345678abcdefghq]/, "")
      input = player.next_move
      if input == "q"
        exit
      end

      original = [GRID_MAP[input[1]], GRID_MAP[input[0]]]
      target = [GRID_MAP[input[3]], GRID_MAP[input[2]]]

      [original, target]
    end

    def next_player(player)
      (player == 0 ? 1 : 0)
    end
  end
end


chess = Chess::Game.new
chess.play