
local MapLayer = class("MapLayer", function() return cc.Layer:create() end)

function MapLayer:ctor() 
    self:init()
    MapLayer._instance = self
end

function MapLayer:init()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    -- add in farm background
    local bg = cc.Sprite:create("farm.jpg")
    bg:setPosition(origin.x + visibleSize.width / 2, origin.y + visibleSize.height / 2)
    self:addChild(bg)
    -- bg:setOpacity(64)
    self.bg = bg
end

function MapLayer:deinit()
end

function MapLayer:dtor()
    self:deinit()
end

function MapLayer.getInstance()
    return MapLayer._instance
end

function MapLayer:getSize()
    return self.bg:getContentSize()
end

return MapLayer