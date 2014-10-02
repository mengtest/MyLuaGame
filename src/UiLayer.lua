

local UiLayer = class("UiLayer", function() return cc.Layer:create() end)

local ZOrder = {}
ZOrder.topBar = 1
ZOrder.uiDlgLayer = 0
ZOrder.colorLayer = -1

function UiLayer:ctor() 
	self:init()
end

function UiLayer:init()
	self.menu = cc.Menu:create()
	self:addChild(self.menu)
	self.menu:setPosition(cc.p(0,0))
	self:addEnterBtn()
end

function UiLayer:deinit()

end

function UiLayer:dtor()
	self:deinit()
end


function UiLayer:addTopBar()
	assert(not self.topBar)
	-- bg
	local topBar = ccui.Scale9Sprite:create("enter.png")
	local size = topBar:getContentSize()
	topBar:setContentSize(cc.size(display.width, size.height))
	Util.placeAlign(topBar, "lt")
	self:addChild(topBar, ZOrder.topBar)
	-- menu
	local menu = cc.Menu:create()
	topBar:addChild(menu)
	menu:setPosition(cc.p(0,0))
	-- back
	local back = Util.createButton({
		tex = "back.png",
		cb = function() self:backCb() end,
		})
	Util.placeAlign(back, "lm", topBar)
	menu:addChild(back)
	self.topBar = topBar
end


function UiLayer:removeTopBar()
	if self.topBar then
		self:removeChild(self.topBar)
		self.topBar = nil
	end
end


function UiLayer:addLayerColor()
	assert(not self.layerColor)
	local layerColor = cc.LayerColor:create(cc.c4b(128, 128, 128, 128))
	self:addChild(layerColor)
	self.layerColor = layerColor
end


function UiLayer:removeLayerColor()
	if self.layerColor then
		self:removeChild(self.layerColor)
		self.layerColor = nil
	end
end


function UiLayer:backCb()
	cclog("UiLayer:backCb")
	self:popUiDlgLayer()
end


function UiLayer:pushUiDlgLayer(uiDlgLayer)
	if not self.uiDlgLayerStack then
		self.uiDlgLayerStack = {}
	end
	self:addChild(uiDlgLayer)
	uiDlgLayer.uiLayer = self
	local count = #self.uiDlgLayerStack
	if count > 0 then
		self.uiDlgLayerStack[count]:setVisible(false)
	end
	self.uiDlgLayerStack[count + 1] = uiDlgLayer
	-- table.insert(self.uiDlgLayerStack, uiDlgLayer)
	self:UpdateTopBar()
end


function UiLayer:popUiDlgLayer()
	assert(self.uiDlgLayerStack)
	local count = #self.uiDlgLayerStack
	local uiDlgLayer = self.uiDlgLayerStack[count]
	self:removeChild(uiDlgLayer)
	self.uiDlgLayerStack[count] = nil
	if count > 1 then
		self.uiDlgLayerStack[count - 1]:setVisible(true)
	end
	self:UpdateTopBar()
end


function UiLayer:UpdateTopBar()
	local count = #self.uiDlgLayerStack
	if (count > 0) then
		self.enterBtn:setVisible(false) 
		if not self.topBar then
			self:addTopBar()
		end
		if not self.layerColor then
			self:addLayerColor()
		end
	elseif (count == 0) then
		self.enterBtn:setVisible(true)
		if self.topBar then
			self:removeTopBar()
		end
		if self.layerColor then
			self:removeLayerColor()
		end
	end
end


function UiLayer:addEnterBtn()
	local enterBtn = Util.createButton({
		tex = "enter.png",
		cb = function() self:enterBtnCb() end,
		})
	self.menu:addChild(enterBtn)
	Util.placeAlign(enterBtn, "rt")
	self.enterBtn = enterBtn
end


function UiLayer:enterBtnCb()
	cclog("UiLayer:enterBtnCb")
	self:pushUiDlgLayer(require("MainUiLayer").new())
end

function UiLayer:openMessageBox(param)
	self:pushUiDlgLayer(require("MessageBoxUiLayer").new(param))
end

function UiLayer.closeMessageBox(cancelMsg)
	self:popUiDlgLayer()
end

 
return UiLayer