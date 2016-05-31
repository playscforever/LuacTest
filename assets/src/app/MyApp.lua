
require("config")
require("cocos.init")
require("framework.init")
require("app.GlobalVar")
local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    
    cc.FileUtils:getInstance():addSearchPath("res/beforeinner/")
    self:enterScene("CheckLayer")
    cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "upgrade/res/")
    cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "upgrade/src/")
    cc.FileUtils:getInstance():addSearchPath("res/")
--    local nextScene = require("app.scenes.TestScene").create()
--    display.replaceScene(nextScene)
end

 
return MyApp
