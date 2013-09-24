module Chess

  class Piece
    attr_reader :color, :position

    def initialize(color, position)
      @color, @position = color, position
    end
  end
end