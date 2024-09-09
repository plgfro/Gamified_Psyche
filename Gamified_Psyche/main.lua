-- DEV PROCESS:
--[[
* Create Events
    * For simplicity's sake, events will be very barebones.
    * Each event will be formatted this way: {
            Name: (name displayed on the top)
            Description: (what the player can read)
            Decisions: {
                Decision_Objects_1,2,3, and 4
            }

            end_event()
                determine_choice() function (takes in decision number), returns a table of new weights to "merge" with the main table.
    }
    Event_Weights object: {
            table of each event and its current probability. determine_weight() will loop through each event.
            (this is a very inefficient process because of the number of events & the number of redundant ones, too, but it should work for now)
    }
    Player object: {
            name
            description
            predispositions to disorders {
                table of key-value pairs of key being disorder name, value being the current predisposition. disorders that cannot exist with eachother ex: (ADHD AND SCHIZOPHRENIA) will be negated if discovered.
            },
            past_decisions: (provides the event and the decision taken. may not include as it may need to reconstruct the entire probabilities table each iteration, which is strange)
    }
    Game Manager: {
            Handles the primary game logic, functions:
            select_event(Player, Current_Weights) -- Picks an event from the weights table and returns an Event object.
            load_event() -- This loads the event into the game
            evaluate_event_decision() -- This is called when the player clicks a button, recalibrates the Event Weights table, and then returns the event used
    },
    Renderer {
        Handles the gui stuff (the boooring stuff :yawn:)
        Renderer.new_event() -- This takes in an event object and shows the popup screen for an event.
        Renderer.main_menu() -- Shows the main menu... duh?
        Renderer.
    }

]]--

local timers = require("Timer")
local game_manager = require("Game_Manager")
game_manager.gui_toggles.main_menu = true -- Starts as true at the beginning of the game.
local Renderer = require("Renderer")

love.window.setTitle("Gamified Psyche")

function love.mousepressed(x, y, button, touch_screen, presses)
    -- Process if it was a button.
    local coords = {
        ["X"] = x,
        ["Y"] = y
    }
    local potential_button_to_trigger = game_manager.buttons_subsection.buttons[coords]
    if potential_button_to_trigger then
        potential_button_to_trigger.Function()
    end
end

function love.update(delta_time)
    timers.check_alarms(delta_time)
end

function love.draw()
    local resolution = Renderer.get_resolution()
    for gui_name, value in pairs(game_manager.gui_toggles) do -- allows for ease of adding new guis
        if value then
            -- This is the first time i nest an if statement 
            -- in a for loop because its Lua not LuaU :(
            Renderer.load_object(resolution, gui_name)
        end
    end 
    -- Potential issue with this for loop is order (its a dictionary), so either create a separate gui for each possibility of the game menu, and load each one separately, or embed it all into the game.lua.
    -- A possible solution is to create a separate list involving load order, which will be a looping linearly, then taking the value as a key to this dict.
    -- New solution is make the gui innately able to support multiple, and make the guis toggle them.
end
-- TODO: Work on creating the proper initialization of the game
-- (Creating a player, adding the proper progression through Events, which will be done
-- By creating an events tab, and an Events Manager (Found in Handler.lua), which will load in events, calculate the probabilities for an event, roll them, and evaluate them.
-- Everytime an event happens, it will automatically load the generic events gui, feeding data into Game_Manager's variables.
-- Each individual button "A, B, C, and D" will have their own function associated with the event,
-- All of which will universally call back to the Event Manager.
-- Each of these buttons have special event attachments that they will add or remove probabilities from other events
-- When a button is hooked (it wil lbe in the respective Choice_1.lua, Choice_2, etc..)
-- It will have a direct callback to Event Manager, 
-- loading the corresponding event to that button, which is stored in
-- Game_Manager.button_event_correspondences

-- The actual probabilities of an event will be stored in Events_Manager.event_probabilities,
-- Will simply be a frequency table of the event's name out of idk, 100 events that are constantly recalibrated.
-- Doing this because I don't have time to do proper probability stats rn

-- TODO: Create a function that switches on & off guis such as probability button -> home button stuff (to make it easier to do so)
