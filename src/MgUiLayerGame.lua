

local MgGame = require "MgGame"
local MgCcbHelp = require "MgCcbHelp"


local MgUiLayerGame = class("MgUiLayerGame", function() return cc.Layer:create() end)


function MgUiLayerGame:ctor()
    self:init()
end


function MgUiLayerGame:init()
    self:initWithCcb()
end


function MgUiLayerGame:initWithCcb()

    local ctrl = {}

    ctrl.onPauseBtn = function()
        self:onPauseBtn()
    end

    local param = {
        name = "UiLayerGame.ccbi",
        ctrl = ctrl,
        }

    local node = MgCcbHelp.load(param)
    self:addChild(node)

    self.ctrl = ctrl

    self:updateBtn()

end


function MgUiLayerGame:onPauseBtn()
    cclog("MgUiLayerGame:onPauseBtn")
    local isPause = MgGame.getIsPause()
    cclog("isPause"..tostring(isPause))
    if isPause then
        MgGame.resumeGame()
    else
        MgGame.pauseGame()
    end
    self:updateBtn()
end


function MgUiLayerGame:updateBtn()
    local label = self.ctrl["pauseBtn"]:getTitleLabel()
    local isPause = MgGame.getIsPause()
    local text = isPause and ">" or "||"
    label:setString(text)
end


return MgUiLayerGame
