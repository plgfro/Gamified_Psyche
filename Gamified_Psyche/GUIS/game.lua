-- The game is formatted like so:

--[[
1: Open Body of Text. This will contain the scenario.
2: Answer Choices (only a function that will toggle on & off these answer choices.)
3: Another gui that is presented that will explain the Psychology term(s) 
related to your answer choice that you picked.
]]--
local Buttons_Manager = require("Buttons_Manager")
local game_manager = require("Game_Manager")

local font = love.graphics.getFont()
local previous_name = ""
local previous_age = -1
local text_scale_factor = 3.5

local function get_text_border_size(text_obj, scale_factor, resolution)
    return {
        ["X"] = text_obj:getWidth() * scale_factor + 0.03*resolution.X,
        ["Y"] = text_obj:getHeight() * scale_factor + 0.015*resolution.Y
    }
end
-- Image object initializers:
local probability_sign = love.graphics.newImage("Assets/probability_sign.png")

-- Text object initializers:
local name_text
local age_text

-- More caching
local unclearable_buttons = { -- This gui is able to run all of these buttons at the same time. We need to create dynamic inheritance so that whenever a new gui is loaded at the same time as one, the older uis temporarily inherit this list. (another solution is im not sure but again we've got barely any time left we cant implement 1 now)
    ["Disorder_Probability_Button"] = true,
    ["Home"] = true, 
    ["Choice_1"] = true,
    ["Choice_2"] = true,
    ["Choice_3"] = true,
    ["Choice_4"] = true,
    ["Next_Scenario"] = true
}

return function(resolution) -- This is the draw function.
    Buttons_Manager.clear_buttons(unclearable_buttons)
    -- Caching
    local last_right_corner = 0 -- This contains the x position for the previous right corner
    
    -- Border
    local inner_border_x = 0.0625 * resolution.X
    local inner_border_y = 0.05 * resolution.Y
    local inner_border_size_x = 0.875 * resolution.X
    local inner_border_size_y = 0.95 * resolution.Y
    local inner_border_right_corner = inner_border_x + inner_border_size_x

    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("line", inner_border_x, inner_border_y, inner_border_size_x, inner_border_size_y)

    -- Headers

    -- Verify the name has not changed.
    if game_manager.player_object.Name ~= previous_name then
        previous_name = game_manager.player_object.Name
        name_text = love.graphics.newText(font, {{1,1,1}, previous_name})
    end
    if game_manager.player_object.Age ~= previous_age then 
        previous_age = game_manager.player_object.Age
        age_text = love.graphics.newText(font, {{1,1,1}, previous_age.." yrs old"})
    end
    -- These if statements are "expensive". There needs to be a better way to do this.
    local box_offset_x = 0.01*resolution.X
    local box_offset_y = 0.01*resolution.Y
    local name_holder_size = get_text_border_size(name_text, text_scale_factor, resolution)

    last_right_corner = inner_border_x
    love.graphics.rectangle("line", inner_border_x, inner_border_y, name_holder_size.X, name_holder_size.Y) -- Name holder
    love.graphics.draw(name_text, last_right_corner + box_offset_x, inner_border_y + box_offset_y, 0, text_scale_factor)

    last_right_corner = last_right_corner + name_holder_size.X
    -- Age
    local age_holder_size = get_text_border_size(age_text, text_scale_factor, resolution)
    love.graphics.rectangle("line", last_right_corner, inner_border_y, age_holder_size.X, age_holder_size.Y)
    love.graphics.draw(age_text, last_right_corner + box_offset_x, inner_border_y + box_offset_y, 0, text_scale_factor)

    last_right_corner = last_right_corner + age_holder_size.X

    -- Now that the headers have been created, determine whether or not to show the percent or the home button.
    if not game_manager.gui_toggles.disorder_probabilities then
        Buttons_Manager.add_button({
            ["X"] = inner_border_right_corner - 0.1425*resolution.X,
            ["Y"] = inner_border_y
        },
        {
            ["X"] = 0.1375*resolution.X,
            ["Y"] = 0.1375*resolution.X
        },
        "Disorder_Probability_Button"
        )
        love.graphics.rectangle("line", inner_border_right_corner - 0.1375*resolution.X, inner_border_y, 0.1375*resolution.X, 0.1375*resolution.X)
        love.graphics.draw(probability_sign, inner_border_right_corner - 0.1425*resolution.X, inner_border_y, 0, 0.14)
    end
end