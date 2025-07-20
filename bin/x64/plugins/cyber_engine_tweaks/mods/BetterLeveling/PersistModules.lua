local persistModules = {}

local Core       = require("modules/LevelingCore")
local fixpers    = require("modules/Values/FixesPersist")
local attrUnlock = require("modules/Values/AttributeUnlocked")
local attrBonus  = require("modules/Values/AttributeBonus")
local levelBonus = require("modules/Values/LevelBonus")
local cyberprogress   = require("modules/Values/MoreCyberwareCapacity")

function persistModules.applyBaseSettings()
    local file = io.open("Data/config.json", "r")
    if not file then
        return
    end

    local content = file:read("*a")
    file:close()

    local ok, config = pcall(function() return json.decode(content) end)
    if not ok or not config then
        return
    end

    fixpers:apply(config)
    attrUnlock:applyAttributeCap(config.AttributeCap)
    cyberprogress:apply(config)
end

function persistModules.tryApplyBonusIfNeeded()
    local player = Game and Game.GetPlayer()
    local devData = player and PlayerDevelopmentSystem.GetData(player)
    if not devData then return end

    local attributes = {
        gamedataStatType.Reflexes,
        gamedataStatType.Cool,
        gamedataStatType.Strength,
        gamedataStatType.TechnicalAbility,
        gamedataStatType.Intelligence
    }

    for _, attr in ipairs(attributes) do
        if devData:GetAttributeValue(attr) > 20 then
            attrBonus:apply()
            return true
        end
    end

    return false
end

local lastAttrValues = {}

local function checkAttributeChanges()
    local player = Game and Game.GetPlayer()
    local devData = player and PlayerDevelopmentSystem.GetData(player)
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

local baseApplied = false
local bonusApplied = false

registerForEvent("onUpdate", function()
    local player = Game and Game.GetPlayer()
    local devData = player and PlayerDevelopmentSystem and PlayerDevelopmentSystem.GetData(player)

    if not baseApplied and devData then
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

        if levelBonus and type(levelBonus.update) == "function" then
            levelBonus.update()
        else
            print("[BTL] levelBonus.update is not available (nil or not a function)")
        end
    end
end)

return persistModules
