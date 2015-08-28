

function registerItem(itemid, itemname, texture)
	minetest.register_craftitem("chisel:item_"..itemid, {
		description = itemname,
		inventory_image = "chisel_"..texture..".png"
	})
end


function registerBlock(itemid, blockname, texture)
	--[[minetest.register_node("chisel:block_"..itemid, {
		description = blockname,
		tiles = {"chisel_"..texture..".png"},
		is_ground_content = true,
		groups = {crumbly=1, cracky=3}
	})]]
	minetest.register_node("chisel:block_"..itemid, {
		description = blockname,
		tiles = {"chisel_"..texture..".png"},
		is_ground_content = false,
		groups = {cracky=3, stone=1},
		sounds = {
			footstep = "chisel_hard_footstep",
			dig = "chisel_dig_cracky",
			dug = "chisel_dig_cracky",
			place = "chisel_place_node_hard"
		}
	})
end


function registerBlocks(itemid, blockname, texture, ammount)
	for _id = 1,ammount do
		registerBlock(itemid.._id, blockname.._id, texture.."_".._id)
	end
end


registerItem("chisel", "Chisel", "chisel_iron")


registerBlocks("cobble", "Cobble", "cobble",15)