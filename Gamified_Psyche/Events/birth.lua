local Choice = require("Objects.Choice_Manager")
local Game_Manager = require("Game_Manager")

return {
    ["Name"] = "birth",
    ["Probability_Calculation"] = function()
        local player = Game_Manager.player_object
        if player.Age > 0 then -- Can't be born again (unless you're in Jesus, but that's a different type of rebirth lmao)
            return 0
        end
        return 1 
    end,
    ["Content"] = "You have just been born and came out of your mother's womb, what is your first move?",
    ["Choices"] = { -- the function is able to do whatever tf it wants, so that it can modify the game environment. it can even cause new events if wanted. 
        Choice.new("Cry really loudly", function() 
            Game_Manager.player_object.Temperament = "Difficult" 
        end, "You chose to cry really loudly. Naturally, this is not an indicative sign of a difficult temperament, but could be part of one, meaning that you, as a baby, may have a difficult temperament."),
        Choice.new("Spontaneously stop breathing and die.", 
        function() 
            Game_Manager.kill_player() 
        end, "You chose to die. It was your time. This is a sign of a DEAD temperament."),
        Choice.new("Do nothing", function() 
            Game_Manager.player_object.Temperament = "Slow-to-warm-up" 
        end, "You chose to do nothing. You did not show fear within this scenario, but this could be a potential characteristic of a slow-to-warm-up temperament, as their anxiety leads to their being reluctant to try new things."),
        Choice.new("Breastfeed", function() 
            Game_Manager.player_object.Temperament = "Easy" 
        end, "You chose to breastfeed, rather than deciding to be disruptive. This is a potential sign of an easy temperament, as those with an easy temperament tend to be adaptable, along with showing positive mood and emotion. More emprically, this demonstrates the Moro reflex, as the Moro reflex is the baby's natural reflex to suck, primarily for breastfeeding..")
    },
    ["Event_Ended"] = function() end -- This function is called whenever an event finishes. (when a choice is made). Can contain default probabilities modified by the mere event occurring.
}