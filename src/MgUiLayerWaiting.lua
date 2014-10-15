

local MgCcbHelp = require "MgCcbHelp"


local MgUiLayerWaiting = class("MgUiLayerWaiting", require("MgUiLayerDlg"))


function MgUiLayerWaiting:init()
    MgUiLayerWaiting.super.init(self)
    self:initWithCcb()
end


function MgUiLayerWaiting:initWithCcb()

    local ctrl = {}

    local param = {
        name = "UiLayerWaiting.ccbi",
        ctrl = ctrl,
        }

    local node = MgCcbHelp.load(param)

    self:addChild(node)

end


function MgUiLayerWaiting:prepareToNextScene()
    local function cb()
    end
    performWithDelay(self, cb, 0)
end


return MgUiLayerWaiting
