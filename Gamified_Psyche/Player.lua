local Player = {}

Player.create_player = function(name, age, disorder_probabilities)
    if not name then
        name = "UNKNOWN"
    end
    if not age then
        age = "0"
    end
    if not disorder_probabilities then
        disorder_probabilities = {}
    end
    return {
        ["Name"] = name,
        ["Age"] = age,
        ["Disorder_Chances"] = disorder_probabilities,
        ["Diagnosed_Disorders"] = {},
        ["Passions"] = {} -- Unlocks as one goes through life.
    }
end
return Player