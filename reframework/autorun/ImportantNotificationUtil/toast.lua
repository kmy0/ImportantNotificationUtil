---@class PartsJust
---@field obj app.GUI020100PartsJust
---@field parent app.GUI020100
---@field button_array System.Array<app.GUIFunc.TYPE>

local config = require("ImportantNotificationUtil.config")
local data = require("ImportantNotificationUtil.data")
local table_util = require("ImportantNotificationUtil.table_util")
local util = require("ImportantNotificationUtil.util")

local ace = data.ace
local rt = data.runtime
local gui = data.gui
local rl = data.util.reverse_lookup

local this = {}

---@param ptr integer
---@return PartsJust
local function get_PartsJust(ptr)
    local obj = sdk.to_managed_object(ptr) --[[@as app.GUI020100PartsJust]]
    local parent = obj:get_Owner()
    local input_ctrl = parent._InputCtrl
    local callback = input_ctrl._Callback
    local button_array = callback._SlotBtns
    return {
        obj = obj,
        parent = parent,
        button_array = button_array,
    }
end

function this.partsjust_end_pre(args)
    if not config.current.mod.is_enabled then
        return
    end

    local partsjust = get_PartsJust(args[2])
    partsjust.button_array:set_Item(0, ace.map.default_key_func)
end

function this.partsjust_enable_buttons_pre(args)
    if not config.current.mod.is_enabled then
        return
    end

    local partsjust = get_PartsJust(args[2])
    local fix_panel = ace.enum.fix_panel[partsjust.parent:get_FixPanelType()]
    if table_util.table_contains(ace.map.fix_panel_overwrite, fix_panel) then
        thread.get_hook_storage()["this"] = partsjust
        local panel = config.current.mod
        local button_left_name = gui.combo.gui_func[panel.button_left.combo]
        local button_right_name = gui.combo.gui_func[panel.button_right.combo]
        local button_left_struct = ace.map.key_name_sort[button_left_name]
        local button_right_struct = ace.map.key_name_sort[button_right_name]
        local device = ace.enum.input_device[partsjust.obj._LastInputDevice]

        if device == "KEYBOARD" or device == "MOUSE" then
            args[4] = sdk.to_ptr(button_left_struct.kb)
            args[3] = sdk.to_ptr(button_right_struct.kb)
        elseif device == "PAD" then
            args[4] = sdk.to_ptr(button_left_struct.pad)
            args[3] = sdk.to_ptr(button_right_struct.pad)
        end
    end
end

function this.partsjust_enable_buttons_post(retval)
    if not config.current.mod.is_enabled then
        return retval
    end

    local partsjust = thread.get_hook_storage()["this"]
    if not partsjust then
        return retval
    end

    local panel = config.current.mod
    local button_left = panel.button_left.gui_func
    local button_right = panel.button_right.gui_func

    partsjust.button_array:set_Item(0, button_left)
    partsjust.button_array:set_Item(1, button_right)

    local panel_left = partsjust.obj:get__PanelSkip()
    local panel_right = partsjust.obj:get__PanelKey()

    local icon_left = rt.get_guiman():call("createIconSettingFromGUIFunc(app.GUIFunc.TYPE)", button_left)
    local icon_right = rt.get_guiman():call("createIconSettingFromGUIFunc(app.GUIFunc.TYPE)", button_right)

    util.setGameKeyIcon:call(nil, partsjust.parent, panel_left, icon_left, nil)
    util.setGameKeyIcon:call(nil, partsjust.parent, panel_right, icon_right, nil)
    return retval
end

function this.update_player_cmd_mask_post(retval)
    if not config.current.mod.is_map_unblock or not rt.get_guiman():get_IsJustTimingShortcutWaiting() then
        return retval
    end

    local gui020100_array = util.get_all_t("app.GUI020100")
    if gui020100_array:get_Count() > 0 then
        local gui020100 = gui020100_array:get_Item(0)
        ---@cast gui020100 app.GUI020100
        local fix_panel = ace.enum.fix_panel[gui020100:get_FixPanelType()]
        if table_util.table_contains(ace.map.fix_panel_overwrite, fix_panel) then
            local master_player = rt.get_playman():getMasterPlayer()
            local hunter_char = master_player:get_Character()
            local player_flags = hunter_char._HunterContinueFlag
            player_flags:off(rl(ace.enum.hunter_continue, "DISABLE_OPEN_MAP"))
        end
    end
    return retval
end

return this
