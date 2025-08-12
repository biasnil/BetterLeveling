-- Utility/EventListener.lua
local EventListener   = {}

local Core            = require("Modules/LevelingCore")
local UI              = require("Modules/LevelingUI")
local Constants       = require("Utility/ConstantsHandler")

function EventListener.on(event, cb)         registerForEvent(event, cb) end
function EventListener.observe(class, m, cb) Observe(class, m, cb) end
function EventListener.override(class, m, cb) Override(class, m, cb) end

-- Handlers
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

function EventListener.handleUpdate() end

local PersistModules
registerForEvent("onInit",   EventListener.handleInit)

registerForEvent("onTweak",  EventListener.handleTweak)

registerForEvent("onUpdate", function(dt)
  PersistModules = PersistModules or require("PersistModules")
  if PersistModules and PersistModules.handleUpdate then
    PersistModules.handleUpdate(dt)
  end
end)

return EventListener
