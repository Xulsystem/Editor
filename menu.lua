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
menu.lpan.w = 250
menu.lpan.h = love.graphics.getHeight()

menu.box = {}
menu.box.src = {}
menu.box.src.x = menu.lpan.x + 3
menu.box.src.y = menu.lpan.y + 2
menu.box.src.w = menu.lpan.w - 6
menu.box.src.h = 400

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
	love.graphics.rectangle('line', menu.box.src.x, menu.box.src.y, menu.box.src.w, 25, round)
	love.graphics.rectangle('line', menu.box.src.x, menu.box.src.y+25, menu.box.src.w, menu.box.src.h-25, round)
--	love.graphics.setScissor()
	love.graphics.rectangle('line', menu.box.src.x, menu.box.src.y, menu.box.src.w, menu.box.src.h, round)
end
