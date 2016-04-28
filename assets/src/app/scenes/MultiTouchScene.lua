local MultiTouchScene = class("MultiTouchScene", function() 
	return display.newScene("MultiTouchScene")
end )

function MultiTouchScene:ctor()

	local sprite = display.newSprite("icon.png")
	sprite:setPosition(cc.p(444,444))
	sprite:addTo(self)
	sprite:runAction(cc.RotateBy:create(0.51, 360))
	sprite:setTouchEnabled(true)
	sprite:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
	sprite:addNodeEventListener(cc.NODE_TOUCH_EVENT , function(event) 
			--如果只有一个点，则移动
			print(event.name )
			if event.points["0"] and not event.points["1"] then 
				local first = event.points["0"]
				local dx = first.x - first.prevX
				local dy = first.y - first.prevY
				sprite:setPosition(cc.p(sprite:getPositionX() + dx,sprite:getPositionY() + dy))
			elseif event.points["0"] and event.points["1"] then 
			-- 大于等于2个点，只取前2点的相对位置变化
				local first = event.points["0"]
				local second = event.points["1"]
				local length = G_GlobalFunc.get_distance(first.x,first.y,second.x,second.y)
				local length2 = G_GlobalFunc.get_distance(first.prevX,first.prevY,second.prevX,second.prevY)
				local ration = (length-length2)/(sprite:getTextureRect().width + sprite:getTextureRect().height)
				sprite:setScale(sprite:getScale()*( 1 + ration))
			end 
			if event.name == "began" then 
				return true
			end 
		end)

	sprite:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function(event) 
			print("capture " .. event.name)
		end )	
	print("MultiTouchScene:ctor()")

	local layer = cc.Layer:create()
	layer:enableAccelerometer(true)
	layer:registerScriptAccelerateHandler(function(x,y,z,a,b,c)
	    sprite:setPosition(cc.p(sprite:getPositionX() - y*10, sprite:getPositionY() + x*10))
	end)
	self:addChild(layer)

	self:setKeypadEnabled(true)
    self:addNodeEventListener(cc.KEYPAD_EVENT,function(event)
    	print(event)
    	sprite:setPosition(cc.p(111,111))
	end)

	app:addEventListener("APP_ENTER_BACKGROUND_EVENT", function(event)
	    print("APP_ENTER_BACKGROUND_EVENT")
	end)

	app:addEventListener("APP_ENTER_FOREGROUND_EVENT", function(event)
	    print("APP_ENTER_FOREGROUND_EVENT")
	end)

end 

function MultiTouchScene:onEnter()
	print("MultiTouchScene:onEnter()")
end 

function MultiTouchScene:onExit()
	print("MultiTouchScene:onExit()")


end 

return MultiTouchScene

