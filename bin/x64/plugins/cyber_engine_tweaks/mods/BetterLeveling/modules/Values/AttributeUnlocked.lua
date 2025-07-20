local AttributeUnlocked = {}

function AttributeUnlocked:applyAttributeCap(cap)
    local attributes = {
        "Strength",
        "Reflexes",
        "TechnicalAbility",
        "Cool",
        "Intelligence"
    }

    for _, attr in ipairs(attributes) do
        local key = string.format("BaseStats.%s.max", attr)
        TweakDB:SetFlat(key, cap)
    end
end

return AttributeUnlocked
