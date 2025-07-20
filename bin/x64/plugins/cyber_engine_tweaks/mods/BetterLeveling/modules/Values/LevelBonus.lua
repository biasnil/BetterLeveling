local LevelBonus = {}

local startedTracking = false
local lastTrackedLevel = -1
local levelsAlreadyRewarded = {}

-- Tiers for health, armor, stamina
local tiers = {
    { min = 61, max = 99, hp = 50, armor = 50, stamina = 10 },
    { min = 100, max = 199, hp = 100, armor = 100, stamina = 50 },
    { min = 200, max = math.huge, hp = 500, armor = 500, stamina = 100 }
}

function LevelBonus.applyBonusesForLevel(level)
    if levelsAlreadyRewarded[level] then return end
    levelsAlreadyRewarded[level] = true

    local player = GetPlayer()
    if not player then return end

    local stats = Game.GetStatsSystem()
    local playerID = player:GetEntityID()

    -- Remove old modifiers in this group
    stats:RemoveAllModifiers(playerID, "BTL_LevelBonus")

    for _, tier in ipairs(tiers) do
        if level >= tier.min and level <= tier.max then
            local bonuses = {
                { stat = gamedataStatType.Health, value = tier.hp },
                { stat = gamedataStatType.Armor, value = tier.armor },
                { stat = gamedataStatType.Stamina, value = tier.stamina }
            }
            for _, bonus in ipairs(bonuses) do
                local mod = RPGManager.CreateStatModifier(bonus.stat, gameStatModifierType.Additive, bonus.value)
                mod.group = "BTL_LevelBonus"
                stats:AddModifier(playerID, mod)
            end
            break
        end
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
        local step = currentLevel > lastTrackedLevel and 1 or -1
        for lvl = lastTrackedLevel + step, currentLevel, step do
            LevelBonus.applyBonusesForLevel(lvl)
        end
        lastTrackedLevel = currentLevel
    end
end

return LevelBonus
