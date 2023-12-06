module AutoDropDead
  class EndGame
    def initialize(players = [])
        @players = Array(players)
    end

    def calculate_highest_score
        return nil if @players.none? { |player| player.hand }
      
        max_score = @players.select { |player| player.hand }.max_by(&:score).score
        winners = @players.select { |player| player.hand && player.score == max_score }
      
        if winners.size == 1
          winners[0]
        else
          nil
        end
      end

    def dropdead(player)
        @players.delete(player)
    end
  end
end
