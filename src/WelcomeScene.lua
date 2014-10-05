

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
        --name = "WelcomeLayer.ccbi",
        name = "WelcomeLayer.ccbi",
        ctrl = ctrl,
        ctrlName = "WelcomeLayer",
        }

    local node = CcbHelp.load(param)
    self:addChild(node)

end


function WelcomeLayer:addLogo()
    local sp = cc.Sprite:create(logoTex)
    self:addChild(sp)
    sp:setPosition(ccp(display.cx, display.cy + 100))
end


function WelcomeLayer:addBtn()
    self.menu = cc.Menu:create()
    self:addChild(self.menu)
    self.menu:setPosition(cc.p(0, 0))
    local loginBtn = Util.createButton({title = "login", cb = function()
        self:onBtnLogin()
    end})
    self.menu:addChild(loginBtn)
    loginBtn:setPosition(ccp(display.cx, display.cy))
end


function WelcomeLayer:onLoginButton()
    print("WelcomeLayer:onLoginButton")
    self:toLogin()
end


function WelcomeLayer:toLogin()
    if true then
        self:openAccountLayer()
        return
    end

    local Rpc = require("Rpc")
    local function loginCb(succ, result)
        if succ then
            print("rpc login succ")
            self:loginSucc()
        end
    end
    Rpc.call(loginCb, "login", 991)
    print("rpc call login")
end


function WelcomeLayer:loginSucc()
    cc.Director:getInstance():replaceScene(require("RpcTestScene").new())
end


function WelcomeLayer:getAccount()
    return "lin"
end


function WelcomeLayer:openAccountLayer()
    self.uiLayer:pushUiDlgLayer(require("SettingUiLayer").new())
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
