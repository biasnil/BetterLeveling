local StartingAttribute = {}

function StartingAttribute:apply(config)
    if not TweakDB:GetFlat("BTL.StartingAttributePoints") then
        TweakDB:CreateRecord("BTL.StartingAttributePoints", "gamedataStatModifierGroup_Record")
    end

    TweakDB:SetFlat("BTL.StartingAttributePoints", config.StartingAttributePoints, "Int32")
    Override('CharacterCreationStatsMenu', 'ResetAllBtnBackToBaseline', function(self)
        for i, v in ipairs(self.attributesControllers) do
            v.data:SetValue(3)
            v:Refresh()
        end
        self.startingAttributePoints = TweakDBInterface.GetInt(TweakDBID.new("BTL.StartingAttributePoints"), 7)
        self.attributePointsAvailable = self.startingAttributePoints
        inkTextRef.SetText(self.skillPointLabel, tostring(self.attributePointsAvailable))
        self:RefreshPointsLabel()
        self:ManageAllButtonsVisibility()
    end)

    Observe('CharacterCreationGenderSelectionMenu', 'OnIntro', function(self)
        self.characterCustomizationState:SetAttributePointsAvailable(
            TweakDBInterface.GetInt(TweakDBID.new("BTL.StartingAttributePoints"), 7)
        )
    end)

    print("[BTL] StartingAttribute hooks and TweakDB value applied.")
end

return StartingAttribute
