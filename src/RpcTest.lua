
local Rpc = require("rpc")


local RpcTest = {}


function RpcTest.begin()
    print("RpcTest.begin")
    RpcTest._test()
end


function RpcTest._test()
--  http://http://xmlrpc.scripting.com/spec.html

    local function loginCb(succ, result)
        if succ then
            print(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "system.listMethods")
    print("rpc call system.listMethods")
    
    local function loginCb(succ, result)
        if succ then
            print(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "system.methodHelp", "login")
    print("rpc call system.methodHelp")

    local function loginCb(succ, result)
        if succ then
            print(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "system.methodSignature", "login")
    print("rpc call system.methodSignature")

    local function loginCb(succ, result)
        if succ then
            print(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "login", 991)
    print("rpc call login")
    
    local function loginCb(succ, result)
        if succ then
            print(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "login", 992)
    print("rpc call login")

    local function loginCb(succ, result)
        if succ then
            print(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(loginCb, "login", 992)
    print("rpc call login")

    local function exitCb(succ, result)
        if succ then
            print(type(result))
            Util.dump(result)
        end
    end
    Rpc.call(exitCb, "exit")
    print("rpc call exit")
    

end


function RpcTest._test()
--  http://http://xmlrpc.scripting.com/spec.html
    for i = 1, 10 do
        local function loginCb(succ, result)
            if succ then
                print(type(result))
                Util.dump(result)
            end
        end

        local flag = cc.Application:getInstance():getTargetPlatform()
        Rpc.call(loginCb, "login", flag)
        print("rpc call login")
    end
end

return RpcTest
