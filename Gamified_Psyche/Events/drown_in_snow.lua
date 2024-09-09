local Game_Manager = require("Game_Manager")
local Choice = require("Objects.Choice_Manager")

return {
    ["Name"] = "drown_in_snow",
    ["Probability_Calculation"] = function() 
        local age = Game_Manager.player_object.Age
        if age >= 7 then 
            return 1 
        end
        return 0
    end,
    ["Content"] = "You are a 7-year-old child playing outside in the snow. Suddenly, you find yourself stuck and sinking deeper into a large pile of snow. What do you do next?",
    ["Choices"] = {
        Choice.new("Call for help and wait for an adult", function() Game_Manager.kill_player()
        end, "As you take your last dying breaths of your short life, you recall seeing a man on the street also dying in snow. You demonstrate social learning one last time, attempting to copy the hand-movement you saw him make. However, it was too late. You heard the voice of God, telling you: There are not enough events for this game, so I must kill you."),
        
        Choice.new("Try to dig your way out carefully", function() Game_Manager.kill_player()
        end, "You attempt to solve your way out of the issue of drowning in snow, trying to dig around and find an escape. By demonstrating problem-solving skills that you had built the foundations to in Jean Piaget's preoperational stage, you would've escaped. However, it was too late. You heard the voice of God, telling you: There are not enough events for this game, so I must kill you."),
        
        Choice.new("Panicking and thrashing around", function() Game_Manager.kill_player()
        end, "By choosing this decision, you demonstrate a lack of emotional regulation, as your first move was to panic. Of course, you are a child, so it is excused. Anyhow, here's what happens: You hear God's voice saying: \"Thanks for making my life easier. I do not have to magically make you die. You did it for me. Sorry, I didn't have enough assets."),
        
        Choice.new("Remember the lesson about staying calm and plan your escape", function() Game_Manager.kill_player()
        end, "As you attempt to logically think about what is happening to you, the freezing cold of the snow starts to press in on your skin. You open your mouth to scream for help, but it is drowned in snow. Then, you hear God's voice: \"I'm sorry you couldn't have lived longer. I did not have enough events to make you live past the age of 7. This world is a simulation BTW.")
    },
    ["Event_Ended"] = function() end -- This function is called whenever an event finishes. Can contain default probabilities modified by the mere event occurring.
}