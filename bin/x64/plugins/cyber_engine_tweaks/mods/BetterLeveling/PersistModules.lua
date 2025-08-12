local persistModules = {}

local Core           = require("Modules/LevelingCore")
local StartupTweaks  = require("Function/StartupTweaks")
local attrUnlock     = require("Function/AttributeUnlocked")
local attrBonus      = require("Function/AttributeBonus")
local levelBonus     = require("Function/LevelBonus")
local cyberprogress  = require("Function/MoreCyberwareCapacity")
local Math           = require("Utility/MathHandler")

local function getDevData()
    local p = Game and Game.GetPlayer()
    return p and PlayerDevelopmentSystem.GetData(p)
end

local lastAttrValues = {}
local baseApplied = false
local bonusApplied = false
local xpApplied = false

function persistModules.applyBaseSettings()
    local file = io.open("Data/config.json", "r")
    if not file then return end

    local content = file:read("*a")
    file:close()

    local ok, config = pcall(function() return json.decode(content) end)
    if not ok or not config then return end

    if config.FeatureFlags.StartingAttr then
        StartupTweaks:apply(config)
    end
    if config.FeatureFlags.AttributeCap then
        attrUnlock:applyAttributeCap(config.AttributeCap)
    end
    if config.FeatureFlags.CyberwareScaling then
        cyberprogress:apply(config)
    end
end

function persistModules.tryApplyBonusIfNeeded()
    if not Core.curSettings.FeatureFlags.AttributeBonus then return false end

    local devData = getDevData()
    if not devData then return false end

    local attributes = {
        gamedataStatType.Reflexes,
        gamedataStatType.Cool,
        gamedataStatType.Strength,
        gamedataStatType.TechnicalAbility,
        gamedataStatType.Intelligence
    }

    for _, attr in ipairs(attributes) do
        local value = devData:GetAttributeValue(attr)
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

    local statTypes = {
        Reflexes = gamedataStatType.Reflexes,
        Cool = gamedataStatType.Cool,
        Strength = gamedataStatType.Strength,
        TechnicalAbility = gamedataStatType.TechnicalAbility,
        Intelligence = gamedataStatType.Intelligence
    }

    for name, stat in pairs(statTypes) do
        local current = devData:GetAttributeValue(stat)
        local last = lastAttrValues[name] or 0
        if current > last then
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

        local statTypes = {
            Reflexes = gamedataStatType.Reflexes,
            Cool = gamedataStatType.Cool,
            Strength = gamedataStatType.Strength,
            TechnicalAbility = gamedataStatType.TechnicalAbility,
            Intelligence = gamedataStatType.Intelligence
        }

        for name, stat in pairs(statTypes) do
            lastAttrValues[name] = devData:GetAttributeValue(stat)
        end
    end

    if baseApplied and not bonusApplied then
        bonusApplied = persistModules.tryApplyBonusIfNeeded() or false
    end

    if baseApplied then
        checkAttributeChanges()

        if Core.curSettings.FeatureFlags.LevelBonus and levelBonus and type(levelBonus.update) == "function" then
            levelBonus.update()
        end

        if Core.curSettings.FeatureFlags.XPMultiplier and not xpApplied then
            xpApplied = true
            local xpMod = require("Function/XPMultiplier")
            xpMod:apply()
        end
    end

    if #Core.deferredQueue > 0 then
        local task = table.remove(Core.deferredQueue, 1)
        local ok, err = pcall(task.func)
        -- (optional) log err if not ok
    end
end

return persistModules
