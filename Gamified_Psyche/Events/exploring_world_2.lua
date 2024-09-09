local Game_Manager = require("Game_Manager")
local Choice = require("Objects.Choice_Manager")

local name = "exploring_world_2"
return {
    ["Name"] = name,
    ["Probability_Calculation"] = function(past_events) 
        -- Detect if it happened already.
        for index, event in pairs(past_events) do 
            if event.Name == name then
                return 0
            end
        end

        local age = Game_Manager.player_object.Age
        if age >= 1 and age < 3 then -- Sensorimotor stage ends at 3.
            return 1 -- Equal chance amongst all of the other sensorimotor events.
        end
        return 0
    end,
    ["Content"] = "You are a child between the ages of 1-3 years old. You are starting to get acquainted with your senses. What is your next move?",
    ["Choices"] = {
        Choice.new("Reach for the mobile hanging over your crib repeatedly and intentionally", function() 
        end, "You are demonstrating coordination of secondary circular reactions, as secondary circular reactions are defined by Jean Piaget to be repetitive actions to make something happen, showing understanding of basic cause & effect."),
        
        Choice.new("Push a toy car and watch it roll away, then go back and do it again.", function() 
        end, "You are exhibiting tertiary circular reactions, which in Jean Piaget's sensorimotor stage is where one repeats certain actions in order to observe the environment's behavior. In this scenario, it is your pushing the toy car to observe the effects of your force on it."),
        
        Choice.new("Say 'Mama' or 'Dada' for the first time", function() 
        end, "Congratulations! You've said your first word. This is the beginning of your language development, a crucial part to development & to Jean Piaget's sensorimotor stage."),
        
        Choice.new("Play peek-a-boo with your mom", function() 
        end, "In this scenario, you are developing object permanence, understanding that objects continue to exist even when they cannot be seen, a fundamental concept in Jean Piaget's theory. Many infants do not have this ability until around 4-7 months old. (of course, this is a game, so we're letting you develop it later.)")
    },
    ["Event_Ended"] = function() end -- This function is called whenever an event finishes. Can contain default probabilities modified by the mere event occurring.
}
