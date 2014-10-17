

local MgLayerSingleTouch = require("MgLayerSingleTouch")

local MgStar = require "MgStar"
local MgCcbHelp = require "MgCcbHelp"

local MgMapLayer = class("MgMapLayer", MgLayerSingleTouch)


function MgMapLayer:ctor()
    self:init()
    MgMapLayer._instance = self
end


function MgMapLayer:init()
    self:initWithCcb()
    self:initStar()
end


function MgMapLayer:deinit()
end


function MgMapLayer:dtor()
    self:deinit()
end


function MgMapLayer:initWithCcb()

    local ctrl = {}

    ctrl.onPauseBtn = function()
        self:onPauseBtn()
    end

    local param = {
        name = "MapLayerGame.ccbi",
        ctrl = ctrl,
        }

    local node = MgCcbHelp.load(param)
    self:addChild(node)

    self.ctrl = ctrl

end


function MgMapLayer.getInstance()
    return MgMapLayer._instance
end


function MgMapLayer:getSize()
    return self.bg:getContentSize()
end


function MgMapLayer:getStar()
    return self.MgStar
end


function MgMapLayer:initStar()
    local starObj = self.ctrl["star"]
    local MgStar = MgStar.new(starObj)
    self.MgStar = MgStar
end


return MgMapLayer
