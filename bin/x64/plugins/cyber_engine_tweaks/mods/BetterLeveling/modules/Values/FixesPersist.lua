local FixesPersist = {}

function FixesPersist:apply(config)
    TweakDB:SetFlat("LootPrereqs.BelowMaxPlayerLevelPrereq.valueToCheck", config.NewLevelCap)
    TweakDB:SetFlat("LootPrereqs.MaxPlayerLevelPrereq.valueToCheck", config.NewLevelCap)
    TweakDB:SetFlat("LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1.valueToCheck", config.NewLevelCap)
    TweakDB:SetFlat("LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1.valueToCheck", config.NewLevelCap)
end

return FixesPersist
