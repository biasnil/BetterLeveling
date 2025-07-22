local Core = require("Modules/LevelingCore")
local CyberwareUnlocked = {}

function CyberwareUnlocked:apply()
    Core.applyCyberwareCap()
end

return CyberwareUnlocked
