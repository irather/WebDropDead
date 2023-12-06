module AutoDropDead
    class Scorecard 
        def initialize
            @scores = {}
        end
    
        def add_die_value_array(player, die_value_array, dice_count)
            player_name = player.name
            @scores[player_name] ||= 0
            @scores[player_name] += die_value_array.sum
        end
    
        def get_player_score(player)
            @scores[player.name]
        end
    
        def is_turn_over(active_turn, dice_count)
            active_turn && dice_count.zero?
        end
    end
end
