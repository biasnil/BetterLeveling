return {
    tab = "레벨링 향상",
    subcategory = "레벨 설정",

    levelCap = "레벨 상한",
    levelCapDesc = "플레이어의 최대 레벨. (기본값: 60)",

    streetCredCap = "스트리트 크레드 상한",
    streetCredCapDesc = "스트리트 크레드 최대 레벨 (기본값: 50).",

    startPoints = "초기 속성 포인트",
    startPointsDesc = "V가 시작할 때 보유한 속성 포인트. 게임을 재시작하세요. (기본값: 7)",

    maxAttribute = "초기 속성 최대값",
    maxAttributeDesc = "캐릭터 생성 시 속성별 최대 포인트. (기본값: 6)",

    languageCategory = "언어",
    languageLabel = "UI 언어",
    languageDesc = "이 모드에서 사용할 언어를 선택하세요.",
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
    refreshDesc = "선택을 저장합니다. 변경 사항을 적용하려면 게임을 재시작하거나 모드 메뉴를 다시 여세요.",
    restartPopup = "언어 변경을 적용하려면 게임을 재시작하거나 모드 메뉴를 다시 여세요.",

    attributeCategory = "속성 설정",
    attributeCap = "속성 상한",
    attributeCapDesc = "각 속성이 도달할 수 있는 최대값을 설정합니다. (기본값: 20)",

    moreCyberware = "사이버웨어 용량",
    moreCyberwareDesc = "레벨에 따라 사이버웨어 용량의 증가 배율을 설정합니다. (기본값: 3)",

    cyberwareCap = "사이버웨어 용량 상한",
    cyberwareCapDesc = "사이버웨어 최대 용량 설정 (재로딩 필요). (기본값: 450)",

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
        LevelCap = "사용자 지정 레벨 활성화",
        StreetCredCap = "사용자 지정 스트리트 크레드 활성화",
        AttributeCap = "속성 상한 활성화 (게임 재시작 필요)",
        StartingAttr = "초기 속성 활성화",
        CyberwareScaling = "사이버웨어 확장 활성화",
        CyberwareCap = "사이버웨어 용량 상한 활성화",
        AttributeBonus = "속성 보너스 활성화",
        LevelBonus = "레벨 보너스 활성화",
        XPMultiplier = "경험치 배수 활성화",
        XPMult_StreetCred = "스트리트 크레드 경험치 배수 활성화",
        XPMult_Headhunter = "현상금 사냥꾼 경험치 배수 활성화",
        XPMult_Netrunner = "네트러너 경험치 배수 활성화",
        XPMult_Shinobi = "시노비 경험치 배수 활성화",
        XPMult_Solo = "솔로 경험치 배수 활성화",
        XPMult_Engineer = "엔지니어 경험치 배수 활성화"
    },

    xpScalingCategory = "경험치, 스트리트 크레드, 시노비",
    xpScalingToggleDesc = "해당 분류의 경험치 배수를 켜거나 끕니다.",
    xpSliderDesc = "경험치 배수 설정 (기본값: 1.0).",

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
        Level = "레벨 경험치 배수",
        StreetCred = "스트리트 크레드 경험치 배수",
        Headhunter = "현상금 사냥꾼 경험치 배수",
        Netrunner = "네트러너 경험치 배수",
        Shinobi = "시노비 경험치 배수",
        Solo = "솔로 경험치 배수",
        Engineer = "엔지니어 경험치 배수"
    }
}
