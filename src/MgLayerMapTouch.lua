
local MultiTouchLayer = require("MultiTouchLayer")
local MapLayer = require("MapLayer")

local MapTouchLayer = class("MapTouchLayer", MultiTouchLayer)


function MapTouchLayer:ctor() 
	self.super.ctor(self)
	self.touchArray = utils.AutoArray
	self:init()
end


function MapTouchLayer:init()
	-- self.super.init()
end


function MapTouchLayer:onTouchesBegan(touches, event)
	for _, touch in ipairs(touches) do
		self.touchArray:add(touch)
 	end
    return true
end


function MapTouchLayer:distOfTwoPoint(pt1, pt2)
	local dx = math.abs(pt1.x - pt2.x)
	local dy = math.abs(pt1.y - pt2.y)
	return math.sqrt(dx * dx + dy * dy) 
end


function MapTouchLayer:onTouchesMoved(touches, event)
	-- self.touches = touches
	local deltaToMove 
	local deltaToScale
	local count = #self.touchArray

	if 1 == count then -- one touch on
		local delta = touches[1]:getDelta()
		deltaToMove = delta
	else -- two touch on   should scale
		-- to check whether touch changed ()
		-- self.touchArray[1] and self.touchArray[2]

		local shouldScale = false

		for _, touch in ipairs(touches) do
			shouldScale = ((self.touchArray[1] == touch) -- self.touchArray[1] changed
				or (self.touchArray[2] == touch)) -- self.touchArray[2] changed
			if shouldScale then break end
		end	

		if shouldScale then 
			local touch1 = self.touchArray[1]
			local touch2 = self.touchArray[2]

			local delta1 = touch1:getDelta()
			local delta2 = touch2:getDelta()
			deltaToMove = cc.p( (delta1.x + delta2.x)/2, (delta1.y + delta2.y)/2 )

			local previousLocation1 = touch1:getPreviousLocation()
			local previousLocation2 = touch2:getPreviousLocation()
			local location1 = touch1:getLocation()
			local location2 = touch2:getLocation()
			local previousDist = self:distOfTwoPoint(previousLocation1, previousLocation2)
			local dist = self:distOfTwoPoint(location1, location2)

			deltaToScale = dist / previousDist		
		end

	end

	local mapLayer = MapLayer.getInstance()
	if deltaToMove then
		local x, y = mapLayer:getPosition()
		mapLayer:setPosition(cc.p(x + deltaToMove.x, y + deltaToMove.y))
	end

	if deltaToScale then
		local scale = mapLayer:getScale()
		mapLayer:setScale(scale * deltaToScale)	
	end
end


function MapTouchLayer:onTouchesEnded(touches, event)
	if #self.touchArray == 0 then return end
	for _, touch in ipairs(touches) do
		self.touchArray:remove(touch)
	end
	-- check scale
	self:checkScale()
end



function MapTouchLayer:checkScale()
	local winSize = cc.Director:getInstance():getWinSize()

	local mapLayer = MapLayer.getInstance()
	--local size = mapLayer:getContentSize()
	local size = mapLayer:getSize()

	local rate = size.width / size.height
	local winRate = winSize.width / winSize.height

	local scaleLimit
	if rate > winRate then
		scaleLimit = winSize.width / size.width
	else
		scaleLimit = winSize.height / size.height
	end

	local scale = mapLayer:getScale()
	if scale < scaleLimit then
		cclog("scale out of limit ")
		local action = CCScaleTo:create(0.5, scaleLimit)
		mapLayer:runAction(action)
	end
end


function MapTouchLayer:checkLocation()
	
end


function MapTouchLayer:onTouchBegan(touch, event)
    return true
end


function MapTouchLayer:onTouchMoved(touch, event)
	
end


function MapTouchLayer:onTouchEnded(touch, event)

end


return MapTouchLayer
