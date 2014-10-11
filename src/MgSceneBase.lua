
local MgSceneBase = class("MgSceneBase", function() 
    return cc.Scene:create()
end)

function MgSceneBase:ctor()
    cclog("MgSceneBase:ctor")
    self:init()
end

function MgSceneBase:init()
    cclog("MgSceneBase:init")
    self.uiLayer = require("MgUiLayer").new()
    self:addChild(self.uiLayer, MgZOrder.uiLayer)
end

function MgSceneBase:deinit()
end

function MgSceneBase:dtor()
    self:deinit()
end

return MgSceneBase
