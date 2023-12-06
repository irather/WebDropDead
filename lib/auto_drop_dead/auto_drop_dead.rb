module AutoDropDead
  class AutoDropDead
    attr_reader :transcript
    
    def initialize(players)
      @players = players.map { Player.new }
      @hand_calculator = HandCalculator.new 
      @scorecard = Scorecard.new 
      @end_game = EndGame.new
      @transcript = []
    end
  
    def play_game(sides, dice_count, player_count)
      @players.each do |player|
        player.hand = Hand.new(dice_count, sides) unless player.hand
      end
    
      @transcript << "Game Started"
      active_players = @players.dup
    
      while active_players.any?
        active_players.each do |player|
          next unless player.hand
          player_turn(player, sides, dice_count)
    
          if player.hand.values.empty?
            @end_game.dropdead(player)
            @transcript << "#{player.name} is removed from the game"
            active_players.delete(player)
          end
        end
      end
    
      determine_winner
      display_transcript
    end
  
    def player_turn(player, sides, dice_count)
      hand = player.hand
      initial_values = hand.values
    
      # Roll until no 2 or 5
      rolls = roll_until_no_2_or_5(hand)
      values = hand.values
    
      if rolls.empty? && !initial_values.any? { |value| [2, 5].include?(value) }
        # No 2s or 5s were rolled
        score = @hand_calculator.calculate_hand(initial_values, dice_count)
        player.score += score
        @transcript << "#{player.name} rolled: #{initial_values.join(', ')}"
        @transcript << "#{player.name}'s score: #{player.score} (Gained #{score} points)"
      elsif rolls.empty?
        @transcript << "#{player.name} rolled: no valid rolls"
      end
    end
  
    def roll_until_no_2_or_5(hand)
      rolls = []
    
      hand.roll_dice
      values = hand.values
    
      while values.any? { |value| [2, 5].include?(value) }
        rolls.concat(values)
        hand.remove_dice([2, 5])
        hand.roll_dice
        values = hand.values
      end
    
      rolls
    end
  
    def determine_winner
      winners = @end_game.calculate_highest_score
    
      if winners
        if winners.is_a?(Array)
          winner_names = winners.map(&:name).join(", ")
          @transcript << "Winners: #{winner_names}"
        else
          @transcript << "#{winners.display_score} = #{winners.name} wins!"
        end
      end
    end
  
    def display_transcript
      @transcript.each { |line| puts line }
    end
  end
end
