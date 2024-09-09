local Game_Manager = require("Game_Manager")
local Events_Manager = require("Events_Manager")
local Buttons_Manager = require("Buttons_Manager")
local Timer_Manager = require("Timer")

local unclearable_buttons = {
    ["Next_Scenario"] = true,
    ["Home"] = true,
    ["Disorder_Probability_Button"] = true,
    ["Choice_1"] = true,
    ["Choice_2"] = true,
    ["Choice_3"] = true,
    ["Choice_4"] = true
}
local font = love.graphics.getFont()
local text_object = love.graphics.newText(font, "")
local alarm = false
Game_Manager.globals.characters_until_new_line = 0
local increment_content = false

return function(resolution) -- Fix bug where clicking the probability sign to view probabilities before making a decision glitches game out.
    Buttons_Manager.clear_buttons(unclearable_buttons)
    if Events_Manager.current_increment == 0 then
        Game_Manager.globals.characters_until_new_line = Events_Manager.current_increment
    end
    if not alarm and Events_Manager.current_increment < #Events_Manager.current_event_description then
        Timer_Manager.set_alarm(.025, function()
            if not increment_content then
                Events_Manager.current_increment = Events_Manager.current_increment + 1
                    Game_Manager.globals.characters_until_new_line = Game_Manager.globals.characters_until_new_line + 1
                increment_content = true
            end
            alarm = false
        end)
        alarm = true
    end
    local content = Events_Manager.current_event_description

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
    local primary_frame_size_y = 0.3 * resolution.Y
    love.graphics.rectangle("line", text_frame_border_x, text_frame_border_y, primary_frame_size_x, primary_frame_size_y)

    -- Now, draw the text. It will vary per frame....
    if increment_content then
        local text_object = Events_Manager.displayed_event_description
        text_object = text_object..string.sub(Events_Manager.current_event_description, Events_Manager.current_increment, Events_Manager.current_increment)
        if Game_Manager.globals.characters_until_new_line >= 69 then
            Game_Manager.globals.characters_until_new_line = 0
            text_object = text_object.."\n"
        end
        increment_content = false
        Events_Manager.displayed_event_description = text_object
    end
    text_object:set(Events_Manager.displayed_event_description)
    love.graphics.draw(text_object, text_frame_border_x, text_frame_border_y)

    -- Answer Choices
    local current_answer_choice_coordinate = {
        ["X"] = 0.15 * resolution.X,
        ["Y"] = 0.625 * resolution.Y
    }
    local answer_choice_size = {
        ["X"] = 0.3 * resolution.X,
        ["Y"] = 0.125 * resolution.Y
    }
    local answer_choice_coordinates_info = {}

    for i = 1, 4 do -- For the 4 answer choices.
        answer_choice_coordinates_info[i] = { -- This is so it can create buttons out of them. There is a more efficient way to do this, but it's 8:45 pm and I'm tired.
            ["X"] = current_answer_choice_coordinate.X,
            ["Y"] = current_answer_choice_coordinate.Y
        }
        love.graphics.rectangle("line", current_answer_choice_coordinate.X, current_answer_choice_coordinate.Y, answer_choice_size.X, answer_choice_size.Y)
        current_answer_choice_coordinate.X = current_answer_choice_coordinate.X + (0.4 * resolution.X)
        if i%2 == 0 then
            current_answer_choice_coordinate.X = 0.15 * resolution.X
            current_answer_choice_coordinate.Y = current_answer_choice_coordinate.Y + (0.15 * resolution.Y)
        end
    end

    -- Generate text out of the answer choices
    for index, answer_choice_coordinate in pairs(answer_choice_coordinates_info) do
        -- This is only going to work when Events_Manager.current_event is existent, but this gui never pops up unless it is, so, so here we go.
        local choice_desc = Events_Manager.current_event.Choices[index].Content
        local current_text = ""
        local new_lines = math.ceil(#choice_desc/27) -- 27 characters until a new line.
        for i = 1, new_lines do
            current_text = current_text..string.sub(choice_desc, (i - 1)*27, i*27).."\n" -- Slices of 27.
        end
        text_object:set(current_text)
        love.graphics.draw(text_object, answer_choice_coordinate.X, answer_choice_coordinate.Y)
    end

    -- Create buttons out of the answer choices. (finally.)
    for index, answer_choice_coordinate in pairs(answer_choice_coordinates_info) do
        local button_name = "Choice_"..index
        Buttons_Manager.add_button(
            answer_choice_coordinate,
            answer_choice_size,
            button_name
        )
    end
end