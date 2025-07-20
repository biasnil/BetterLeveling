local Core = require("modules/LevelingCore")
local UI = require("modules/LevelingUI")
local CyberwareUnlocked = require("modules/Addon/CyberwareUnlocked")
require("PersistModules")

registerForEvent("onTweak", function()
    Core.curSettings = Core.loadSettings() or Core.Globals
    Core.refreshVariables()
    Core.applyCyberwareCap()
end)

registerForEvent("onInit", function()
    Core.curSettings = Core.loadSettings() or {
        NewLevelCap = 60,
        MaxStartingAttribute = 6,
        StartingAttributePoints = 7,
        Language = 1,
        AttributeCap = 20,
        MoreCyberwareCapacity = 6,
        StreetCredCap = 50,
        CyberwareCap = 1000
    }

    Core.saveSettings()
    Core.refreshVariables()

    Core.applyFixesPersist()
    Core.applyChangeableValue()
    Core.applyStreetCredCap()

    UI.buildUI()
end)
