
-- multi touch

local MultiTouchLayer = class("MultiTouchLayer", function() return cc.Layer:create() end)

function MultiTouchLayer:ctor() 
	self:_init()
end

function MultiTouchLayer:_init()
    --[[
    local function touchesToLocations(touches)
        local locations = {}
        for i, touch in ipairs(touches) do
            locations[i] = touch:getLocation()
        end
        return locations
    end
    ]]

    local function onTouchesBegan(touches, event)
        return self:onTouchesBegan(touches, event)
    end

    local function onTouchesMoved(touches, event)
        self:onTouchesMoved(touches, event)
    end

    local function onTouchesEnded(touches, event)
        self:onTouchesEnded(touches, event)
    end

    local listener = cc.EventListenerTouchAllAtOnce:create()    
    listener:registerScriptHandler(onTouchesBegan, cc.Handler.EVENT_TOUCHES_BEGAN)
    listener:registerScriptHandler(onTouchesMoved, cc.Handler.EVENT_TOUCHES_MOVED)
    listener:registerScriptHandler(onTouchesEnded, cc.Handler.EVENT_TOUCHES_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

function MultiTouchLayer:deinit()
end

function MultiTouchLayer:dtor()
	self:deinit()
end

-- over load

function MultiTouchLayer:onTouchesBegan(touches, event)
    return true
end

function MultiTouchLayer:onTouchesMoved(touches, event)

end

function MultiTouchLayer:onTouchesEnded(touches, event)

end

return MultiTouchLayer