require_relative "./piece"
require_relative "./pawn"
require_relative "./stepping_piece"
require_relative "./sliding_piece"

module Chess
  class Board
    attr_reader :grid

    def initialize
      @grid = init_grid
    end

    def move(pos1, pos2)
      piece = piece(pos1)
      raise "Invalid move!" unless piece.valid_move?(pos2)

      @grid[pos1[0]][pos1[1]] = nil
      @grid[pos2[0]][pos2[1]] = piece
      piece.position = pos2
    end

    def show_grid
      puts "   a  b  c  d  e  f  g  h"
      @grid.each_with_index do |row, index|
        print "#{@grid.length-index} "
        row.each do |piece|
          print " #{piece ? piece : " "} "
        end
        puts
      end
    end

    def piece(pos)
      @grid[pos[0]][pos[1]]
    end

    def pieces(color)
      pieces = []
      @grid.each do |row|
        row.each do |piece|
          pieces << piece if piece && piece.color == color
        end
      end

      pieces
    end

    def on_board?(pos)
      pos[0].between?(0, 7) && pos[1].between?(0, 7)
    end

    def position_occupied?(pos)
      position_occupied_by_color?(pos, :white) ||
      position_occupied_by_color?(pos, :black)
    end

    def position_occupied_by_color?(pos, color)
      piece = self.piece(pos)

      return false if piece.nil?

      piece.color == color
    end

    # def position_occupied_by_other?(pos)
#       piece = board.piece(pos)
#
#       return false if piece.nil?
#
#       piece.color != self.color
#     end

    def game_over?
      checkmate?(:white) || checkmate?(:black) || stalemate?
    end

    def check?(color)
      king = king(color)
      pieces(color == :white ?  :black : :white).each do |piece|
        return true if piece.moves.include?(king.position)
      end

      false
    end

    def checkmate?(color)
      return false unless check?(color)

      pieces(color).each do |piece|
        return false if piece.valid_moves.length > 0
      end

      true
    end

    def stalemate?
      false
    end

    def dup
      new_board = Board.new

      grid = []
      # deep duplication of @grid
      @grid.each do |row|
        new_row = []
        row.each do |piece|
          new_row << (piece ? piece.dup : nil)
        end
        grid << new_row
      end

      new_board.grid = grid

      new_board
    end


    protected

    def grid=(grid)
      @grid = grid
    end


    private

    def init_grid
      grid = Array.new(8) do
        Array.new(8) { nil }
      end

      {:black => [0, 1], :white => [7, 6]}.each do |color, row|
        8.times do |column|
          grid[row[1]][column] = Pawn.new(color, [row[1], column], self)
        end

        grid[row[0]][0] = Rook.new(color, [row[0], 0], self)
        grid[row[0]][1] = Knight.new(color, [row[0], 1], self)
        grid[row[0]][2] = Bishop.new(color, [row[0], 2], self)
        grid[row[0]][3] = Queen.new(color, [row[0], 3], self)
        grid[row[0]][4] = King.new(color, [row[0], 4], self)
        grid[row[0]][5] = Bishop.new(color, [row[0], 5], self)
        grid[row[0]][6] = Knight.new(color, [row[0], 6], self)
        grid[row[0]][7] = Rook.new(color, [row[0], 7], self)
      end

      grid
    end

    def king(color)
      @grid.each do |row|
        row.each do |piece|
          return piece if piece.is_a?(King) && piece.color == color
        end
      end
    end

  end
end