

local MgCcbHelp = require "MgCcbHelp"


local MgUiLayerSetting = class("MgUiLayerSetting", require("MgUiLayerDlg"))
local MgAudio = require("MgAudio")


function MgUiLayerSetting:init()
    MgUiLayerSetting.super.init(self)
    self:initWithCcb()
end


function MgUiLayerSetting:initWithCcb()

    local ctrl = {}

    ctrl.onMusicBtn = function()
        self:onMusicBtn()
    end

    ctrl.onAccountBtn = function()
        self:onAccountBtn()
    end

    local param = {
        name = "UiLayerSetting.ccbi",
        ctrl = ctrl,
        -- ctrlName = "SettingLayer",
        }

    local node = MgCcbHelp.load(param)

    self:addChild(node)

    self.ctrl = ctrl

    self:refreshMusicBtn()

end


function MgUiLayerSetting:onMusicBtn()
    cclog("MgUiLayerSetting:onMusicBtn")
    if MgAudio.isMusicOff() then
        cclog("status is: off")
        MgAudio.setMusicStatus(true)
        assert(not MgAudio.isMusicOff())
    else
        cclog("status is: on")
        MgAudio.setMusicStatus(false)
        assert(MgAudio.isMusicOff())
    end
    self:refreshMusicBtn()
end


function MgUiLayerSetting:refreshMusicBtn()
    local title = MgAudio.isMusicOff() and T"off" or T"on"
    self.ctrl.musicBtn:getTitleLabel():setString(title)
end


function MgUiLayerSetting:onAccountBtn()
    cclog("MgUiLayerSetting:onAccountBtn")
    self.uiLayer:pushUiDlgLayer(MgUtils.rerequire("MgUiLayerAccount").new())
end


return MgUiLayerSetting
