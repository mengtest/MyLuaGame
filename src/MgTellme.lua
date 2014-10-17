-- MgTellme
-- single obj

local MgGame = require "MgGame"


local TELLME_FONT_SIZE = 24
local TELLME_FONT = ""
local TELLME_X_BEGIN = MgUtils.display.cx
local TELLME_Y_BEGIN = MgUtils.display.cy
local TELLME_LABEL_HEIGHT = TELLME_FONT_SIZE
local TELLME_KEEP_TIME = 4
local TELLME_FADEOUT_TIME = 1
local TELLME_COLOR = cc.c3b(255, 0, 0)


local TellmeLabel = class("TellmeLabel", function(text)
    return cc.LabelTTF:create(text, TELLME_FONT, TELLME_FONT_SIZE)
end)

TellmeLabel.refLabelArray = {}


function TellmeLabel:ctor()
    self:init()
end


function TellmeLabel:init()
    self:setColor(TELLME_COLOR)
    self:setPosition(cc.p(TELLME_X_BEGIN, TELLME_Y_BEGIN))
    local function afterKeepDelay()
        self:runAction(self:createAction(TELLME_FADEOUT_TIME))
    end
    local function afterFadeOut()
        self:removeFromParent()
        TellmeLabel.removeFromRef(self)
    end
    performWithDelay(self, afterKeepDelay, TELLME_KEEP_TIME)
    performWithDelay(self, afterFadeOut, TELLME_KEEP_TIME + TELLME_FADEOUT_TIME)
    TellmeLabel.addToRef(self)
end


function TellmeLabel:moveUp()
    local x, y = self:getPosition()
    self:setPosition(cc.p(x, y + TELLME_LABEL_HEIGHT))
end

function TellmeLabel:createAction(delay)
    return cc.FadeTo:create(delay, 0)
end


function TellmeLabel.addToRef(label)
    TellmeLabel.refLabelArray[label] = true
end


function TellmeLabel.removeFromRef(label)
    TellmeLabel.refLabelArray[label] = nil
end



local MgTellme = {}


function MgTellme.show(text)
    local uiLayer = MgGame.refCurrentScene
    if not uiLayer then
        cclog("no uiLayer")
    end

    local label = TellmeLabel.new(text)
    uiLayer:addChild(label)

    -- move up
    for label in pairs(TellmeLabel.refLabelArray) do
        label:moveUp()
    end
end


return MgTellme