local M    = {}
local Core = require("Modules/LevelingCore")

local DP_ATTR = gamedataDevelopmentPointType.Primary  or gamedataDevelopmentPointType.Attribute
local DP_PERK = gamedataDevelopmentPointType.Perks    or gamedataDevelopmentPointType.Perk

local function getTargetsFromConfig(deltaLevels)
  local mult = (deltaLevels and deltaLevels ~= 0) and deltaLevels or 1

  if Core and type(Core.getPerLevelTargets) == "function" then
    local a, p = Core.getPerLevelTargets(deltaLevels)
    return (a or 0), (p or 0)
  end

  local cfg = Core.curSettings or {}
  local ff  = cfg.FeatureFlags or {}
  local dfl = (require("Utility/ConstantsHandler").DefaultSettings) or {}

  local attrPer = 0
  if ff.MoreAttrPerLevel then
    attrPer = (tonumber(cfg.AttrPointsPerLevel) or dfl.AttrPointsPerLevel or 15) * mult
  end

  local perkPer = 0
  if ff.MorePerkPerLevel then
    perkPer = (tonumber(cfg.PerkPointsPerLevel) or dfl.PerkPointsPerLevel or 15) * mult
  end

  return attrPer, perkPer
end

function M:apply()
  if not Override then
    print("[BTL] Override() missing; cannot install Attribute/Perk top-up.")
    return
  end

  Override("PlayerDevelopmentData", "ModifyProficiencyLevel",
    function(self, idx, isDebug, dL, wrapped)
      -- Snapshot BEFORE vanilla award
      local preA = (DP_ATTR and self:GetDevPoints(DP_ATTR)) or 0
      local preP = (DP_PERK and self:GetDevPoints(DP_PERK)) or 0

      -- Let vanilla grant its points
      wrapped(idx, isDebug, dL)

      -- Compute what vanilla actually gave this call
      local postA = (DP_ATTR and self:GetDevPoints(DP_ATTR)) or preA
      local postP = (DP_PERK and self:GetDevPoints(DP_PERK)) or preP
      local gotA  = postA - preA
      local gotP  = postP - preP

      -- If neither pool changed, it wasn't a relevant character level-up; bail
      if gotA == 0 and gotP == 0 then return end

      -- Desired TOTALS for this event (already multiplied by deltaLevels)
      local wantA, wantP = getTargetsFromConfig(dL)
      local needA = (wantA or 0) - gotA
      local needP = (wantP or 0) - gotP

      if DP_ATTR and needA > 0 then self:AddDevelopmentPoints(needA, DP_ATTR) end
      if DP_PERK and needP > 0 then self:AddDevelopmentPoints(needP, DP_PERK) end
    end)

  print("[BTL] Attribute/Perk per level top-up installed (config-driven).")
end

return M
