

local CcbHelp = require "CcbHelp"


local WaitingUiLayer = class("WaitingUiLayer", require("UiDlgLayer"))


function WaitingUiLayer:init()
    WaitingUiLayer.super.init(self)
    self:initWithCcb()
end


function WaitingUiLayer:initWithCcb()

    local ctrl = {}

    local param = {
        name = "WaitingUiLayer.ccbi",
        ctrl = ctrl,
        }

    local node = CcbHelp.load(param)

    self:addChild(node)

end


function WaitingUiLayer:prepareToNextScene()
    local function cb()
    end
    performWithDelay(self, cb, 0)
end


return WaitingUiLayer
