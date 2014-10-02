
-- label bg sound
-- btn
-- label effect voice
-- btn

local SettingUiLayer = class("SettingUiLayer", require("UiDlgLayer"))
local audio = require("audio")


function SettingUiLayer:init()
	SettingUiLayer.super.init(self)
	self.menu = cc.Menu:create()
	self:addChild(self.menu)
	self.menu:setPosition(cc.p(0,0))
	self:addVoiceBtn()
	self:addVoiceLabel()
end


function SettingUiLayer:addVoiceBtn()
	local switchitem = Util.createToggleButton({
		tex1 = nil,
		tex2 = nil,
		text1 = T"on",
		text2 = T"off",
		cb = function() self:onVoiceBtn() end,
		})
	Util.placeAlign(switchitem, "rm")
	cclog("isMusicOff? %s", audio.isMusicOff() and "true" or "false")
	if audio.isMusicOff() then
		switchitem:setSelectedIndex(1)
	end
	self.menu:addChild(switchitem)
end

function SettingUiLayer:onVoiceBtn()
	cclog("SettingUiLayer:onVoiceBtn")
	audio.setMusicStatus(audio.isMusicOff())
end

function SettingUiLayer:addVoiceLabel()
	local label = Util.createLabel(T"music")
	self:addChild(label)
	Util.placeAlign(label, "rm", self, -50, 50)
end

return SettingUiLayer