---@class RuntimeData
---@field guiman app.GUIManager?
---@field playman app.PlayerManager?
---@field inputman app.GameInputManager?

---@class RuntimeData
local this = {}

---@return app.GUIManager
function this.get_guiman()
    if not this.guiman then
        local obj = sdk.get_managed_singleton("app.GUIManager")
        ---@cast obj app.GUIManager
        this.guiman = obj
    end
    return this.guiman
end

---@return app.PlayerManager
function this.get_playman()
    if not this.playman then
        local obj = sdk.get_managed_singleton("app.PlayerManager")
        ---@cast obj app.PlayerManager
        this.playman = obj
    end
    return this.playman
end

---@return app.GameInputManager
function this.get_inputman()
    if not this.inputman then
        local obj = sdk.get_managed_singleton("app.GameInputManager")
        ---@cast obj app.GameInputManager
        this.inputman = obj
    end
    return this.inputman
end

return this
