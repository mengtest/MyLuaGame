

local MgCcbHelp = require "MgCcbHelp"


local MgUiLayerAccount = class("MgUiLayerAccount", require("MgUiLayerDlg"))


function MgUiLayerAccount:init()
    MgUiLayerAccount.super.init(self)
    self:initWithCcb()
end


function MgUiLayerAccount:initWithCcb()

    local ctrl = {}

    ctrl.onSureBtn= function()
        self:onSureBtn()
    end

    local param = {
        name = "UiLayerAccount.ccbi",
        ctrl = ctrl,
        }

    local node = MgCcbHelp.load(param)

    self:addChild(node)

    self.ctrl = ctrl

    local function sprite2EditBox(sp)
        local parent = sp:getParent()
        local size = sp:getContentSize()
        local x, y = sp:getPosition()
        local newEditBox = ccui.EditBox:create(size, "TextInput.png")
        newEditBox:setPosition(cc.p(x, y))
        parent:addChild(newEditBox)
        return newEditBox
    end

    local tb = self:loadAccount() -- load from xml
    local account = tb.account
    local password = tb.password
    cclog(account)
    cclog(password)

    local accountEdit = sprite2EditBox(self.ctrl.accountEdit)
    if account == "" then
        accountEdit:setPlaceHolder(T"account")
    else
        accountEdit:setText(account)
    end

    local passwordEdit = sprite2EditBox(self.ctrl.passwordEdit)
    if password == "" then
        passwordEdit:setPlaceHolder(T"password")
    else
        passwordEdit:setText(password)
        passwordEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
    end

    self.ctrl.accountEdit = accountEdit
    self.ctrl.passwordEdit = passwordEdit
end


function MgUiLayerAccount:onSureBtn()
    cclog("MgUiLayerAccount:onSureBtn")
    local account = self.ctrl.accountEdit:getText()
    local password = self.ctrl.passwordEdit:getText()
    cclog(account)
    cclog(password)
    self:saveAccount({account = account, password = password,})
    self.uiLayer:popUiDlgLayer()
end


function MgUiLayerAccount:saveAccount(param)
    local userDefault = cc.UserDefault:getInstance()
    local account = param.account
    local password = param.password
    userDefault:setStringForKey("account", account)
    userDefault:setStringForKey("password", password)
end


function MgUiLayerAccount:loadAccount()
    local userDefault = cc.UserDefault:getInstance()
    local account = userDefault:getStringForKey("account")
    local password = userDefault:getStringForKey("password")
    return {account = account, password = password,}
end


return MgUiLayerAccount
