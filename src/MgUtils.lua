
local MgUtils = {}



function MgUtils.dump(object)
    local traceback = debug.traceback("", 2)
    cclog("dump from: " .. traceback)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            cclog(object)
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
    end
    return _copy(object)
end

--[[--

用指定字符或字符串分割输入字符串，返回包含分割结果的数组

~~~ lua

local input = "Hello,World"
local res = string.split(input, ",")
-- res = {"Hello", "World"}

local input = "Hello-+-World-+-Quick"
local res = string.split(input, "-+-")
-- res = {"Hello", "World", "Quick"}

~~~

@param string input 输入字符串
@param string delimiter 分割标记字符或字符串

@return array 包含分割结果的数组

]]
function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

--[[--

输出值的内容

### 用法示例

~~~ lua

local t = {comp = "chukong", engine = "quick"}

dump(t)

~~~

@param mixed value 要输出的值

@param [string desciption] 输出内容前的文字描述

@parma [integer nesting] 输出时的嵌套层级，默认为 3

]]
function MgUtils.dump(value, desciption, nesting)
    if type(nesting) ~= "number" then nesting = 3 end

    local lookupTable = {}
    local result = {}

    local function _v(v)
        if type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        return tostring(v)
    end

    local traceback = string.split(debug.traceback("", 2), "\n")
    --cclog("dump from: " .. string.trim(traceback[3]))
    cclog("dump from: " .. traceback[3])

    local function _dump(value, desciption, indent, nest, keylen)
        desciption = desciption or "<var>"
        spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(_v(desciption)))
        end
        if type(value) ~= "table" then
            result[#result +1 ] = string.format("%s%s%s = %s", indent, _v(desciption), spc, _v(value))
        elseif lookupTable[value] then
            result[#result +1 ] = string.format("%s%s%s = *REF*", indent, desciption, spc)
        else
            lookupTable[value] = true
            if nest > nesting then
                result[#result +1 ] = string.format("%s%s = *MAX NESTING*", indent, desciption)
            else
                result[#result +1 ] = string.format("%s%s = {", indent, _v(desciption))
                local indent2 = indent.."    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = _v(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then keylen = vkl end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    _dump(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result +1] = string.format("%s}", indent)
            end
        end
    end
    _dump(value, desciption, "- ", 1)

    for i, line in ipairs(result) do
        cclog(line)
    end
end

function MgUtils.rerequire(name)
    cclog("rerequire file %s", name)
    cclog("at date %s", os.date())
    package.loaded[name] = nil
    return require(name)
end


function MgUtils.placeAlign(nodeWithSize, type, parent, xoff, yoff)
    local size = nodeWithSize:getContentSize()
    -- assert(size.width ~= 0)
    -- assert(size.height ~= 0)

    local x = 0
    local y = 0
    local xoff = xoff or 0
    local yoff = yoff or 0

    if parent then
        local psize = parent:getContentSize()
        assert(psize.width ~= 0)
        assert(psize.height ~= 0)
        if type == "rt" then
            x = psize.width - size.width / 2
            y = psize.height - size.height / 2
        elseif type == "lb" then
            x = 0 + size.width / 2
            y = 0 + size.height / 2
        elseif type == "lt" then
            x = 0 + size.width / 2
            y = psize.height - size.height / 2
        elseif type == "lm" then
            x = 0 + size.width / 2
            y = psize.height / 2
        elseif type == "rm" then
            x = psize.width - size.width / 2
            y = psize.height / 2
        elseif type == "mm" then
            x = psize.width / 2
            y = psize.height / 2
        end
    else
        if type == "rt" then
            x = display.right - size.width / 2
            y = display.top - size.height / 2
        elseif type == "lb" then
            x = display.left + size.width / 2
            y = display.bottom + size.height / 2
        elseif type == "lt" then
            x = display.left + size.width / 2
            y = display.top - size.height / 2
        elseif type == "lm" then
            x = display.left + size.width / 2
            y = display.cy
        elseif type == "rm" then
            x = display.right - size.width / 2
            y = display.cy
        elseif type == "mm" then
            x = display.cx
            y = display.cy
        end
    end

    nodeWithSize:setPosition(cc.p(x + xoff, y + yoff))

end


function MgUtils.createButton(param)
    local tex = param.tex or "btn_blue.png"
    local cb = param.cb
    local sprite1 = cc.Sprite:create(tex)
    local sprite2 = cc.Sprite:create(tex)

    sprite2:setScaleY(1.1)

    local btn = cc.MenuItemSprite:create(sprite1, sprite2)
    btn:registerScriptTapHandler(cb)

    -- title
    local title = param.title
    local titleLabel = cc.LabelTTF:create(title, "", 24)
    btn:addChild(titleLabel)
    MgUtils.placeAlign(titleLabel, "mm", btn)

    return btn
end


local function createToggleButton(param)
    local tex1 = param.tex1 or "btn_blue.png"
    local tex2 = param.tex2 or "btn_blue.png"
    local switchSprite1 = cc.Sprite:create(tex1)
    local switchSprite2 = cc.Sprite:create(tex2)
    local cb = param.cb
    local text1 = param.text1
    local text2 = param.text2

    local switchitem1  = cc.MenuItemSprite:create(switchSprite1, switchSprite1)
    local switchitem2 = cc.MenuItemSprite:create(switchSprite2, switchSprite2)

    if text1 and text2 then
        local textLabel1 = cc.LabelTTF:create(text1, "", 24)
        local textLabel2 = cc.LabelTTF:create(text2, "", 24)
        switchitem1:addChild(textLabel1)
        switchitem2:addChild(textLabel2)
        MgUtils.placeAlign(textLabel1, "mm", switchitem1)
        MgUtils.placeAlign(textLabel2, "mm", switchitem2)
    end

    local switchitem = cc.MenuItemToggle:create(switchitem1)
    switchitem:addSubItem(switchitem2)
    switchitem:registerScriptTapHandler(function() if cb then cb() end end)
    --turn on
    switchitem:setSelectedIndex(0)
    return switchitem
end


function MgUtils.createLabel(text, fontSize, font) 
    return cc.LabelTTF:create(text, font or "", fontSize or 24)
end


local AutoArray = class("AutoArray", function() return {} end)

function AutoArray:add(anObj)
    table.insert(self, anObj)
end

function AutoArray:remove(theObj)
    local keep = {}
    for _, objref in ipairs(self) do
        if objref ~= theObj then
            table.insert(keep, objref)
        end
    end
    local count = #self
    for i = count, 1, -1 do
        table.remove(self, i)
    end
    for _, objref in ipairs(keep) do
        table.insert(self, objref)
    end
end

function AutoArray:indexOfObj(theObj)
    for index, objref in ipairs(self) do
        if objref == theObj then
            return index
        end
    end
end

MgUtils.AutoArray = AutoArray


local gprint = print
function print(...)
    return gprint("==== ", ...)
end


--Create an class.
function class(classname, super)
    local superType = type(super)
    local cls

    if superType ~= "function" and superType ~= "table" then
        superType = nil
        super = nil
    end

    if superType == "function" or (super and super.__ctype == 1) then
        -- inherited from native C++ Object
        cls = {}

        if superType == "table" then
            -- copy fields from super
            for k,v in pairs(super) do cls[k] = v end
            cls.__create = super.__create
            cls.super    = super
        else
            cls.__create = super
        end

        if not super or superType == "function" then
            cls.ctor = function() end
        end
        -- cls.ctor    = function() end

        cls.__cname = classname
        cls.__ctype = 1

        function cls.new(...)
            local instance = cls.__create(...)
            -- copy fields from class to native object
            for k,v in pairs(cls) do instance[k] = v end
            instance.class = cls
            instance:ctor(...)
            return instance
        end

    else
        -- inherited from Lua Object
        if super then
            cls = clone(super)
            cls.super = super
        else
            cls = {ctor = function() end}
        end

        cls.__cname = classname
        cls.__ctype = 2 -- lua
        cls.__index = cls

        function cls.new(...)
            local instance = setmetatable({}, cls)
            instance.class = cls
            instance:ctor(...)
            return instance
        end
    end

    return cls
end


local winSize = cc.Director:getInstance():getWinSize()

local display = {}

display.size               = {width = winSize.width, height = winSize.height}
display.width              = display.size.width
display.height             = display.size.height
display.cx                 = display.width / 2
display.cy                 = display.height / 2
display.c_left             = -display.width / 2
display.c_right            = display.width / 2
display.c_top              = display.height / 2
display.c_bottom           = -display.height / 2
display.left               = 0
display.right              = display.width
display.top                = display.height
display.bottom             = 0


MgUtils.display = display


return MgUtils
