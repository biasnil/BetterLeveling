local EventListener = {}

local Core = require("Modules/LevelingCore")
local UI = require("Modules/LevelingUI")
local Constants = require("Utility/ConstantsHandler")
local PersistModules = require("PersistModules")

-------------------------------
-- Event API
-------------------------------

function EventListener.on(event, callback)
    registerForEvent(event, callback)
end

function EventListener.observe(class, method, callback)
    Observe(class, method, callback)
end

function EventListener.override(class, method, callback)
    Override(class, method, callback)
end

-------------------------------
-- Player Helpers
-------------------------------

function EventListener.getPlayer()
    return Game and Game.GetPlayer()
end

function EventListener.getDevData()
    local player = EventListener.getPlayer()
    return player and PlayerDevelopmentSystem.GetData(player)
end

function EventListener.withDevData(callback)
    local devData = EventListener.getDevData()
    if devData then callback(devData) end
end

-------------------------------
-- Event Handlers
-------------------------------

function EventListener.handleInit()
    Core.curSettings = Core.loadSettings() or Constants.deepCopy(Constants.DefaultSettings)
    Core.saveSettings()
    Core.refreshVariables()
    Core.applyFixesPersist()
    Core.applyChangeableValue()
    Core.applyStreetCredCap()
    UI.buildUI()
end

function EventListener.handleTweak()
    Core.curSettings = Core.loadSettings() or Constants.deepCopy(Constants.DefaultSettings)
    Core.refreshVariables()
    Core.applyCyberwareCap()
end

function EventListener.handleUpdate()
    local PersistModules = require("PersistModules")
    EventListener.on("onUpdate", PersistModules.handleUpdate)
end

return EventListener
