
default = {}

-- GUI related stuff
default.gui_bg = "bgcolor[#080808BB;true]"
default.gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
default.gui_slots = "listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]"


local chest_formspec =
	"size[8,9]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;main;0,0.3;8,4;]"..
	"list[current_player;main;0,4.85;8,1;]"..
	"list[current_player;main;0,6.08;8,3;8]"..
	"listring[current_name;main]"..
	"listring[current_player;main]"
	--default.get_hotbar_bg(0,4.85)



local modname = minetest.get_current_modname()


function registerBlock(itemid, blockname, texture)
	minetest.register_node(modname..":block_"..itemid, {
		description = blockname,
		tiles = {modname.."_"..texture..".png"},
		is_ground_content = false,
		groups = {cracky=4, stone=1},
		sounds = {
			footstep = modname.."_hard_footstep",
			dig = modname.."_dig_cracky",
			dug = modname.."_dig_cracky",
			place = modname.."_place_node_hard"
		},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", chest_formspec)
			meta:set_string("infotext", "Chest")
			local inv = meta:get_inventory()
			inv:set_size("main", 8*4)
		end,
		can_dig = function(pos,player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			return inv:is_empty("main")
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			minetest.log("action", player:get_player_name()..
					" moves stuff in chest at "..minetest.pos_to_string(pos))
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			minetest.log("action", player:get_player_name()..
					" moves stuff to chest at "..minetest.pos_to_string(pos))
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			minetest.log("action", player:get_player_name()..
					" takes stuff from chest at "..minetest.pos_to_string(pos))
		end,
	})
end


minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
	if minetest.setting_getbool("creative_mode") then
		--minetest.remove_node(pos)
	else
		print(node.name)
		if node.name == "testmod:block_testblock" then
			--node.testtest = 12345
			local meta = minetest.get_meta(pos)
			--meta:set_string("testtest", "12345")
			--print("Set meta")
			print(meta:get_string("testtest"))
			
			print("Setting inventory")
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", chest_formspec)
			meta:set_string("infotext", "Chest")
			local inv = meta:get_inventory()
			inv:set_size("main", 8*math.random(4,6))
		end
		--puncher:get_inventory():add_item('main', node)
		--print(node.name)
	end
end)



registerBlock("testblock", "Test Block", "testblock")
