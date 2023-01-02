sbut = {}
sbut.all = {}
sbut.__index = sbut

function sbut.new(x, y, w, h)
	local self = {}
	setmetatable(self, sbut)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.hover = false
	self.border = false
	self.active = true
	self.visible = true
	self.callback = function(num) print(tostring(_G.sbut.all[num])..' : nocallback') end
	self.codeDraw = function() end
	self.codeUpdate = function() end
	table.insert(sbut.all, self)
	return self
end

function sbut:setActive(bool) self.active = bool end
function sbut:setVisible(bool) self.visible = bool end

function sbut:setDraw(foo) self.codeDraw = foo end
function sbut:setUpdate(foo) self.codeUpdate = foo end
function sbut:setCallback(foo) self.callback = foo end

function sbut:isHover() return self.hover end


function sbut:showBox(bool) self.border = bool end

function sbut:update() 
	self.hover = checkcollision(love.mouse.getX(), love.mouse.getY(), 1, 1, self.x, self.y, self.w, self.h)
	pcall(self.codeUpdate) 
end

function sbut:draw()
	self.codeDraw()
	if self.border then
		love.graphics.setColor(math.random(), math.random(), math.random(), 1)
		love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
	end
end

function sbut.click(x, y)
	for k, v in ipairs(sbut.all) do
		if v.active and checkcollision(x, y, 1, 1, v.x, v.y, v.w, v.h) then
			v.callback(k)
		end
	end
end

function sbut.hover()
	local hov
	for k, v in ipairs(sbut.all) do
		if checkcollision(love.mouse.getX(), love.mouse.getY(), 1, 1, v.x, v.y, v.w, v.h) then
			hov = true
			break
		else
			hov = false
		end
	end
	return hov
end

function sbut.updateAll()
	for k, v in ipairs(sbut.all) do
		--if v.active then
			v:update()
		--end
	end
end

function sbut.drawAll()
	for k, v in ipairs(sbut.all) do
		if v.visible then
			v:draw()
		end
	end
end