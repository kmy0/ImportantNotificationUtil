---@class (exact) GuiData
---@field combo GuiCombo

---@class (exact) GuiCombo
---@field gui_func string[]

local ace_data = require("ImportantNotificationUtil.data.ace")
local table_util = require("ImportantNotificationUtil.table_util")

local this = {
    combo = {
        gui_func = {},
    },
}

function this.init()
    this.combo.gui_func = table_util.keys(ace_data.map.key_name_to_gui_func)
    table.sort(this.combo.gui_func, function(a, b)
        local a_key = ace_data.map.key_name_sort[a]
        local b_key = ace_data.map.key_name_sort[b]

        local a_both = a_key.pad and a_key.kb
        local b_both = b_key.pad and b_key.kb

        if a_both and not b_both then
            return true
        elseif not a_both and b_both then
            return false
        end

        if a_key.pad and not b_key.pad then
            return true
        elseif not a_key.pad and b_key.pad then
            return false
        end

        return a < b
    end)
end

return this
