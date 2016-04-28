local ColorLayer = class("ColorLayer", function() 
	return display.newColorLayer( cc.c3b(255, 123, 0) )
end)

function ColorLayer:ctor()
	local label = G_GlobalFunc.createLabel(self,"test123",222,333)
	label:addTo(self)
	print("fk123")
end 


return ColorLayer
 