
local Audio = require("MgAudio")

local MgGame = {}


function MgGame.run()
    if not Audio.isMusicOff() then
        Audio.playBgMusic()
    end
    MgGame.gotoWelcomeScene()
end


function MgGame.gotoWelcomeScene()
    MgGame.replaceScene(MgUtils.rerequire("MgSceneWelcome").new())
end


function MgGame.gotoGameScene()
    MgGame.replaceScene(MgUtils.rerequire("MgSceneGame").new())
end

--[[--

切换到新场景

~~~ lua

-- 使用红色做过渡色
display.replaceScene(nextScene, "fade", 0.5, ccc3(255, 0, 0))

~~~

@param CCScene newScene 场景对象
@param string transitionType 过渡效果名
@param number time 过渡时间
@param mixed more 过渡效果附加参数

]]
function MgGame.replaceScene(newScene, transitionType, time, more)
    local refCurrentScene = newScene
    local sharedDirector = cc.Director:getInstance()
    if sharedDirector:getRunningScene() then
        if transitionType then
            newScene = display.wrapSceneWithTransition(newScene, transitionType, time, more)
        end
        sharedDirector:replaceScene(newScene)
    else
        sharedDirector:runWithScene(newScene)
    end
    MgGame.refCurrentScene = refCurrentScene 
end


return MgGame
