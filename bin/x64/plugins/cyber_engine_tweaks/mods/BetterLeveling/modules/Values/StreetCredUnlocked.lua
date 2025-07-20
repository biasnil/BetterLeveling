local StreetCredUnlocked = {}

function StreetCredUnlocked:apply(cap)
    if not cap then
        print("[BTL] No street cred cap provided.")
        return
    end

    TweakDB:SetFlat("BaseStats.StreetCred.max", cap)
    TweakDB:SetFlat("Proficiencies.StreetCred.maxLevel", cap)
end

return StreetCredUnlocked
