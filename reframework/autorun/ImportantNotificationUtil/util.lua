local this = {}

this.setGameKeyIcon = sdk.find_type_definition("app.GUIUtilApp"):get_method(
    "setGameKeyIcon(app.GUIBaseApp, via.gui.Panel, ace.GUIDef.IconSetting, app.GUIBaseApp)"
) --[[@as REMethodDefinition]]

---@generic T
---@param array System.Array<T>
---@return System.ArrayEnumerator<T>
function this.get_array_enum(array)
    local enum
    local success, arr = pcall(function()
        return array:ToArray()
    end)

    if not success then
        arr = array
    end

    success, enum = pcall(function()
        return arr:GetEnumerator()
    end)

    if not success then
        enum = sdk.create_instance("System.ArrayEnumerator", true) --[[@as System.ArrayEnumerator]]
        enum:call(".ctor", arr)
    end
    return enum
end

---@generic T
---@param system_array System.Array<T>
---@return T[]
function this.system_array_to_lua(system_array)
    local ret = {}
    local enum = this.get_array_enum(system_array)

    while enum:MoveNext() do
        local o = enum:get_Current()
        table.insert(ret, o)
    end
    return ret
end

---@param s string
---@param sep string?
---@return string[]
function this.split_string(s, sep)
    if not sep then
        sep = "%s"
    end

    local ret = {}
    for i in string.gmatch(s, "([^" .. sep .. "]+)") do
        table.insert(ret, i)
    end
    return ret
end

---@return via.Scene
function this.get_scene()
    return sdk.call_native_func(
        sdk.get_native_singleton("via.SceneManager"),
        sdk.find_type_definition("via.SceneManager") --[[@as RETypeDefinition]],
        "get_CurrentScene()"
    )
end

---@param type string?
---@return System.Array<REManagedObject>
function this.get_all_t(type)
    if not type then
        type = "via.Transform"
    end
    return this.get_scene():call("findComponents(System.Type)", sdk.typeof(type))
end

---@param guid System.Guid
---@return string
function this.format_guid(guid)
    return string.format(
        "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
        guid.mData1,
        guid.mData2,
        guid.mData3,
        guid.mData4_0,
        guid.mData4_1,
        guid.mData4_2,
        guid.mData4_3,
        guid.mData4_4,
        guid.mData4_5,
        guid.mData4_6,
        guid.mData4_7
    )
end

return this
