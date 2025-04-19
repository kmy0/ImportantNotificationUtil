local this = {
    ace = require("ImportantNotificationUtil.data.ace"),
    gui = require("ImportantNotificationUtil.data.gui"),
    runtime = require("ImportantNotificationUtil.data.runtime"),
    util = require("ImportantNotificationUtil.data.util"),
    initialized = false,
}

---@return boolean
function this.init()
    if this.initialized then
        return true
    end

    if not this.ace.init() then
        return false
    end
    this.gui.init()

    this.initialized = true
    return true
end

return this
