local Choice = require("Objects.Choice_Manager")
local Game_Manager = require("Game_Manager")

local name = "sensing"
return {
    ["Name"] = name,
    ["Probability_Calculation"] = function(past_events) 
        for index, event in pairs(past_events) do 
            if event.Name == name then
                return 0
            end
        end
        local age = Game_Manager.player_object.Age
        if age >= 1 and age < 3 then -- Sensorimotor stage ends at 3.
            return 1
        end
        return 0
    end, -- Must return a decimal.
    ["Content"] = "You are now starting to learn how to perceive your world through using your senses. What is your move?",
    ["Choices"] = { -- the function is able to do whatever tf it wants, so that it can modify the game environment. it can even cause new events if wanted. 
        Choice.new("Look at the toy", function() end, "You look at the toy, engaging your sense of sight, part of Jean Piaget's sensorimotor stage, which is focused on becoming acquainted with your environment."),
        Choice.new("Watch as your parents roll a ball and it disappears under a couch.", function() end, "This is part of Jean Piaget's sensorimotor stage, where it is primarily focused on becoming acquainted with your environment, which can involve sucking, touching, seeing, and feeling. You chose to watch the ball roll, so you gain the experience of using your sense of sight. However, as it disappears under a couch, you will not choose to pursue it, as you have not yet developed your sense of object permanence."),
        Choice.new("Feel the ball as it gets rolled towards you.", function() end, "This is part of Jean Piaget's sensorimotor stage, where it is primarily focused on becoming acquainted with your environment, which can involve sucking, touching, seeing, and feeling. You chose to feel the ball, so you gain the experience of doing so, gaining understanding of feeling."),
        Choice.new("Suck your thumb.", function() end, "This is part of Jean Piaget's sensorimotor stage, where it is primarily focused on becoming acquainted with your environment, which can involve sucking, touching, seeing, and feeling. You chose to suck your thumb, so you gain the experience of doing so.")
    },
    ["Event_Ended"] = function() end -- This function is called whenever an event finishes. (when a choice is made). Can contain default probabilities modified by the mere event occurring.
}