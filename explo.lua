explo = {}
explo.path = {}
explo.gpath = {}
explo.gpath.save = love.filesystem.getUserDirectory()
explo.gpath.src = '/Users/macbook/Documents/PROGRAMMATION/vim/src/'


explo.root = love.filesystem.getUserDirectory()
for s in explo.root:gmatch("%w+") do
	table.insert(explo.path, s)
end

explo.view = -1



explo.tName = 16
explo.tList = 20

explo.img = {}
explo.img.file = love.graphics.newImage('icofil.png')
explo.img.dir = love.graphics.newImage('icodir.png')

local FONT_LINE_HEIGHT = 0.8

explo.font = love.graphics.newFont("Poppins-Regular.ttf", 12)

explo.font:setLineHeight(FONT_LINE_HEIGHT)


explo.x = 30
explo.y = 30
explo.w = 3*185 + 150
explo.h = 20 * (explo.font:getHeight() + 3) + explo.font:getHeight() + 12

explo.tmp = nil
explo.header = {}
explo.header.x = explo.x
explo.header.y = explo.y
explo.header.w = explo.w
explo.header.h = 40

explo.ui = {}
explo.ui.x = explo.x
explo.ui.y = explo.header.y + explo.header.h
explo.ui.w = 150
explo.ui.h = 300

explo.display = {}
explo.display.x = explo.ui.x + explo.ui.w
explo.display.y = explo.header.y + explo.header.h
explo.display.w = explo.w - explo.ui.w
explo.display.h = explo.ui.h

explo.bottom = {}
explo.bottom.x = explo.x
explo.bottom.y = explo.ui.y + explo.ui.h
explo.bottom.w = explo.w
explo.bottom.h = 40

explo.pathDisplay = InputField("")
explo.pathDisplay:setWidth(500)
explo.pathDisplay:setEditable(false)

explo.pathDisplayX = 40
explo.pathDisplayY = 10

explo.cDoc = {}
explo.cDoc.x = 25
explo.cDoc.y = 170
explo.cDoc.w = 100
explo.cDoc.inp = InputField(sheet.name, "multiwrap")
explo.cDoc.inp:setFont(explo.font)
explo.cDoc.inp:setWidth(explo.cDoc.w)
explo.cDoc.inp:setAlignment('center')
--local s, e = explo.cDoc.inp:getText():find('%.')
--explo.cDoc.inp:setSelection(0, e - 1)
--explo.cDoc.inp:setHeight(explo.font:getHeight())



explo.round = 8
explo.scroll = 0
explo.scrollVel = 0

-- BTNS

explo.buttons = {}
explo.buttons.back = sbut.new(0, 0, explo.font:getHeight(), explo.font:getHeight())

explo.buttons.back:setUpdate(function() explo.buttons.back.x = explo.x + explo.pathDisplayX - explo.buttons.back.w
								 		explo.buttons.back.y = explo.y + explo.pathDisplayY 
										end)
explo.buttons.back:setDraw(function() 	love.graphics.setColor(rgb('#404040'))
										love.graphics.rectangle('fill', explo.buttons.back.x, explo.buttons.back.y, explo.buttons.back.w, explo.buttons.back.h, 4) 
										love.graphics.setColor(1, 1, 1)
										love.graphics.print('<', explo.buttons.back.x + 5, explo.buttons.back.y + 1)
										end)

explo.buttons.back:setCallback(function()	table.remove(explo.path)
											explo.scroll = 0
											explo.refresh()
											end)

explo.buttons.save = sbut.new(0, 0, explo.font:getWidth('Enregister') + 12, explo.font:getHeight())

explo.buttons.save:setUpdate(function() explo.buttons.save.x = explo.x + explo.w - 100
										explo.buttons.save.y = explo.bottom.y + 10
										end)

