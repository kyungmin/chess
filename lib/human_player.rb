module Chess
  class HumanPlayer
    attr_reader :color

    def initialize(color)
      @color = color
    end

    def name
      @color.to_s.capitalize
    end

    def next_move
      gets.chomp.gsub(/[^12345678abcdefghq]/, "")
    end
  end
end