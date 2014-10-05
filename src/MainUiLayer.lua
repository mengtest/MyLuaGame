
local CcbHelp = require "CcbHelp"


local MainUiLayer = class("MainUiLayer", require("UiDlgLayer"))


function MainUiLayer:ctor()
    MainUiLayer.super.ctor(self)
    self:init()
end


function MainUiLayer:init()
    MainUiLayer.super.init(self)
    self:initWithCcb()
end


function MainUiLayer:initWithCcb()

    local ctrl = {}

    ctrl.onSettingBtn = function()
        self:onSettingBtn()
    end

    local param = {
        name = "MainUiLayer.ccbi",
        ctrl = ctrl,
        }

    local node = CcbHelp.load(param)
    self:addChild(node)
    Util.dump(param.ctrl)

    self.ctrl = ctrl

end


function MainUiLayer:onSettingBtn()
    cclog("MainUiLayer:onSettingBtn")
    self.uiLayer:pushUiDlgLayer(Util.rerequire("SettingUiLayer").new())
end


return MainUiLayer
