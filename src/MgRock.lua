
-- MgRock
local TEX_ROCK = "rock.png"
local PI = 3.1415926535
local ROCK_MOVE_LEN = MgUtils.display.height
local ROCK_MOVE_SPEED = ROCK_MOVE_LEN

local sin = math.sin
local cos = math.cos
local tan = math.tan

local random = math.random


-- tools

local function randomRad()
    local r = random(0, PI)
    return r
end


local MgRock = class("MgRock", function() return cc.Sprite:create(TEX_ROCK) end)


function MgRock:ctor()
    self:init()
end


function MgRock:init()
    self:initPhysics()
    self:beginAction()
end


function MgStar:initPhysics()
    local size = self:getContentSize()
    local physicsBody = cc.PhysicsBody:createBox(size)
    self:setPhysicsBody(physicsBody)
    self:setDynamic(false)
end


function MgRock:beginAction()
    local rad = randomRad()
    local len = ROCK_MOVE_LEN
    local v = ROCK_MOVE_SPEED
    local x = len * rad
    local y = len * rad
    local dr = len / v
    
    local moveTo = cc.MoveTo:create(dr, cc.p(x, y))

    local delay = cc.DelayTime:create(dr)
    local callFunc = cc.CallFuncN:create(
        function()
            :
        end
    )
    
    local tintTo = cc.TintTo:create(1, 128, 128, 128)
    local tintToR = cc.TintTo:create(1, 255, 255, 255)
    local seq = cc.Sequence:create(tintTo, tintToR)
    local rep = cc.RepeatForever:create(seq)
    self:runAction(rep)
end


return MgRock
