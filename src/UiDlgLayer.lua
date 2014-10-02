
local UiDlgLayer = class("UiDlgLayer", function() return cc.Layer:create() end)


function UiDlgLayer:ctor() 
	self:init()
end


function UiDlgLayer:init()
	local function onTouchBegan(touch, event)
		cclog("UiDlgLayer swallow touch")
        cclog("__cname %s", self.__cname)
        cclog("self %s", self)
        return true
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    listener:setSwallowTouches(true)
end


function UiDlgLayer:deinit()

end


function UiDlgLayer:dtor()
	self:deinit()
end


return UiDlgLayer