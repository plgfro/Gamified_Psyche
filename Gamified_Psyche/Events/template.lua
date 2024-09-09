local Choice = require("Objects.Choice_Manager")

return {
    ["Name"] = "TEMPLATE",
    ["Probability_Calculation"] = function(past_events) return 0 end, -- Must return a decimal.
    ["Content"] = "I AM A TEMPLATE. YOU SHOULD NOT BE SEEING THIS UNLESS YOU DID A FUNNY.",
    ["Choices"] = { -- the function is able to do whatever tf it wants, so that it can modify the game environment. it can even cause new events if wanted. 
        Choice.new("TEMPLATE DESCRIPTION", function() 
            print("I LOVE THIS GAME") 
        end, "Choice Description"),
        Choice.new("TEMPLATE DESCRIPTION", function() 
            print("NAH THIS GAMES TRASH") 
        end, "Choice Description"),
        Choice.new("TEMPLATE DESCRIPTION", function() 
            print("NO ONE LEAK THIS PLS") 
        end, "Choice Description"),
        Choice.new("TEMPLATE DESCRIPTION", function() 
            print("WACK AHHH DEBUG STATEMENTS") 
        end, "Choice Description"),
    },
    ["Event_Ended"] = function() end -- This function is called whenever an event finishes. (when a choice is made). Can contain default probabilities modified by the mere event occurring.
}