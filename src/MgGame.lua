
local Audio = require("MgAudio")

local MgGame = {}


function MgGame.run()
    if not Audio.isMusicOff() then
        Audio.playBgMusic()
    end
    MgGame.gotoWelcomeScene()
end


function MgGame.gotoWelcomeScene()
    MgUtils.replaceScene(MgUtils.rerequire("MgSceneWelcome").new())
end


function MgGame.gotoGameScene()
    MgUtils.replaceScene(MgUtils.rerequire("MgSceneGame").new())
end


return MgGame
