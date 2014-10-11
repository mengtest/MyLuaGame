

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
        ctrlName = "UiLayerWelcome",
        }

    local node = MgCcbHelp.load(param)
    self:addChild(node)

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
        self:openAccountLayer()
        return
    end

    --------

    local function loginCb(succ, loginResult)
        self:closeWaitingLayer()
        if succ and loginResult then
            cclog("rpc login succ")
            self:loginSucc()
        else
            cclog("rpc login fail")
            self:loginFail()
        end
    end

    MgRpc.login(account, password, loginCb)

    self:openWaitingLayer() -- loading
end


function MgUiLayerWelcome:loginSucc()
    -- load base data
    local function methodCb(succ, result)
        if succ then -- all rpc method
            -- utils.dump(result)
        end
    end
    MgRpc.call(methodCb, 'system.listMethods') -- XXX:
end


function MgUiLayerWelcome:loginFail() -- TODO:
    
end


function MgUiLayerWelcome:loadAccount()
    local userDefault = cc.UserDefault:getInstance()
    local account = userDefault:getStringForKey("account")
    local password = userDefault:getStringForKey("password")
    return {account = account, password = password,}
end


function MgUiLayerWelcome:openAccountLayer()
    self.uiLayer:pushUiDlgLayer(utils.rerequire("AccountUiLayer").new())
end


function MgUiLayerWelcome:openWaitingLayer()
    self.uiLayer:pushUiDlgLayer(utils.rerequire("WaitingUiLayer").new())
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
