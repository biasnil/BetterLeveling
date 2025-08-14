local persistModules = {}

local Core                  = require("Modules/LevelingCore")
local StartupTweaks         = require("Function/StartupTweaks")
local attrUnlock            = require("Function/AttributeUnlocked")
local attrBonus             = require("Function/AttributeBonus")
local levelBonus            = require("Function/LevelBonus")
local cyberprogress         = require("Function/MoreCyberwareCapacity")
local Math                  = require("Utility/MathHandler")

-- single source of truth for attribute stat types
local STAT_TYPES = {
    Reflexes         = gamedataStatType.Reflexes,
    Cool             = gamedataStatType.Cool,
    Strength         = gamedataStatType.Strength,
    TechnicalAbility = gamedataStatType.TechnicalAbility,
    Intelligence     = gamedataStatType.Intelligence
}

local function getDevData()
    local p = Game and Game.GetPlayer()
    return p and PlayerDevelopmentSystem.GetData(p) or nil
end

local lastAttrValues = {}
local baseApplied    = false
local bonusApplied   = false
local xpApplied      = false
local attrPerkApplied = false -- NEW: install extra-points-on-level once

-- Apply things that are pure "push settings into game" once per boot
function persistModules.applyBaseSettings()
    local cfg = Core.curSettings or Core.loadSettings()

    if cfg.FeatureFlags.StartingAttr then
        StartupTweaks:apply(cfg)
    end
    if cfg.FeatureFlags.AttributeCap then
        attrUnlock:applyAttributeCap(cfg.AttributeCap)
    end
    if cfg.FeatureFlags.CyberwareScaling then
        cyberprogress:apply(cfg)
    end
end

function persistModules.tryApplyBonusIfNeeded()
    if not Core.curSettings.FeatureFlags.AttributeBonus then return false end

    local devData = getDevData()
    if not devData then return false end

    for _, stat in pairs(STAT_TYPES) do
        local value = devData:GetAttributeValue(stat)
        if Math.shouldApplyAttributeBonus(value) then
            attrBonus:apply()
            return true
        end
    end

    return false
end

local function checkAttributeChanges()
    if not Core.curSettings.FeatureFlags.AttributeBonus then return end

    local devData = getDevData()
    if not devData then return end

    for name, stat in pairs(STAT_TYPES) do
        local current = devData:GetAttributeValue(stat)
        local last    = lastAttrValues[name]
        if last == nil or current > last then
            attrBonus:apply()
        end
        lastAttrValues[name] = current
    end
end

function persistModules.handleUpdate(dt)
    local devData = getDevData()
    if not devData then return end

    if not baseApplied then
        baseApplied = true

        Core.curSettings = Core.loadSettings()
        Core.refreshVariables()
        persistModules.applyBaseSettings()

        for name, stat in pairs(STAT_TYPES) do
            lastAttrValues[name] = devData:GetAttributeValue(stat)
        end
    end

    if baseApplied and not bonusApplied then
        bonusApplied = persistModules.tryApplyBonusIfNeeded()
    end

    if baseApplied then
        checkAttributeChanges()

        if Core.curSettings.FeatureFlags.LevelBonus
            and levelBonus and type(levelBonus.update) == "function" then
            levelBonus.update()
        end

        if Core.curSettings.FeatureFlags.XPMultiplier and not xpApplied then
            xpApplied = true
            local xpMod = require("Function/XPMultiplier")
            xpMod:apply()
        end

        local ff = Core.curSettings.FeatureFlags or {}
        if (ff.MoreAttrPerLevel or ff.MorePerkPerLevel) and not attrPerkApplied then
          attrPerkApplied = true
          local ap = require("Function/AttributeandPerkperLevel")
          ap:apply()
        end
    end

    local q = Core.deferredQueue
    if q and #q > 0 then
        local task = table.remove(q, 1)
        local ok, err = pcall(task.func)
    end
end

return persistModules
