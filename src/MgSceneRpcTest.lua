
local RpcTestScene = class("RpcTestScene", require("BaseScene"))


function RpcTestScene:init()
	cclog("RpcTestScene:init")
	RpcTestScene.super.init(self)

	self.menu = cc.Menu:create()
	self:addChild(self.menu)

    local function btnCb()
        local RpcTest = utils.rerequire("RpcTest")
        RpcTest.begin()
    end

    local btn = utils.createButton({text = "test", 
    cb = btnCb,})

    self.menu:addChild(btn)
end


return RpcTestScene
