local Core       = require("Modules/LevelingCore")
local Constants  = require("Utility/ConstantsHandler")

local function loadLocalization(id)
    local sources = {
        [1] = "Localization/en", -- English
        [2] = "Localization/fr", -- French
        [3] = "Localization/es", -- Spanish
        [4] = "Localization/zh", -- Chinese
        [5] = "Localization/ru", -- Russian
        [6] = "Localization/de", -- German
        [7] = "Localization/ko", -- Korean
        [8] = "Localization/ja", -- Japanese
        [9] = "Localization/ms", -- Malay
    }
    return require(sources[id or 1])
end

local function addIntSlider(path, label, desc, min, max, step, key, default, callback, featureKey)
    nativeSettings.addRangeInt(
        path, label, desc,
        min, max, step,
        Core.curSettings[key] or default,
        default,
        Constants.ifEnabled(featureKey, function(v)
            Core.curSettings[key] = v
            Core.saveSettings()
            if callback then callback(v) end
        end)
    )
end

local function addSwitch(path, label, desc, key)
    nativeSettings.addSwitch(
        path, label, desc,
        Core.curSettings.FeatureFlags[key],
        true,
        function(val)
            Core.curSettings.FeatureFlags[key] = val
            Core.saveSettings()
            Core.reloadMods()
        end
    )
end

local function addXPFloatSlider(path, label, desc, key, default)
    nativeSettings.addRangeFloat(
        path, label, desc,
        0.1, 100.0, 0.1, "%.2f",
        Core.curSettings.XPValues[key] or default,
        default,
        Constants.ifEnabled("XPMult_" .. key, function(v)
            Core.curSettings.XPValues[key] = v
            Core.saveSettings()
            Core.refreshVariables()
        end)
    )
end

local function buildUI()
    nativeSettings = GetMod("nativeSettings")
    if not nativeSettings then
        print("[BTL] NativeSettings not found.")
        return
    end

    local L = loadLocalization(Core.curSettings.Language)
    local d = Constants.DefaultSettings

    -- Main tabs & subcategories
    nativeSettings.addTab("/BTL", L.tab)
    nativeSettings.addSubcategory("/BTL/Level", L.subcategory)
    nativeSettings.addSubcategory("/BTL/Language", L.languageCategory)
    nativeSettings.addSubcategory("/BTL/Attribute", L.attributeCategory)
    nativeSettings.addSubcategory("/BTL/XP", L.xpScalingCategory)
    nativeSettings.addSubcategory("/BTL/Features", L.featureTogglesCategory)

    -- Ordered feature toggles
    for _, key in ipairs(L.toggleOrder) do
        addSwitch("/BTL/Features", L.toggleLabels[key], L.toggleDesc, key)
    end

    -- XP sliders early
    for _, profKey in ipairs(L.xpSliderOrder) do
        local label = L.xpSliderLabels[profKey]
        local default = (d.XPValues and d.XPValues[profKey]) or 1.0
        addXPFloatSlider("/BTL/XP", label, L.xpSliderDesc, profKey, default)
    end

    -- Language selector
    nativeSettings.addSelectorString(
        "/BTL/Language",
        L.languageLabel,
        L.languageDesc,
        L.languageOptions,
        Core.curSettings.Language,
        d.Language,
        function(val)
            Core.curSettings.Language = val
            Core.saveSettings()
        end
    )

    nativeSettings.addButton(
        "/BTL/Language",
        L.refreshLabel,
        L.refreshDesc,
        "OK",
        0,
        function()
            Core.saveSettings()
            Game.GetSystemRequestsHandler():QueuePopup(L.restartPopup, L.tab, {}, false)
        end
    )

    -- Core sliders
    addIntSlider("/BTL/Attribute", L.attributeCap,    L.attributeCapDesc,    20, 100,   1, "AttributeCap",             d.AttributeCap,      Core.applyAttributeCap,    "AttributeCap")
    addIntSlider("/BTL/Level",     L.levelCap,        L.levelCapDesc,        60, 300,   1, "NewLevelCap",              d.NewLevelCap,       Core.applyChangeableValue, "LevelCap")
    addIntSlider("/BTL/Level",     L.streetCredCap,   L.streetCredCapDesc,   50, 500,   1, "StreetCredCap",            d.StreetCredCap,     Core.applyStreetCredCap,   "StreetCredCap")
    addIntSlider("/BTL/Level",     L.startPoints,     L.startPointsDesc,     7, 100,    1, "StartingAttributePoints",  d.StartingAttributePoints, Core.updateStartingPointsFlat, "StartingAttr")
    addIntSlider("/BTL/Level",     L.maxAttribute,    L.maxAttributeDesc,    3, 20,     1, "MaxStartingAttribute",     d.MaxStartingAttribute, Core.applyChangeableValue, "LevelCap")
    addIntSlider("/BTL/Attribute", L.moreCyberware,   L.moreCyberwareDesc,   3, 60,     1, "MoreCyberwareCapacity",    d.MoreCyberwareCapacity, Core.applyMoreCyberwareCapacity, "CyberwareScaling")
    addIntSlider("/BTL/Attribute", L.cyberwareCap,    L.cyberwareCapDesc,    450, 10000,100, "CyberwareCap",             d.CyberwareCap,      Core.applyCyberwareCap,   "CyberwareCap")
    addIntSlider("/BTL/Level",     L.attrPerLevelLabel, L.attrPerLevelDesc, 1, 100, 1, "AttrPointsPerLevel", d.AttrPointsPerLevel, nil, "MoreAttrPerLevel")
    addIntSlider("/BTL/Level",     L.perkPerLevelLabel, L.perkPerLevelDesc, 1, 100, 1, "PerkPointsPerLevel", d.PerkPointsPerLevel, nil, "MorePerkPerLevel")
end

return { buildUI = buildUI }
