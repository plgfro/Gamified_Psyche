local Game_Manager = require("Game_Manager")
return function()
    Game_Manager.gui_toggles.main_menu = false
    Game_Manager.gui_toggles.credits = true
end