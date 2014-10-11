require "cocos2d/Cocos2d"
require "cocos2d/Cocos2dConstants"
require "cocos2d/extern"
require "utils"
--[[
local autoArray = utils.AutoArray.new()
autoArray:add(1)
autoArray:add("20")
autoArray:remove(1)
autoArray:remove("20")

autoArray:add("21")
autoArray:add("22")
autoArray:add("23")
autoArray:remove("22")

autoArray:add("25")

utils.dump(autoArray)
cclog(autoArray:indexOfObj("23"))
cclog(autoArray:indexOfObj("25"))
]]

cclog(2)

