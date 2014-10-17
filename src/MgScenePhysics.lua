

local PhysicsLayer = require("PhysicsLayer")

local PhysicsScene = class("PhysicsScene", function() 
    return cc.Scene:createWithPhysics()
end)

function PhysicsScene:ctor() 
    self:init()
end

function PhysicsScene:init()
    self:getPhysicsWorld():setDebugDrawMask(
              debug and cc.PhysicsWorld.DEBUGDRAW_ALL or cc.PhysicsWorld.DEBUGDRAW_NONE)
    self:addChild(PhysicsLayer.new())
end

function PhysicsScene:deinit()
end

function PhysicsScene:dtor()
    self:deinit()
end

return PhysicsScene
