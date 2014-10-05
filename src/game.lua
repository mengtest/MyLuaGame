
local Audio = require("audio")

local game = class("game", function()
    return {}
end)

function game:ctor()
    self:init()
end

function game:init()
    -- cc.Director:getInstance():runWithScene(require("RpcTestScene").new())
    cc.Director:getInstance():runWithScene(Util.rerequire("WelcomeScene").new())
    if not Audio.isMusicOff() then
        Audio.playBgMusic()
    end
end

function game:deinit()
end

function game:dtor()
    self:deinit()
end

return game
