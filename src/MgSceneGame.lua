
local MgLayerMap = require("MgLayerMap")
local MgLayerMapTouch = require("MgLayerMapTouch")


local MgSceneGame = class("MgSceneGame", require("MgSceneBase")) 


function MgSceneGame:init()
    MgSceneGame.super.init(self)
    self:addChild(MgLayerMap.new())
    self:addChild(MgLayerMapTouch.new())
end


function MgSceneGame:deinit()
end


function MgSceneGame:dtor()
    self:deinit()
end


return MgSceneGame
