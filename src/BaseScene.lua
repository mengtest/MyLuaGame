
local BaseScene = class("BaseScene", function() 
	return cc.Scene:create()
end)

function BaseScene:ctor()
	cclog("BaseScene:ctor")
	self:init()
end

function BaseScene:init()
	cclog("BaseScene:init")
	self.uiLayer = require("UiLayer").new()
	self:addChild(self.uiLayer, ZOrder.uiLayer)
end

function BaseScene:deinit()
end

function BaseScene:dtor()
	self:deinit()
end

return BaseScene
