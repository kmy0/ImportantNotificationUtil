local config = require("ImportantNotificationUtil.config")
local config_menu = require("ImportantNotificationUtil.gui")
local data = require("ImportantNotificationUtil.data")
local toast = require("ImportantNotificationUtil.toast")

config.init()

sdk.hook(
    sdk.find_type_definition("app.GUIManager"):get_method("updatePlCommandMask") --[[@as REMethodDefinition]],
    function(args) end,
    toast.update_player_cmd_mask_post
)
sdk.hook(
    sdk.find_type_definition("app.GUI020100PartsJust"):get_method("setEnable(System.Boolean, System.Boolean)") --[[@as REMethodDefinition]],
    toast.partsjust_enable_buttons_pre,
    toast.partsjust_enable_buttons_post
)
sdk.hook(
    sdk.find_type_definition("app.GUI020100PartsJust"):get_method("end()") --[[@as REMethodDefinition]],
    toast.partsjust_end_pre
)

re.on_draw_ui(function()
    if imgui.button(string.format("%s %s", config.name, config.version)) then
        config_menu.is_opened = not config_menu.is_opened
    end
end)

re.on_frame(function()
    data.init()

    if not reframework:is_drawing_ui() then
        config_menu.is_opened = false
    end

    if config_menu.is_opened then
        config_menu.draw()
    end
end)

re.on_config_save(config.save)
