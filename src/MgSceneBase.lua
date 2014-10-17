
local MgSceneBase = class("MgSceneBase", function(isPhysics)
    if isPhysics then
        cclog("physics scene")
        return cc.Scene:createWithPhysics()
    else
        return cc.Scene:create()
    end
end)


function MgSceneBase:ctor()
    cclog("MgSceneBase:ctor")
    self:init()
end

function MgSceneBase:init()
    cclog("MgSceneBase:init")
    self.uiLayer = require("MgUiLayer").new()
    self:addChild(self.uiLayer, require("MgZOrder").uiLayer)
end

function MgSceneBase:deinit()
end

function MgSceneBase:dtor()
    self:deinit()
end

return MgSceneBase
