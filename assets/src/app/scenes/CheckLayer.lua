local CheckLayer = class("CheckLayer", function() 
    return display.newScene("CheckLayer")
end)


function CheckLayer:ctor()
    local sprite = display.newSprite("bg_login.png",display.cx,display.cy)
    sprite:setScale(2)
    self:addChild(sprite)

    self._label = G.createLabel(self,"this is callbak out put ",display.cx,display.height - 200,true)




    if device.platform == "android" then 
        self:_getConfig()    
    end 
    if device.platform == "windows" then 
        self:_checkVersion()
    end

end 

function CheckLayer:_showEntrance()
    G.createMenuWithLabel({parent = self, strings = "进入游戏",
        clickFunc = function() 
            -- cc.FileUtils:getInstance():addSearchPath("res/")
            display.replaceScene(require("app.scenes.InnerLayer").new())
        end, x = display.cx, y = display.cy-100})
end 

-- 获取config.cfg 判断是否需要内更新
function CheckLayer:_getConfig()
    local javaParams = {
        cc.FileUtils:getInstance():getWritablePath() ,
        "http://192.168.1.187/yzj/",
        "config.cfg",
        function(event)
            self._label:setString(event)
            self:_parseCfg()
            self:_checkVersion()
        end        
    }
    dump(javaParams)
    G.callNativeMethod{name = "getConfig" , params = javaParams}
end

function CheckLayer:_checkVersion()
    print(G.getVersion())
    self._label:setString(G.getVersion() .. "(" .. G_CFG["version"] .. ")")
    if tostring(G_VERSION) < G_CFG["version"] then 
        self:addChild(self:initDialog(),11)
    else 
        self:_showEntrance()
    end 
end 

function CheckLayer:_doInnerUpgrade()

    local javaParams = {
        cc.FileUtils:getInstance():getWritablePath() ,
        G_CFG["url"],
        G_CFG["name"],
        function(event) 
            self._label:setString(event)
            --更新版本号
            G_VERSION = G_CFG["version"]
            G.setVersion()
            self:_showEntrance()
            self:removeChild(self._initDialog, true)
        end 
    }
    dump(javaParams)
    G.callNativeMethod{name = "doUpgrade" , params = javaParams}

end 


function CheckLayer:initDialog()
    local callback1 = function() 
        self:_doInnerUpgrade()
    end 
    local callback2 = function()
        self:_showEntrance()
        self:removeChild(self._initDialog, true)
    end     
    self._initDialog = require("app.scenes.CocosDialog").new(
        {title = "检测到新版本" .. G_CFG["version"] .. "是否立刻更新" , buttons = {"更新","取消"} , callbacks = {callback1,callback2} }
        )
    print(self._initDialog)
    return self._initDialog
end

function CheckLayer:_parseCfg()
    local key,value = "",""
    file = io.open(cc.FileUtils:getInstance():getWritablePath() .. "config.cfg","r")
    for line in file:lines() do
        key = string.sub(line,1,string.find(line,' = ') - 1)
        value = string.sub(line,string.find(line,' = ') + 3,#line)
        value = string.gsub(value, "\n", "")
        value = string.gsub(value, "\r", "")
        value = string.gsub(value, "\t", "")
        value = string.gsub(value, "\r\n", "")
        value = string.gsub(value, "\n\r", "")
        G_CFG[key] = value
    end
    file:close()
end 


return CheckLayer

