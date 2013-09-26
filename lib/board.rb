require "colorize"

require_relative "./piece"
require_relative "./pawn"
require_relative "./stepping_piece"
require_relative "./sliding_piece"

module Chess
  class InvalidMoveException < Exception
  end


  class Board
    def initialize
      @grid = init_grid
    end

    def move(pos1, pos2, color)
      piece = piece(pos1)
      if piece.color != color
        message = "Invalid move: piece at (#{pos1[0]}, #{pos1[1]}) not #{color}."
        raise InvalidMoveException.new(message)
      elsif castling?(piece, pos2)
        try_castling(piece, pos2)
      elsif !piece.valid_moves.include?(pos2)
        raise InvalidMoveException.new("Invalid move!")
      else
        move!(pos1, pos2, color)
      end
    end

    def move!(pos1, pos2, color)
      piece = piece(pos1)

      @grid[pos1[0]][pos1[1]] = nil
      @grid[pos2[0]][pos2[1]] = piece
      piece.position = pos2
    end

    # def to_s
    def show_grid
      # board_str = ""
      puts "   a   b   c   d   e   f   g   h".colorize(:white)
      background = [:white, :light_white]
      bg_toggle = 0
      @grid.each_with_index do |row, index|
        print "#{@grid.length-index} ".colorize(:white)
        row.each do |piece|
          print " #{piece ? piece : " "}  ".colorize(:color => :black,
          :background => background[bg_toggle])
          bg_toggle = (bg_toggle == 0 ? 1 : 0)
        end
        bg_toggle = (bg_toggle == 0 ? 1 : 0)
        puts
      end

      nil
    end

    # def [](pos)
    # def []=(pos, val)
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
      # !!piece(pos)
      position_occupied_by_color?(pos, :white) ||
      position_occupied_by_color?(pos, :black)
    end

    def position_occupied_by_color?(pos, color)
      piece = self.piece(pos)

      return false if piece.nil?

      piece.color == color
    end

    def game_over?(color)
      # every checkmate is a stalemate when currently in check
      # so only need to look for stalemate
      stalemate?(color)
    end

    def check?(color)
      king = king(color)
      pieces(color == :white ?  :black : :white).any? do |piece|
        piece.moves.include?(king.position)
      end
    end

    def checkmate?(color)
      check?(color) && stalemate?(color)
    end

    def stalemate?(color)
      pieces(color).none? do |piece|
        piece.valid_moves.length > 0
      end
    end

    def dup
      new_board = Board.new

      grid = []
      # deep duplication of @grid
      @grid.each do |row|
        new_row = []
        row.each do |piece|
          new_row << (piece ? piece.dup(new_board) : nil)
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

    def castling?(piece, pos2)
      return false unless piece.is_a?(King)

      original_y = piece.position[1]
      new_y = pos2[1]

      (new_y - original_y).abs == 2
    end

    def try_castling(king, pos2)
      if pos2[1] == 6
        rook = self.piece([king.position[0], 7])
      else
        rook = self.piece([king.position[0], 0])
      end

      if castling_possible?(king, rook)
        # make the special move
        if rook.position[1] == 7 # right side
          new_king_pos = [king.position[0], 6]
          new_rook_pos = [king.position[0], 5]
        else
          new_king_pos = [king.position[0], 2]
          new_rook_pos = [king.position[0], 3]
        end
        move!(king.position, new_king_pos, king.color)
        move!(rook.position, new_rook_pos, king.color)
      else
        raise InvalidMoveException.new("Castling is not possible.")
      end

    end

    def castling_possible?(king, rook)
      !rook.nil? && rook.is_a?(Rook) && (rook.color == king.color) &&
              !king.moved? && !rook.moved? && positions_empty?(king, rook)
    end

    def positions_empty?(king, rook)
      positions = []
      if rook.position[1] == 7 # right side
        positions << [king.position[0], 5]
        positions << [king.position[0], 6]
      else # left side
        positions << [king.position[0], 1]
        positions << [king.position[0], 2]
        positions << [king.position[0], 3]
      end

      positions.all? do |position|
        piece(position).nil?
      end
    end

  end
end