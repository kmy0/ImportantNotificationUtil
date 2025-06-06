---@meta

---@class via.Object : REManagedObject
---@class via.clr.ManagedObject : via.Object
---@class via.Component : via.clr.ManagedObject
---@class via.UserData : via.clr.ManagedObject
---@class via.Scene : via.clr.ManagedObject
---@class app.AppBehavior : via.Behavior
---@class via.Behavior : via.Component
---@class via.GameObject : via.clr.ManagedObject

---@class System.ValueType : ValueType
---@class System.UInt32 : integer, System.ValueType
---@class System.Int32 : integer, System.ValueType
---@class System.Int64 : integer, System.ValueType
---@class System.UInt16 : integer, System.ValueType
---@class System.Byte : integer, System.ValueType
---@class System.Boolean : boolean, System.ValueType
---@class System.String : string, via.clr.ManagedObject
---@class System.Enum : integer, System.ValueType
---@class System.Object : via.clr.ManagedObject
---@class System.Single : integer, System.ValueType
---@class System.Guid : System.ValueType
---@field mData1 System.UInt32
---@field mData2 System.UInt16
---@field mData3 System.UInt16
---@field mData4_0 System.Byte
---@field mData4_1 System.Byte
---@field mData4_2 System.Byte
---@field mData4_3 System.Byte
---@field mData4_4 System.Byte
---@field mData4_5 System.Byte
---@field mData4_6 System.Byte
---@field mData4_7 System.Byte

---@class ace.GAElementBase : via.Behavior
---@class ace.GAElement<T> : ace.GAElementBase

---@class System.ArrayEnumerator<T> : via.clr.ManagedObject
---@field MoveNext fun(self: System.ArrayEnumerator): System.Boolean
---@field get_Current fun(self: System.ArrayEnumerator): any

---@class System.Array<T> : System.Object
---@field get_Count fun(self: System.Array): integer
---@field get_Item fun(self: System.Array, i: integer): any
---@field set_Item fun(self: System.Array, i: integer, item: any)
---@field Contains fun(self: System.Array, item: any): System.Boolean
---@field ToArray fun(self: System.Array): System.Array<any>
---@field GetEnumerator fun(self: System.Array): System.ArrayEnumerator<any>
---@field IndexOf fun(self: System.Array, item: any): System.Int32
---@field AddRange fun(self: System.Array, list: System.Array<any>)
---@field AddWithResize fun(self: System.Array, item: any)
---@field Remove fun(self: System.Array, item: any): System.Boolean
---@field Clear fun(self: System.Array)

---@class ace.GUIManagerBase : ace.GAElement
---@class app.GUIManager : ace.GUIManagerBase
---@field get_IsJustTimingShortcutWaiting fun(self: app.GUIManager): System.Boolean
---@field convertFuncToKeyType fun(self: app.GUIManager, device: ace.GUIDef.INPUT_DEVICE, icon: ace.GUIDef.IconSetting): app.GUIDefApp.GAME_KEY_TYPE

---@class ace.cSafeContinueFlagGroup : via.clr.ManagedObject
---@field off fun(self: ace.cSafeContinueFlagGroup, flag: System.UInt32)

---@class app.CharacterBase : app.AppBehavior
---@class app.HunterCharacter : app.CharacterBase
---@field _HunterContinueFlag ace.cSafeContinueFlagGroup

---@class app.cPlayerManageInfo : via.clr.ManagedObject
---@field get_Character fun(self: app.cPlayerManageInfo): app.HunterCharacter

---@class app.PlayerManager : ace.GAElement
---@field getMasterPlayer fun(self: app.PlayerManager): app.cPlayerManageInfo

---@class ace.GUIBaseCore : via.Behavior
---@class ace.GUIBase : ace.GUIBaseCore
---@class app.GUIBaseApp: ace.GUIBase
---@class app.GUIHudBase : app.GUIBaseApp
---@class ace.cGUIPartsBase : via.clr.ManagedObject
---@class app.cGUIPartsBaseApp : ace.cGUIPartsBase

---@class ace.cGUIInputCtrl.CallbackParam : ace.cNonCycleTypeObject
---@field _SlotBtns System.Array<app.GUIFunc.TYPE>

---@class app.GUIFunc.TYPE : System.Enum
---@class ace.cLeakCheckObject : via.clr.ManagedObject
---@class ace.cNonCycleTypeObject : ace.cLeakCheckObject
---@class ace.cGUIInputCtrlBase : ace.cNonCycleTypeObject
---@class ace.cGUIInputCtrl : ace.cGUIInputCtrlBase
---@field _Callback ace.cGUIInputCtrl.CallbackParam

---@class app.GUI020100.FIX_PANEL_TYPE : System.Enum
---@class app.GUI020100 : app.GUIHudBase
---@field _InputCtrl ace.cGUIInputCtrl
---@field get_FixPanelType fun(self: app.GUI020100): app.GUI020100.FIX_PANEL_TYPE

---@class ace.GUIDef.INPUT_DEVICE : System.Enum
---@class app.GUI020100PartsJust : app.cGUIPartsBaseApp
---@field _LastInputDevice ace.GUIDef.INPUT_DEVICE
---@field get_Owner fun(self: app.GUI020100PartsJust): app.GUI020100

---@class ace.user_data.GameKeyDefinition.cData : via.clr.ManagedObject
---@field _InstanceGuid System.Guid

---@class ace.user_data.GameKeyDefinition : via.UserData
---@field get_Values fun(self: ace.user_data.GameKeyDefinition): System.Array<ace.user_data.GameKeyDefinition.cData>

---@class ace.user_data.RawKeyDefinition.cData : via.clr.ManagedObject
---@field _InstanceGuid System.Guid
---@field _Name System.String

---@class ace.user_data.RawKeyDefinition : via.UserData
---@field get_Values fun(self: ace.user_data.RawKeyDefinition): System.Array<ace.user_data.RawKeyDefinition.cData>

---@class ace.GUIDef.IconSetting : System.ValueType
---@class app.GUIDefApp.GAME_KEY_TYPE : System.Enum
---@class app.GameInputManager : ace.GAElement
---@field get_RawKeyDefinitonMkb fun(self: app.GameInputManager): ace.user_data.RawKeyDefinition
---@field get_MkbUIGameKeyDefData fun(self: app.GameInputManager): ace.user_data.GameKeyDefinition
---@field get_RawKeyDefinitionPad fun(self: app.GameInputManager): ace.user_data.RawKeyDefinition
---@field get_PadUIGameKeyDefData fun(self: app.GameInputManager): ace.user_data.GameKeyDefinition

---@class app.HunterDef.CONTINUE_FLAG : System.Enum
