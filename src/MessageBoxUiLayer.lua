
-- label bg sound
-- btn
-- label effect voice
-- btn

local MessageBoxUiLayer = class("MessageBoxUiLayer", require("UiDlgLayer"))
local audio = require("audio")


function MessageBoxUiLayer:ctor(param)
	assert(param)
	self.param = param
	MessageBoxUiLayer.super.ctor(self)
end

function MessageBoxUiLayer:init()
	MessageBoxUiLayer.super.init(self)
	self.menu = cc.Menu:create()
	self:addChild(self.menu)
	self.menu:setPosition(cc.p(0,0))
	self:addTitleLabel()
	self:addInfoLabel()
	self:addButtons()
end


function MessageBoxUiLayer:addTitleLabel()
end


function MessageBoxUiLayer:addInfoLabel()
	local text = self.param.info or "empty"
	local label = Util.createLabel(text)
	self:addChild(label)
	Util.placeAlign(label, "mm", self)
end


function MessageBoxUiLayer:addButtons()
	local param = self.param
	local function okCb()
		if param.okCb then param.okCb() end
		self.uiLayer:popUiDlgLayer()
	end
	local function cancelCb()
		if param.cancelCb then param.cancelCb() end
		self.uiLayer:popUiDlgLayer()
	end

	local okBtn = Util.createButton({
		title = T"ok",
		cb = okCb, 
		})	
	local cancelBtn = Util.createButton({
		title = T"cancel",
		cb = cancelCb,
		})	
	
	self.menu:addChild(okBtn)
	self.menu:addChild(cancelBtn)
	Util.placeAlign(okBtn, "mm", self, -100, -100)
	Util.placeAlign(cancelBtn, "mm", self, 100, -100)
end

return MessageBoxUiLayer