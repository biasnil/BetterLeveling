return {
    tab = "レベリング向上",
    subcategory = "レベル設定",

    levelCap = "レベル上限",
    levelCapDesc = "プレイヤーの最大レベル。（既定：60）",

    streetCredCap = "ストリートクレッド上限",
    streetCredCapDesc = "ストリートクレッドの最大レベル（既定：50）。",

    startPoints = "初期属性ポイント",
    startPointsDesc = "V が開始時に所持する属性ポイント。ゲームを再起動してください。（既定：7）",

    maxAttribute = "初期属性の最大値",
    maxAttributeDesc = "キャラ作成時の属性ごとの最大ポイント。（既定：6）",

    languageCategory = "言語",
    languageLabel = "UI 言語",
    languageDesc = "この Mod で使用する言語を選択します。",
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
    refreshDesc = "選択を保存します。変更を反映するにはゲームを再起動するか、Mod メニューを開き直してください。",
    restartPopup = "言語変更を反映するにはゲームを再起動するか、Mod メニューを開き直してください。",

    attributeCategory = "属性設定",
    attributeCap = "属性上限",
    attributeCapDesc = "各属性が到達できる最大値を設定します。（既定：20）",

    moreCyberware = "サイバーウェア容量",
    moreCyberwareDesc = "レベルに応じたサイバーウェア容量のスケーリング係数を設定します。（既定：3）",

    cyberwareCap = "サイバーウェア容量上限",
    cyberwareCapDesc = "サイバーウェアの最大容量を設定（再読み込みが必要）。（既定：450）",

    featureTogglesCategory = "機能の有効 / 無効",
    toggleDesc = "この機能をオン/オフします。",

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
        LevelCap = "カスタムレベルを有効化",
        StreetCredCap = "カスタム・ストリートクレッドを有効化",
        AttributeCap = "属性上限を有効化（ゲームの再起動が必要）",
        StartingAttr = "初期属性を有効化",
        CyberwareScaling = "サイバーウェア拡張を有効化",
        CyberwareCap = "サイバーウェア容量上限を有効化",
        AttributeBonus = "属性ボーナスを有効化",
        LevelBonus = "レベルボーナスを有効化",
        XPMultiplier = "XP 倍率を有効化",
        XPMult_StreetCred = "ストリートクレッド XP 倍率を有効化",
        XPMult_Headhunter = "ヘッドハンター XP 倍率を有効化",
        XPMult_Netrunner = "ネットランナー XP 倍率を有効化",
        XPMult_Shinobi = "シノビ XP 倍率を有効化",
        XPMult_Solo = "ソロ XP 倍率を有効化",
        XPMult_Engineer = "エンジニア XP 倍率を有効化"
    },

    xpScalingCategory = "XP・ストリートクレッド・シノビ",
    xpScalingToggleDesc = "このカテゴリの XP 倍率をオン/オフにします。",
    xpSliderDesc = "XP 倍率を設定（既定：1.0）。",

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
        Level = "レベル XP 倍率",
        StreetCred = "ストリートクレッド XP 倍率",
        Headhunter = "ヘッドハンター XP 倍率",
        Netrunner = "ネットランナー XP 倍率",
        Shinobi = "シノビ XP 倍率",
        Solo = "ソロ XP 倍率",
        Engineer = "エンジニア XP 倍率"
    }
}
