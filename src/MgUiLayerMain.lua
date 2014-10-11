
local MgCcbHelp = require "MgCcbHelp"


local MgUiLayerMain = class("MgUiLayerMain", require("MgUiLayerDlg"))


function MgUiLayerMain:ctor()
    MgUiLayerMain.super.ctor(self)
    self:init()
end


function MgUiLayerMain:init()
    MgUiLayerMain.super.init(self)
    self:initWithCcb()
end


function MgUiLayerMain:initWithCcb()

    local ctrl = {}

    ctrl.onSettingBtn = function()
        self:onSettingBtn()
    end

    local param = {
        name = "UiLayerMain.ccbi",
        ctrl = ctrl,
        }

    local node = MgCcbHelp.load(param)
    self:addChild(node)

    self.ctrl = ctrl

end


function MgUiLayerMain:onSettingBtn()
    cclog("MgUiLayerMain:onSettingBtn")
    self.uiLayer:pushUiDlgLayer(MgUtils.rerequire("MgUiLayerSetting").new())
end


return MgUiLayerMain
