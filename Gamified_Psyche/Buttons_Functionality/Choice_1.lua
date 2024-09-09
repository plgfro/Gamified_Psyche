local Events_Manager = require("Events_Manager")
local Choice_Manager = require("Objects.Choice_Manager")

return function()
    local current_event = Events_Manager.current_event
    local choice = current_event.Choices[1]
    Events_Manager.ending_event(current_event)
    choice.Completed_Function()
    Choice_Manager.end_choice(choice)
end