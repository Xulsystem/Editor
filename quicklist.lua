qlist = {}
qlist.lst = {}

function qlist.reload()
	qlist.path = explo.gpath.src
	local _qlisttmp = io.popen('ls '..qlist.path)
	local _pl = 0
	for l in _qlisttmp:lines() do
		if l:match('(%w+).src') then
			table.insert(qlist.lst, {name = l, x = 0, y = _pl, w = 150, h = 20})
			_pl = _pl+1
		end
	end
end

function qlist.draw()
	for k, v in ipairs(qlist.lst) do
		love.graphics.print(v.name:sub(1, #v.name-4), v.x, v.y*30)
	end
end
