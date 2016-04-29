local TestScene = class("TestScene", function() 
	return display.newScene("TestScene")
end)

function TestScene:create()
    local scene = TestScene.new()
    scene:registerScriptHandler(function(eventType) 
        print(eventType) 
    end)
    return scene 
end

function TestScene:ctor()
	self._myLabel = cc.ui.UILabel.new({
			UILabelType = 2,
			text = "heheda"
		})
	self._myLabel:align(display.CENTER,display.cx,display.cy - 100):addTo(self,1)
	local sprite = display.newSprite("bg_login.png",display.cx,display.cy)
	self:addChild(sprite)
	
	self:testTouch()
	self:getSprite()
	self:addExitSprite()
end

function TestScene:addManyLabel()

end    

function TestScene:testTouch()
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
			print("touch!!")
			self:nodeJump()
		end )
end 
  
function TestScene:nodeJump()
	if self._myLabel:getNumberOfRunningActions() > 0 then return end 
	local up 		= cc.MoveBy:create(0.2, cc.p(0,100))
	local down 		= cc.MoveBy:create(0.2, cc.p(0,-100))
	local callback 	= function() 
		print("callback ! ")
	end 
	local sequence 	= cc.Sequence:create(
			cc.EaseIn:create(up, 0.2),
			cc.EaseOut:create(down, 0.2),
			cca.cb(callback)
		)
	self._myLabel:runAction(sequence)

end 

function TestScene:getSprite()

	local sprite = display.newSprite("icon-jineng.png")
	sprite:align(display.CENTER,display.cx,display.cy):addTo(self)
	sprite:setTouchEnabled(true)
	print("before set " .. tostring(sprite:isTouchSwallowEnabled()))
	sprite:setTouchSwallowEnabled(false)
	print("after set " .. tostring(sprite:isTouchSwallowEnabled()))
	sprite:addNodeEventListener(cc.NODE_TOUCH_EVENT , function(event) 
		print(event.name)
		print("click")
		-- true 表示继续处理 比如moved事件  ended事件等
		return true
	end) 
end 
 
function TestScene:addExitSprite()
	-- local sprite = display.newSprite("arrow.png")
	-- local rect = sprite:getTextureRect()
	-- sprite:align(display.CENTER , display.width  - rect.width / 2  , display.height - rect.height/2)
	-- sprite:addTo(self)
	-- sprite:setTouchEnabled(true)

	local button = cc.ui.UIPushButton.new({normal = "f1.png",pressed="f2.png"})
	button:align(display.BOTTOM_CENTER, display.cx , 0):addTo(self)
	button:onButtonClicked(function()  
			local scene = require("app.scenes.MultiTouchScene").new()
			local transition = display.wrapSceneWithTransition(scene, "fade", 0.5)
			display.replaceScene(scene)
		end)

	local button2 = cc.ui.UIPushButton.new({normal = "b1.png",pressed="b2.png"})
	button2:align(display.BOTTOM_CENTER, display.cx - 100 , 0):addTo(self)
	button2:onButtonClicked(function()  

			local scene = require("app.scenes.ColorScene").new()
			local transition = display.wrapSceneWithTransition(scene, "fade", 1,cc.c3b(123, 123, 0))
			display.replaceScene(scene)
		end)
end 

function TestScene:onEnter()
	print("onEnter()")
end

function TestScene:onExit()
	print("onExit()")
end

return TestScene