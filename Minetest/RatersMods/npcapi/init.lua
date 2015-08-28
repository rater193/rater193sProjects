
--the table for storing all the functions
NPCEngine = {}

--for storing all the data for the NPCs
NPCEngine.Data = {}

--the list of stored entities
NPCEngine.Data.entities = {}
--the list of stored objects
NPCEngine.Data.objects = {}

--for creating a basic fireable event
local function createEvent()
	--the returning table
	local ret = {}
	
	--for storeing the list of instances that we create for bindable functions
	ret.instances = {}
	
	--for fireing the event, with varied arguments
	function ret:fire(...)
		for i, v in pairs(ret.instances) do
			v(...)
		end
	end
	
	--for registering new events
	function ret:connect(_f)
		table.insert(ret.instances, _f)
	end
	
	--then returning the new bindable event
	return ret
end

--for registering new NPCs
function NPCEngine:new(npcname, model, texture)
	local npc = {}
	
	local entname = ""
		--[[default.player_register_model(model, {
		animation_speed = 30,
		textures = {texture, },
		animations = {
			-- Standard animations.
			stand     = { x=  0, y= 79, },
			lay       = { x=162, y=166, },
			walk      = { x=168, y=187, },
			mine      = { x=189, y=198, },
			walk_mine = { x=200, y=219, },
			-- Extra animations (not currently used by the game).
			sit       = { x= 81, y=160, },
		},
	})]]

	
	minetest.register_entity(npcname,{
		hp_max = 1,
		physical = true,
		weight = 5,
		collisionbox = {-0.3,-1,-0.3, 0.3,.75,0.3},
		visual = "mesh",
		visual_size = {x=1, y=1},
		mesh = model,
		textures = {texture}, -- number of required textures depends on visual
		colors = {0xFF0000}, -- number of required colors depends on visual
		is_visible = true,
		makes_footstep_sound = false,
		automatic_rotate = false,
		data = {
			jumptime = 0
		},
		on_rightclick = function(self, clicker)
			print("click?")
			--self.entidtest = math.random(20000)
			print("entidtest:", self.entidtest)
		end,
		get_staticdata = function(self)
			print("Get static data?")
			
			npc_data = {}
			npc_data.data = {}
			
			for i, v in pairs(self.data) do
				--if type(i) ~= "function" then
					npc_data.data[i] = v
				--end
			end
			
			npc.Events.OnSave:fire(self, npc_data)
			
			npc_data.loaded = true
			return minetest.serialize(npc_data)
		end,
		on_activate = function(self, staticdata)
			
			if staticdata~="" then
				local data = minetest.deserialize(staticdata)
				--if staticdata then
					print("staticdata: ", staticdata)
					print("data: ", data)
					
					for i, v in pairs(data) do
						--if type(i) ~= "function" then
							self.data[i] = v
						--end
					end
					print("[info] LOADING NPC DATA")
					npc.Events.OnLoad:fire(self, data)
				--end
			else
				--print("[info] DATA:", staticdata)
			end
		end,
		on_step = function(self, dtime)
			--local ent = self.get_luaentity()
			local obj = self.object
			
			self.data.jumptime = self.data.jumptime+dtime
			if self.data.jumptime > 2 then
				obj:setvelocity({x=0, y=5, z=0})
				self.data.jumptime = 0
			end
			obj:setacceleration({x=0, y=-10, z=0})
			
		end
	}
	)
	
	

	function npc:spawn(...)
		local args = {...}
		local wantedpos = {x=0, y=0, z=0}
		if #args == 1 then
			--using pos
			local pos = args[1]
			wantedpos = pos
			npc.Events.OnSpawn:fire(pos)
		elseif #args >= 3 then
			--use x, y, z
			local x, y, z = args[1], args[2], args[3]
			wantedpos = {x = x, y = y, z = z}
			npc.Events.OnSpawn:fire(pos)
		else
			error("Invalid arguments, npc:spawn(pos) or npc:spawn(x,y,z)")
			return nil
		end
		local obj = minetest.add_entity(wantedpos, npcname)
		
		return obj:get_luaentity()
	end
	
	
	
	--for creating new events
	--usage: event.EventName:connect(FiredFunction)
	--event.EventName:fire(...) will throw the event with the arguments you specify
	npc.Events = {}
	npc.Events.OnSpawn = createEvent()
	npc.Events.OnDied = createEvent()
	npc.Events.OnUpdate = createEvent()
	npc.Events.OnSave = createEvent()
	npc.Events.OnLoad = createEvent()
	
	table.insert(NPCEngine.Data.objects, npc)
	
	return npc
end



minetest.NPC = NPCEngine