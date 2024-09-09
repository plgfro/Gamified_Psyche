local Renderer = {}

-- Default resolution is 800 (x), 600 (y)
Renderer.get_resolution = function()
    return {
        ["X"] = love.graphics.getWidth(),
        ["Y"] = love.graphics.getHeight()
    }
end

Renderer.load_object = function(resolution, object_name)
    -- Goal: Load up everything within the main menu object.
    local object_to_load = require("GUIS."..object_name)
    object_to_load(resolution)
end

return Renderer