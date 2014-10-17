
local MgLayerMap = require("MgLayerMap")
local MgLayerMapTouch = require("MgLayerMapTouch")
local MgUiLayerGame = require("MgUiLayerGame")


local MgSceneGame = class("MgSceneGame", require("MgSceneBase"))


function MgSceneGame:init()
    MgSceneGame.super.init(self)
    self:getPhysicsWorld():setDebugDrawMask(
              debug and cc.PhysicsWorld.DEBUGDRAW_ALL or cc.PhysicsWorld.DEBUGDRAW_NONE)
    self:addChild(MgLayerMap.new())
    -- self:addChild(MgLayerMapTouch.new())
    self:addChild(MgUiLayerGame.new())
end


function MgSceneGame:deinit()
end


function MgSceneGame:dtor()
    self:deinit()
end


return MgSceneGame
