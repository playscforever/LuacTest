local CheckLayer = class("CheckLayer", function() 
    return display.newScene("CheckLayer")
end)


function CheckLayer:ctor()
    local sprite = display.newSprite("bg_login.png",display.cx,display.cy)
    sprite:setScale(2)
    self:addChild(sprite)

    G.createMenuWithLabel({parent = self, strings = "开始更新",
        clickFunc = function() 
            self:_checkInnerUpgrade()
            -- cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "upgrade/res/")
            -- cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "upgrade/src/")
        end, x = display.cx, y = display.cy+100})

    G.createMenuWithLabel({parent = self, strings = "进入游戏",
        clickFunc = function() 
            -- cc.FileUtils:getInstance():addSearchPath("res/")
            display.replaceScene(require("app.scenes.InnerLayer").new())
        end, x = display.cx, y = display.cy-100})

    G.createMenuWithLabel({parent = self, strings = "getConfig",
        clickFunc = function() 
            G.callNativeMethod{name = "getConfig" , params = nil}
        end, x = display.cx, y = display.cy-200})
end 


function CheckLayer:_checkInnerUpgrade()

    local javaParams = {
        cc.FileUtils:getInstance():getWritablePath() ,
        "http://192.168.180.33/yzj/",
        "upgrade.zip"
    }
    dump(javaParams)
    G.callNativeMethod{name = "doUpgrade" , params = javaParams}

end 

return CheckLayer