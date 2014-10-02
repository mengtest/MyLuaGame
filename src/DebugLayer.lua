
local DebugLayer = class("DebugLayer", function() return cc.Layer:create() end)

function DebugLayer:ctor() 
	self:init()
end

function DebugLayer:init()
	
end

function DebugLayer:deinit()

end

function DebugLayer:dtor()
	self:deinit()
end

return DebugLayer