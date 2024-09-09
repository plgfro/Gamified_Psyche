local Game_Manager = require("Game_Manager")
local Events_Manager = require("Events_Manager")

return function()
  for gui_name, gui_val in pairs(Game_Manager.gui_toggles) do
    Game_Manager.gui_toggles[gui_name] = false
  end
  Game_Manager.switched_guis = {}
  Game_Manager.player_object = {}
  Game_Manager.gui_toggles.main_menu = true
end