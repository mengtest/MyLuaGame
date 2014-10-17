-- MgStar

local TICK_DELAY = 0.1


local MgRock = require "MgRock"

local MgStar = class("MgStar", function(starSp) return starSp end)


function MgStar:ctor()
    self:init()
end


function MgStar:init()
    self:initPhysics()
    self:beginAction()
end


function MgStar:initPhysics()
    local size = self:getContentSize()
    local physicsBody = cc.PhysicsBody:createBox(size)
    self:setPhysicsBody(physicsBody)
    self:setDynamic(false)
end


function MgStar:beginAction()
    local tintTo = cc.TintTo:create(1, 128, 128, 128)
    local tintToR = cc.TintTo:create(1, 255, 255, 255)
    local seq = cc.Sequence:create(tintTo, tintToR)
    local rep = cc.RepeatForever:create(seq)
    self:runAction(rep)
end


function MgStar:initTick()
    performWithDelay(self, function()
        self:tick()
    end, TICK_DELAY)
end


function MgStar:tick()
    self:createRock()
end


function MgStar:createRock()
    local rock = MgRock.new()
    self:addChild(rock)
end


return MgStar
