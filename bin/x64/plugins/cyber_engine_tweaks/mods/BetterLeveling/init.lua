local Event = require("Utility/EventListener")
require("PersistModules")

Event.on("onInit", Event.handleInit)
Event.on("onTweak", Event.handleTweak)
Event.handleUpdate()