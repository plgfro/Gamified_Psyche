local home_button_img = love.graphics.newImage("Assets/house.png")
local Buttons_Manager = require("Buttons_Manager")
local Game_Manager = require("Game_Manager")
local disorders = require("Content.Disorders")

local unclearable_buttons = {
    ["Home"] = true
}
local function decimal_to_3_digits_string(decimal_number)
    decimal_number = tostring(decimal_number)
    local decimal_number_length = #decimal_number

    if decimal_number_length == 4 then
        return decimal_number
    end
    if decimal_number_length == 1 then -- Single digit number.
        return decimal_number..".00"
    end
    -- Figure out how many trailing zeroes to add.
    local decimals_to_add = 4 - decimal_number_length
    for i = 1, decimals_to_add do
        decimal_number = decimal_number.."0"
    end
    return decimal_number
end

local font = love.graphics.getFont()
local chances_texts = {} -- This is to optimize and avoid spamming newText everytime this gui is available.
local disorders_texts = {} -- This is also to optimize and avoid spamming newText.
for i = 1, 100 do
    chances_texts[decimal_to_3_digits_string(i/100)] = love.graphics.newText(font, decimal_to_3_digits_string(i/100)) 
end
for disorder_name, _ in pairs(disorders) do
    disorders_texts[disorder_name] = love.graphics.newText(font, disorder_name)
end

return function(resolution)
    Buttons_Manager.clear_buttons(unclearable_buttons)
    local inner_border_x = 0.0625 * resolution.X
    local inner_border_y = 0.05 * resolution.Y
    local inner_border_size_x = 0.875 * resolution.X
    local inner_border_size_y = 0.95 * resolution.Y
    local inner_border_right_corner = inner_border_x + inner_border_size_x

    local button_border_corner = inner_border_right_corner - 0.1375*resolution.X
    local button_border_size = 0.1375*resolution.X -- It is a square.

    -- Primary frame (shows the probabilities of a "disorder")
    local primary_frame_border_x = 0.1225 * resolution.X
    local primary_frame_border_y = 0.25 * resolution.Y
    local primary_frame_size_x = 0.7550 * resolution.X
    local primary_frame_size_y = 0.65 * resolution.Y

    local primary_frame_chance_left_corner_x = (0.8) * resolution.X

    love.graphics.rectangle("line", primary_frame_border_x, primary_frame_border_y, primary_frame_size_x, primary_frame_size_y)

    -- Populate the primary frame.
    local current_y_position_scale = 0.255
    for disorder_name, chance in pairs(Game_Manager.player_object.Disorder_Chances) do
        local text_object = disorders_texts[disorder_name]
        love.graphics.draw(text_object, primary_frame_border_x, current_y_position_scale * resolution.Y, 0, 2)

        local chance_text_object = chances_texts[decimal_to_3_digits_string(chance)]
        love.graphics.draw(chance_text_object, primary_frame_chance_left_corner_x, current_y_position_scale * resolution.Y, 0, 2)
        current_y_position_scale = current_y_position_scale + 0.05
    end

    -- Return home button.
    -- print(button_border_corner, inner_border_y)
    -- print(button_border_corner + button_border_size, inner_border_y + button_border_size)
    Buttons_Manager.add_button({
        ["X"] = button_border_corner,
        ["Y"] = inner_border_y
    },
    {
        ["X"] = button_border_size,
        ["Y"] = button_border_size
    },
    "Home"
    )
    
    love.graphics.rectangle("line", button_border_corner, inner_border_y, button_border_size, button_border_size)
    love.graphics.draw(home_button_img, inner_border_right_corner - 0.1375*resolution.X, inner_border_y, 0, 0.135)
end