---@class (exact) WindowState
---@field pos_x integer
---@field pos_y integer
---@field size_x integer
---@field size_y integer

---@class (exact) GuiState
---@field main WindowState

---@class (exact) PanelButton
---@field combo integer
---@field gui_func app.GUIFunc.TYPE

---@class (exact) ModSettings
---@field button_left PanelButton
---@field button_right PanelButton
---@field is_enabled boolean
---@field is_map_unblock boolean

---@class (exact) Settings
---@field gui GuiState
---@field mod ModSettings

---@class (exact) Config
---@field version string
---@field name string
---@field config_path string
---@field cache_path string
---@field default Settings
---@field current Settings
---@field init fun()
---@field load fun()
---@field save fun()
---@field restore fun()
---@field get fun(key: string): any
---@field set fun(key: string, value: any)

local table_util = require("ImportantNotificationUtil.table_util")
local util = require("ImportantNotificationUtil.util")

---@class Config
local this = {}

this.version = "0.0.1"
this.name = "ImportantNotificationUtil"
this.config_path = this.name .. "/config.json"
---@diagnostic disable-next-line: missing-fields
this.current = {}
this.default = {
    gui = {
        main = {
            pos_x = 50,
            pos_y = 50,
            size_x = 800,
            size_y = 700,
        },
    },
    mod = {
        button_left = {
            combo = 1,
            gui_func = 1,
        },
        button_right = {
            combo = 1,
            gui_func = 1,
        },
        is_enabled = false,
        is_map_unblock = false,
    },
}

---@param key string
---@return any
function this.get(key)
    local ret = this.current
    if not key:find(".") then
        return ret[key]
    end

    local keys = util.split_string(key, "%.")
    for i = 1, #keys do
        ret = ret[keys[i]]
    end
    return ret
end

---@param key string
---@param value any
function this.set(key, value)
    local t = this.current
    if not key:find(".") then
        t[key] = value
        return
    end
    table_util.set_nested_value(t, util.split_string(key, "%."), value)
end

function this.load()
    local loaded_config = json.load_file(this.config_path)
    if loaded_config then
        this.current = table_util.table_merge(this.default, loaded_config) --[[@as Settings]]
    else
        this.current = table_util.table_deep_copy(this.default) --[[@as Settings]]
    end
end

function this.save()
    json.dump_file(this.config_path, this.current)
end

function this.restore()
    this.current = table_util.table_deep_copy(this.default) --[[@as Settings]]
    this.save()
end

function this.init()
    this.load()
end

return this
