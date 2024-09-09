local Game_Manager = require("Game_Manager")
local Buttons_Manager = require("Buttons_Manager")
-- Generated Assets Previously:

local font = love.graphics.getFont()
local title_text = love.graphics.newText(font, {{0,0,0}, "Gamified Psyche"})

local settings_text = love.graphics.newText(font, {{0,0,0}, "Credits"})
local play_text = love.graphics.newText(font, {{0,0,0}, "Play"})

local unclearable_buttons = {
    ["Play"] = true,
    ["Credits"] = true
}

local main_menu = function(resolution) -- This is to draw the main menu.
    Buttons_Manager.clear_buttons(unclearable_buttons)
    -- Headers
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("fill", 0.0625 * resolution.X, 0.05 * resolution.Y, 0.875 * resolution.X, 1 * resolution.Y)
    love.graphics.draw(title_text, 0.125 * resolution.X, 0.1 * resolution.Y, 0, 6, 5)

    -- Buttons
    -- Play Button
    local play_button_pos_x = 0.2 * resolution.X
    local play_button_pos_y = 0.8 * resolution.Y

    local settings_button_pos_x = 0.6 * resolution.X
    local settings_button_pos_y = 0.8 * resolution.Y

    local main_menu_button_size_x = 0.2 * resolution.X
    local main_menu_button_size_y = 0.1 * resolution.Y

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", play_button_pos_x, play_button_pos_y, main_menu_button_size_x, main_menu_button_size_y)
    love.graphics.rectangle("fill", settings_button_pos_x, settings_button_pos_y, main_menu_button_size_x, main_menu_button_size_y)

    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.rectangle("fill", 0.2125 * resolution.X, 0.8125 * resolution.Y, 0.175 * resolution.X, 0.075 * resolution.Y)
    love.graphics.rectangle("fill", 0.6125 * resolution.X, 0.8125 * resolution.Y, 0.175 * resolution.X, 0.075 * resolution.Y)

    -- Text to the Buttons
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(play_text, 0.265 * resolution.X, 0.825 * resolution.Y, 0, 2, 2)
    love.graphics.draw(settings_text, 0.635 * resolution.X, 0.825 * resolution.Y, 0, 2, 2)

    -- Initialize the button clicked events.
    Buttons_Manager.add_button({
        ["X"] = play_button_pos_x,
        ["Y"] = play_button_pos_y
    },
    {
        ["X"] = main_menu_button_size_x,
        ["Y"] = main_menu_button_size_y
    },
    "Play"
    )
    Game_Manager.globals.play_button_added = true
    Buttons_Manager.add_button({
        ["X"] = settings_button_pos_x,
        ["Y"] = settings_button_pos_y
    },
    {
        ["X"] = main_menu_button_size_x,
        ["Y"] = main_menu_button_size_y
    },
    "Credits"
    )
    Game_Manager.globals.credits_button_added = true
end

return main_menu