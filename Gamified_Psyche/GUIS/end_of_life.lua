local Game_Manager = require("Game_Manager")
local Buttons_Manager = require("Buttons_Manager")
local unclearable_buttons = {
  ["Main_Menu"] = true
}

local font = love.graphics.getFont()
local dead_text = love.graphics.newText(font, {{1,1,1}, ""})

return function(resolution)
  Buttons_Manager.clear_buttons(unclearable_buttons)

  local player = Game_Manager.player_object
  dead_text:set("Your character, "..player.Name..", has died at\nthe ripe age of "..player.Age.." years old.")
  love.graphics.draw(dead_text, 0.15 * resolution.X, 0.4 * resolution.Y, 0, 2, 2)
  
end