local Game_Manager = require("Game_Manager")
local Events_Manager = require("Events_Manager")
local random_names = require("Content.Player_Names")
local disorders = require("Content.Disorders")

local player = require("Player")

return function()
    -- Toggle off all other uis and intialize the proper game logic.
    math.randomseed(os.clock())
    -- local name = random_names[math.random(1, #random_names)]
    local name = "Bruhley Shhhultz"
    local new_player = player.create_player(name, 0, disorders)
    Game_Manager.globals = {}
    Game_Manager.player_object = new_player
    
    for gui_name, toggled_value in pairs(Game_Manager.gui_toggles) do
        Game_Manager.gui_toggles[gui_name] = false
    end
    Game_Manager.gui_toggles.game = true
    Events_Manager.load_event("birth")
end