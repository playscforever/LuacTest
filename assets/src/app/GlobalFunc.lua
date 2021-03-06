GlobalFunc = {}

function GlobalFunc.print_table( ... )
    for k,v in pairs(...) do
        print(k,v)
    end
end

function GlobalFunc.get_distance(x1,y1,x2,y2)
    return math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
end

function GlobalFunc.createButton(filename, parent, x, y, autoAdd, params)
    local button = display.newSprite(filename, x, y)
    -- print(button:getAnchorPoint().x)
    -- print(button:getAnchorPoint().y)
    if autoAdd then 
        button:addTo(parent,1)
    end 
    button:setTouchEnabled(true)
    button:setTouchSwallowEnabled(true)
    button:setName(filename)

-- 1.°´ÏÂ¶¯×÷½áÊø£¬ÊÕÆð   
-- 2.°´ÏÂÁ¢¿ÌÊÕÆð     
-- 3.Á¬Ðøµã»÷ÆÁ±Î    
    local quickTap = false 
    local start = false 
    local function scaleBack()
        local scaleX = cc.ScaleTo:create(0.2, 1, 0.8, 1) 
        local seq = transition.sequence({
            cc.DelayTime:create(0.05), 
            cc.ScaleTo:create(0.2, 1, 1, 1),
            cc.CallFunc:create(function() 
                start = false 
                quickTap = false 
            end )
        })
        local spawn = cc.Spawn:create({scaleX, seq})
        button:runAction(spawn)
    end 
    button:setTouchCaptureEnabled(true)
    button:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function( event ) 
        print("cc.NODE_TOUCH_CAPTURE_EVENT  button " .. event.name)
        return true
    end )
    button:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event )
        print(button:getName() .. event.name)
        if event.name == "moved" then 
            button:setPosition(
                cc.p(button:getPositionX() + event.x - event.prevX, 
                    button:getPositionY() + event.y - event.prevY))
        elseif event.name == "ended" and params and params.clickFunc then
            if cc.rectContainsPoint( button:getBoundingBox(), cc.p(event.x,event.y)) then 
                params.clickFunc()
            end 
        end 
        if button:getNumberOfRunningActions() == 0 then 
            if event.name == "began" then 
                G_GlobalFunc.convertToWorldSpace(button)
                start = true 
                local scaleY = cc.ScaleTo:create(0.2, 1, 0.8, 1) 
                local seq = transition.sequence({
                    cc.DelayTime:create(0.05), 
                    cc.ScaleTo:create(0.2, 1.2, 0.8, 1),
                    cc.CallFunc:create(function() 
                        if quickTap then 
                            quickTap = false 
                            scaleBack()
                        end 
                    end )
                })
                local spawn = cc.Spawn:create({scaleY, seq})
                button:runAction(spawn)
            elseif event.name == "ended" then 
                scaleBack()
            end 
        elseif event.name == "ended" and start then 
            quickTap = true 
        -- else
        --     return false 
        end 
        return true 
    end)
	return button
end 


function GlobalFunc.createLabel(parent, _text,x,y,autoAdd)
    local label = cc.ui.UILabel.new({
        UILabelType = 2,
        text = _text,
        size = 40,
    }):align(display.CENTER, x, y)
    if autoAdd then 
        label:addTo(parent)
    end 
    return label
end 

-- function display.newColorLayer(color)
--     local node
--     if cc.bPlugin_ then
--         node = display.newNode()
--         local layer = cc.LayerColor:create(color)
--         node:addChild(layer)
--         node:setTouchEnabled(true)
--         node:setTouchSwallowEnabled(true)
-- ������bug  ��һ��Դ��  quick-3.3/quick/framework/display.lua
--         node.setContentSize = layer.setContentSize
--         node.getContentSize = layer.getContentSize
--     else
--         node = cc.LayerColor:create(color)
--     end
--     return node
-- end

function GlobalFunc.createColorLayer(params)  
    -- using table to delivery params 
    local layer = display.newColorLayer(params.color4B)  
    if params.autoAdd then 
        local zOrder = params.zOrder or 0
        layer:addTo(params.parent, zOrder)
    end 
    layer:setTouchEnabled(true)
    layer:setTouchSwallowEnabled(true)
    if params.size then 
        layer:setContentSize(params.size)
    else 
        layer:setContentSize(cc.size(100,100))
    end 
    if params.x and params.y then 
        layer:setPosition(cc.p(params.x, params.y))
    else 
        layer:setPosition(cc.p(display.cx, display.cy))
    end 
    

    layer:setTouchCaptureEnabled(true)
    layer:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function( event ) 
        print("cc.NODE_TOUCH_CAPTURE_EVENT  layer " .. event.name)
        return true
    end )


    local ret = layer:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function(event ) 
        print(event.name)
        if event.name == "moved" then 
            layer:setPosition(
                cc.p(layer:getPositionX() + event.x - event.prevX, 
                    layer:getPositionY() + event.y - event.prevY))
        end 
        return true
    end)
    -- layer:setTouchCaptureEnabled(true)
    return layer 
end 


