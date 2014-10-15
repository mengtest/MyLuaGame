
local MgLayerMap = require("MgLayerMap")
local MgLayerMapTouch = require("MgLayerMapTouch")


local MgSceneGame = class("MgSceneGame", function() 
    return cc.Scene:create()
end)


function MgSceneGame:ctor() 
    self:init()
end


function MgSceneGame:init()
    self:addChild(MgLayerMap.new())
    self:addChild(MgLayerMapTouch.new())
end


function MgSceneGame:deinit()
end


function MgSceneGame:dtor()
    self:deinit()
end


return MgSceneGame
