lst = 'bonjour zaza.lua zeze.src dada.txt'
for w in lst:gmatch('(%w+).src') do
	print(w)
end
