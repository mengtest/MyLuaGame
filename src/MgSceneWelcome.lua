

local MgRpc = require("MgRpc")

local MgCcbHelp = require "MgCcbHelp"


local MgUiLayerWelcome = class("MgUiLayerWelcome", function()
    return cc.Layer:create()
end)


function MgUiLayerWelcome:ctor()
    self:init()
end


function MgUiLayerWelcome:init()
    self:initWithCcb()
end


function MgUiLayerWelcome:initWithCcb()

    local ctrl = {}

    ctrl.onLoginButton = function()
        self:onLoginButton()
    end

    local param = {
        name = "UiLayerWelcome.ccbi",
        ctrl = ctrl,
        }

    local node = MgCcbHelp.load(param)
    self:addChild(node)

    -- test
    performWithDelay(self, function()
        self:gotoGameScene()
    end, 0)
end


function MgUiLayerWelcome:onLoginButton()
    cclog("MgUiLayerWelcome:onLoginButton")
    self:toLogin()
    self:openWaitingLayer()
end


function MgUiLayerWelcome:toLogin()
    local tb = self:loadAccount()
    local account = tb.account
    local password = tb.password
    if not account then
        MgTellme.show(T"account not exist")
        self:openAccountLayer()
        return
    end

    --------

    local function loginCb(succ, loginResult)
        if succ and loginResult then
            cclog("rpc login succ")
            self:loginSucc()
        else
            self:closeWaitingLayer()
            cclog("rpc login fail")
            self:loginFail()
        end
    end

    -- MgRpc.login(account, password, loginCb)
    self:gotoGameScene()
end


function MgUiLayerWelcome:loginSucc()
    -- load base data
    local function methodCb(succ, result)
        if succ then -- all rpc method
            -- utils.dump(result)
            self:closeWaitingLayer()
            self:gotoGameScene()
        end
    end
    MgRpc.call(methodCb, 'system.listMethods') -- XXX:
end


function MgUiLayerWelcome:gotoGameScene()
    require("MgGame").gotoGameScene()
end


function MgUiLayerWelcome:loginFail() -- TODO:
    self:closeWaitingLayer()
    MgTellme.show(T"fail to login")
end


function MgUiLayerWelcome:loadAccount()
    local userDefault = cc.UserDefault:getInstance()
    local account = userDefault:getStringForKey("account")
    local password = userDefault:getStringForKey("password")
    return {account = account, password = password,}
end


function MgUiLayerWelcome:openAccountLayer()
    self.uiLayer:pushUiDlgLayer(MgUtils.rerequire("MgUiLayerAccount").new())
end


function MgUiLayerWelcome:openWaitingLayer()
    self.uiLayer:pushUiDlgLayer(MgUtils.rerequire("MgUiLayerWaiting").new())
end


function MgUiLayerWelcome:closeWaitingLayer()
    self.uiLayer:popUiDlgLayer()
end


--------


local MgSceneWelcome = class("MgSceneWelcome", require("MgSceneBase"))


function MgSceneWelcome:init()
    cclog("MgSceneWelcome:init")
    MgSceneWelcome.super.init(self)
    local layer = MgUiLayerWelcome.new()
    layer.uiLayer = self.uiLayer
    self:addChild(layer)
end


return MgSceneWelcome
