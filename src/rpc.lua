
local Http = require("http")

local xmlrpc = require("xmlrpc")


local Rpc = {}


function Rpc._encode(method, ...)
    return xmlrpc.clEncode(method, ...)
end

function Rpc._decode(data)
    return xmlrpc.clDecode(data)
end

function Rpc.call(cb, method, ...)
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

    local Http = Util.rerequire("http")
    Http.send(data, _cb)
end

return Rpc
