local config = require("ImportantNotificationUtil.config")
local data = require("ImportantNotificationUtil.data")
local gui_util = require("ImportantNotificationUtil.gui.util")
local table_util = require("ImportantNotificationUtil.table_util")

local gui = data.gui
local ace = data.ace
local rl = data.util.reverse_lookup

local this = {
    is_opened = false,
}
local window = {
    flags = 0,
    condition = 1 << 1,
}

local function ensure_correct_pick(panel_button)
    local gui_func_name = rl(ace.map.key_name_to_gui_func, panel_button.gui_func)
    if not gui_func_name then
        panel_button.combo = 1
        return
    end

    if gui_func_name ~= gui.combo.gui_func[panel_button.combo] then
        local combo_index = table_util.index(gui.combo.gui_func, gui_func_name)
        if not combo_index then
            panel_button.combo = 1
            return
        end
        panel_button.combo = combo_index
    end
end

function this.draw()
    imgui.set_next_window_pos(
        Vector2f.new(config.current.gui.main.pos_x, config.current.gui.main.pos_y),
        window.condition
    )
    imgui.set_next_window_size(
        Vector2f.new(config.current.gui.main.size_x, config.current.gui.main.size_y),
        window.condition
    )

    this.is_opened =
        imgui.begin_window(string.format("%s %s", config.name, config.version), this.is_opened, window.flags)

    if not this.is_opened then
        imgui.end_window()
        local pos = imgui.get_window_pos()
        local size = imgui.get_window_size()
        config.current.gui.main.pos_x, config.current.gui.main.pos_y = pos.x, pos.y
        config.current.gui.main.size_x, config.current.gui.main.size_y = size.x, size.y
        config.save()
        return
    end

    imgui.spacing()
    imgui.indent(3)

    local panel = config.current.mod
    ensure_correct_pick(panel.button_left)
    ensure_correct_pick(panel.button_right)

    _, panel.is_map_unblock = imgui.checkbox("Unblock Map", panel.is_map_unblock)
    gui_util.tooltip("Prevent notification from blocking Open Map hotkey", true)
    _, panel.is_enabled = imgui.checkbox("Enable", panel.is_enabled)
    imgui.begin_disabled(not panel.is_enabled)
    ---@diagnostic disable-next-line: assign-type-mismatch
    _, panel.button_left.combo = imgui.combo("Left Button", panel.button_left.combo, gui.combo.gui_func)
    ---@diagnostic disable-next-line: assign-type-mismatch
    _, panel.button_right.combo = imgui.combo("Right Button", panel.button_right.combo, gui.combo.gui_func)
    imgui.end_disabled()

    panel.button_left.gui_func = ace.map.key_name_to_gui_func[gui.combo.gui_func[panel.button_left.combo]]
    panel.button_right.gui_func = ace.map.key_name_to_gui_func[gui.combo.gui_func[panel.button_right.combo]]

    imgui.unindent(3)
    imgui.end_window()
end

return this
