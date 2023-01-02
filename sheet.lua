sheet = {}

sheet.colors = {}
sheet.colors.bg = {.95, .95, .90}
sheet.colors.bText = {.05, .05, .05}
sheet.x = menu.lpan.w
sheet.y = menu.hpan.h
sheet.w = love.graphics.getWidth() - menu.lpan.w
sheet.h = 950

sheet.name = 'Untitled.txt'

sheet.tZone = InputField("Initial text.", "multiwrap")

local FONT_LINE_HEIGHT = 0.8
--local theFont = love.graphics.newFont("Poppins-Regular.ttf", 20)
local theFont = love.graphics.newFont(20, "none")
theFont:setLineHeight(FONT_LINE_HEIGHT)
sheet.tZone:setFont(theFont)
sheet.tZone:setWidth(sheet.w)

function sheet.update()
	sheet.w = love.graphics.getWidth() - menu.lpan.w
	sheet.tZone:setWidth(sheet.w)
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
	love.graphics.setColor(sheet.colors.bg)
	love.graphics.rectangle('fill', sheet.x, sheet.y, sheet.w, sheet.h)
	love.graphics.setFont(sheet.tZone:getFont())

	love.graphics.setColor(0, 0, 1)
	for _, x, y, w, h in sheet.tZone:eachSelection() do
		love.graphics.rectangle("fill", sheet.x+x+5, sheet.y+y, w, h)
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

			love.graphics.print(s, sheet.x + div + 5, sheet.y+y)
			div = div + love.graphics.getFont():getWidth(s..' ')


		end
	end
	love.graphics.setColor(.05, .05, 05)
	local x, y, h = sheet.tZone:getCursorLayout()
	love.graphics.rectangle("fill", sheet.x+x+5, sheet.y+y, 1, h)

end
