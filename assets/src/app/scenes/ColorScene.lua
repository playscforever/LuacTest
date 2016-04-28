local ColorScene = class("ColorScene", function() 
	return display.newScene("ColorScene")
end)

function ColorScene:ctor()
	self.layer = require("app.scenes.ColorLayer").new()
	self.layer:setContentSize(111,111)
	self:addChild(self.layer)
end 


return ColorScene

