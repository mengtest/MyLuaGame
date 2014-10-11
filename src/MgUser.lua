

local dump = MgUtils.dump

local MgUser = {}

local MgUserv = {
    uid = "", -- use MgUser account
    name = "",
    level = 1,
    gold = 0,
    gem = 0,
    hp = 0,
    status = 0,
}

-- default 
function MgUserv.setKeyValue(key, value)
    cclog("MgUser set prop %s to %s", key, value) -- log
    MgUserv[key] = value
end


function MgUserv.setUid(uid)
    cclog("MgUser set uid %s", uid)
    MgUserv.uid = uid
end


setmetatable(MgUser, MgUserv)

MgUserv.__newindex = function(tb, key, value)
    error("MgUserv __newindex read only key")
end

-- MgUserv.__index = MgUserv
MgUserv.__index = function(tb, key) -- i want log
    -- cclog("MgUserv __index %s", key)
    return MgUserv[key]
end


-- MgUser.uid = 1 -- will cause error
-- MgUserv.setUid("test") -- use set to update
-- MgUserv.setKeyValue("uid", "00")
-- print(MgUserv.uid) -- use key to read


return MgUser
