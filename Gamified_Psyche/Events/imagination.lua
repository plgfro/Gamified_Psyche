local Game_Manager = require("Game_Manager")
local Choice = require("Objects.Choice_Manager")

return {
    ["Name"] = "imagination",
    ["Probability_Calculation"] = function() 
        local age = Game_Manager.player_object.Age
        if age >= 3 and age < 7 then -- Preoperational stage ends at 3.
            return 1 -- Equal chance amongst all of the other Preoperational events.
        end
        return 0
    end,
    ["Content"] = "You are a child between the ages of 4-6 years old. Your imagination is running wild, and you love to engage in make-believe play. What do you do next?",
    ["Choices"] = {
        Choice.new("Use a stick as a pretend sword", function() 
        end, "You are demonstrating symbolic function, a part of Jean Piaget's preoperational stage. By using a stick as a symbol for a sword, you demonstrate said symbolic thinking."),
        
        Choice.new("Step infront of the TV that your parents are watching to get a closer look", function() 
        end, "Egocentrism, a common element of the preoperational stage, is Jean Piaget's description of when a child is unable to understand other perspectives. In this scenario, your stepping infront of the TV demonstrates egocentrism, as you have no idea that you are blocking your parent's view of the TV."),
        
        Choice.new("Build a castle out of blocks and say it's alive", function() 
        end, "Animistic thinking, which is Jean Piaget's description of when a child believes that inanimate objects have lifelike qualities. In this scenario, you are assigning human attributes to the castle that you just built, showing animistic thinking, a common trait in the preoperational stage."),
        
        Choice.new("Draw a picture of your family", function()
            Game_Manager.player_object.Passions["Drawing"] = true
        end, "By drawing, you are developing fine motor skills, a crucial part of Jean Piaget's preoperational stage, which is essential to development as you learn how to use the small muscles in your hands.")
    },
    ["Event_Ended"] = function() end -- This function is called whenever an event finishes. Can contain default probabilities modified by the mere event occurring.
}
