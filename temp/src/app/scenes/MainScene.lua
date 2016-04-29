
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local label = nil
local inAction = false

function MainScene:ctor()

self:setColor(display.COLOR_BLUE)


    label = cc.ui.UILabel.new({
            UILabelType = 2,
            text        = "who i am?",
        })

    label:align(display.CENTER,111,111):addTo(self)

    local callback = function()
        print("end\n\n hehee ")
    end
    local sequence = cc.Sequence:create(
            cc.MoveTo:create(0.1,cc.p(333,333)),
            cc.RotateBy:create(0.1,360),
            cc.CallFunc:create(callback)
        )
    label:runAction(sequence)

    self:testTouch()


end


function MainScene:testTouch()
    self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT , function(event) 
            print("okok")
            self:spriteJump()
        end 
    )
end

function MainScene:spriteJump()
    if inAction then return end 
    local action1 = cc.MoveBy:create(0.2, cc.p(0,100))
    local action2 = cc.MoveBy:create(0.2, cc.p(0,-100))
    local callback = function() 
        inAction = false
    end 
    -- 模拟跳动
    local sequence = cc.Sequence:create(
        cc.EaseIn:create(action1,0.4)
        ,cc.EaseOut:create(action2, 0.4)
        -- ,cc.CallFunc:create(callback)
        ,cca.cb(callback)
        -- ,cc.EaseElasticIn:create(action2)
    )
    inAction = true
    label:runAction(sequence)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

function MainScene:testEdit()
    -- local function onEdit(event, editbox)
    --     if event == "began" then
    --         print("开始输入")
    --     elseif event == "changed" then
    --         print("输入框内容发生变化")
    --     elseif event == "ended" then
    --         print("输入结束")
    --     elseif event == "return" then
    --         print("从输入框返回")
    --     end
    --     print(editbox:getText())
    -- end
    -- local editbox = cc.ui.UIInput.new({
    --     image = "edit.png",
    --     listener = onEdit,
    --     size = cc.size(200, 40),
    --     x = display.cx,
    --     y = display.cy,
    -- })

    -- editbox:align(display.CENTER,333,333):addTo(self)


end 


return MainScene
