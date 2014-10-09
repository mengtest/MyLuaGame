
local Rpc = require("rpc")


local RpcTest = {}


function RpcTest.begin()
    cclog("RpcTest.begin")
    RpcTest._test()
end


function RpcTest._test()
--  http://http://xmlrpc.scripting.com/spec.html

    local function loginCb(succ, result)
        if succ then
            cclog(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "system.listMethods")
    cclog("rpc call system.listMethods")
    
    local function loginCb(succ, result)
        if succ then
            cclog(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "system.methodHelp", "login")
    cclog("rpc call system.methodHelp")

    local function loginCb(succ, result)
        if succ then
            cclog(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "system.methodSignature", "login")
    cclog("rpc call system.methodSignature")

    local function loginCb(succ, result)
        if succ then
            cclog(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "login", 991)
    cclog("rpc call login")
    
    local function loginCb(succ, result)
        if succ then
            cclog(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "login", 992)
    cclog("rpc call login")

    local function loginCb(succ, result)
        if succ then
            cclog(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "login", 992)
    cclog("rpc call login")

    local function exitCb(succ, result)
        if succ then
            cclog(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(exitCb, "exit")
    cclog("rpc call exit")
    

end


function RpcTest._test()
--  http://http://xmlrpc.scripting.com/spec.html
    local Rpc = Util.rerequire("Rpc")
    for i = 1, 10 do
        local function loginCb(succ, result)
            if succ then
                cclog(type(result))
                Util.dump(result)
            end
        end

        local flag = cc.Application:getInstance():getTargetPlatform()
        Rpc.call(loginCb, "login", flag)
        cclog("rpc call login")
    end
end

function RpcTest._test()
--  http://http://xmlrpc.scripting.com/spec.html
    local Rpc = Util.rerequire("Rpc")
    co = coroutine.create(function()
        for i = 1, 10 do
            local function loginCb(succ, result)
                if succ then
                    cclog(type(result))
                    Util.dump(result)
                    coroutine.resume(co)
                end
            end

            local flag = cc.Application:getInstance():getTargetPlatform()
            Rpc.call(loginCb, "login", flag)
            cclog("rpc call login")
            coroutine.yield()
        end
    end)
    coroutine.resume(co)
end

return RpcTest
