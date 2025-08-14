return {
    tab = "레벨링 향상",
    subcategory = "레벨 설정",

    levelCap = "레벨 상한",
    levelCapDesc = "플레이어 최대 레벨. (기본: 60)",

    streetCredCap = "스트리트 크레드 상한",
    streetCredCapDesc = "스트리트 크레드 최대 레벨 (기본: 50).",

    startPoints = "시작 속성 포인트",
    startPointsDesc = "V가 시작 시 보유하는 속성 포인트. 게임을 재시작하세요. (기본: 7)",

    maxAttribute = "시작 속성 최대치",
    maxAttributeDesc = "캐릭터 생성 시 속성별 최대값. (기본: 6)",

    languageCategory = "언어",
    languageLabel = "UI 언어",
    languageDesc = "이 모드에서 사용할 언어를 선택합니다.",
    languageOptions = {
        [1] = "영어",
        [2] = "프랑스어",
        [3] = "스페인어",
        [4] = "중국어",
        [5] = "러시아어",
        [6] = "독일어",
        [7] = "한국어",
        [8] = "일본어",
        [9] = "말레이어"
    },

    refreshLabel = "언어 적용",
    refreshDesc = "선택을 저장합니다. 변경을 적용하려면 게임을 재시작하거나 모드 메뉴를 다시 여세요.",
    restartPopup = "언어 변경을 적용하려면 게임을 재시작하거나 모드 메뉴를 다시 여세요.",

    attributeCategory = "속성 설정",
    attributeCap = "속성 상한",
    attributeCapDesc = "각 속성이 도달할 수 있는 최대값을 설정합니다. (기본: 20)",

    attrPerLevelLabel = "레벨당 속성 포인트",
    attrPerLevelDesc  = "레벨업 시 획득하는 속성 포인트 총량.",
    perkPerLevelLabel = "레벨당 퍼크 포인트",
    perkPerLevelDesc  = "레벨업 시 획득하는 퍼크 포인트 총량.",

    moreCyberware = "사이버웨어 용량",
    moreCyberwareDesc = "레벨에 따라 사이버웨어 용량이 증가하는 배수를 설정합니다. (기본: 3)",

    cyberwareCap = "사이버웨어 용량 상한",
    cyberwareCapDesc = "최대 사이버웨어 용량을 설정 (재로드 필요). (기본: 450)",

    featureTogglesCategory = "기능 켜기/끄기",
    toggleDesc = "이 기능을 켜거나 끕니다.",

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
        LevelCap = "사용자 정의 레벨 사용",
        StreetCredCap = "사용자 정의 스트리트 크레드 사용",
        AttributeCap = "속성 상한 사용 (재시작 필요)",
        StartingAttr = "시작 속성 사용",
        CyberwareScaling = "사이버웨어 스케일링 사용",
        CyberwareCap = "사이버웨어 상한 사용",
        AttributeBonus = "속성 보너스 사용",
        MoreAttrPerLevel = "레벨당 속성 포인트 사용",
        MorePerkPerLevel = "레벨당 퍼크 포인트 사용",
        LevelBonus = "레벨 보너스 사용",
        XPMultiplier = "XP 배수 사용",
        XPMult_StreetCred = "스트리트 크레드 XP 배수 사용",
        XPMult_Headhunter = "헤드헌터 XP 배수 사용",
        XPMult_Netrunner = "넷러너 XP 배수 사용",
        XPMult_Shinobi = "시노비 XP 배수 사용",
        XPMult_Solo = "솔로 XP 배수 사용",
        XPMult_Engineer = "엔지니어 XP 배수 사용"
    },

    xpScalingCategory = "XP, 스트리트 크레드, 시노비 배수",
    xpScalingToggleDesc = "해당 분야의 XP 배수를 켜거나 끕니다.",
    xpSliderDesc = "XP 배수 설정 (기본: 1.0).",

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
        Level = "레벨 XP 배수",
        StreetCred = "스트리트 크레드 XP 배수",
        Headhunter = "헤드헌터 XP 배수",
        Netrunner = "넷러너 XP 배수",
        Shinobi = "시노비 XP 배수",
        Solo = "솔로 XP 배수",
        Engineer = "엔지니어 XP 배수"
    }
}
