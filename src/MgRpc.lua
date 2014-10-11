
local MgUser = require("MgUser")

local MgHttp = require("MgHttp")

local MgXmlRpc = require("MgXmlRpc")


local MgRpc = {}


function MgRpc._encode(method, ...)
    return MgXmlRpc.clEncode(method, ...)
end

function MgRpc._decode(data)
    return MgXmlRpc.clDecode(data)
end

function MgRpc.callAsync(cb, method, ...)
    local data = MgRpc._encode(method, ...)
    local function _cb(succ, response)
        local decodeSucc, result
        if succ then
            decodeSucc, result = MgRpc._decode(response)
            if not decodeSucc then
                 cclog("decode rpc error")
                 utils.dump(response)
            end
        else
            cclog("http error")
        end
        if cb then cb(succ and decodeSucc, result) end -- always cb
    end

    -- local MgHttp = utils.rerequire("http")
    MgHttp.send(data, _cb)
end

function MgRpc.call(cb, method, ...)
     return MgRpc.callAsync(cb, method, ...)
end


--[[
function MgRpc.call(cb, method, ...)
    -- return MgRpc.callAsync(cb, method, ...)
    local co = coroutine.create(function()
        local _cb = function(...)
            cb(...)
            -- coroutine.resume(co)
        end
        MgRpc.callAsync(_cb, method, 1)
        cclog("==============1")
        coroutine.yield()
        cclog("==============2")
    end)
    coroutine.resume(co)

end
]]--


local MgRpcM = {}
setmetatable(MgRpc, MgRpcM)
MgRpcM.__index = function(self, key)
    -- cclog("rpcm index key %s", key)
    local function newFunc(...)
        
        local argsLen = select("#", ...) -- args len
        local endParam = nil -- the last param
        if argsLen > 0 then
            endParam = select(argsLen, ...)
        end

        local hadCb = false
        local _cb = nil -- callback

        if endParam and (type(endParam) == "function") then -- the endparam is func the cb
            -- cclog("rpc cb is %s", endParam)
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
        table.insert(_args, 1, MgUser.uid)

        --[[
        cclog("\n\n")
        cclog("[rpc->]%s", key)
        utils.dump(_args)
        cclog("\n\n")
        ]]

        self.call(_cb, key, unpack(_args))
    end
    return newFunc
end


return MgRpc
