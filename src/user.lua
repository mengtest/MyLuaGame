

local dump = Util.dump

local user = {}

local userv = {
    uid = "", -- use user account
    name = "",
    level = 1,
    gold = 0,
    gem = 0,
    hp = 0,
    status = 0,
}

-- default 
function userv.setKeyValue(key, value)
    cclog("user set prop %s to %s", key, value) -- log
    userv[key] = value
end


function userv.setUid(uid)
    cclog("user set uid %s", uid)
    userv.uid = uid
end


setmetatable(user, userv)

userv.__newindex = function(tb, key, value)
    error("userv __newindex read only key")
end

-- userv.__index = userv
userv.__index = function(tb, key) -- i want log
    cclog("userv __index %s", key)
    return userv[key]
end


-- user.uid = 1 -- will cause error
-- userv.setUid("test") -- use set to update
-- userv.setKeyValue("uid", "00")
-- print(userv.uid) -- use key to read


return user
