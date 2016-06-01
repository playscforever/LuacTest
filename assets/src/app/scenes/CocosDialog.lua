
local CocosDialog = class("CocosDialog", function()
    return display.newColorLayer(cc.c4b(0,0,0,125))
end)

-- tanchuang-board.png
-- btn-middle-blue
function CocosDialog:ctor(args, addExit)
    -- addExit = true
    print("fuck")
    local sum = #args.buttons
    -- print("sum = " .. tostring(sum))
    self._back = display.newSprite("tanchuang-board.png",display.cx,display.cy)
    -- self._back:addTo(self)
    self:setContentSize(cc.size(1000,1000))

    local label_tips = cc.ui.UILabel.new({
            UILabelType = 2, text = args.title , size = 22})
       -- local test1 = cc.Label:createWithTTF("debug", "res/fonts/Marker Felt.ttf", 24)
    -- label_tips = cc.Label:createWithSystemFont("debug","res/fonts/Marker Felt.ttf",22)
    local labels = {}
    for i=1,sum do
        local label = cc.ui.UILabel.new({
            UILabelType = 2, text = args.buttons[i], size = 22})
        table.insert(labels,label)
    end

    local items = {}
    for i=1,sum do
        local item = cc.MenuItemImage:create("btn-middle-blue.png","btn-middle-blue.png","btn-middle-blue.png")
        if addExit then 
            item:setScale(0.7)
        end 
        item:addChild(labels[i])
        labels[i]:setPosition(cc.p( item:getContentSize().width/2,  item:getContentSize().height/2))
        labels[i]:setAnchorPoint(cc.p(0.5,0.5))
        -- local item = cc.MenuItemLabel:create(labels[i])
        table.insert(items,item)
    end

	self._menu = cc.Menu:create()
    self._menu:addChild( cc.MenuItemLabel:create(label_tips) )
    for i=1,sum do
        self._menu:addChild(items[i])
        items[i]:registerScriptTapHandler(args.callbacks[i])
    end
    self:addChild(self._menu) 
    self._menu:setPosition(cc.p(display.cx,display.cy))
    self._menu:alignItemsVerticallyWithPadding(20)
    if addExit then 
        self._menu:alignItemsVerticallyWithPadding(0)
    end 

    -- self:addChild(G_GlobalFunc.disabledOtherTouch())


    if addExit then 
        -- btn-close
        local close = cc.MenuItemImage:create("btn-close.png","btn-close.png","btn-close.png")
        local closeMenu = cc.Menu:create(close)
        self._back:addChild(closeMenu)
        closeMenu:setPosition(cc.p( self._back:getContentSize().width - 33,self._back:getContentSize().height - 33))
        close:registerScriptTapHandler(function()  
            self:removeFromParent()
        end )

    end 
end


function CocosDialog:onEnter()
	--因为LayerColor的原因无法调用？？
	print("CocosDialog     onEnter()")
end

function CocosDialog:onExit()
	print("CocosDialog     onExit()")
end

return CocosDialog

