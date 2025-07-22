local LevelBonus = {}
local Math = require("Utility/MathHandler")

local startedTracking = false
local lastTrackedLevel = -1
local levelsAlreadyRewarded = {}

function LevelBonus.applyBonusesForLevel(level)
    if levelsAlreadyRewarded[level] then return end
    levelsAlreadyRewarded[level] = true

    local player = GetPlayer()
    if not player then return end

    local stats = Game.GetStatsSystem()
    local playerID = player:GetEntityID()

    stats:RemoveAllModifiers(playerID, "BTL_LevelBonus")

    local bonus = Math.getLevelBonus(level)
    if not bonus then return end

    local entries = {
        { stat = gamedataStatType.Health, value = bonus.health },
        { stat = gamedataStatType.Armor, value = bonus.armor },
        { stat = gamedataStatType.Stamina, value = bonus.stamina }
    }

    for _, entry in ipairs(entries) do
        local mod = RPGManager.CreateStatModifier(entry.stat, gameStatModifierType.Additive, entry.value)
        mod.group = "BTL_LevelBonus"
        stats:AddModifier(playerID, mod)
    end
end

function LevelBonus.update()
    local player = Game.GetPlayer()
    local devData = player and PlayerDevelopmentSystem.GetData(player)
    if not devData then return end

    local currentLevel = devData:GetProficiencyLevel(gamedataProficiencyType.Level)

    if not startedTracking and currentLevel > 60 then
        startedTracking = true
        lastTrackedLevel = currentLevel
        for lvl = 61, currentLevel do
            LevelBonus.applyBonusesForLevel(lvl)
        end
    end

    if startedTracking and currentLevel ~= lastTrackedLevel then
        local step = Math.getLevelStep(lastTrackedLevel, currentLevel)
        for lvl = lastTrackedLevel + step, currentLevel, step do
            LevelBonus.applyBonusesForLevel(lvl)
        end
        lastTrackedLevel = currentLevel
    end
end

return LevelBonus
