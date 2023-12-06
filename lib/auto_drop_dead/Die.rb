module AutoDropDead
    class Die
        attr_reader :sides, :value
    
        def initialize(sides)
            @sides = sides
            roll_die
        end
    
        def roll_die
            @value = rand(1..sides)
        end
    
    end
end