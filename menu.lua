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
menu.lpan.w = 100
menu.lpan.h = 200

function menu.draw()
	love.graphics.setColor(menu.hpan.color)
	love.graphics.rectangle('fill', menu.hpan.x, menu.hpan.y, menu.hpan.w, menu.hpan.h)
end