explo.buttons.save:setDraw(function() 	love.graphics.setColor(rgb('#47F647'))
										love.graphics.rectangle('fill', explo.buttons.save.x, explo.buttons.save.y, explo.font:getWidth('Enregister') + 12, explo.font:getHeight(), 4)
										love.graphics.setColor(rgb('#000000'))
										love.graphics.print('Enregister', explo.buttons.save.x + 6, explo.buttons.save.y)
										
										end)

explo.buttons.save:setCallback(function() 	explo.tmp = io.open('/'..table.concat(explo.path, '/')..'/'..explo.cDoc.inp:getText(), 'w')
											explo.tmp:write(sheet.tZone:getText())
											explo.tmp:close()
											explo.view = -1
											explo.gpath.save = '/'..table.concat(explo.path, '/')..'/'
											end)

explo.buttons.cancel = {}
explo.buttons.cancel = sbut.new(0, 0, explo.font:getWidth('Enregister') + 12, explo.font:getHeight())

explo.buttons.cancel:setUpdate(function() explo.buttons.cancel.x = explo.x + explo.w - 180
										explo.buttons.cancel.y = explo.bottom.y + 10
										end)

explo.buttons.cancel:setDraw(function() 	love.graphics.setColor(rgb('#F64747'))
										love.graphics.rectangle('fill', explo.buttons.cancel.x, explo.buttons.cancel.y, explo.font:getWidth('Enregister') + 12, explo.font:getHeight(), 4)
										love.graphics.setColor(rgb('#000000'))
										love.graphics.print('Annuler', explo.buttons.cancel.x + (explo.font:getWidth('Enregister') + 12) / 2 - explo.font:getWidth('Annuler')/2, explo.buttons.cancel.y)
										end)

explo.buttons.cancel:setCallback(function() explo.view = -1 end)


function explo.keypressed(key)
	if key == 'escape' then
		explo.view = -1
		explo.scroll = 0
		explo.scrollVel = 0
		explo.refresh()
	end
end

function explo.wheelmoved(dx, dy)
	explo.scrollVel = explo.scrollVel + dy * 1
	--explo.scroll = math.clamp(-explo.tList * explo.font:getHeight() + explo.h - 36, explo.scroll + dy * 2, 0)
end

