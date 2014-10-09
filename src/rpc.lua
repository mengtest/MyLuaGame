
local user = require("user")

local Http = require("http")

local xmlrpc = require("xmlrpc")


local Rpc = {}


function Rpc._encode(method, ...)
    return xmlrpc.clEncode(method, ...)
end

function Rpc._decode(data)
    return xmlrpc.clDecode(data)
end

function Rpc.callAsync(cb, method, ...)
    local data = Rpc._encode(method, ...)
    local function _cb(succ, response)
        local decodeSucc, result
        if succ then
            decodeSucc, result = Rpc._decode(response)
            if not decodeSucc then
                 cclog("decode rpc error")
                 Util.dump(response)
            end
        else
            cclog("http error")
        end
        if cb then cb(succ and decodeSucc, result) end -- always cb
    end

    -- local Http = Util.rerequire("http")
    Http.send(data, _cb)
end

function Rpc.call(cb, method, ...)
     return Rpc.callAsync(cb, method, ...)
end


--[[
function Rpc.call(cb, method, ...)
    -- return Rpc.callAsync(cb, method, ...)
    local co = coroutine.create(function()
        local _cb = function(...)
            cb(...)
            -- coroutine.resume(co)
        end
        Rpc.callAsync(_cb, method, 1)
        cclog("==============1")
        coroutine.yield()
        cclog("==============2")
    end)
    coroutine.resume(co)

end
]]--


local RpcM = {}
setmetatable(Rpc, RpcM)
RpcM.__index = function(self, key)
    cclog("rpcm index key %s", key)
    local function newFunc(...)
        
        local argsLen = select("#", ...) -- args len
        local endParam = nil -- the last param
        if argsLen > 0 then
            endParam = select(argsLen, ...)
        end

        local hadCb = false
        local _cb = nil -- callback

        if endParam and (type(endParam) == "function") then -- the endparam is func the cb
            cclog("rpc cb is %s", endParam)
            hadCb = true
            _cb = endParam
        else
            _cb = function()end -- fixme  give nil
        end

        local _args = {}
        local len = hadCb and argsLen - 1 or argsLen
        for i = 1, len do
            _args[i] = select(i, ...)
        end
        table.insert(_args, 1, user.uid)

        cclog("\n\n")
        cclog("[rpc->]%s", key)
        Util.dump(_args)
        cclog("\n\n")

        self.call(_cb, key, unpack(_args))
    end
    return newFunc
end


return Rpc
