local Buttons_Manager = require("Buttons_Manager")

local font = love.graphics.getFont()
local home_button_img = love.graphics.newImage("Assets/house.png")
local return_home_text = love.graphics.newText(font, {{1,1,1}, "Return to Main Menu"})

local credits_header = love.graphics.newText(font, {{1,1,1}, "Credits:"})
local credits_line_1 = love.graphics.newText(font, {{1,1,1}, "Game Programmer: Pierre De Agostini-Frometa"})
local credits_line_2 = love.graphics.newText(font, {{1,1,1}, "Initial Idea: Jonathan Diaz"})
local credits_line_3 = love.graphics.newText(font, {{1,1,1}, "Initial Inspiration: Bradley Sultz"})

local credits_holder = {
    credits_line_1,
    credits_line_2,
    credits_line_3
}

local unclearable_buttons = {
    "Return_Main_Menu"
}

return function(resolution)
    Buttons_Manager.clear_buttons(unclearable_buttons)
    -- Border:
    local inner_border_x = 0.0625 * resolution.X
    local inner_border_y = 0.05 * resolution.Y
    local inner_border_size_x = 0.875 * resolution.X
    local inner_border_size_y = 0.95 * resolution.Y
    local inner_border_right_corner = inner_border_x + inner_border_size_x

    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("line", inner_border_x, inner_border_y, inner_border_size_x, inner_border_size_y)

    -- Draw the header for the credits.
    love.graphics.draw(credits_header, 0.15 * resolution.X, 0.05 * resolution.Y, 0, 2, 2)


    -- Create the individual lines of the credits.
    local current_y_position = 0.1
    for index, credit_line in pairs(credits_holder) do
        -- increment the y position by the index
        love.graphics.draw(credit_line, 0.15 * resolution.X, current_y_position * resolution.Y, 0)
        current_y_position = current_y_position + 0.05
    end

    -- Create the home button
    love.graphics.draw(return_home_text, 0.335 * resolution.X, 0.55 * resolution.Y, 0, 2)

    love.graphics.rectangle("line", 0.375 * resolution.X, 0.6 * resolution.Y, 0.25 * resolution.X, 0.25 * resolution.X)
    love.graphics.draw(home_button_img, 0.375 * resolution.X, 0.6 * resolution.Y, 0, 0.25)

    -- Initialize the button.
    Buttons_Manager.add_button(
        {
            ["X"] = 0.375 * resolution.X,
            ["Y"] = 0.6 * resolution.Y
        },
        {
            ["X"] = 0.25 * resolution.X,
            ["Y"] = 0.25 * resolution.Y
        },
        "Return_Main_Menu"
    )
end