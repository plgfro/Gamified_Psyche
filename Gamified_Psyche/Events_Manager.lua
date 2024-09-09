local Events_Manager = {}
local Game_Manager = require("Game_Manager")

local function get_events()
    local events = {}
    local event_files = love.filesystem.getDirectoryItems("Events")
    for index, event_name in pairs(event_files) do
        event_name = string.sub(event_name, 1, #event_name - 4) -- Cuts off the .lua extension.
        local event = require("Events."..event_name)
        
        table.insert(events, event)
    end
    return events
end

Events_Manager.past_events = {}
Events_Manager.events = get_events()
Events_Manager.event_probabilities = {}

Events_Manager.current_event_description = ""
Events_Manager.displayed_event_description = ""
Events_Manager.current_increment = 0

Events_Manager.current_event = Events_Manager.events[1]
Events_Manager.current_event_description = Events_Manager.current_event.Content
Events_Manager.chosen_choice = nil

Events_Manager.calculate_event_probabilities = function() -- God save me. 10:57 P.M
    for index, event in pairs(Events_Manager.events) do
        local event_given_probability = event.Probability_Calculation(Events_Manager.past_events)
        Events_Manager.event_probabilities[event.Name] = event_given_probability
        if event_given_probability <= 0 then
            Events_Manager.event_probabilities[event.Name] = nil -- It has a 0% chance of happening. Might as well not include it in the pool.
        end
    end -- TODO: change the algorithm here so that every event has its reported amount of occurring.
end

Events_Manager.find_event = function(event_name)
    for index, event in pairs(Events_Manager.events) do
        if event.Name == event_name then
            return event
        end
    end
end

Events_Manager.get_total_available_events = function()
    local events_number = 0
    for event_name, value in pairs(Events_Manager.event_probabilities) do
        events_number = events_number + 1
    end
    return events_number
end

Events_Manager.ending_event = function(event)
    table.insert(Events_Manager.past_events, event)
    event.Event_Ended()
end

Events_Manager.choose_event = function()
    math.randomseed(os.clock())
    local available_events = Events_Manager.get_total_available_events()
    if available_events <= 0 then
        return Events_Manager.find_event("TEMPLATE")
    end
    if available_events == 1 then -- There's only one possible event. Not going to go into the loop.
        for event_name, event in pairs(Events_Manager.event_probabilities) do
            return Events_Manager.find_event(event_name)
        end
    end

    local random_event
    while not random_event do
        -- Going with the naive approach of randomly selecting & then proceeding to select 1 from the list of available events..
        -- Select a random event from
        local random_event_index = math.random(1, #Events_Manager.events)
        local event = Events_Manager.events[random_event_index]
        if Events_Manager.event_probabilities[event.Name] then
            if math.random() < Events_Manager.event_probabilities[event.Name] then
                random_event = event
                break
            end
        end
    end
    return random_event
end

Events_Manager.find_event = function(current_name)
    for i, event in pairs(Events_Manager.events) do
        if event.Name == current_name then
            return event
        end
    end
end

Events_Manager.load_event = function(event_name)
    Events_Manager.current_event_description = ""
    Events_Manager.displayed_event_description = ""
    Events_Manager.current_increment = 0
    
    Events_Manager.current_event = Events_Manager.find_event(event_name)
    Events_Manager.current_event_description = Events_Manager.current_event.Content
    Events_Manager.chosen_choice = nil

    Game_Manager.gui_toggles.scenario_answer_choices = true
    Game_Manager.gui_toggles.scenario_outcome = false
end
-- TODO: Work on the Next Scenario button, make it actually work.

return Events_Manager