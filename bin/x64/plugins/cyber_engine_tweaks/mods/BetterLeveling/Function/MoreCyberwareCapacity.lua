local MoreCyberwareCapacity = {}

function MoreCyberwareCapacity:apply(config)
    local newValue = config.MoreCyberwareCapacity or 6
    TweakDB:SetFlat("Character.PlayerCyberwareSystem_inline11.value", newValue)

    local player = Game.GetPlayer()
    if player then
        local humanity = Game.GetStatsSystem():GetStatValue(player:GetEntityID(), gamedataStatType.Humanity)
    end
end

registerForEvent("onInit", function()
    Observe('PlayerDevelopmentData', 'ModifyProficiencyLevel', function(_, proficiencyIndex, isDebug, levelIncrease)
        local data = PlayerDevelopmentSystem.GetData(Game.GetPlayer())
        local type = data:GetProficiencyRecordByIndex(proficiencyIndex):Type()

        if type == gamedataProficiencyType.Level then
            local core = require("Modules/LevelingCore")
            core.applyMoreCyberwareCapacity()
        end
    end)
end)

return MoreCyberwareCapacity
