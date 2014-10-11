
local Audio = require("MgAudio")

local MgGame = class("MgGame", function()
    return {}
end)

function MgGame:ctor()
    self:init()
end

function MgGame:init()
    MgUtils.replaceScene(MgUtils.rerequire("MgSceneWelcome").new())
    if not Audio.isMusicOff() then
        Audio.playBgMusic()
    end
end

function MgGame:deinit()
end

function MgGame:dtor()
    self:deinit()
end

return MgGame
