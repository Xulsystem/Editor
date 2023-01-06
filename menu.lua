menu = {}
menu.lpan = {}
menu.hpan = {}

menu.hpan.x = 0
menu.hpan.y = 0
menu.hpan.w = love.graphics.getWidth()
menu.hpan.h = 60
menu.hpan.color = rgb('#212121')

menu.lpan.x = 0
menu.lpan.y = menu.hpan.h
menu.lpan.w = 200
menu.lpan.h = love.graphics.getHeight()

menu.box = {}
menu.box.src = {}
menu.box.src.x = menu.lpan.x + 3
menu.box.src.y = menu.lpan.y + 2
menu.box.src.w = menu.lpan.w - 6
menu.box.src.h = 400

menu.box.src.buttons = {}
menu.box.src.buttons.search = sbut.new(menu.lpan.x + menu.lpan.w - 26, menu.lpan.y + 5, 20, 20)
menu.box.src.buttons.search:setDraw(function()	love.graphics.setColor(rgb('#FFFFFF'))
												love.graphics.rectangle('fill', menu.box.src.buttons.search.x, menu.box.src.buttons.search.y, 20, 20, 4)
												end)
menu.box.src.buttons.search:setCallback(function()	explo.launch('src')
													end)
menu.box.src.buttons.search:setUpdate(function()	if explo.view == 1 then
														menu.box.src.buttons.search:setVisible(false)
														menu.box.src.buttons.search:setActive(false)
													elseif explo.view == -1 then
														menu.box.src.buttons.search:setVisible(true)
														menu.box.src.buttons.search:setActive(true)
													end
												end)
function menu.load()
	qlist.reload()
end

function menu.update()
	menu.hpan.w = love.graphics.getWidth()
	menu.lpan.h = love.graphics.getHeight()
end

function menu.draw()
	love.graphics.setColor(menu.hpan.color)
	love.graphics.rectangle('fill', menu.hpan.x, menu.hpan.y, menu.hpan.w, menu.hpan.h)

	love.graphics.setColor(menu.hpan.color)
	love.graphics.rectangle('fill', menu.lpan.x, menu.lpan.y, menu.lpan.w, menu.lpan.h)
	
	-- BOXSRC
	local round = 8
	love.graphics.setColor(rgb('#303030'))
	love.graphics.rectangle('fill', menu.box.src.x, menu.box.src.y, menu.box.src.w, menu.box.src.h, round)
	love.graphics.setLineWidth(2)
	love.graphics.setColor(rgb('#505050'))
--	love.graphics.setScissor(menu.box.src.x, menu.box.src.y, menu.box.src.w, 25)
	love.graphics.rectangle('line', menu.box.src.x, menu.box.src.y, menu.box.src.w, 26, round)
	love.graphics.rectangle('line', menu.box.src.x, menu.box.src.y+26, menu.box.src.w, menu.box.src.h-26, round)
--	love.graphics.setScissor()
	love.graphics.rectangle('line', menu.box.src.x, menu.box.src.y, menu.box.src.w, menu.box.src.h, round)
	qlist.draw()
end
