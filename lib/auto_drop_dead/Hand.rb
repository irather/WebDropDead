module AutoDropDead
  class Hand
    def initialize(dice_count, sides)
      @dice = Array.new(dice_count) { Die.new(sides) }
    end
  
    def roll_dice
      values = @dice.map(&:roll_die)
      remove_dice
      values
    end
  
    def remove_dice(values_to_remove = [2, 5])
      @dice.reject! { |die| values_to_remove.include?(die.value) }
    end
  
    def values
      @dice.map(&:value)
    end
  end
end