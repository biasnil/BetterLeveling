return {
    tab = "Better Leveling",
    subcategory = "Level Settings",

    levelCap = "Level Cap",
    levelCapDesc = "Max player level. (default: 60)",

    streetCredCap = "Street Cred Cap",
    streetCredCapDesc = "Maximum street cred level (default: 50).",

    startPoints = "Starting Attribute Points",
    startPointsDesc = "Attribute points V starts with. Make sure to reset your game. (default: 7)",

    maxAttribute = "Max Starting Attribute",
    maxAttributeDesc = "Max points per attribute at character creation. (default: 6)",

    languageCategory = "Language",
    languageLabel = "UI Language",
    languageDesc = "Choose which language to use for this mod.",
    languageOptions = {
        [1] = "English",
        [2] = "Français",
        [3] = "Español",
        [4] = "中文",
        [5] = "Русский",
        [6] = "Deutsch",
        [7] = "한국어",
        [8] = "日本語",
        [9] = "Malay"
    },

    refreshLabel = "Apply Language",
    refreshDesc = "Saves your selection. Please restart the game or reopen the mod menu to apply changes.",
    restartPopup = "Restart the game or reopen the mod menu to apply language changes.",

    attributeCategory = "Attribute Settings",
    attributeCap = "Attribute Cap",
    attributeCapDesc = "Sets the maximum value each attribute can reach. (default: 20)",

    moreCyberware = "Cyberware Capacity",
    moreCyberwareDesc = "Sets the scaling factor for Cyberware capacity based on your level. (default: 3)",

    cyberwareCap = "Cyberware Capacity Cap",
    cyberwareCapDesc = "Set the max cyberware capacity (requires reload). (default: 450)",

    featureTogglesCategory = "Enable or Disable Features",
    toggleDesc = "Turn this feature on or off.",

    toggleOrder = {
        "LevelCap",
        "StreetCredCap",
        "AttributeCap",
        "StartingAttr",
        "CyberwareScaling",
        "CyberwareCap",
        "AttributeBonus",
        "LevelBonus",
        "XPMultiplier",
        "XPMult_StreetCred",
        "XPMult_Headhunter",
        "XPMult_Netrunner",
        "XPMult_Shinobi",
        "XPMult_Solo",
        "XPMult_Engineer"
    },

    toggleLabels = {
        LevelCap = "Enable Custom Level",
        StreetCredCap = "Enable Custom Street Cred",
        AttributeCap = "Enable Attribute Cap (Requires game restart)",
        StartingAttr = "Enable Starting Attributes",
        CyberwareScaling = "Enable Cyberware Scaling",
        CyberwareCap = "Enable Cyberware Cap",
        AttributeBonus = "Enable Attribute Bonuses",
        LevelBonus = "Enable Level Bonuses",
        XPMultiplier = "Enable XP Multipliers",
        XPMult_StreetCred = "Enable Street Cred XP Multiplier",
        XPMult_Headhunter = "Enable Headhunter XP Multiplier",
        XPMult_Netrunner = "Enable Netrunner XP Multiplier",
        XPMult_Shinobi = "Enable Shinobi XP Multiplier",
        XPMult_Solo = "Enable Solo XP Multiplier",
        XPMult_Engineer = "Enable Engineer XP Multiplier"
    },

    xpScalingCategory = "XP, Street Cred, Shinobi Multiplier",
    xpScalingToggleDesc = "Turn XP multiplier on or off for this proficiency.",
    xpSliderDesc = "Set XP multiplier (default: 1.0).",

    xpSliderOrder = {
        "Level",
        "StreetCred",
        "Headhunter",
        "Netrunner",
        "Shinobi",
        "Solo",
        "Engineer"
    },

    xpSliderLabels = {
        Level = "Level XP Multiplier",
        StreetCred = "Street Cred XP Multiplier",
        Headhunter = "Headhunter XP Multiplier",
        Netrunner = "Netrunner XP Multiplier",
        Shinobi = "Shinobi XP Multiplier",
        Solo = "Solo XP Multiplier",
        Engineer = "Engineer XP Multiplier"
    }
}
