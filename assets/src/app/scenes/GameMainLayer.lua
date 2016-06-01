local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local GameMainLayer = class("GameMainLayer", function() 
	return display.newScene("GameMainLayer")
end)


GameMainLayer.title = nil 

function GameMainLayer:ctor()
	-- self._myLabel = cc.ui.UILabel.new({
	-- 		UILabelType = 2,
	-- 		text = "heheda啊"
	-- 	})
	-- self._myLabel:align(display.CENTER,display.cx,display.cy - 100):addTo(self,1)
	local sprite = display.newSprite("bg_login.png",display.cx,display.cy)
    sprite:setScale(2)
	self:addChild(sprite)
	
--    self._myChat = display.newSprite("icon-liaotian.png",display.cx , display.height - 100):addTo(self,1)

    G_GlobalFunc.createColorLayer({parent = self, color4B = cc.c4b(255, 0, 0, 125), 
    	autoAdd = true, zOrder = 3 , x = 100, y = display.height - 100,
    	size = cc.size(100,100)})

    local chat = G_GlobalFunc.createButton("icon-liaotian.png", self, display.cx , display.height - 100, true)
    G_GlobalFunc.createButton("back.png", self, display.cx , display.height - 200, true)

    print("globalfunction " .. tostring(G_GlobalFunc.get_distance(1,1,2,2)))
    
    self:testConvertSpace()
    self:addTouch()
    self:testTimer()
    self:testPopupLayer()
    self:testregisterScriptTapHandler()
    self:testJava()
    self:testJava2()
    self:testLuaCallCPP()
    self:innerUpgrade()
    print(cc.FileUtils:getInstance():getWritablePath())
    GameMainLayer.title = G.createLabel(self," this is callbak out put ",333,333,true)
    -- GameMainLayer.title:setString("hehe")
end

function GameMainLayer:addTouch()
	self:setTouchEnabled(true)
    local ret = self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event ) 
        print("mainscene = " .. event.name)
        return true
    end)
    print("mainscene ret = " .. ret)
end 

function GameMainLayer:testConvertSpace()
    -- local parentColorLayer = G_GlobalFunc.createColorLayer({parent = self, color4B = cc.c4b(255, 0, 0, 125), 
    -- 	autoAdd = true, zOrder = 1 , x = 100, y = 100,
    -- 	size = cc.size(10,10)})	

    local chat1 = G_GlobalFunc.createButton("icon-liaotian.png", self, 100 , 100, true)
    local chat2 = G_GlobalFunc.createButton("icon-liaotian.png", chat1, 100 , 100, true)
    local chat3 = G_GlobalFunc.createButton("icon-liaotian.png", chat2, 100 , 100, true)
    local chat4 = G_GlobalFunc.createButton("icon-liaotian.png", chat3, 100 , 100, true)

    G_GlobalFunc.convertToWorldSpace(chat1)
    G_GlobalFunc.convertToWorldSpace(chat2)
    G_GlobalFunc.convertToWorldSpace(chat3)
    G_GlobalFunc.convertToWorldSpace(chat4)

end 

function GameMainLayer:testTimer()
	local sum = 4
	local id = 0
	local globalId = 0
	local handler = function()
		sum = sum - 1
		print(sum)
		G_GlobalFunc.getTime()
		if sum <= 0 and id then 
			scheduler.unscheduleGlobal(id)
		end 
	end 
	-- id = scheduler.scheduleGlobal(handler,1)
	
	local handler2 = function()
		G.getTime()
		if sum <= 0 and globalId then 
			scheduler.unscheduleGlobal(globalId)
		end 
	end 
	-- globalId = scheduler.scheduleUpdateGlobal(handler2)

	local delayHandler = function()
		G.getTime()
	end 
	local tempId = scheduler.performWithDelayGlobal(delayHandler,1)
	-- scheduler.unscheduleGlobal(tempId)
end 