function explo.mouseclick(x, y)
	if explo.view == 1 then
		for k, v in ipairs(explo.result) do
			if checkcollision(x, y, 1, 1, v.x, v.y, 180, explo.font:getHeight()) and v.typ == 'dir' and not sbut.hover() then
				table.insert(explo.path, v.name:sub(1, #v.name-1))
				explo.scroll = 0
				explo.refresh()
			end
		end
	end
end

function explo.launch()
	explo.path = {}
	explo.cDoc.inp:setText(sheet.name)
	local s, e = explo.cDoc.inp:getText():find('%.')
	explo.cDoc.inp:setSelection(0, e - 1)
	explo.view = 1
	for s in explo.gpath.save:gmatch("%w+") do
		table.insert(explo.path, s)
	end

	explo.refresh()
end

function explo.refresh()
	local handle = io.popen("ls -F /"..table.concat(explo.path, '/')..'/')
	explo.result = {}
	--table.insert(explo.result, {name = 'back', type = 'dir', dName = "<<..", hover = false, x = 0, y = 0})
	for l in handle:lines() do
		local t = {}
		for w in l:gmatch('[^%.]+') do
			table.insert(t, w)
		end

		local n = ''
		if t[1] and t[2] then
			if #t[1] > explo.tName then
			    n = t[1]:sub(1, explo.tName - 4)..'...'..t[1]:sub(#t[1] - 2)..'.'..t[2]
			else
				n = t[1]..'.'..t[2]
			end
			table.insert(explo.result, {name = l, typ = 'file', dName = n, hover = false, x = 0, y = 0})
		end
		if l:sub(#l) == '/' then
			local locl
			local dName
			if #l > 18 then
				dName = l:sub(1, 8)..'...'..l:sub(#l - 4)
			else
				dName = l:sub(1, #l-1)
			end
			if l:match('%s') then
				locl = l:gsub('%s', [[\ ]])
			else
				locl = l
			end
				table.insert(explo.result, {name = locl, typ = 'dir', dName = dName, hover = false, x = 0, y = 0})
			end
		end
	handle:close()
	explo.tList = math.ceil(#explo.result / 3)

	explo.pathDisplay:setText('~/'..table.concat(explo.path, "/")..'/')
end


function explo.update()
	if explo.view == 1 then
		explo.buttons.back:setActive(true)
		explo.buttons.back:setVisible(true)

		explo.buttons.save:setActive(true)
		explo.buttons.save:setVisible(true)

		explo.buttons.cancel:setActive(true)
		explo.buttons.cancel:setVisible(true)
		explo.scroll = explo.scroll + explo.scrollVel
		explo.scroll = math.clamp(-explo.tList * explo.font:getHeight() + explo.display.h - (explo.font:getHeight() / 2), explo.scroll, 0)

		for k, v in ipairs(explo.result) do
		   	local x = explo.display.x + math.floor((k-1)/explo.tList) * 180
		   	local y = explo.display.y + (((k-1) % explo.tList)) * (explo.font:getHeight())
		   	v.x = x + 3
		   	v.y = y + 3 + explo.scroll
	    end

	    for k, v in ipairs(explo.result) do
		    if checkcollision(v.x, v.y, 180, explo.font:getHeight(), love.mouse.getX(), love.mouse.getY(), 1, 1) then
		    	v.hover = true
		    else
		    	v.hover = false
		    end	
		end
		explo.scrollVel = explo.scrollVel * 0.8
	else
		explo.buttons.back:setActive(false)
		explo.buttons.back:setVisible(false)

		explo.buttons.save:setActive(false)
		explo.buttons.save:setVisible(false)

		explo.buttons.cancel:setActive(false)
		explo.buttons.cancel:setVisible(false)
	end
end

function explo.draw()
	-- DRAWWIN
	if explo.view == 1 then
		love.graphics.setFont(explo.font)

		love.graphics.setColor(1, 1, 1, .4)
		love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

		love.graphics.setScissor(explo.header.x, explo.header.y, explo.header.w, explo.header.h)
		love.graphics.setColor(rgb('#212121'))
		love.graphics.rectangle('fill', explo.header.x, explo.header.y, explo.header.w, explo.header.h + 30, explo.round)
		love.graphics.setScissor()

		love.graphics.setColor(rgb('#282828'))
		love.graphics.rectangle('fill', explo.ui.x, explo.ui.y, explo.ui.w, explo.ui.h)

		love.graphics.setColor(rgb('#404040'))
		love.graphics.rectangle('fill', explo.display.x, explo.display.y, explo.display.w, explo.display.h)

		love.graphics.setScissor(explo.bottom.x, explo.bottom.y, explo.bottom.w, explo.bottom.h)
		love.graphics.setColor(rgb('#212121'))
		love.graphics.rectangle('fill', explo.bottom.x, explo.bottom.y - 20, explo.bottom.w, explo.bottom.h + 20, explo.round)
		love.graphics.setScissor()

		love.graphics.setColor(rgb('#121212'))
		love.graphics.line(explo.x + 1, explo.y + explo.header.h-1, explo.x + explo.w - 1, explo.y + explo.header.h-1)

		love.graphics.setColor(rgb('#121212'))
		love.graphics.line(explo.x + 1, explo.ui.y + explo.ui.h + 1, explo.x + explo.w - 1, explo.ui.y + explo.ui.h + 1)

		love.graphics.setColor(rgb('#585858'))
		love.graphics.rectangle('fill', explo.display.x + explo.display.w - 10, explo.display.y, 10, explo.display.h, 5)

		love.graphics.setColor(rgb('#212121'))
		love.graphics.rectangle('fill', explo.display.x + explo.display.w - 10, explo.display.y + (explo.scroll / (-explo.tList * explo.font:getHeight() + explo.display.h - (explo.font:getHeight() / 2)) * (explo.display.h - 50)), 10, 50, 5)

		love.graphics.setColor(rgb('#585858'))
		love.graphics.rectangle('fill', explo.x + explo.pathDisplayX, explo.y + explo.pathDisplayY, explo.pathDisplay:getWidth(), explo.font:getHeight(), 4)

		love.graphics.setColor(rgb('#FFFFFF'))
		love.graphics.setScissor(explo.x + explo.pathDisplayX, explo.y + explo.pathDisplayY, explo.pathDisplay:getWidth(), explo.font:getHeight())
		for _, text, x, y in explo.pathDisplay:eachVisibleLine() do
			love.graphics.print(text, explo.x + explo.pathDisplayX + 6, explo.y + explo.pathDisplayY + 1)
		end
		love.graphics.setScissor()

		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(explo.img.file, explo.x + 35, explo.y + 80, 0, 5, 5)

		------------------------------------------------------------------------
		love.graphics.setColor(1, 1, 1)
		for _, text, x, y in explo.cDoc.inp:eachVisibleLine() do
			love.graphics.setColor(rgb('#585858'))
			love.graphics.rectangle('fill', explo.x + explo.cDoc.x - 4, explo.y + explo.cDoc.y + y, explo.cDoc.w + 8, explo.font:getHeight())
			love.graphics.setColor(1, 1, 1)
			love.graphics.print(text, explo.x + explo.cDoc.x + x, explo.y + explo.cDoc.y + y)
		end
		love.graphics.setColor(0, 0, 1, .5)
		for _, x, y, w, h in explo.cDoc.inp:eachSelection() do
			love.graphics.rectangle("fill", explo.x + explo.cDoc.x + x, explo.y + explo.cDoc.y + y + 2, w, explo.font:getHeight() - 4)
		end
		love.graphics.setColor(.05, .05, 05)
		local x, y, h = explo.cDoc.inp:getCursorLayout()
		love.graphics.rectangle("fill", explo.x + explo.cDoc.x + x, explo.y + explo.cDoc.y + y, 1, h)
		-------------------------------------------------------------------------

	    love.graphics.setScissor(explo.display.x, explo.display.y, explo.display.w, explo.display.h)
	    for k, v in ipairs(explo.result) do
	    	if v.typ == 'dir' then
	    		if v.hover then 
	    			love.graphics.setColor(rgb('#5555EE'))
	    			love.graphics.rectangle('fill', v.x, v.y, 180, explo.font:getHeight()+1, explo.round - 4, explo.round - 4)
	    		end
	    		love.graphics.setColor(rgb('#EEEE77'))
	    		love.graphics.draw(explo.img.dir, v.x + 2, v.y + 1)
	    		love.graphics.setColor(rgb('#FFFFFF')) -- TEXT COLOR
	    		love.graphics.print(v.dName, v.x + 6 + 14, v.y+1)
	    	elseif v.typ == 'file' then
	    		if v.hover then 
	    			love.graphics.setColor(rgb('#555555'))
	    			love.graphics.rectangle('fill', v.x, v.y, 180, explo.font:getHeight()+1, explo.round - 4, explo.round - 4)
	    		end
	    	    love.graphics.setColor(rgb('#AAAAAA'))
	    		love.graphics.draw(explo.img.file, v.x + 2, v.y + 1)
	    		love.graphics.setColor(rgb('#888888')) -- TEXT COLOR
	    		love.graphics.print(v.dName, v.x + 6 + 14, v.y+1)
	    	else
	    		--love.graphics.setColor(rgb('#DAD3FF'))
	    		--love.graphics.rectangle('fill', v.x, v.y, 200, explo.font:getHeight()+1, explo.round, explo.round)
	    		love.graphics.setColor(rgb('#2C2C2E')) -- TEXT COLOR
	    		love.graphics.print(v.dName, v.x + 6, v.y)
	    	end
	    end
	    love.graphics.setScissor()
	    
	end
end