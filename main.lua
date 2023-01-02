--[[ V2.0 ]]

InputField = require("InputField")
love.graphics.setDefaultFilter('nearest', 'nearest')
require('utils')
require('GMaths')
require('sbut')
--local field      = InputField("Initial text.", "multiwrap")
require('menu')
require('sheet')

require('explo')



love.window.setMode( 800, 600, {msaa = 0, highdpi = true, resizable = true})


--local fieldX = 80
--local fieldY = 50

dict = {}



local FONT_LINE_HEIGHT = 0.8

love.graphics.setBackgroundColor(rgb('#212121'))

love.keyboard.setKeyRepeat(true)

dict = {}

dict.keyword = {}
dict.keyword.hash = {}
dict.keyword.hash.color = rgb('#E5838D')
dict.keyword.hash.list = {'%#%w+'}

dict.keyword.dollar = {} 
dict.keyword.dollar.color = {1, 0, 1}
dict.keyword.dollar.list = {'%$%w+'}

dict.keyword.args = {}
dict.keyword.args.color = {1, 0, 1}
dict.keyword.args.list = {'<(.-)>'}


dict.keyword.keyw = {}
dict.keyword.keyw.color = rgb('#48BEFF')
dict.keyword.keyw.list = {"%@"}

GPATH = {}
GPATH.src = ''
GPATH.saves = ''


function love.keypressed(key, scancode, isRepeat)
	if explo.view == -1 then
	    sheet.tZone:keypressed(key, isRepeat)
	else
		explo.cDoc.inp:keypressed(key, isRepeat)
	end

	if love.keyboard.isDown('lctrl') and key == 's' then
		explo.launch()
	end
	explo.keypressed(key)
end
function love.textinput(text)
	if explo.view == -1 then
		sheet.tZone:textinput(text)
	else
		explo.cDoc.inp:textinput(text)
	end
end

function love.mousepressed(mx, my, mbutton, pressCount)
	if explo.view == -1 then
		sheet.tZone:mousepressed(mx-sheet.x, my-sheet.y, mbutton, pressCount)
	elseif explo.view == 1 and checkcollision(mx, my, 1, 1, explo.ui.x, explo.ui.y, explo.ui.w, explo.ui.h) then
		explo.cDoc.inp:mousepressed(mx-explo.x - explo.cDoc.x, my-explo.y - explo.cDoc.y, mbutton, pressCount)
	end
	
end
function love.mousemoved(mx, my)
	if explo.view == -1 then
		sheet.tZone:mousemoved(mx-sheet.x, my-sheet.y)
	elseif explo.view == 1 and checkcollision(mx, my, 1, 1, explo.ui.x, explo.ui.y, explo.ui.w, explo.ui.h) then
		explo.cDoc.inp:mousemoved(mx-explo.x - explo.cDoc.x, my-explo.y - explo.cDoc.y)
	end
end
function love.mousereleased(mx, my, mbutton)
	if explo.view == -1 then
		sheet.tZone:mousereleased(mx-sheet.x, my-sheet.y, mbutton)
	elseif explo.view == 1 then
		explo.cDoc.inp:mousereleased(mx-explo.x - explo.cDoc.x, my-explo.y - explo.cDoc.y, mbutton)
	end
	explo.mouseclick(mx, my)
	sbut.click(mx, my)
end
function love.wheelmoved(dx, dy)
	if explo.view == -1 then
		sheet.tZone:wheelmoved(dx, dy)
	else
		explo.cDoc.inp:wheelmoved(dx, dy)
	end
	explo.wheelmoved(dx, dy)
end

function love.load()
	explo.refresh()
	--explo.launch()
end

function love.update(dt)
	menu.update()
	explo.update()
	sheet:update()
	sbut.updateAll()
end

function love.draw() 

	sheet.draw()
	menu.draw()

	explo.draw()
	sbut.drawAll()

end
