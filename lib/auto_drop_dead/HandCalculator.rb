module AutoDropDead
    class HandCalculator
        def initialize
        end
    
        def calculate_hand(die_value_array, dice_count)
            score = die_value_array.sum
            score
          end
    
        def is_turn_over(active_turn, dice_count)
            active_turn && dice_count.zero?
        end
    end
end

