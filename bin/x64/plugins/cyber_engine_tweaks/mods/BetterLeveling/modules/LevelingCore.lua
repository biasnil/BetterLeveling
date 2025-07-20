local Core = {}

Core.curSettings = nil

Core.Globals = {
    NewLevelCap = 60,
    MaxStartingAttribute = 6,
    StartingAttributePoints = 7,
    AttributeCap = 20,
    MoreCyberwareCapacity = 6,
    StreetCredCap = 50,
    CyberwareCap = 1000
}

local startingAttr = require("modules/Values/StartingAttribute")
local moreCyber = require("modules/Values/MoreCyberwareCapacity")

function Core.loadSettings()
    local file = io.open("Data/config.json", "r")
    if not file then
        return Core.Globals
    end
    local config = json.decode(file:read("*a"))
    file:close()
    return config or Core.Globals
end

function Core.saveSettings()
    local file = io.open("Data/config.json", "w")
    file:write(json.encode(Core.curSettings))
    file:close()
end

function Core.refreshVariables()
    Core.Globals.NewLevelCap = Core.curSettings.NewLevelCap
    Core.Globals.StreetCredCap = Core.curSettings.StreetCredCap or 50
    Core.Globals.MaxStartingAttribute = Core.curSettings.MaxStartingAttribute
    Core.Globals.StartingAttributePoints = Core.curSettings.StartingAttributePoints
    Core.Globals.AttributeCap = Core.curSettings.AttributeCap
    Core.Globals.MoreCyberwareCapacity = Core.curSettings.MoreCyberwareCapacity or 6
    Core.Globals.CyberwareCap = Core.curSettings.CyberwareCap or 1000
end

function Core.applyFixesPersist()
    require("modules/Values/FixesPersist"):apply(Core.curSettings)
    startingAttr:apply(Core.curSettings)
end

function Core.applyChangeableValue()
    require("modules/Values/ChangeableValue"):apply(Core.curSettings)
end

function Core.applyAttributeCap()
    require("modules/Values/AttributeUnlocked"):applyAttributeCap(Core.curSettings.AttributeCap)
end

function Core.applyAttributeBonuses()
    require("modules/Values/AttributeBonus"):apply()
end

function Core.applyMoreCyberwareCapacity()
    moreCyber:apply(Core.curSettings)
end

function Core.applyCyberwareCap()
    local cap = Core.Globals.CyberwareCap or 1000
    TweakDB:SetFlat("BaseStats.Humanity.max", cap)
    TweakDB:Update("BaseStats.Humanity.max")
    -- I am sorry... Its the only way.
    Core.Globals.CyberwareCap = Core.curSettings.CyberwareCap or 1000
end

function Core.applyStreetCredCap()
    local streetCred = require("modules/Values/StreetCredUnlocked")
    streetCred:apply(Core.curSettings.StreetCredCap)
end

function Core.reloadMods()
    Core.curSettings = Core.loadSettings() or Core.curSettings
    Core.refreshVariables()
    Core.applyFixesPersist()
    Core.applyAttributeCap()
    Core.applyAttributeBonuses()
    Core.applyMoreCyberwareCapacity()
    Core.applyChangeableValue()
end

return Core
