-- This "class" will contain variables and lots of other things required for the game to function.
local Game_Manager = {}
Game_Manager.globals = {}
Game_Manager.gui_toggles = {}
Game_Manager.player_object = {}
Game_Manager.switched_guis = {} -- This is for toggling on & off guis when it comes to single-depth guis.
Game_Manager.buttons_subsection = require("Buttons_Manager")

Game_Manager.kill_player = function()
    for gui_name, v in pairs(Game_Manager.gui_toggles) do
        Game_Manager.gui_toggles[gui_name] = false
    end
    Game_Manager.gui_toggles.end_of_life = true
    Game_Manager.player_object.dead = true
end

return Game_Manager