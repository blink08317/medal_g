-----------------------------------------------------------------------------------------
--medal_game
-- main.lua
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

_W = display.contentWidth
_H = display.contentHeight

local back = display.newImageRect( "bkg_clouds.png", _W*4, _H*4 )

local ground = display.newImageRect( "dai1.png", _W, _H/4 )
ground.x = _W-(_W/4); ground.y = _H

dai = display.newImageRect( "dai2.png", _W, _H/4)
dai.x = _W+(_W/4); dai.y = _H-(_H/4)

local rect = display.newRect(_W+(_W/12)+5, 0, 5, _H)

local kuma = display.newImageRect( "mogu1.png", 40, 40 )
kuma.x = _W/2

local physics = require( "physics" )
physics.start()
physics.addBody( ground, "static", { friction=0.5, bounce=0.3 } )
physics.addBody( dai, "static", { friction=10.0, bounce=0.0 } )
physics.addBody( rect, "static")
physics.addBody( kuma, { density=40.0, friction=0.1, bounce=0.3 })

local coin = {}

for i = 1, 20 do
	coin[i] = display.newImageRect( "coin.png", 20, 4)
	coin[i].rotation = math.random(85); coin[i].x = math.random(_W-(_W/4))+(_W/4)
	coin[i].y = math.random(_H/8)
	physics.addBody( coin[i], { density=40.0, friction=0.1, bounce=0.3 } )
end

local flg = 0
local w1 = 0

local function onTimeEvent(event)
	if(kuma.y >= _H) then
		local text1  = display.newText("CLEAR!", 20, 20, native.systemFont, 50)
	end
	if(flg == 0) then
		physics.removeBody( dai )
		dai.x = dai.x - 1
		w1 = w1 + 1
		physics.addBody( dai, "static", { friction=0.5, bounce=0.0 } )
		if(w1 > _W/4) then
			flg = 1
			w1 = 0
		end
	elseif(flg == 1) then
		physics.removeBody( dai )
		dai.x = dai.x + 1
		w1 = w1 + 1
		physics.addBody( dai, "static", { friction=0.5, bounce=0.0 } )
		if(w1 > _W/4) then
			flg = 0
			w1 = 0
		end
	end
end

local function TouchScreen(event)
	if event.phase == "began" then
		mycoin = display.newImageRect( "coin.png", 20, 4)
		mycoin.rotation = math.random(85); mycoin.x = _W/2+_W/16; mycoin.y = _H/2-_H/4
		physics.addBody( mycoin, { density=40.0, friction=0.1, bounce=0.3 } )
	end
end

timer.performWithDelay(10, onTimeEvent, 0 )
Runtime:addEventListener("touch", TouchScreen)