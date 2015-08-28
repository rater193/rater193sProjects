
--[[
	addLoot(item, weight, minamm, maxamm)
	item : The item data you want to use
		EX: {name="default:dirt"}
	weight : The weight of probability that this item will spawn
	minamm, maxamm : The ammount that get spawned
]]


if not _G.battletowers then
	_G.battletowers = {}
	
	
	
	_G.battletowers.loot = {
		items = {},
		weightcount = 0
	}

	function _G.battletowers:addLoot(item, weight, minamm, maxamm)
		table.insert(_G.battletowers.loot.items, {
			item=item,
			weight=weight or 5,
			minamm=minamm or 2,
			maxamm=maxamm or 5
		})
		_G.battletowers.loot.weightcount=_G.battletowers.loot.weightcount+weight
	end

	function _G.battletowers:getLoot()
		local ammount = math.random(_G.battletowers.loot.weightcount)
		
		local place = 0
		for index, item in pairs(_G.battletowers.loot.items) do
			if place+item.weight >= ammount then
				item.item.count = math.random(item.minamm, item.maxamm)
				return item.item
			else
				place = place+item.weight
			end
		end
	end
end