sheet = {}

sheet.colors = {}
sheet.colors.bg = {48/255, 56/255, 65/255}
sheet.colors.bText = {1, 1, 1}
sheet.x = menu.lpan.w
sheet.y = menu.hpan.h
sheet.w = love.graphics.getWidth() - menu.lpan.w
sheet.h = love.graphics.getHeight() - menu.hpan.h

sheet.name = 'Untitled.txt'

sheet.tZone = InputField("Initial text.", "multiwrap")

local FONT_LINE_HEIGHT = 1
--local theFont = love.graphics.newFont("Poppins-Regular.ttf", 20)
local theFont = love.graphics.newFont(16, "none")
theFont:setLineHeight(FONT_LINE_HEIGHT)
sheet.tZone:setFont(theFont)
sheet.tZone:setWidth(sheet.w)
sheet.tZone:setHeight(sheet.h)
function sheet.update()
	sheet.w = love.graphics.getWidth() - menu.lpan.w
	sheet.tZone:setWidth(sheet.w)
	sheet.h = love.graphics.getHeight() - menu.hpan.h
	sheet.tZone:setHeight(sheet.h-20)
	local txt = sheet.tZone:getText()
	if txt:find("%$%w+%$") then
		local s, e = txt:find("%$%w+%$")
		local h = io.open(explo.gpath.src..txt:sub(s+1, e-1)..'.src')
		h:read()
		local tmp = h:read('*a')
		sheet.tZone:setText(txt:gsub('%$%w+%$', tmp..''))
		sheet.tZone:moveCursor(#tmp - math.floor(e-s)-1)
		h:close()
		
	end
end


function sheet.draw()
	----------------------
	love.graphics.setColor(sheet.colors.bg)
	love.graphics.rectangle('fill', sheet.x, sheet.y, sheet.w, sheet.h, 6)
	love.graphics.setFont(sheet.tZone:getFont())
	----------------------
	love.graphics.setColor(210/255, 175/255, 70/255, .5)
	for _, x, y, w, h in sheet.tZone:eachSelection() do
		love.graphics.rectangle("fill", sheet.x+x+5, sheet.y+y+5, w, h)
	end
	love.graphics.setColor(1, 1, 1)
	for _, text, x, y in sheet.tZone:eachVisibleLine() do
		local div = 0
		for s in text:gmatch("[%S%(]+") do
			local matched = false
			for k1, v1 in pairs(dict.keyword) do
				for k2, v2 in pairs(dict.keyword[k1]["list"]) do
					if s:match(v2) then
					    love.graphics.setColor(dict.keyword[k1]["color"])
					    matched = true
					    break
					else
						love.graphics.setColor(sheet.colors.bText)
					end
				end
				if matched then break end
			end
			love.graphics.print(s, sheet.x + div + 5, sheet.y+y+5)
			div = div + love.graphics.getFont():getWidth(s..' ')
		end
	end
	love.graphics.setColor(210/255, 140/255, 50/255, math.floor((1+sheet.tZone:getBlinkPhase()*2)%2))
	local x, y, h = sheet.tZone:getCursorLayout()
	love.graphics.rectangle("fill", sheet.x+x+5, sheet.y+y+5, 2, h)
end
