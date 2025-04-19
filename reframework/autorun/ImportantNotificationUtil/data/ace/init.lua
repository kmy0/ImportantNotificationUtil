local data_util = require("ImportantNotificationUtil.data.util")
local rt_data = require("ImportantNotificationUtil.data.runtime")
local table_util = require("ImportantNotificationUtil.table_util")
local util = require("ImportantNotificationUtil.util")

local rl = data_util.reverse_lookup

---@class AceData
local this = require("ImportantNotificationUtil.data.ace.ace")

---@param icon ace.GUIDef.IconSetting
---@param device ace.GUIDef.INPUT_DEVICE
---@param raw_key_map table<string, ace.user_data.RawKeyDefinition.cData>
---@param game_key_data System.Array<ace.user_data.GameKeyDefinition.cData>
---@param gui_func app.GUIFunc.TYPE
---@return System.String?
local function get_key_name(icon, device, raw_key_map, game_key_data, gui_func)
    local key_type = this.enum.game_key[rt_data.get_guiman():convertFuncToKeyType(device, icon)]
    local game_key = game_key_data:get_Item(gui_func)
    local key_guid = game_key._Key:get_Item(0)
    local raw_key = raw_key_map[util.format_guid(key_guid)]

    if key_type then
        key_type = this.map.game_key_to_name[key_type]
    end
    if raw_key and key_type then
        if key_type ~= "" then
            return string.format("%s - %s", raw_key._Name, key_type)
        else
            return raw_key._Name
        end
    end
end

---@return boolean
function this.init()
    local guiman = rt_data.get_guiman()
    local inputman = rt_data.get_inputman()

    if not guiman or not inputman then
        return false
    end

    data_util.get_enum("app.GUI020100.FIX_PANEL_TYPE", this.enum.fix_panel, nil, { "NONE" })
    data_util.get_enum("app.GUIFunc.TYPE", this.enum.gui_func)
    data_util.get_enum("ace.GUIDef.INPUT_DEVICE", this.enum.input_device)
    data_util.get_enum("app.GUIDefApp.GAME_KEY_TYPE", this.enum.game_key)

    local kb_device = rl(this.enum.input_device, "KEYBOARD")
    local kb_raw_key_data = util.system_array_to_lua(inputman:get_RawKeyDefinitonMkb():get_Values())
    local kb_game_key_data = inputman:get_MkbUIGameKeyDefData():get_Values()
    local kb_raw_key_map = table_util.map_array(kb_raw_key_data, function(o)
        return util.format_guid(o._InstanceGuid)
    end) --[[@as table<string, ace.user_data.RawKeyDefinition.cData>]]

    local pad_device = rl(this.enum.input_device, "PAD")
    local pad_raw_key_data = util.system_array_to_lua(inputman:get_RawKeyDefinitionPad():get_Values())
    local pad_game_key_data = inputman:get_PadUIGameKeyDefData():get_Values()
    local pad_raw_key_map = table_util.map_array(pad_raw_key_data, function(o)
        return util.format_guid(o._InstanceGuid)
    end) --[[@as table<string, ace.user_data.RawKeyDefinition.cData>]]

    for gui_func, _ in pairs(this.enum.gui_func) do
        local icon = guiman:call("createIconSettingFromGUIFunc(app.GUIFunc.TYPE)", gui_func)

        local key
        local pad_key = get_key_name(icon, pad_device, pad_raw_key_map, pad_game_key_data, gui_func)
        local kb_key = get_key_name(icon, kb_device, kb_raw_key_map, kb_game_key_data, gui_func)

        if pad_key and kb_key then
            key = string.format("%s / %s", pad_key, kb_key)
        elseif pad_key then
            key = pad_key
        else
            key = kb_key
        end

        if key and not this.map.key_name_to_gui_func[key] then
            this.map.key_name_to_gui_func[key] = gui_func
            this.map.key_name_sort[key] = {
                pad = pad_key ~= nil,
                kb = kb_key ~= nil,
            }
        end
    end

    return true
end

return this