function GameMainLayer:testPopupLayer(color)
	-- 两个没有父子关系的colorLayer可以正常屏蔽触摸
	color = cc.c4b(111,111,111,200)
	if color then 
		local layer = display.newColorLayer( color )
		layer:setPosition(display.width * 3 / 4 , display.height * 4 / 5)
		layer:addTo(self,2)
		layer:setContentSize(cc.size(111,111))
		layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
			print("111111")
			return true
		end)

		color = cc.c4b(45,211,12,200)
		local layer2 = display.newColorLayer( color )
		layer2:setPosition(display.width * 3 / 4 + 50 , display.height * 4 / 5)
		layer2:addTo(self,2)
		layer2:setContentSize(cc.size(111,111))
		layer2:setTouchSwallowEnabled(false)
		layer2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
			print("22222")
			return true
		end)

	else
		local layer = display.newLayer()
		G.createLabel(layer," i am pupup",222,222,true)
		layer:addTo(self,2)
		layer:setTouchEnabled(false)
		layer:setTouchSwallowEnabled(false)
	end 
end 

--------------------MenuItemEx.lua-------------------    menuitem 才有的
-- function MenuItem:registerScriptTapHandler(handler)
-- end
function GameMainLayer:testregisterScriptTapHandler()
	local click = function() 
		local pauseLayer = require("app.scenes.GamePauseLayer").new()
		pauseLayer:addTo(self,2)
	end 
	local tap = G.createButton("jingliandan.png", self, display.cx , display.cy, true,{clickFunc = click})



end 


function GameMainLayer:testJava()
    local callback = function()
        -- call Java method
        local javaClassName = "com/yzj/tools/NativeProxy"
        local javaMethodName = "printLog"
        local javaParams = {
            "How are you ?",
            "I'm great !",
            function(event)
                local str = "Java method callback value is [" .. event .. "]"
                btn:setButtonLabel(cc.ui.UILabel.new({text = str, size = 32}))
            end
        }
        local javaMethodSig = "(Ljava/lang/String;Ljava/lang/String;I)V"

        -- javaClassName = "org/cocos2dx/lua/NativeProxyTest"
        javaParams = {"this is lua for java"}
        javaMethodSig = "(Ljava/lang/String;)V"
        luaj.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end 
    G.createMenuWithLabel({parent = self, strings = "javaPrint", clickFunc = callback, x = 100, y = display.cy})

end 




function GameMainLayer:testJava2()
    local callback = function()
        local javaParams = {
            cc.FileUtils:getInstance():getWritablePath(),
            cc.FileUtils:getInstance():getWritablePath(),
            function(event)
                local str = "Java method callback value is [" .. event .. "]"
                GameMainLayer.title:setString(str)
            end
        }
        G.callNativeMethod{name = "showAlertDialog" , params = javaParams}
    end 
    G.createMenuWithLabel({parent = self, strings = "javaCallback", clickFunc = callback, x = 100, y = display.cy-100})

end 


function GameMainLayer:testLuaCallCPP()
    local callback = function()
        print(cc.Sprite)
        print(pp.CircleBy)
        local radius = 50
        local x = GameMainLayer.title:getPositionX()
        local y = GameMainLayer.title:getPositionY() - radius
        local circle = pp.CircleBy:create(2, cc.p(x,y) , radius)
        GameMainLayer.title:runAction(circle)
    end 
    G.createMenuWithLabel({parent = self, strings = "LuaC", clickFunc = callback, x = 100, y = display.cy-200})

end 



function GameMainLayer:innerUpgrade()
    print(cc.FileUtils:getInstance():getWritablePath() .. "upgrade/res/")
    cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "upgrade/res/")
    local callback = function()
        local javaParams = {
            cc.FileUtils:getInstance():getWritablePath()
        }
        G.callNativeMethod{name = "downloadSth" , params = javaParams}
    end 
    G.createMenuWithLabel({parent = self, strings = "downloadSth", clickFunc = callback, x = 300, y = display.cy-100})

end 


return GameMainLayer