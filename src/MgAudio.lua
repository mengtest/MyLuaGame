-- Audio
require "AudioEngine" 

local Audio = {}
local userDefault = cc.UserDefault:getInstance()

function Audio.isMusicOff()
    return userDefault:getBoolForKey("MusicOff")
end

function Audio.setMusicStatus(on)
    cclog("Audio.setMusicStatus%s", on and true or false)
    userDefault:setBoolForKey("MusicOff", not on)
    AudioEngine.stopMusic()
    if on then 
        Audio.playBgMusic()
    end
end

function Audio.playBgMusic()
    if Audio.isMusicOff() then return end
    local MUSIC_FILE = "background.mp3"
    AudioEngine.playMusic(MUSIC_FILE, true)
end

function Audio.pauseBgMusic()
    if Audio.isMusicOff() then return end
    AudioEngine.pauseMusic()
end

function Audio.resumeMusic()
    if Audio.isMusicOff() then return end
    AudioEngine.resumeMusic()
end

function Audio.playEffect(file)
    if Audio.isMusicOff() then return end
    AudioEngine.playEffect(file)
end


return Audio
