

require "cocos.cocosbuilder.CCBReaderLoad"


local CcbHelp = {}

-- param.ctrlName ?
function CcbHelp.load(param)
    if param.ctrlName then
        ccb[param.ctrlName] = param.ctrl
    end
    local  proxy = cc.CCBProxy:create()
    local node = CCBReaderLoad(param.name, proxy, param.ctrl)
    return node
end


return CcbHelp
