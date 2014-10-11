
local MapLayer = require("MapLayer")
local MapTouchLayer = require("MapTouchLayer")

local MainScene = class("MainScene", function() 
    return cc.Scene:create()
end)

function MainScene:ctor() 
    self:init()
end

function MainScene:init()
    self:addChild(MapLayer.new())
    self:addChild(MapTouchLayer.new())
end

function MainScene:deinit()
end

function MainScene:dtor()
    self:deinit()
end

return MainScene
