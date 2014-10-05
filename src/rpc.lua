
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
                 print("decode rpc error")
                 Util.dump(response)
            end
        else
            print("http error")
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
        print("==============1")
        coroutine.yield()
        print("==============2")
    end)
    coroutine.resume(co)

end
]]--

return Rpc
