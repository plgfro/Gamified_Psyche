local Game_Manager = require("Game_Manager")
return function()
    for gui_name, value in pairs(Game_Manager.gui_toggles) do
        if value then
            Game_Manager.gui_toggles[gui_name] = false
            Game_Manager.switched_guis[gui_name] = true
        end
    end
    Game_Manager.gui_toggles.game = true
    Game_Manager.gui_toggles.disorder_probabilities = true
end