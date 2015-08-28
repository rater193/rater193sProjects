
local modname = minetest.get_current_modname()


function registerBlock(itemid, blockname, texture)
	minetest.register_node(modname..":block_"..itemid, {
		description = blockname,
		tiles = {modname.."_"..texture..".png"},
		is_ground_content = false,
		groups = {cracky=3, stone=1},
		sounds = {
			footstep = modname.."_hard_footstep",
			dig = modname.."_dig_cracky",
			dug = modname.."_dig_cracky",
			place = modname.."_place_node_hard"
		}
	})
end



registerBlock("spawnzombie", "Zombie Spawner", "zombiespawner")
