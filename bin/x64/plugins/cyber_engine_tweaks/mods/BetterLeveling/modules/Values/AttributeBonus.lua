local AttributeBonus = {}

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

    for _, h in pairs(self.handles) do
        stats:RemoveModifier(playerID, h)
    end
    self.handles = {}

    local bonuses = {
        Reflexes         = { stat = gamedataStatType.CritChance,  scale = 0.5 },
        Cool             = { stat = gamedataStatType.CritDamage,  scale = 1.25 },
        Strength         = { stat = gamedataStatType.Health,      scale = 2.0 },
        TechnicalAbility = { stat = gamedataStatType.Armor,       scale = 2.0 },
        Intelligence     = { stat = gamedataStatType.Memory,      isRAM = true }
    }

    for attr, cfg in pairs(bonuses) do
        local value = devData:GetAttributeValue(gamedataStatType[attr])
        if value > 20 then
            local over  = value - 20
            local bonus = cfg.isRAM and (math.floor(value / 4) - 5)
                                       or (over * cfg.scale)

            local mod = RPGManager.CreateStatModifier(
                            cfg.stat, gameStatModifierType.Additive, bonus)
            stats:AddModifier(playerID, mod)
            self.handles[attr] = mod
        end
    end
end

print("[BTL] AttributeBonus module loaded.")

return AttributeBonus