-- function display.newLayer()
--     local layer
--     if cc.bPlugin_ then
--         layer = display.newNode()
--         layer:setContentSize(display.width, display.height)
--         layer:setTouchEnabled(true)
--     else
--         layer = cc.Layer:create()
--     end
--     return layer
-- end
function GlobalFunc.createLayer(params)  
    -- using table to delivery params 
    -- local layer = display.newColorLayer(params.color4B)  newColorLayer have a bug 
    -- quick �Ż���layer����addNodeEventListener
    -- local layer = cc.Layer:create()
    local layer = display.newLayer()
    if params.autoAdd then 
        local zOrder = params.zOrder or 0
        layer:addTo(params.parent, zOrder)
    end 
    layer:setTouchEnabled(true)
    layer:setTouchSwallowEnabled(false)
    local innerLabel = GlobalFunc.createLabel(layer, "layer1234567890132456789" ,display.cx, display.cy, true)


    layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        print(event.name)
        return true
    end)

    layer:setColor(cc.c4b(255, 0, 0, 125))
    return layer 
end 


function GlobalFunc.pp(x,y) 
    if x and type(x) == "table" then 
        if x.width then 
            print(" x = " .. tostring(x.width))
            print(" y = " .. tostring(x.height)) 
        else 
            print(" x = " .. tostring(x.x))
            print(" y = " .. tostring(x.y))         
        end 
    else 
        print(" x = " .. tostring(x))
        print(" y = " .. tostring(y))
    end 
end 


function GlobalFunc.convertToWorldSpaceAR(node)
    return node:getParent():convertToWorldSpaceAR(cc.p(node:getPosition()))
end 

function GlobalFunc.convertToWorldSpace(node)
    local ret = node:getParent():convertToWorldSpace(cc.p(node:getPosition()))
    GlobalFunc.pp(ret)
    return ret
end 

function GlobalFunc.getTime()
--  http://blog.csdn.net/ningyuanhuo/article/details/43069969
    local date=os.date("%Y-%m-%d %H:%M:%S")
    print(date)
    return date
end 

-- CCSGUIReaderEx::shareReaderEx()->widgetFromJsonFile(jsonFile,
function GlobalFunc.loadCCSJsonFile(scene, jsonFile)
    local pathInfo = io.pathinfo(jsonFile)
    dump(pathInfo)
    local node, width, height = cc.uiloader:load(jsonFile)
    width = width or display.width
    height = height or display.height
    if node then
        -- ��֤json��ȡ֮������Ļ�м���ʾ  ��json�����Ƚ�С��ʱ�����ã�
        node:setPosition((display.width - width)/2, (display.height - height)/2)
        node:setTag(101)
        scene:addChild(node)
    end
end


function GlobalFunc.createMenuWithLabel(params)
    local parent = params.parent
    local strings = params.strings
    local clickFunc = params.clickFunc
    local x = params.x
    local y = params.y 

    local itemLabel1 = cc.MenuItemLabel:create(G.createLabel( parent , strings , 0, 0, false))
    itemLabel1:registerScriptTapHandler(clickFunc)
    local menu = cc.Menu:create(itemLabel1)
    menu:setPosition(cc.p(x,y))
    menu:addTo(parent,2)
    return menu
end 

local function checkArguments(args, sig ,returnType)
    if type(args) ~= "table" then args = {} end
    if sig then return args, sig end

    sig = {"("}
    for i, v in ipairs(args) do
        local t = type(v)
        if t == "number" then
            sig[#sig + 1] = "F"
        elseif t == "boolean" then
            sig[#sig + 1] = "Z"
        elseif t == "function" then
            sig[#sig + 1] = "I"
        else
            sig[#sig + 1] = "Ljava/lang/String;"
        end
    end

    local returnSig = 'V'
    if returnType  ~= nil then
        if returnType == "boolean" then
            returnSig = 'Z'
        elseif returnType == "int" then
            returnSig = 'I'
        elseif returnType == "string" then
            returnSig = 'Ljava/lang/String;'
        end
    end
    sig[#sig + 1] = ")" .. returnSig
    return args, table.concat(sig)
end


-- �ṩ�������Ͳ����Ϳ�����   MethodSig���Զ�����VOID��Ӧ�Ĳ���
function GlobalFunc.callNativeMethod(params)
    local javaClassName = "com/yzj/tools/NativeProxy"
    local javaMethodName = params.name
    local javaParams = params.params
    local retType = params.ret
    if device.platform == "android" or true then 
        local args, sig = checkArguments(javaParams, sig,retType)
        print(sig)
        -- һ��Ҫע����������������ֵ��������
        local ok,ret = luaj.callStaticMethod(javaClassName, javaMethodName, javaParams,sig)
        return ret
    else 
        print("not android")
    end 
end 


function GlobalFunc.getVersion()
    local versionFile = cc.FileUtils:getInstance():getWritablePath() .. "version"
    local file = io.open(versionFile,"r")
    if not file then 
        -- ��һ�ν�����Ϸ ����file
        file = io.open(versionFile, "w")
        io.output(file)
        G_VERSION = G.callNativeMethod{name = "getVersion" , params = nil , ret = "string"}
        io.write(G_VERSION)
        io.close(file)
    else 
        file = io.open(versionFile,"r")
        for line in file:lines() do
            G_VERSION = line
            break
        end        
    end 
    return G_VERSION
end 

function GlobalFunc.setVersion()
    local versionFile = cc.FileUtils:getInstance():getWritablePath() .. "version"
    file = io.open(versionFile, "w")
    io.output(file)
    io.write(G_VERSION)
    io.close(file)
end 

return GlobalFunc





