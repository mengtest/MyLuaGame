
-- CC_USE_DEPRECATED_API = true
require "cocos.init"


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
        glview = cc.GLViewImpl:createWithRect("MyGame", cc.rect(0,0,160,240))
        director:setOpenGLView(glview)
    end

    -- XXX: resolution size
    glview:setDesignResolutionSize(320, 480, cc.ResolutionPolicy.NO_BORDER)

    --turn on display FPS
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)
end


local function searchPathInit()
end


local function baseRequire()
    require "MgLanguage"
    MgUtils = require "MgUtils"
    MgTellme = require "MgTellme"
end


local function main()
    baseInit()
    searchPathInit()
    baseRequire()
    require("MgGame").run()
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
