# Better Leveling (Revamp of Custom Level Cap)

A lightweight, modular framework to tune **Cyberpunk 2077** progression without save editing. It exposes caps, starting values, multipliers, and passive bonuses via **Native Settings** and applies them safely at runtime with **CET (Lua)**. A small **redscript** shim ensures the in-game UI respects new limits.

> **Note:** Changing or toggling **Attribute Cap** requires a **game restart** for the attribute screen UI to refresh. Gameplay data is written; the restart is only for the UI cache.

---

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Install](#install)
- [How It Works](#how-it-works)
- [Configuration](#configuration)
- [Project Layout](#project-layout)
- [Localization](#localization)
- [Troubleshooting](#troubleshooting)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [Credits & License](#credits--license)

---

## Features

- **Custom Level Cap** – Set player level cap.
- **Custom Street Cred Cap** – Set Street Cred max level.
- **Attribute Cap** – Raise/lower per-attribute max (UI shows it; gameplay enforces it).  
  - Disabling restores vanilla **20** on next run; existing points above 20 are **not** clamped.
- **Starting Attributes** – Control max per-stat at character creation and starting attribute points.
- **Cyberware Capacity Scaling** – Scale capacity with level; optional **capacity cap**.
- **Attribute Bonuses** – Post-20 thresholds grant passive stat bonuses.
- **Level Bonuses** – Per-level health/armor/stamina (configurable table; defaults apply >60).
- **XP Multipliers** – Per-track multipliers (Level, Street Cred, Headhunter, Netrunner, Shinobi, Solo, Engineer).
- **Localization** – English, Français, Español, 中文, Русский, Deutsch, 한국어, 日本語, **Melayu**.

---

## Requirements

- **Cyber Engine Tweaks (CET)** for Lua runtime & Native Settings
- **RED4ext + redscript**
- **Cyberpunk 2077 v2.3+** (tested target)

This mod writes **TweakDB** values for gameplay changes and uses **redscript** only where the vanilla UI needs to read the new limits.

---

## Install

1) **Lua (CET) part** → copy the mod folder to:
<CP2077>/bin/x64/plugins/cyber_engine_tweaks/mods/BetterLeveling/

Should include: `init.lua`, `EventListener.lua`, `Modules/*.lua`, `Function/*.lua`, `Utility/*.lua`, `Localization/*.lua`.  
`Data/config.json` is auto-created on first run.

2) **Redscript part** → copy to:
<CP2077>/r6/scripts/BetterLeveling/

Must include: `AttributeUnlocked.reds` (and any helpers you add later).

3) Launch → **Native Settings** → **Better Leveling** tab.

---

## How It Works

**Boot & events**
- CET loads `init.lua` and registers handlers.
- **onInit**: load/merge `Data/config.json`, apply baseline TweakDB writes, build the settings UI.
- **onUpdate**: a small **deferred queue** applies feature modules in a safe, deterministic order.
- **onTweak reload**: re-apply caps that depend on TweakDB refresh.

**Settings flow**
- `Utility/ConstantsHandler.lua` defines defaults.
- `Modules/LevelingCore.lua`  
  - `loadSettings()` reads/merges config and persists new keys.  
  - `refreshVariables()` mirrors settings into `Globals`.  
  - `reloadMods()` enqueues `apply*` tasks; each checks its feature flag.

**Apply tasks (highlights)**
- `Function/ChangeableValue.lua`: Level cap & creation UI limits.
- `Function/StreetCredUnlocked.lua`: Street Cred cap.
- `Function/MoreCyberwareCapacity.lua`: Capacity scaling + cap.
- `Function/AttributeUnlocked.lua`: Writes `BaseStats.<Attr>.max` for all attributes.
- `Function/AttributeBonus.lua` / `Function/LevelBonus.lua`: Adds stat modifiers using handles.

**UI shim (redscript)**
- `AttributeUnlocked.reds` wraps attribute menu population so the displayed cap = current `Stat_Record.Max()` from TweakDB. (We avoid brittle `GetInt(..., "max")`; we use `rec.Max()`.)

**Why a deferred queue?**  
To avoid applying multiple record/flat changes mid-frame in unsafe order. UI callbacks **enqueue** work; the frame loop applies it.

---

## Configuration

Created automatically at `Data/config.json` on first run:

```json
{
  "NewLevelCap": 60,
  "StreetCredCap": 50,
  "StartingAttributePoints": 7,
  "MaxStartingAttribute": 6,
  "AttributeCap": 20,
  "MoreCyberwareCapacity": 3,
  "CyberwareCap": 450,

  "FeatureFlags": {
    "LevelCap": true,
    "StreetCredCap": true,
    "AttributeCap": true,
    "StartingAttr": true,
    "CyberwareScaling": true,
    "CyberwareCap": false,
    "AttributeBonus": true,
    "LevelBonus": true,
    "XPMultiplier": true,
    "XPMult_StreetCred": true,
    "XPMult_Headhunter": true,
    "XPMult_Netrunner": true,
    "XPMult_Shinobi": true,
    "XPMult_Solo": true,
    "XPMult_Engineer": true
  },

  "XPValues": {
    "Level": 1.0,
    "StreetCred": 1.0,
    "Headhunter": 1.0,
    "Netrunner": 1.0,
    "Shinobi": 1.0,
    "Solo": 1.0,
    "Engineer": 1.0
  },

  "Language": 1
}
```

## Project Layout
```
BetterLeveling/
├─ init.lua
├─ EventListener.lua
├─ Modules/
│  ├─ LevelingCore.lua          # settings I/O, globals, deferred queue, apply* orchestration
│  ├─ LevelingUI.lua            # Native Settings UI
│  └─ PersistModules.lua        # (optional) per-frame checks / one-time installs
├─ Function/
│  ├─ AttributeUnlocked.lua     # writes BaseStats.<Attr>.max
│  ├─ AttributeBonus.lua        # post-20 bonuses
│  ├─ LevelBonus.lua            # level-based bonuses
│  ├─ ChangeableValue.lua       # level cap + creation UI limits
│  ├─ StreetCredUnlocked.lua
│  ├─ MoreCyberwareCapacity.lua
│  └─ StartupTweaks.lua
├─ Utility/
│  ├─ ConstantsHandler.lua
│  ├─ MathHandler.lua
│  └─ (helpers)
├─ Localization/
│  ├─ en.lua fr.lua es.lua zh.lua ru.lua
│  ├─ de.lua ko.lua ja.lua ms.lua
│  └─ (loader maps numeric id → file)
└─ r6/scripts/
   └─ AttributeUnlocked.reds
```

## Localization
Supported languages:

English, Français, Español, 中文, Русский, Deutsch, 한국어, 日本語, Melayu

Language selection is numeric; ensure your loader maps:

lua
Copy
Edit
local sources = {
  [1]="Localization/en",[2]="Localization/fr",[3]="Localization/es",
  [4]="Localization/zh",[5]="Localization/ru",[6]="Localization/de",
  [7]="Localization/ko",[8]="Localization/ja",[9]="Localization/ms"
}
Add a new language

Create Localization/<code>.lua mirroring keys from en.lua.

Add localized name to each file’s languageOptions.

Extend the loader table above.

## Troubleshooting
Attribute screen still shows 20 after raising cap
Restart the game (UI cache). Gameplay cap changes are written to TweakDB; restart makes UI read the new Stat_Record.Max().
XP changes do nothing
Enable XP Multipliers plus the specific track(s). Confirm config.json updated after moving sliders.

## Conflicts
Mods that also write BaseStats.*.max, Street Cred/Level caps, or install competing XP hooks may override behavior. The last writer wins.
Logs
CET console shows Lua stack traces.
redscript errors → r6/logs/redscript_rCURRENT.log.

## Compatibility
Tested on CP2077 2.3+ with CET, RED4ext, redscript current as of release.
Does not edit saves; it writes runtime TweakDB values and adds/removes stat modifiers with handles.
Safe to remove mid-playthrough, but any buffs above vanilla will drop to base values after removal.


## Contributing
PRs welcome! Please:
Match code style (small modules, apply* pattern, minimal globals).
Avoid hard-applying from UI callbacks—enqueue to the deferred queue.
Keep localization keys stable and update all locales when adding new strings.

Credits & License
Original concept & implementation: BiasNil
Built with CET, RED4ext, redscript (licensed separately; respect their licenses).
License: MIT © 2025 BiasNil — see LICENSE
This project is open source under the MIT License. You may use, modify, and redistribute, including forks/derivatives, provided you include the copyright notice and license. No warranty. Do not redistribute CDPR game assets.

## Credits & License
**Original concept & implementation:** BiasNil  
**Built with:** Cyber Engine Tweaks (CET), RED4ext, and redscript — each licensed separately; please respect their licenses.  
**License:** MIT — © 2025 BiasNil. See [LICENSE](./LICENSE).
This project’s **code** is open source under the MIT License. You may use, modify, and redistribute it (including forks and derivatives) as long as you include the copyright notice and license. The software is provided “as is,” without warranty. Do **not** redistribute any CDPR game assets or third-party assets without permission.
