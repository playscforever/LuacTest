local InnerLayer = class("InnerLayer", function() 
    return display.newScene("InnerLayer")
end)


function InnerLayer:ctor()
    local sprite = display.newSprite("inner.png",display.cx,display.cy)
    sprite:setScale(2)
    self:addChild(sprite)
    self:method1()

end 

function InnerLayer:method1()
    G.createMenuWithLabel({parent = self, strings = "返回",
        clickFunc = function() 
            print("why???")
            display.replaceScene(require("app.scenes.CheckLayer").new())
        end, x = display.cx, y = display.cy+100})
end 

return InnerLayer