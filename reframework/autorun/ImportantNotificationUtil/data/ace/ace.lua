---@class AceData
---@field enum AceEnum
---@field map AceMap

---@class (exact) AceEnum
---@field fix_panel table<app.GUI020100.FIX_PANEL_TYPE, string>
---@field gui_func table<app.GUIFunc.TYPE, string>
---@field input_device table<ace.GUIDef.INPUT_DEVICE, string>
---@field game_key table<app.GUIDefApp.GAME_KEY_TYPE, string>
---@field hunter_continue table<app.HunterDef.CONTINUE_FLAG, string>

---@class (exact) KeyNameSort
---@field pad boolean
---@field kb boolean

---@class (exact) AceMap
---@field key_name_to_gui_func table<string, app.GUIFunc.TYPE>
---@field key_name_sort table<string, KeyNameSort>
---@field game_key_to_name table<string, string>
---@field default_key_func app.GUIFunc.TYPE
---@field fix_panel_overwrite string[]

---@class AceData
local this = {
    enum = {
        fix_panel = {},
        gui_func = {},
        input_device = {},
        game_key = {},
        hunter_continue = {},
    },
    map = {
        key_name_to_gui_func = {},
        key_name_sort = {},
        game_key_to_name = {
            ON = "HOLD",
            ON_TIMER = "TIMED HOLD",
            TRIGGER = "",
        },
        default_key_func = 207,
        fix_panel_overwrite = {
            "IMPORTANT_LINE1",
            "IMPORTANT_LINE2",
        },
    },
}

return this
