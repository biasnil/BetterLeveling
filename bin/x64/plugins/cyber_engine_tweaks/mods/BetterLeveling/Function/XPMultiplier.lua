local XPMultiplier = {}
local Core = require("Modules/LevelingCore")

-- Maps XP enums to config keys
local function resolveXPTypeName(xpType)
  if xpType == gamedataProficiencyType.Level then
    return "Level"
  elseif xpType == gamedataProficiencyType.StreetCred then
    return "StreetCred"
  elseif xpType == gamedataProficiencyType.CoolSkill then
    return "Headhunter"
  elseif xpType == gamedataProficiencyType.IntelligenceSkill then
    return "Netrunner"
  elseif xpType == gamedataProficiencyType.ReflexesSkill then
    return "Shinobi"
  elseif xpType == gamedataProficiencyType.StrengthSkill then
    return "Solo"
  elseif xpType == gamedataProficiencyType.TechnicalAbilitySkill then
    return "Engineer"
  end
  return nil
end

function XPMultiplier:apply()
  if not Core.curSettings.FeatureFlags.XPMultiplier then
    return
  end

  Override("PlayerDevelopmentSystem", "OnExperienceAdded", function(self, request, wrapped)
    local typeName = resolveXPTypeName(request.experienceType)
    if typeName and Core.curSettings.FeatureFlags["XPMult_" .. typeName] then
      local mult = Core.getXPModifierFor(typeName)
      request.amount = math.floor(request.amount * mult + 0.0001)
    end
    wrapped(request)
  end)

  Override("PlayerDevelopmentSystem", "OnExperienceQueued", function(self, request, wrapped)
    local typeName = resolveXPTypeName(request.experienceType)
    if typeName and Core.curSettings.FeatureFlags["XPMult_" .. typeName] then
      local mult = Core.getXPModifierFor(typeName)
      request.amount = math.floor(request.amount * mult + 0.0001)
    end
    wrapped(request)
  end)
end

return XPMultiplier
