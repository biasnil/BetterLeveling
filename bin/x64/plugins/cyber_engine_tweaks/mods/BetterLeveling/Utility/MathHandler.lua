local MathHandler = {}

function MathHandler.getAttributeBonus(statName, value)
    local over = value - 20
    if over <= 0 then return 0 end

    local bonusScales = {
        Reflexes = 0.5,
        Cool = 1.25,
        Strength = 2.0,
        TechnicalAbility = 2.0,
        Intelligence = nil
    }

    if statName == "Intelligence" then
        return math.max(math.floor(value / 4) - 5, 0)
    end

    local scale = bonusScales[statName]
    return scale and (over * scale) or 0
end

function MathHandler.getLevelBonus(level)
    local tiers = {
        { min = 61, max = 99, hp = 50, armor = 50, stamina = 10 },
        { min = 100, max = 199, hp = 100, armor = 100, stamina = 50 },
        { min = 200, max = math.huge, hp = 500, armor = 500, stamina = 100 }
    }

    for _, tier in ipairs(tiers) do
        if level >= tier.min and level <= tier.max then
            return {
                health = tier.hp,
                armor = tier.armor,
                stamina = tier.stamina
            }
        end
    end

    return nil
end

function MathHandler.shouldApplyAttributeBonus(value)
    return value > 20
end

function MathHandler.getLevelStep(from, to)
    return (to > from) and 1 or -1
end

function MathHandler.getStartingAttributeClamp(value)
    return math.max(3, math.min(value, 20))
end

function MathHandler.getCyberwareScaling(level)
    return math.floor(3 + (level / 20))
end

function MathHandler.getStreetCredCapDefault()
    return 50
end

return MathHandler
