local ConstantsHandler = {}

-- Separate feature flag table for clarity
local defaultFlags = {
    LevelCap = true,
    StreetCredCap = true,
    AttributeCap = true,
    StartingAttr = true,
    CyberwareScaling = true,
    CyberwareCap = true,
    AttributeBonus = true,
    LevelBonus = true,

    -- XP Multiplier system
    XPMultiplier = true,
    XPMult_StreetCred = true,
    XPMult_Headhunter = true,
    XPMult_Netrunner = true,
    XPMult_Shinobi = true,
    XPMult_Solo = true,
    XPMult_Engineer = true,

    MoreAttrPerLevel = true,
    MorePerkPerLevel = true
}

-- Default XP multipliers (flat values)
local defaultXPValues = {
    Level = 1.0,
    StreetCred = 1.0,
    Headhunter = 1.0,
    Netrunner = 1.0,
    Shinobi = 1.0,
    Solo = 1.0,
    Engineer = 1.0
}

ConstantsHandler.FeatureFlags = defaultFlags
ConstantsHandler.XPValues = defaultXPValues

-- Default mod settings
ConstantsHandler.DefaultSettings = {
    NewLevelCap = 60,
    MaxStartingAttribute = 6,
    StartingAttributePoints = 7,
    AttributeCap = 20,
    MoreCyberwareCapacity = 6,
    StreetCredCap = 50,
    CyberwareCap = 1000,
    Language = 1,
    FeatureFlags = defaultFlags,
    XPValues = defaultXPValues,
    AttrPointsPerLevel = 1,
    PerkPointsPerLevel = 1
}

-- Utility to clone default settings
function ConstantsHandler.deepCopy(orig)
    local copy = {}
    for k, v in pairs(orig) do
        if type(v) == "table" then
            copy[k] = ConstantsHandler.deepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

-- Utility to conditionally run feature callbacks
function ConstantsHandler.ifEnabled(flag, fn)
    return function(...)
        local settings = require("Modules/LevelingCore").curSettings
        if settings and settings.FeatureFlags[flag] then
            return fn(...)
        end
    end
end

return ConstantsHandler
