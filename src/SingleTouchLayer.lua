
-- single touch

local SingleTouchLayer = class("SingleTouchLayer", function() return cc.Layer:create() end)

function SingleTouchLayer:ctor() 
	self:_init()
end

function SingleTouchLayer:_init()

	local function onTouchBegan(touch, event)
        return self:onTouchBegan(touch, event)
    end

    local function onTouchMoved(touch, event)
        self:onTouchMoved(touch, event)
    end

    local function onTouchEnded(touch, event)
        self:onTouchEnded(touch, event)
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

function SingleTouchLayer:deinit()
end

function SingleTouchLayer:dtor()
	self:deinit()
end

function SingleTouchLayer:onTouchBegan(touch, event)
    return true
end

function SingleTouchLayer:onTouchMoved(touch, event)
    
end

function SingleTouchLayer:onTouchEnded(touch, event)

end

return SingleTouchLayer