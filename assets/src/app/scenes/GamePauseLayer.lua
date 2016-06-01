local GamePauseLayer = class("GamePauseLayer", function() 
	return display.newColorLayer(cc.c4b(111,111,111,200))
end)

function GamePauseLayer:ctor()
	local itemLabel1 = cc.MenuItemLabel:create(G.createLabel(self, "Close", 0, 0, false))
	itemLabel1:registerScriptTapHandler(function()
		print("hehe wo qu ")
		self:removeFromParent()
	end)
	local menu = cc.Menu:create(itemLabel1)
	menu:setPosition(cc.p(display.cx,display.cy))
	menu:addTo(self,2)

	local index = 11
	if index == 1 then 
		cc.FileUtils:getInstance():addSearchPath("res/GameRPG/")
		ccs.SceneReader:getInstance()
			:createNodeWithSceneFile("publish/RPGGame.json")
			:addTo(self)
	else 
		-- ccs.SceneReader:getInstance()
		-- 	:createNodeWithSceneFile("ui_layout/PauseLayer_1.json")
		-- 	:addTo(self)
		G.loadCCSJsonFile(self, "ui_layout/PauseLayer_1.json")
	end

	local image = cc.uiloader:seekNodeByName(self, "Image_1")
	image:setTouchEnabled(true)
	image:setScale(0.4)
	image:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		print(event.x)
		return true
	end)


end 

return GamePauseLayer
