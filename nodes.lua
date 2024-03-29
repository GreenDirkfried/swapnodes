local S = swapnodes.S
local register_node = swapnodes.register_node

function swapnodes.register_falling_node(material, material_sound)
	--swap node falling
	register_node("swapnodes:" .. material .. "_falling", {
		description = S("swap" .. material .. " falling"),
		tiles = {"default_" .. material .. ".png"},
		groups = {falling_node = 1},
		sounds = material_sound,
	  on_timer = function(pos, elapsed)
	    			minetest.remove_node(pos)
	  end,
	  on_construct = function(pos)
	  			minetest.get_node_timer(pos):start(4)
	  			minetest.check_for_falling(pos)
	  end,
	})
	--swap node
	register_node("swapnodes:" .. material, {
		description = S("swap" .. material),
		tiles = {"default_" .. material .. ".png"},
		sounds = material_sound,
	  on_punch = function(pos)
					--if puncher:get_wielded_item():get_name() == "default:torch" then
						minetest.swap_node(pos,{name="swapnodes:" .. material .. "_falling"})
	          minetest.registered_nodes["swapnodes:" .. material .. "_falling"].on_construct(pos)
					--end
		end,
	})
	if minetest.get_modpath("mesecons_mvps") then
		mesecon.register_mvps_stopper("swapnodes:" .. material)
		mesecon.register_mvps_stopper("swapnodes:" .. material .. "_falling")
	end
end

swapnodes.register_falling_node("sand", default.node_sound_sand_defaults())
swapnodes.register_falling_node("desert_sand", default.node_sound_sand_defaults())
swapnodes.register_falling_node("silver_sand", default.node_sound_sand_defaults())
swapnodes.register_falling_node("gravel", default.node_sound_gravel_defaults())
