local StreetCredUnlocked = {}
local Math = require("Utility/MathHandler")

function StreetCredUnlocked:apply(cap)
    cap = cap or Math.getStreetCredCapDefault()

    TweakDB:SetFlat("BaseStats.StreetCred.max", cap)
    TweakDB:SetFlat("Proficiencies.StreetCred.maxLevel", cap)
end

return StreetCredUnlocked
