local Game_Manager = require("Game_Manager")
local Choice = require("Objects.Choice_Manager")

local name = "exploring_world"
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
            return 1 -- Equal chance amongst all of the other sensorimotor events.
        end
        return 0
    end,
    ["Content"] = "You are a child between the ages of 1-3 years old. Your world is full of new experiences and discoveries. What do you do next?",
    ["Choices"] = {
        Choice.new("Pick up a toy and shake it", function() 
        end, "Circular Reactions: Repetitive actions that help infants explore and learn about their environment, as described by Jean Piaget."),
        
        Choice.new("Crawl towards a shiny object across the room", function() 
        end, "Goal-Directed Behavior: Purposeful actions that show the infant's marginal ability to plan and achieve a goal, a concept from Jean Piaget's theory."),
        
        Choice.new("Look at yourself in the mirror and smile", function() 
        end, "Self-Recognition: The ability to recognize oneself in a mirror or photograph, a developmental milestone noted by Jean Piaget."),
        
        Choice.new("Attempt to climb the stairs", function() 
        end, "Gross Motor Skills: The abilities required to control the large muscles of the body for walking, running, sitting, crawling, and other activities, as outlined by Jean Piaget.")
    },
    ["Event_Ended"] = function() end -- This function is called whenever an event finishes. Can contain default probabilities modified by the mere event occurring.
}
