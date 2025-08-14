local AttributeBonus = {}
local Math = require("Utility/MathHandler")

AttributeBonus.handles = {}

function AttributeBonus:apply()
    local player = GetPlayer()
    if not player then
        print("[BTL] No player found — skipping bonus application.")
        return
    end

    local stats    = Game.GetStatsSystem()
    local playerID = player:GetEntityID()
    local devData  = PlayerDevelopmentSystem.GetData(player)

    if not devData then
        print("[BTL] PlayerDevelopmentSystem.GetData returned nil — skipping bonus application.")
        return
    end

    -- Clear previous modifiers
    for _, h in pairs(self.handles) do
        stats:RemoveModifier(playerID, h)
    end
    self.handles = {}

    local statMap = {
        Reflexes         = gamedataStatType.CritChance,
        Cool             = gamedataStatType.CritDamage,
        Strength         = gamedataStatType.Health,
        TechnicalAbility = gamedataStatType.Armor,
        Intelligence     = gamedataStatType.Memory
    }

    for attr, statType in pairs(statMap) do
        local value = devData:GetAttributeValue(gamedataStatType[attr])
        local bonus = Math.getAttributeBonus(attr, value)

        if bonus > 0 then
            local mod = RPGManager.CreateStatModifier(statType, gameStatModifierType.Additive, bonus)
            stats:AddModifier(playerID, mod)
            self.handles[attr] = mod
        end
    end
end

return AttributeBonus
