

local Http = {}

require("NetworkConstants")

function Http._newRequest()
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    -- xhr:open("POST", "http://10.211.55.7:80")
    -- xhr:open("POST", "http://127.0.0.1:8000")
    -- xhr:open("POST", "http://192.168.1.108:8000")
    xhr:open("POST", "http://115.231.94.187:80")
    return xhr
end

function Http.send(data, cb)
    local xhr = Http._newRequest()
    local function _cb()
        cb(xhr.status == 200, xhr.response)
    end
    xhr:registerScriptHandler(_cb)
    xhr:send(data)
end

return Http
