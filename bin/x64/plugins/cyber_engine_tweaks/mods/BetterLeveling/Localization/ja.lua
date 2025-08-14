return {
    tab = "レベリング拡張",
    subcategory = "レベル設定",

    levelCap = "レベル上限",
    levelCapDesc = "プレイヤーの最大レベル。（既定: 60）",

    streetCredCap = "ストリートクレド上限",
    streetCredCapDesc = "ストリートクレドの最大レベル（既定: 50）。",

    startPoints = "初期アトリビュート点",
    startPointsDesc = "Vが最初に所持するアトリビュート点。ゲームを再起動してください。（既定: 7）",

    maxAttribute = "初期アトリビュート上限",
    maxAttributeDesc = "キャラ作成時の各アトリビュート最大値。（既定: 6）",

    languageCategory = "言語",
    languageLabel = "UI言語",
    languageDesc = "このMODで使用する言語を選択。",
    languageOptions = {
        [1] = "英語",
        [2] = "フランス語",
        [3] = "スペイン語",
        [4] = "中国語",
        [5] = "ロシア語",
        [6] = "ドイツ語",
        [7] = "韓国語",
        [8] = "日本語",
        [9] = "マレー語"
    },

    refreshLabel = "言語を適用",
    refreshDesc = "選択を保存します。ゲームを再起動するかMODメニューを開き直してください。",
    restartPopup = "言語変更を適用するにはゲーム再起動またはMODメニューを再度開いてください。",

    attributeCategory = "アトリビュート設定",
    attributeCap = "アトリビュート上限",
    attributeCapDesc = "各アトリビュートが到達できる最大値を設定。（既定: 20）",

    attrPerLevelLabel = "レベル毎のアトリビュート点",
    attrPerLevelDesc  = "レベルアップ毎に獲得するアトリビュート点の合計。",
    perkPerLevelLabel = "レベル毎のパーク点",
    perkPerLevelDesc  = "レベルアップ毎に獲得するパーク点の合計。",

    moreCyberware = "サイバーウェア容量",
    moreCyberwareDesc = "レベルに応じたサイバーウェア容量の倍率を設定。（既定: 3）",

    cyberwareCap = "サイバーウェア容量上限",
    cyberwareCapDesc = "サイバーウェアの最大容量を設定（再読み込みが必要）。（既定: 450）",

    featureTogglesCategory = "機能の有効/無効",
    toggleDesc = "この機能をオン/オフにします。",

    toggleOrder = {
        "LevelCap",
        "StreetCredCap",
        "AttributeCap",
        "StartingAttr",
        "CyberwareScaling",
        "CyberwareCap",
        "AttributeBonus",
        "MoreAttrPerLevel",
        "MorePerkPerLevel",
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
        LevelCap = "カスタムレベルを有効化",
        StreetCredCap = "カスタム・ストリートクレドを有効化",
        AttributeCap = "アトリビュート上限を有効化（再起動が必要）",
        StartingAttr = "初期アトリビュートを有効化",
        CyberwareScaling = "サイバーウェア倍率を有効化",
        CyberwareCap = "サイバーウェア上限を有効化",
        AttributeBonus = "アトリビュートボーナスを有効化",
        MoreAttrPerLevel = "レベル毎のアトリビュート点を有効化",
        MorePerkPerLevel = "レベル毎のパーク点を有効化",
        LevelBonus = "レベルボーナスを有効化",
        XPMultiplier = "XP倍率を有効化",
        XPMult_StreetCred = "ストリートクレドXP倍率を有効化",
        XPMult_Headhunter = "ヘッドハンターXP倍率を有効化",
        XPMult_Netrunner = "ネットランナーXP倍率を有効化",
        XPMult_Shinobi = "シノビXP倍率を有効化",
        XPMult_Solo = "ソロXP倍率を有効化",
        XPMult_Engineer = "エンジニアXP倍率を有効化"
    },

    xpScalingCategory = "XP・ストリートクレド・シノビ倍率",
    xpScalingToggleDesc = "この分野のXP倍率を切り替えます。",
    xpSliderDesc = "XP倍率を設定（既定: 1.0）。",

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
        Level = "レベルXP倍率",
        StreetCred = "ストリートクレドXP倍率",
        Headhunter = "ヘッドハンターXP倍率",
        Netrunner = "ネットランナーXP倍率",
        Shinobi = "シノビXP倍率",
        Solo = "ソロXP倍率",
        Engineer = "エンジニアXP倍率"
    }
}
