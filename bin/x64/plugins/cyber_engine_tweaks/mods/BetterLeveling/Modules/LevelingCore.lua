local Core = {}

local Constants = require("Utility/ConstantsHandler")
Core.curSettings = nil
Core.Globals = Constants.deepCopy(Constants.DefaultSettings)

-- Deferred reload queue
Core.deferredQueue = {}

function Core.defer(fn, label)
    table.insert(Core.deferredQueue, { func = fn, name = label or "unnamed" })
end

local startingAttr = require("Function/StartupTweaks")
local moreCyber = require("Function/MoreCyberwareCapacity")

function Core.loadSettings()
    local file = io.open("Data/config.json", "r")
    if not file then
        return Constants.deepCopy(Constants.DefaultSettings)
    end

    local ok, content = pcall(function() return json.decode(file:read("*a")) end)
    file:close()
    local config = ok and content or {}

    local flagsUpdated = false
    local xpUpdated = false

    -- Merge missing FeatureFlags if needed
    if not config.FeatureFlags then
        config.FeatureFlags = Constants.deepCopy(Constants.DefaultSettings.FeatureFlags)
        flagsUpdated = true
    else
        for k, v in pairs(Constants.DefaultSettings.FeatureFlags) do
            if config.FeatureFlags[k] == nil then
                config.FeatureFlags[k] = v
                flagsUpdated = true
            end
        end
    end

    -- Merge missing XPValues if needed
    if not config.XPValues then
        config.XPValues = Constants.deepCopy(Constants.DefaultSettings.XPValues)
        xpUpdated = true
    else
        for k, v in pairs(Constants.DefaultSettings.XPValues) do
            if config.XPValues[k] == nil then
                config.XPValues[k] = v
                xpUpdated = true
            end
        end
    end

    if flagsUpdated or xpUpdated then
        local fileOut = io.open("Data/config.json", "w")
        fileOut:write(json.encode(config))
        fileOut:close()
    end

    return config
end

function Core.saveSettings()
    local file = io.open("Data/config.json", "w")
    file:write(json.encode(Core.curSettings))
    file:close()
end

function Core.refreshVariables()
    Core.Globals.NewLevelCap = Core.curSettings.NewLevelCap
    Core.Globals.StreetCredCap = Core.curSettings.StreetCredCap or Constants.DefaultSettings.StreetCredCap
    Core.Globals.MaxStartingAttribute = Core.curSettings.MaxStartingAttribute
    Core.Globals.StartingAttributePoints = Core.curSettings.StartingAttributePoints
    Core.Globals.AttributeCap = Core.curSettings.AttributeCap
    Core.Globals.MoreCyberwareCapacity = Core.curSettings.MoreCyberwareCapacity or Constants.DefaultSettings.MoreCyberwareCapacity
    Core.Globals.CyberwareCap = Core.curSettings.CyberwareCap or Constants.DefaultSettings.CyberwareCap
    Core.Globals.XPValues = Core.curSettings.XPValues or Constants.DefaultSettings.XPValues
end

function Core.applyFixesPersist()
    if Core.curSettings.FeatureFlags.StartingAttr then
        require("Function/StartupTweaks"):apply(Core.curSettings)
        startingAttr:apply(Core.curSettings)
    end
end

function Core.applyChangeableValue()
    if Core.curSettings.FeatureFlags.LevelCap then
        require("Function/ChangeableValue"):apply(Core.curSettings)
    end
end

function Core.applyAttributeCap()
    if Core.curSettings.FeatureFlags.AttributeCap then
        require("Function/AttributeUnlocked"):applyAttributeCap(Core.curSettings.AttributeCap)
    end
end

function Core.applyAttributeBonuses()
    if Core.curSettings.FeatureFlags.AttributeBonus then
        require("Function/AttributeBonus"):apply()
    end
end

function Core.applyMoreCyberwareCapacity()
    if Core.curSettings.FeatureFlags.CyberwareScaling then
        moreCyber:apply(Core.curSettings)
    end
end

function Core.applyCyberwareCap()
    if not Core.curSettings.FeatureFlags.CyberwareCap then return end
    local cap = Core.Globals.CyberwareCap
    TweakDB:SetFlat("BaseStats.Humanity.max", cap)
    TweakDB:Update("BaseStats.Humanity.max")
end

function Core.applyStreetCredCap()
    if Core.curSettings.FeatureFlags.StreetCredCap then
        local streetCred = require("Function/StreetCredUnlocked")
        streetCred:apply(Core.curSettings.StreetCredCap)
    end
end

function Core.getXPModifierFor(typeName)
    if not Core.curSettings.FeatureFlags.XPMultiplier then
        return 1.0
    end
    return Core.curSettings.XPValues[typeName] or 1.0
end

function Core.reloadMods()
    Core.curSettings = Core.loadSettings() or Core.curSettings
    Core.refreshVariables()

    Core.defer(Core.applyFixesPersist, "FixesPersist")
    Core.defer(Core.applyAttributeCap, "AttributeCap")
    Core.defer(Core.applyAttributeBonuses, "AttributeBonuses")
    Core.defer(Core.applyMoreCyberwareCapacity, "CyberwareScaling")
    Core.defer(Core.applyChangeableValue, "ChangeableValue")
end

return Core
