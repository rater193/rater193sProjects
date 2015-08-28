
_G.rater193.battletowers.npcs = {}


--test npc
local npcTest = minetest.NPC:new("battletowers_npcs:test", "NPCBasic.b3d", "battletowers_npcs_skin_trader.png")

npcTest.Events.OnSpawn:connect(function()
	print("FIRED FROM CUSTOM FUNCTION :D")
end)

npcTest.Events.OnSpawn:connect(function()
	print("it works with multiple events :)")
end)


_G.rater193.battletowers.npcs.testnpc = npcTest
