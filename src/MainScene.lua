
local MapLayer = require("MapLayer")
local MapTouchLayer = require("MapTouchLayer")


local MainScene = class("MainScene", require("BaseScene"))

function MainScene:init()
	cclog("MainScene:init")
	MainScene.super.init(self)
	self:addChild(MapLayer.new())
	self:addChild(MapTouchLayer.new())
	self.uiLayer:openMessageBox({
		info = T"save?",
		okCb = function() cclog("ok cb") end, 
		cancelCb = function() cclog("cancel cb") end,
	})
end

return MainScene
