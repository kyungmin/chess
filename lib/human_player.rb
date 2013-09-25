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
      gets.chomp.gsub(/[^1-8a-hq]/, "")
    end
  end
end