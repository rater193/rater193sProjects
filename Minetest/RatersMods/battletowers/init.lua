if not _G.rater193 then _G.rater193 = {}
	if not _G.rater193.battletowers then _G.rater193.battletowers = {} end
end





default = {}

-- GUI related stuff
default.gui_bg = "bgcolor[#080808BB;true]"
default.gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
default.gui_slots = "listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]"

function default.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	return out
end


local chests = {}












modname = minetest.get_current_modname()
moddir = minetest.get_modpath(modname)

dofile(moddir.."/Settings_Loot.lua")

local generatedTowers = {}

minetest.register_on_generated(function(minp, maxp, seed)
	print("minp: ", minp)
	print("maxp: ", maxp)
	for i, v in pairs(minp) do print(i, " = ", v) end
	print("=========================================")
	for i, v in pairs(maxp) do print(i, " = ", v) end
	print("generate?")
	
	local length, width, depth = maxp.x-minp.x, maxp.y-minp.y, maxp.z-minp.z
	--print(length, ", ", width, ", ", depth)
	
	-- i put it to -70 because it generates weirdly
	if minp.y <= -70 and maxp.y >= -70 then
		
		print("GENERATECHECK")
		
		
		
		local pos = {
			x=minp.x,
			y=30,
			z=minp.z
		}
		
		local x, y, z = pos.x, pos.y, pos.z
		
		local cantry = false
		
		if not generatedTowers[x] then
			generatedTowers[x] = {}
			generatedTowers[x][z] = {123}
			cantry = true
		elseif not generatedTowers[x][z] then
			generatedTowers[x][z] = {123}
			cantry = true
		end
		
		
		if cantry then
			print("spawning tower?")
			pos.x = pos.x+math.random(60)+11
			pos.z = pos.z+math.random(60)+11
			
			while minetest.get_node(pos).name == "air" do
				pos.y = pos.y-1
			end
			local name = minetest.get_node(pos).name
			
			local placeabletiles = {
				["default:dirt"]=true
			}
			
			if name == "default:dirt" or name == "default:dirt_with_grass" or name == "default:dirt_with_grass_footsteps" or name == "default:dirt_with_dry_grass" or name == "default:dirt_with_snow" or name == "default:sand" or name == "default:desert_sand" or name == "default:snow" or name == "default:snowblock" or name == "default:ice" then
			
			else
				print("Unable to spawn on "..name)
				return
			end
			print("minetest.get_node(pos): ", minetest.get_node(pos))
			for i, v in pairs(minetest.get_node(pos)) do print(i, " = ", v) end
			
			local schem = moddir.."/schematics/TowerBasic.mts"
			-- Define Placecment Coords
			pos.x = pos.x-10
			pos.z = pos.z-10
			local rotations = {
				"0",
				"90",
				"180",
				"270"
			}
			local r = rotations[math.random(#rotations)]
			
			for _ = 1,math.random(3,10) do
				minetest.place_schematic(pos,schem,"0",{},false)
				local node = minetest:get_node(pos)
				
				
				
				
				local Rows = 1
				
				local invwidth = 8;
				
				
				local chestpos = {x=pos.x+7, y=pos.y+2, z=pos.z+2}
				minetest.set_node(chestpos, {
					name="default:goldblock"
				})
				local meta = minetest.get_meta(chestpos)
				
				local inv = meta:get_inventory()
				inv:set_size("main", invwidth*Rows)
				
				for _ = 1, _*2 do
					local lootitem = _G.battletowers:getLoot()
					
					if not inv:room_for_item("main", lootitem) then
						Rows = Rows+1
						inv:set_size("main", invwidth*Rows)
					end
					
					print(inv:room_for_item("main", lootitem))
					
					inv:add_item("main", lootitem)
				end
				print(Rows)
				
				for _amm = 0,_*(math.random(100,150)/100) do
					--_G.rater193.battletowers.npcs.testnpc:spawn({x = pos.x+math.random(4,12), y = pos.y+2, z = pos.z+math.random(4,12)})
					local mobs = {
						"mobs:spider",
						"mobs:mese_monster",
						"mobs:lava_flan",
						"mobs:sand_monster",
						"mobs:tree_monster"
					}
					local mob = math.random(#mobs)
					minetest.add_entity({x = pos.x+math.random(4,12), y = pos.y+2, z = pos.z+math.random(4,12)}, mobs[mob])
				end

				chest_formspectest =
					"size[8,9]"..
					default.gui_bg..
					default.gui_bg_img..
					default.gui_slots..
					"list[current_name;main;0,0.3;"..invwidth..","..(Rows)..";]"..
					"list[current_player;main;0,"..(1*(Rows)+.3)..";8,1;]"..
					"listring[current_name;main]"..
					"listring[current_player;main]"..
					default.get_hotbar_bg(0,1*(Rows)+.3)
					
				meta:set_string("formspec", chest_formspectest)
				meta:set_string("infotext", "Chest")
				--{name="default:dirt", count=5, wear=0, metadata=""}
				pos.y = pos.y+5
			end
		end
	end
	
	--print("seed: ", seed)
	
	--print("modname: ", modname)
	--print("modir: ", modir)
end)