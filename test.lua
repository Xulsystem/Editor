h = io.open('dict2.txt', 'r')

txt = {}

for lines in h:lines() do
	local cara = lines:sub(1, 1):lower()
	if txt[cara] then
		table.insert(txt[cara], lines)
	else
		txt[cara] = {}
		table.insert(txt[cara], lines)
	end
end
h:close()
for k1, v1 in pairs(txt) do
	--for k2, v2 in pairs(txt[v]) do
		print(k1, #v1)
	--end
end
