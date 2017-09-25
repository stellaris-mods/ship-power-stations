
local base = {
	-- Realships
	rs_support_cruiser           = { 0, 6, 3 },
	rs_ea_cruiser                = { 0, 6, 3 },
	rs_battlecruiser             = { 0, 6, 6 },
	rs_dreadnought               = { 0, 0, 16 },
}

local hdn = { 0, 0, 19 }
local hdnIds = {
	"rs_heavy_dreadnought_type_a", "rs_heavy_dreadnought_type_b", "rs_heavy_dreadnought_type_c",
	"rs_heavy_dreadnought_type_d", "rs_heavy_dreadnought_type_e", "rs_heavy_dreadnought_type_f",
	"rs_heavy_dreadnought_type_g",
	"rs_heavy_dreadnought" -- XXX this might be only from my own local RS-fork
}
for _, id in next, hdnIds do
	base[id] = hdn
end


return base
