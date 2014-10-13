require "Cocos2d"
require "Cocos2dConstants"

-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function baseInit()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    cc.FileUtils:getInstance():setPopupNotify(false) -- not need those log

    -- initialize director
    local director = cc.Director:getInstance()
    local glview = director:getOpenGLView()
    if nil == glview then
        -- in osx
        glview = cc.GLViewImpl:createWithRect("MyGame", cc.rect(0,0,480,320))
        director:setOpenGLView(glview)
    end

    -- XXX: resolution size
    glview:setDesignResolutionSize(480, 320, cc.ResolutionPolicy.NO_BORDER)

    --turn on display FPS
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)
end

local function searchPathInit()
    -- local ccbPath = "res/ccb/Published-iOS"
    -- in dev
    local ccbPath = "/users/linxiaojin/dev/git/MyLuaGame/res/ccb/Published-iOS"
    cc.FileUtils:getInstance():addSearchPath(ccbPath, true)

    -- local resPath = "res"
    -- in dev
    local newPath = "/users/linxiaojin/dev/git/MyLuaGame/res"
    cc.FileUtils:getInstance():addSearchPath(newPath)
end

local function baseRequire()
    require "Cocos2d"
    require "Cocos2dConstants"
    require "extern"
    require "MgLanguage"

    MgZOrder = require "MgZOrder"
    MgUtils = require "MgUtils"
end

local function main()
    baseInit()
    searchPathInit()
    baseRequire()
    require("MgGame").new()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
