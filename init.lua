swapnodes = {}

local modpath = minetest.get_modpath("swapnodes")

local S = minetest.get_translator("swapnodes")
swapnodes.S = S

swapnodes.drop_msg = function(itemstack, player)
	local name = player:get_player_name()
	minetest.chat_send_player(name, S("[swapnodes] nodes do not drop!"))
end

function swapnodes.register_node(name, def)
	def.drop = ""
	if def.groups then
		if not def.groups.dig_immediate then
			def.groups.unbreakable = 1
		end
		def.groups.not_in_creative_inventory = 1
	else
		def.groups = {unbreakable = 1, not_in_creative_inventory = 1}
	end
	def.on_drop = swapnodes.drop_msg
	def.on_blast = function() end
	minetest.register_node(name, def)
end

-- nodes
dofile(modpath .. "/nodes.lua")
