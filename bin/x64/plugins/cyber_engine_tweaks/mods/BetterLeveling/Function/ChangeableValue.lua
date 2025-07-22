local ChangeableValue = {}

function ChangeableValue:apply(config)
    TweakDB:SetFlat("Proficiencies.Level.maxLevel", config.NewLevelCap)
    TweakDB:SetFlat("UICharacterCreationGeneral.BaseValues.maxAttributeValue", config.MaxStartingAttribute, "Int32")
end

return ChangeableValue
