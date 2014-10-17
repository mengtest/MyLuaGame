

local MgCcbHelp = require "MgCcbHelp"


local MgUiLayer = class("MgUiLayer", function() return cc.Layer:create() end)


function MgUiLayer:ctor() 
    self:init()
end

function MgUiLayer:init()
    self.uiDlgLayerStack = {}
    self:initWithCcb()
    self:initMisc()
    self:updateTopBar()
end

function MgUiLayer:deinit()

end

function MgUiLayer:dtor()
    self:deinit()
end


function MgUiLayer:initWithCcb()

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
        }

    local node = MgCcbHelp.load(param)
    self:addChild(node)

    self.ctrl = ctrl

end


function MgUiLayer:initMisc()
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

function MgUiLayer:addTopBar()
    self.ctrl.menuBtn:setVisible(false)
    self.ctrl.topBar:setVisible(true)
    self.ctrl.backBtn:setVisible(true)
end


function MgUiLayer:removeTopBar()
    self.ctrl.menuBtn:setVisible(true)
    self.ctrl.topBar:setVisible(false)
    self.ctrl.backBtn:setVisible(false)
end


function MgUiLayer:addLayerColor()
    self.ctrl.layerColor:setVisible(true)
end


function MgUiLayer:removeLayerColor()
    self.ctrl.layerColor:setVisible(false)
end


function MgUiLayer:onBackBtn()
    cclog("MgUiLayer:onBackBtn")
    self:popUiDlgLayer()
end


function MgUiLayer:pushUiDlgLayer(uiDlgLayer)
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


function MgUiLayer:popUiDlgLayer()
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


function MgUiLayer:updateTopBar()
    local count = #self.uiDlgLayerStack
    if (count > 0) then
        self:addTopBar()
        self:addLayerColor()
    elseif (count == 0) then
        self:removeTopBar()
        self:removeLayerColor()
    end
end


function MgUiLayer:onMenuBtn()
    cclog("MgUiLayer:onMenuBtn")
    self:pushUiDlgLayer(require("MgUiLayerMain").new())
end

function MgUiLayer:openMessageBox(param)
    self:pushUiDlgLayer(require("MgUiLayerMessagebox").new(param))
end

function MgUiLayer.closeMessageBox(cancelMsg)
    self:popUiDlgLayer()
end

 
return MgUiLayer
