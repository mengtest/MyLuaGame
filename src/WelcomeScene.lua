

local Rpc = require("Rpc")

local CcbHelp = require "CcbHelp"


local WelcomeLayer = class("WelcomeLayer", function()
    return cc.Layer:create()
end)


function WelcomeLayer:ctor()
    self:init()
end


function WelcomeLayer:init()
    self:initWithCcb()
end


function WelcomeLayer:initWithCcb()

    local ctrl = {}

    ctrl.onLoginButton = function()
        self:onLoginButton()
    end

    local param = {
        name = "WelcomeLayer.ccbi",
        ctrl = ctrl,
        ctrlName = "WelcomeLayer",
        }

    local node = CcbHelp.load(param)
    self:addChild(node)

    -- test
    self:toLogin()
end


function WelcomeLayer:onLoginButton()
    cclog("WelcomeLayer:onLoginButton")
    self:toLogin()
end


function WelcomeLayer:toLogin()
    local tb = self:loadAccount()
    local account = tb.account
    local password = tb.password
    if not account then
        self:openAccountLayer()
        return
    end

    local function loginCb(succ, loginResult)
        if succ and loginResult then
            cclog("rpc login succ")
            self:loginSucc()
        end
    end

    Rpc.login(account, password, loginCb)
end


function WelcomeLayer:loginSucc()
    -- load base data
    local function methodCb(succ, result)
        if succ then
            Util.dump(result)
        end
    end
    -- Rpc['system.listMethods']()
    Rpc.call(methodCb, 'system.listMethods')
    -- cc.Director:getInstance():replaceScene(require("RpcTestScene").new())
end


function WelcomeLayer:loadAccount()
    local userDefault = cc.UserDefault:getInstance()
    local account = userDefault:getStringForKey("account")
    local password = userDefault:getStringForKey("password")
    return {account = account, password = password,}
end


function WelcomeLayer:openAccountLayer()
    self.uiLayer:pushUiDlgLayer(Util.rerequire("AccountUiLayer").new())
end



--------



local WelcomeScene = class("WelcomeScene", require("BaseScene"))


function WelcomeScene:init()
    cclog("WelcomeScene:init")
    WelcomeScene.super.init(self)
    local layer = WelcomeLayer.new()
    layer.uiLayer = self.uiLayer
    self:addChild(layer)
end



return WelcomeScene
