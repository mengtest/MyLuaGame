

local CcbHelp = require "CcbHelp"


local SettingUiLayer = class("SettingUiLayer", require("UiDlgLayer"))
local audio = require("audio")


function SettingUiLayer:init()
    SettingUiLayer.super.init(self)
    self:initWithCcb()
end


function SettingUiLayer:initWithCcb()

    local ctrl = {}

    ctrl.onMusicBtn = function()
        self:onMusicBtn()
    end

    ctrl.onAccountBtn = function()
        self:onAccountBtn()
    end

    local param = {
        name = "SettingLayer.ccbi",
        ctrl = ctrl,
        -- ctrlName = "SettingLayer",
        }

    local node = CcbHelp.load(param)

    self:addChild(node)

    Util.dump(param.ctrl)

    self.ctrl = ctrl

    self:refreshMusicBtn()

end


function SettingUiLayer:onMusicBtn()
    cclog("SettingUiLayer:onMusicBtn")
    if audio.isMusicOff() then
        cclog("status is: off")
        audio.setMusicStatus(true)
        assert(not audio.isMusicOff())
    else
        cclog("status is: on")
        audio.setMusicStatus(false)
        assert(audio.isMusicOff())
    end
    self:refreshMusicBtn()
end


function SettingUiLayer:refreshMusicBtn()
    local title = audio.isMusicOff() and T"off" or T"on"
    self.ctrl.musicBtn:getTitleLabel():setString(title)
end


function SettingUiLayer:onAccountBtn()
    cclog("SettingUiLayer:onAccountBtn")
    self.uiLayer:pushUiDlgLayer(Util.rerequire("AccountUiLayer").new())
end


return SettingUiLayer
