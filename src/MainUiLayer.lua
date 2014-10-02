
local MainUiLayer = class("MainUiLayer", require("UiDlgLayer"))


function MainUiLayer:ctor()
	MainUiLayer.super.ctor(self)
	self:init()
end


function MainUiLayer:init()
	MainUiLayer.super.init(self)
	self.menu = cc.Menu:create()
	self:addChild(self.menu)
	self.menu:setPosition(cc.p(0,0))
	self:addSettingBtn()
end


function MainUiLayer:addSettingBtn()
	local settintBtn = Util.createButton({
		tex = nil,
		title = T"setting",
		cb = function() self:settinBtnCb() end,
		})
	self.menu:addChild(settintBtn)
	Util.placeAlign(settintBtn, "rm")
end


function MainUiLayer:settinBtnCb()
	cclog("MainUiLayer:settinBtnCb")
	self.uiLayer:pushUiDlgLayer(require("SettingUiLayer").new())
end


return MainUiLayer