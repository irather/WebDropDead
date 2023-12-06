module AutoDropDead
  class Player
    attr_accessor :hand, :score
    attr_reader :name
  
    def initialize(name, dice_count, sides)
      @name = name
      @hand = nil
      @score = 0
    end
  
    def display_score
      "#{@name}'s score: #{@score}"
    end
  
    def eliminate
      @hand = Hand.new(@hand.dice_count, @hand.sides)
    end
  end
end
