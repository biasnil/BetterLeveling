local Core = require("modules/LevelingCore")

local function loadLocalization(id)
    local sources = {
        [1] = "Localization/en",
        [2] = "Localization/fr",
        [3] = "Localization/es",
        [4] = "Localization/zh",
        [5] = "Localization/ru"
    }
    return require(sources[id or 1])
end

local function buildUI()
    local nativeSettings = GetMod("nativeSettings")
    if not nativeSettings then
        print("[BTL] NativeSettings not found.")
        return
    end

    local L = loadLocalization(Core.curSettings.Language)
    local d = {
        NewLevelCap = 60,
        MaxStartingAttribute = 6,
        StartingAttributePoints = 7,
        Language = 1,
        AttributeCap = 20,
        MoreCyberwareCapacity = 6,
        StreetCredCap = 50,
        CyberwareCap = 1000
    }

    nativeSettings.addTab("/BTL", L.tab)
    nativeSettings.addSubcategory("/BTL/Level", L.subcategory)
    nativeSettings.addSubcategory("/BTL/Language", L.languageCategory)
    nativeSettings.addSubcategory("/BTL/Attribute", L.attributeCategory)

    nativeSettings.addSelectorString("/BTL/Language", L.languageLabel, L.languageDesc, L.languageOptions,
        Core.curSettings.Language, d.Language, function(val)
            Core.curSettings.Language = val
            Core.saveSettings()
        end)

    nativeSettings.addButton("/BTL/Language", L.refreshLabel, L.refreshDesc, "OK", 0, function()
        Core.saveSettings()
        Game.GetSystemRequestsHandler():QueuePopup(L.restartPopup, L.tab, {}, false)
    end)

    nativeSettings.addRangeInt("/BTL/Attribute", L.attributeCap, L.attributeCapDesc,
        20, 100, 1, Core.curSettings.AttributeCap, d.AttributeCap,
        function(v)
            Core.curSettings.AttributeCap = v
            Core.saveSettings()
            Core.applyAttributeCap()
        end)

    nativeSettings.addRangeInt("/BTL/Level", L.levelCap, L.levelCapDesc,
    60, 300, 1, Core.curSettings.NewLevelCap, d.NewLevelCap,
    function(v)
        Core.curSettings.NewLevelCap = v
        Core.saveSettings()
        Core.applyChangeableValue()
    end)

    nativeSettings.addRangeInt("/BTL/Level", L.streetCredCap, L.streetCredCapDesc,
    50, 500, 1, Core.curSettings.StreetCredCap or 50, 50,
    function(v)
        Core.curSettings.StreetCredCap = v
        Core.saveSettings()
        Core.applyStreetCredCap()
    end)

    nativeSettings.addRangeInt("/BTL/Level", L.startPoints, L.startPointsDesc,
        7, 100, 1, Core.curSettings.StartingAttributePoints, d.StartingAttributePoints,
        function(v)
            Core.curSettings.StartingAttributePoints = v
            Core.saveSettings()
            Core.updateStartingPointsFlat()
        end)

    nativeSettings.addRangeInt("/BTL/Level", L.maxAttribute, L.maxAttributeDesc,
    3, 20, 1, Core.curSettings.MaxStartingAttribute, d.MaxStartingAttribute,
    function(v)
        Core.curSettings.MaxStartingAttribute = v
        Core.saveSettings()
        Core.applyChangeableValue()
    end)

     nativeSettings.addRangeInt("/BTL/Attribute", L.moreCyberware, L.moreCyberwareDesc,
    3, 60, 1, Core.curSettings.MoreCyberwareCapacity or 6, 6,
    function(v)
        Core.curSettings.MoreCyberwareCapacity = v
        Core.saveSettings()
        Core.applyMoreCyberwareCapacity()
    end)

    nativeSettings.addRangeInt("/BTL/Attribute", L.cyberwareCap , L.cyberwareCapDesc ,
    450, 10000, 100, Core.curSettings.CyberwareCap or 1000, 1000,
    function(v)
        Core.curSettings.CyberwareCap = v
        Core.saveSettings()
        Core.applyCyberwareCap()
    end)

end

return { buildUI = buildUI }
