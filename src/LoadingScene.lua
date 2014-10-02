
local LoadingScene = class("LoadingScene", require("BaseScene"))

function LoadingScene:init()
	cclog("LoadingScene:init")
	LoadingScene.super.init(self)
	self:addLoadingBar()
end

function LoadingScene:addLoadingBar()
	local x = display.cx
	local y = display.cy

	local barBg = cc.Sprite:create("loading_bg.png")
	barBg:setPosition(cc.p(x, y))

	local bar = cc.ProgressTimer:create(cc.Sprite:create("loading.png"))
    bar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    -- Setup for a bar starting from the left since the midpoint is 0 for the x
    bar:setMidpoint(cc.p(0, 0))
    -- Setup for a horizontal bar since the bar change rate is 0 for y meaning no vertical change
    bar:setBarChangeRate(cc.p(1, 0))
    bar:setPosition(cc.p(x, y))

	self:addChild(bar)
	self:addChild(barBg)

	local to = cc.ProgressTo:create(1, 100)
	bar:runAction(to)
	
	performWithDelay(self, function()
		self:gotoGameScene()
		end, 1)
end

function LoadingScene:gotoGameScene()
	cc.Director:getInstance():replaceScene(require("MainScene").new())
end

return LoadingScene
