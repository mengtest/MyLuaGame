

local CcbHelp = require "CcbHelp"


local UiLayer = class("UiLayer", function() return cc.Layer:create() end)


function UiLayer:ctor() 
    self:init()
end

function UiLayer:init()
    self.uiDlgLayerStack = {}
    self:initWithCcb()
    self:initMisc()
    self:updateTopBar()
end

function UiLayer:deinit()

end

function UiLayer:dtor()
    self:deinit()
end


function UiLayer:initWithCcb()

    local ctrl = {}

    ctrl.onMenuBtn = function()
        self:onMenuBtn()
    end

    ctrl.onBackBtn = function()
        self:onBackBtn()
    end

    local param = {
        name = "UiLayer.ccbi",
        ctrl = ctrl,
        ctrlName = "UiLayer",
        }

    local node = CcbHelp.load(param)
    self:addChild(node)
    Util.dump(param.ctrl)

    self.ctrl = ctrl

end


function UiLayer:initMisc()
    --[[
    local function onTouchBegan(touch, event)
        cclog("UiDlgLayer swallow touch")
        cclog("__cname %s", self.__cname)
        cclog("self %s", self)
        return true
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self.ctrl.layerColor)
    listener:setSwallowTouches(true)
    ]]
    --[[
    local size = self.ctrl.topBar:getContentSize()
    self.ctrl.topBar:setPreferredSize(cc.size(display.width, size.height))
    ]]
end

function UiLayer:addTopBar()
    self.ctrl.menuBtn:setVisible(false)
    self.ctrl.topBar:setVisible(true)
    self.ctrl.backBtn:setVisible(true)
end


function UiLayer:removeTopBar()
    self.ctrl.menuBtn:setVisible(true)
    self.ctrl.topBar:setVisible(false)
    self.ctrl.backBtn:setVisible(false)
end


function UiLayer:addLayerColor()
    self.ctrl.layerColor:setVisible(true)
end


function UiLayer:removeLayerColor()
    self.ctrl.layerColor:setVisible(false)
end


function UiLayer:onBackBtn()
    cclog("UiLayer:onBackBtn")
    self:popUiDlgLayer()
end


function UiLayer:pushUiDlgLayer(uiDlgLayer)
    self.ctrl.layerColor:addChild(uiDlgLayer)
    uiDlgLayer.uiLayer = self
    local count = #self.uiDlgLayerStack
    if count > 0 then
        self.uiDlgLayerStack[count]:setVisible(false)
    end
    self.uiDlgLayerStack[count + 1] = uiDlgLayer
    -- table.insert(self.uiDlgLayerStack, uiDlgLayer)
    self:updateTopBar()
end


function UiLayer:popUiDlgLayer()
    assert(self.uiDlgLayerStack)
    local count = #self.uiDlgLayerStack
    local uiDlgLayer = self.uiDlgLayerStack[count]
    self.ctrl.layerColor:removeChild(uiDlgLayer)
    self.uiDlgLayerStack[count] = nil
    if count > 1 then
        self.uiDlgLayerStack[count - 1]:setVisible(true)
    end
    self:updateTopBar()
end


function UiLayer:updateTopBar()
    local count = #self.uiDlgLayerStack
    if (count > 0) then
        self:addTopBar()
        self:addLayerColor()
    elseif (count == 0) then
        self:removeTopBar()
        self:removeLayerColor()
    end
end


function UiLayer:onMenuBtn()
    cclog("UiLayer:onMenuBtn")
    self:pushUiDlgLayer(require("MainUiLayer").new())
end

function UiLayer:openMessageBox(param)
    self:pushUiDlgLayer(require("MessageBoxUiLayer").new(param))
end

function UiLayer.closeMessageBox(cancelMsg)
    self:popUiDlgLayer()
end

 
return UiLayer
