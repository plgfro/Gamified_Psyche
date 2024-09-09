local Buttons_Manager = {}
local Actual_Buttons_Holder = {}
local Buttons_MT = {} -- This is the metatable that dictates what key-value pairs there are.
local button_functions = {}

local function get_button_function(button_name)
    if button_functions[button_name] then
       return button_functions[button_name]
    end
    button_functions[button_name] = require("Buttons_Functionality."..button_name)
    return button_functions[button_name]
end

function string_split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

Buttons_MT.__index = function(self, coordinates_index)
    -- This is going to provide a coordinates index within a point in space.
    for button_name, button_boundaries in pairs(Actual_Buttons_Holder) do
        button_boundaries = string_split(button_boundaries, ":")
        local top_left_coords = string_split(button_boundaries[1], ",")
        local bottom_right_coords = string_split(button_boundaries[2], ",")
        local successful = true
        if coordinates_index.X < tonumber(top_left_coords[1]) then
            successful = false
        end
        if coordinates_index.Y < tonumber(top_left_coords[2]) then
            successful = false
        end
        if coordinates_index.X > tonumber(bottom_right_coords[1]) then
            successful = false
        end
        if coordinates_index.Y > tonumber(bottom_right_coords[2]) then
            successful = false
        end

        if successful then -- Does the "simulation" of a continue statement, but not flow-wise.
            return {
                ["Name"] = button_name,
                ["Function"] = get_button_function(button_name)
            }
        end
    end
    return false
end

Buttons_MT.__newindex = function(self, index, value)
    return error("Attempt to add to buttons list manually.")
end
-- Not adding a newindex method because it is handled by add_button

Buttons_Manager.buttons = {}
Buttons_Manager.add_button = function(top_left_position, size, button_name)
    if Actual_Buttons_Holder[button_name] then
        return
    end
    local bottom_right_position = {
        ["X"] = top_left_position.X + size.X,
        ["Y"] = top_left_position.Y + size.Y
    }
    local coordinates = tostring(top_left_position.X)..","..tostring(top_left_position.Y)..":"..tostring(bottom_right_position.X)..","..tostring(bottom_right_position.Y)
    Actual_Buttons_Holder[button_name] = coordinates
end
setmetatable(Buttons_Manager.buttons, Buttons_MT)

Buttons_Manager.remove_button = function(button_name)
    Actual_Buttons_Holder.buttons[button_name] = nil
end
Buttons_Manager.clear_buttons = function(buttons_not_to_clear)
    for button_name, coordinate in pairs(Actual_Buttons_Holder) do
        if not buttons_not_to_clear[button_name] then
            Actual_Buttons_Holder[button_name] = nil
        end
    end
end
return Buttons_Manager
