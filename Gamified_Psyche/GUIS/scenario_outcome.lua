local Choice_Manager = require("Objects.Choice_Manager")
local Game_Manager = require("Game_Manager")
local Events_Manager = require("Events_Manager")
local Buttons_Manager = require("Buttons_Manager")
local Timer_Manager = require("Timer")

local font = love.graphics.getFont()
local text_object = love.graphics.newText(font, "")
local alarm = false
local increment_content = false

Game_Manager.globals.characters_until_new_line = 0

local load_new_scenario_txt = love.graphics.newText(font, "NEXT SCENARIO")
local load_new_scenario_img = love.graphics.newImage("Assets/plus_sign.png")

local house_img = love.graphics.newImage("Assets/house.png")
local return_main_menu_txt = love.graphics.newText(font, "RETURN TO MAIN MENU")

local unclearable_buttons = { -- This gui is able to run all of these buttons at the same time. We need to create dynamic inheritance so that whenever a new gui is loaded at the same time as one, the older uis temporarily inherit this list. (another solution is im not sure but again we've got barely any time left we cant implement 1 now)
    ["Disorder_Probability_Button"] = true,
    ["Home"] = true, 
    ["Next_Scenario"] = true,
    ["Main_Menu"] = true
}

return function(resolution)
    Buttons_Manager.clear_buttons(unclearable_buttons)
    local outcome_content = Choice_Manager.current_choice.Choice_Outcome_Desc
    if not tonumber(Game_Manager.globals.characters_until_new_line) then
        Game_Manager.globals.characters_until_new_line = 0
    end
    if not alarm and Choice_Manager.current_increment < #outcome_content then
        Timer_Manager.set_alarm(.025, function()
            if not increment_content then
                Choice_Manager.current_increment = Choice_Manager.current_increment + 1
                    Game_Manager.globals.characters_until_new_line = Game_Manager.globals.characters_until_new_line + 1
                increment_content = true
            end
            alarm = false
        end)
        alarm = true
    end -- TODO: Figure out how to use coroutines to make this better ^

     -- Primary frame
     local primary_frame_border_x = 0.1225 * resolution.X
     local primary_frame_border_y = 0.25 * resolution.Y
     local primary_frame_size_x = 0.7550 * resolution.X
     local primary_frame_size_y = 0.7 * resolution.Y
     love.graphics.rectangle("line", primary_frame_border_x, primary_frame_border_y, primary_frame_size_x, primary_frame_size_y)

     -- Text frame to load the text in.
    local text_frame_border_x = 0.15 * resolution.X
    local text_frame_border_y = 0.275 * resolution.Y
    local primary_frame_size_x = 0.7 * resolution.X
    local primary_frame_size_y = 0.25 * resolution.Y
    love.graphics.rectangle("line", text_frame_border_x, text_frame_border_y, primary_frame_size_x, primary_frame_size_y)

    if increment_content then
        local text_object = Choice_Manager.displayed_choice_outcome
        text_object = text_object..string.sub(outcome_content, Choice_Manager.current_increment, Choice_Manager.current_increment)
        if Game_Manager.globals.characters_until_new_line >= 69 then
            Game_Manager.globals.characters_until_new_line = 0
            text_object = text_object.."\n"
        end
        increment_content = false
        Choice_Manager.displayed_choice_outcome = text_object
    end
    text_object:set(Choice_Manager.displayed_choice_outcome)
    love.graphics.draw(text_object, text_frame_border_x, text_frame_border_y)

    -- New scenario button.
    local new_scenario_borders = {
        ["X"] = 0.4 * resolution.X,
        ["Y"] = 0.6 * resolution.Y
    }
    local new_scenario_size = {
        ["X"] = 0.2 * resolution.X,
        ["Y"] = 0.2 * resolution.X
    }
    love.graphics.rectangle("line", new_scenario_borders.X, new_scenario_borders.Y, new_scenario_size.X, new_scenario_size.Y)

    -- Images & Text :D
    if not Game_Manager.player_object.dead then
        love.graphics.draw(load_new_scenario_txt, new_scenario_borders.X + 0.0375 *resolution.X, new_scenario_borders.Y)
        love.graphics.draw(load_new_scenario_img, new_scenario_borders.X + 0.0175 *resolution.X, new_scenario_borders.Y + 0.04*resolution.Y, 0, 0.16)
    
        -- Initializing of the button.
        Buttons_Manager.add_button(new_scenario_borders, new_scenario_size, "Next_Scenario")
    else -- The player has died. :(
        love.graphics.draw(return_main_menu_txt, new_scenario_borders.X + 0.01 * resolution.X, new_scenario_borders.Y)
        love.graphics.draw(house_img, new_scenario_borders.X + 0.0175 *resolution.X, new_scenario_borders.Y + 0.04*resolution.Y, 0, 0.16)

        -- Initializing of the button.
        Buttons_Manager.add_button(new_scenario_borders, new_scenario_size, "Main_Menu")
    end
end