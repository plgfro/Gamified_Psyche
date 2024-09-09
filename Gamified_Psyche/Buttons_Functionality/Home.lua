local Game_Manager = require("Game_Manager")
return function() -- Need to be able to return to the previous state.
    for gui_name, true_value in pairs(Game_Manager.switched_guis) do
        Game_Manager.gui_toggles[gui_name] = true
    end
    Game_Manager.switched_guis = {} -- The switch has been returned.
    Game_Manager.gui_toggles.disorder_probabilities = false

end