local Game_Manager = require("Game_Manager")
local Choice_Manager = {}

Choice_Manager.current_choice_description = "" -- For the text crawl feature but for Choice Manager.
Choice_Manager.displayed_choice_outcome = ""
Choice_Manager.current_increment = 0

Choice_Manager.new = function(description, choice_completed, choice_outcome_description)
    local choice_table = {}
    if not description then
        description = "There is no description for this event. Congrats on breaking the 4th wall."
    end
    if not choice_completed then
        choice_completed = function() end
    end
    if not choice_outcome_description then
        choice_outcome_description = "There are no terms associated with this event, or you have broken the 4th wall. Congrats."
    end
    choice_table.Content = description
    choice_table.Completed_Function = choice_completed
    choice_table.Choice_Outcome_Desc = choice_outcome_description
    return choice_table
end

Choice_Manager.end_choice = function(choice_made)
    Game_Manager.gui_toggles.scenario_answer_choices = false
    Game_Manager.gui_toggles.scenario_outcome = true

    Game_Manager.globals.characters_until_new_line = 0
    Choice_Manager.current_increment = 0
    Choice_Manager.displayed_choice_outcome = ""
    Choice_Manager.current_choice_description = ""
    Choice_Manager.current_choice = choice_made
end

return Choice_Manager