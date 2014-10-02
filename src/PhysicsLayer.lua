
local SingleTouchLayer = require("SingleTouchLayer")

local PhysicsLayer = class("PhysicsLayer", SingleTouchLayer)

function PhysicsLayer:ctor() 
	PhysicsLayer.super.ctor(self)
	self:init()
end

function PhysicsLayer:init()
	self:initContact()	
	self:initEdgeBox()
end

function PhysicsLayer:deinit()
end

function PhysicsLayer:dtor()
	self:deinit()
end


function PhysicsLayer:addObj(location)
	local sp = cc.Sprite:create("menu1.png")
	self:addChild(sp)
	sp:setPosition(location)
	sp:setPhysicsBody(cc.PhysicsBody:createBox(sp:getContentSize()))

	-- 如果对碰撞感兴趣
	-- see setContactTestBitmask
	-- If either comparison results in a non-zero value, 
	-- an PhysicsContact object is created and passed to the physics world’s delegate. 
	-- For best performance, only set bits in the contacts mask 
	-- for interactions you are interested in.

	-- sp:getPhysicsBody():setCategoryBitmask(1);    
    sp:getPhysicsBody():setContactTestBitmask(1); 
	-- sp:getPhysicsBody():setCollisionBitmask(1);   -- 0011

end

function PhysicsLayer:initEdgeBox()
	local size = cc.Director:getInstance():getWinSize()
	local node = cc.Node:create()
    node:setPhysicsBody( cc.PhysicsBody:createEdgeBox(size) )
	node:setPosition( cc.p(size.width / 2, size.height / 2) )
	self:addChild(node)
end

function PhysicsLayer:initContact()
	local function onContactBegin(contact)
		cclog("onContactBegin")
		local a = contact:getShapeA():getBody();
        local b = contact:getShapeB():getBody();
        Util.dump(a:getNode())
        Util.dump(b:getNode())
        return true
	end
	local contactListener = cc.EventListenerPhysicsContact:create();
	contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN);
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(contactListener, self);
end


function PhysicsLayer:onTouchBegan(touch, event)
	self:addObj(touch:getLocation())
    return true
end


function PhysicsLayer:onTouchMoved(touch, event)
	
end


function PhysicsLayer:onTouchEnded(touch, event)

end


return PhysicsLayer
