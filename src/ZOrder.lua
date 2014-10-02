ZOrder = {}


local z = -1


local function maxZ()
    return 0xff
end


local function nextZ()
    z = z + 1
    if z >= maxZ() then
        assert(nil, "max")
    end
    return z
end


ZOrder.map = nextZ() 

ZOrder.uiLayer = maxZ() 


return ZOrder