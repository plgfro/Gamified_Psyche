-- Create a New Scenario.
local Game_Manager = require("Game_Manager")
local Events_Manager = require("Events_Manager")

return function()
    Game_Manager.player_object.Age = Game_Manager.player_object.Age + 1  -- Finish up the current scenario. May want to move this to a different section later on
    -- Call the Events_Manager's next event.
    Game_Manager.globals.characters_until_new_line = 0
  Events_Manager.calculate_event_probabilities()
  local next_event = Events_Manager.choose_event()
  Events_Manager.load_event(next_event.Name)
end