local StartupTweaks = {}
local Math = require("Utility/MathHandler")

local prereqKeys = {
  { k = "LootPrereqs.BelowMaxPlayerLevelPrereq.valueToCheck" },
  { k = "LootPrereqs.MaxPlayerLevelPrereq.valueToCheck" },
  { k = "LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1.valueToCheck" },
  { k = "LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1.valueToCheck" },
  { k = "LootPrereqs.CraftedIconicWeaponRecipePrereq_Epic.valueToCheck",               t = "Float" },
  { k = "LootPrereqs.CraftedIconicWeaponRecipePrereq_Legendary.valueToCheck",         t = "Float" },
  { k = "LootPrereqs.Maximum_EpicPlusCWLevelAvailabilityInLoot.valueToCheck",          t = "Float" },
  { k = "LootPrereqs.LegendaryPlusCWLevelAvailabilityInLoot_inline0.valueToCheck",     t = "Float" },
}

local defaultsCaptured = false
local defaultValues = {}

local function captureDefaults()
  if defaultsCaptured then return end
  defaultsCaptured = true
  for _, e in ipairs(prereqKeys) do
    defaultValues[e.k] = TweakDB:GetFlat(e.k)
  end
end

local function applyPrereqCaps(targetCap)
  captureDefaults()
  if tonumber(targetCap) == 60 then
    -- restore vanilla
    for _, e in ipairs(prereqKeys) do
      local v = defaultValues[e.k]
      if v ~= nil then
        TweakDB:SetFlat(e.k, v, e.t)
      end
    end
  else
    for _, e in ipairs(prereqKeys) do
      TweakDB:SetFlat(e.k, targetCap, e.t)
    end
  end
end

function StartupTweaks:apply(config)
  -- If LevelCap feature is off, treat as "go vanilla"
  local target = (config and config.FeatureFlags and config.FeatureFlags.LevelCap)
                  and (config.NewLevelCap or 60) or 60
  applyPrereqCaps(target)

  if not TweakDB:GetFlat("BTL.StartingAttributePoints") then
      TweakDB:CreateRecord("BTL.StartingAttributePoints", "gamedataStatModifierGroup_Record")
  end

  TweakDB:SetFlat("BTL.StartingAttributePoints", config.StartingAttributePoints, "Int32")

  Override('CharacterCreationStatsMenu', 'ResetAllBtnBackToBaseline', function(self)
      for _, v in ipairs(self.attributesControllers) do
          v.data:SetValue(Math.getStartingAttributeClamp(3))
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
end

return StartupTweaks
