#!/usr/bin/lua

-- ```NSC
-- Power/ Cost  = Cost per power
-- 35   / 11.7  = 2.9914   - Gravitron
-- 40   / 12.5  = 3.2000   - Dark Matter
-- 45   / 13.2  = 3.4090   - etc
-- 50   / 13.9  = 3.5971
-- 55   / 14.5  = 3.7931
-- 60   / 15    = 4.0000
-- ```

-- ```Vanilla
-- Power/ Cost  = Cost per power
-- 10   / 5     = 2       - Fission
-- 15   / 10    = 1.5     - Fusion
-- 20   / 15    = 1.3333  - Cold Fusion
-- 25   / 20    = 1.25    - Antimatter
-- 30   / 25    = 1.2     - Zero Point
-- ```

-- ```TFW
-- Power/ Cost  = Power per mineral
-- 35   / 30    = 1.1666  -- s6      Energon
-- 40   / 35    = 1.1428  -- s7      Antimatter Fusion
-- 45   / 40    = 1.125   -- s8      Dark Matter
-- 50   / 45    = 1.111   -- s9      Opt. Dark Matter
-- 60   / 55    = 1.0909  -- s10     Singularity
-- 70   / 65    = 1.0769  -- s11     Trisingularity
-- 70   / 50    = 1.4     -- s11bio  Bio Reactor I
-- 75   / 75    = 1       -- s11psi  Psi Cell
-- 80   / 90    = 0.8888  -- s11synt Tachyon
-- 80   / 70    = 1.1428  -- s12bio  Bio Reactor II
-- 90   / 120   = 0.75    -- s12synt WIMP Extractor
-- ```

-- 10.3 / 12.1 = X


local outputPath = "../common/component_templates/"
local emptyfile = "util_powah_1.txt"

-- XXX Note that the script doesnt touch
-- localisation files. Make sure they are updated.
local unsortedData = {
	{
		power = 10,
		cost = 2,
		tech = "tech_powah_1",
		icons = "GFX_ship_part_reactor_1",
		name = "Fission Station",
	},
	{
		power = 15,
		cost = 1.5,
		tech = "tech_powah_2",
		icons = "GFX_ship_part_reactor_2",
		name = "Fusion Station",
	},
	{
		power = 20,
		cost = 1.33,
		tech = "tech_powah_3",
		icons = "GFX_ship_part_reactor_3",
		name = "Cold Fusion Station",
	},
	{
		power = 25,
		cost = 1.25,
		tech = "tech_powah_4",
		icons = "GFX_ship_part_reactor_4",
		name = "Antimatter Station",
	},
	{
		power = 30,
		cost = 1.2,
		tech = "tech_powah_5",
		icons = "GFX_ship_part_reactor_5",
		name = "Zero Point Station",
	},
	{
		power = 35,
		cost = 1.166,
		tech = "tech_powah_6",
		icons = "GFX_ship_part_enigmatic_power_core",
		name = "Enigmatic Station",
	},
	{ -- nhunter: t6
		power = 35,
		cost = 1.166,
		tech = "nhsc_tech_advzeropointreactor_1_fake",
		icons = "GFX_ship_part_reactor_nhsc_6",
		name = "Imp. Zero Point Station",
	},
	{ -- nhunter: t7
		power = 45,
		cost = 1.125,
		tech = "nhsc_tech_advzeropointreactor_2_fake",
		icons = "GFX_ship_part_reactor_nhsc_7",
		name = "Singularity Station",
	},
	{ -- nhunter: t7.5
		power = 50,
		cost = 1.111,
		tech = "nhsc_tech_enigmatic_power_2_fake",
		icons = "GFX_ship_part_nhsc_enigmatic_core_2",
		name = "Imp. Enigmatic Station",
	},
	{ -- nhunter: t8
		power = 55,
		cost = 1.1,
		tech = "nhsc_tech_advzeropointreactor_3_fake",
		icons = "GFX_ship_part_reactor_nhsc_8",
		name = "Imp. Singularity Station",
	},
	{ -- TFW s6
		power = 35,
		cost = 1.1666, -- 30
		tech = "tech_fusion_power_energon",
		icons = "GFX_ship_part_reactor_r6",
		name = "Energon Station",
	},
	{ -- TFW s7
		power = 40,
		cost = 1.1428, -- 35
		tech = "tech_antimatter_power_optimized",
		icons = "GFX_ship_part_reactor_r7",
		name = "Antimatter Fusion Station",
	},
	{ -- TFW s8
		power = 45,
		cost = 1.125, -- 40
		tech = "tech_darkmatter_power",
		icons = "GFX_ship_part_reactor_r8",
		name = "Dark Matter Station",
	},
	{ -- TFW s9
		power = 50,
		cost = 1.111, -- 45
		tech = "tech_darkmatter_power_optimized",
		icons = "GFX_ship_part_reactor_r9",
		name = "Optimized Dark Matter Station",
	},
	{ -- TFW S10
		power = 60,
		cost = 1.0909, -- 55
		tech = "tech_singularity_power",
		icons = "GFX_ship_part_reactor_r10",
		name = "Singularity Station",
	},
	{ -- TFW s11
		power = 70,
		cost = 1.0769, -- 65
		tech = "tech_singularity_power_opt",
		icons = "GFX_ship_part_reactor_r10st",
		name = "Trisingularity Station",
	},
	{ -- TFW S11bio
		power = 70,
		cost = 1.400, -- 50
		tech = "tech_bio_power_1",
		icons = "GFX_ship_part_bioreactor_1",
		name = "Bio Station I",
	},
	{ -- TFW s11psi
		power = 75,
		cost = 1, -- 75
		tech = "tech_psi_power_1",
		icons = "GFX_ship_part_reactor_psi1",
		name = "Psi Network Station",
	},
	{ -- TFW s11synt
		power = 80,
		cost = 0.8888, -- 90
		tech = "tech_tachyon_power",
		icons = "GFX_ship_part_reactor_r11",
		name = "Tachyon Station",
	},
	{ -- TFW s12bio
		power = 80,
		cost = 1.1428, -- 70
		tech = "tech_bio_power_2",
		icons = "GFX_ship_part_bioreactor_2",
		name = "Bio Station II",
	},
	{ -- TFW s12synt
		power = 90,
		cost = 0.7500, -- 120
		tech = "tech_wimp_power",
		icons = "GFX_ship_part_reactor_r12",
		name = "WIMP-Extractor Station",
	},
	{ -- NSC
		power = 35,
		cost = 2.9914,
		tech = "tech_graviton_power_fake",
		icons = "GFX_ship_part_reactor_6_NSC",
		name = "Graviton Station",
	},
	{ -- NSC
		power = 40,
		cost = 3.2,
		tech = "tech_dark_matter_power_fake",
		icons = "GFX_ship_part_reactor_7_NSC",
		name = "Dark Matter Station",
	},
	{ -- NSC
		power = 45,
		cost = 3.4090,
		tech = "tech_adv_zero_point_power_fake",
		icons = "GFX_ship_part_reactor_8_NSC",
		name = "Singularity Station",
	},
	{ -- NSC
		power = 50,
		cost = 3.5971,
		tech = "tech_multidimensional_power_fake",
		icons = "GFX_ship_part_reactor_9_NSC",
		name = "Multidimensional Station",
	},
	{ -- NSC
		power = 55,
		cost = 3.7931,
		tech = "tech_nsc_zero_point_power_fake",
		icons = "GFX_ship_part_reactor_10_NSC",
		name = "Zero Point Station",
	},
	{ -- NSC
		power = 60,
		cost = 4,
		tech = "tech_optimized_enigmatic_power_fake",
		icons = "GFX_ship_part_reactor_11_enigmatic_NSC",
		name = "Optimized Enigmatic Station"
	}
}
table.sort(unsortedData, function(a, b)
	if a.power == b.power then return a.cost < b.cost end
	return a.power < b.power
end)
local poweroutput = {}
local cost = {}
local tech = {}
local icons = {}

for _, data in next, unsortedData do
	poweroutput[#poweroutput+1] = data.power
	cost[#cost + 1] = data.cost
	tech[#tech + 1] = data.tech
	icons[#icons + 1] = data.icons
end

local reactorSets = {
	{
		utility = 7,
		size = "corvette neo_MS_scout neo_MS_1 neo_MS_2 neo_MS_3 neo_MS_4 neo_MS_5 zeon_MS_scout zeon_MS_1 zeon_MS_2 zeon_MS_3 zeon_MS_4 zeon_MS_5 zeon_MS_P axis_MS_scout axis_MS_1 axis_MS_2 axis_MS_3 axis_MS_4 axis_MS_5 ball gm",
		file = "util_powah_2_corvette.txt",
	},
	{
		utility = 10,
		size = "destroyer Frigate cofh_se_corvette_hvy",
		file = "util_powah_3_destroyer.txt",
	},
	{
		utility = 14,
		size = "cofh_se_auxiliary_tender overload_mobile_station_small cofh_se_destroyer_hvy cofh_se_corvette_sup cofh_se_destroyer_sup military_station_small Drydock st_light_cruiser_01 st_light_Int_01 st_R_light_Int_01 st_Rebel_01_Escort st_Empire_01_Escort st_R_light_cruiser",
		file = "util_powah_6_station.txt",
	},
	{
		utility = 24,
		size = "cruiser rs_support_cruiser rs_ea_cruiser st_R_Carrier_01 st_R_Cruiser_02 st_R_Cruiser_01 LightCarrier st_Carrier_01 st_Cruiser_01 st_Cruiser_02",
		file = "util_powah_4_cruiser.txt",
	},
	{
		utility = 28,
		size = "military_station_medium st_E_Battlecruiser Battlecruiser st_R_N_Battlecruiser",
		file = "util_powah_6_station.txt",
	},
	{
		utility = 36,
		size = "overload_mobile_station_medium cofh_se_cruiser_sup cofh_se_cruiser_hvy st_heavy_Sup_01 StrikeCruiser galleon rs_battlecruiser st_heavy_Int_01 st_battleship_01 st_R_battleship_01",
		file = "util_powah_7_realships.txt",
	},
	{
		utility = 40,
		size = "battleship Carrier st_battleship_02 st_R_battleship_02 white_base",
		file = "util_powah_5_battleship.txt",
	},
	{
		utility = 56,
		size = "military_station_large overload_mobile_station_large zhow_carrier SCX_Carrier",
		file = "util_powah_6_station.txt",
	},
	{
		utility = 60,
		size = "leviathan cofh_se_battleship_hvy cofh_se_battleship_sup st_dreadnought_01 st_R_dreadnought",
		file = "util_powah_9_isbs.txt",
	},
	{
		utility = 64,
		size = "rs_dreadnought SCX_Dreadnought",
		file = "util_powah_7_realships.txt",
	},
	{
		utility = 72,
		size = "titan Dreadnought",
		file = "util_powah_9_isbs.txt",
	},
	{
		utility = 76,
		size = "rs_heavy_dreadnought rs_heavy_dreadnought_type_a rs_heavy_dreadnought_type_b rs_heavy_dreadnought_type_c rs_heavy_dreadnought_type_d rs_heavy_dreadnought_type_e rs_heavy_dreadnought_type_f rs_heavy_dreadnought_type_g",
		file = "util_powah_7_realships.txt",
	},
	{
		utility = 84,
		size = "Superdreadnought SCX_Superdreadnought Headquarters military_station_xlarge st_SSD st_R_SSD sr_R_SSD st_resurgent_01",
		file = "util_powah_8_nsc.txt",
	},
	{
		utility = 120,
		size = "Flagship",
		file = "util_powah_8_nsc.txt",
	},
}
for _, entry in next, reactorSets do
	local tokens = {}
	for tk in entry.size:gmatch("%S+") do tokens[tk] = true end
	entry.tokens = tokens
end

do
	local actualShipComponents = {
		-- Vanilla
		corvette                     = { 3, 2, 0 },
		destroyer                    = { 4, 3, 0 },
		cruiser                      = { 0, 6, 3 },
		battleship                   = { 0, 0, 10 },
		military_station_small       = { 2, 2, 2 },
		military_station_medium      = { 4, 4, 4 },
		military_station_large       = { 8, 8, 8 },

		galleon                      = { 0, 6, 6 },

		-- Stellaris Remake
		zhow_carrier                 = { 0, 0, 12 },

		-- NSC
		Frigate                      = { 4, 3, 0 },
		Battlecruiser                = { 0, 5, 5 },
		LightCarrier                 = { 4, 4, 2 },
		StrikeCruiser                = { 6, 4, 5 },
		Carrier                      = { 6, 5, 6 },
		Flagship                     = { 0, 4, 28 },
		military_station_xlarge      = { 12, 12, 12 },
		Dreadnought                  = { 0, 4, 16 },
		Superdreadnought             = { 0, 4, 20 },
		Headquarters                 = { 12, 12, 12 },
		Drydock                      = { 0, 4, 2 },

		-- Realships
		rs_support_cruiser           = { 0, 6, 3 },
		rs_ea_cruiser                = { 0, 6, 3 },
		rs_battlecruiser             = { 0, 6, 6 },
		rs_dreadnought               = { 0, 0, 16 },
		rs_heavy_dreadnought_type_a  = { 0, 0, 19 },

		-- ISBS
		titan                        = { 0, 0, 18 },
		leviathan                    = { 0, 0, 15 },

		-- Star Wars Empire ships by Elratie
		st_Empire_01_Escort          = { 0, 2, 2 },
		st_light_cruiser_01          = { 0, 4, 2 },
		st_light_Int_01              = { 0, 5, 2 },
		st_Cruiser_01                = { 0, 6, 2 },
		st_Cruiser_02                = { 0, 6, 2 },
		st_Carrier_01                = { 0, 6, 2 },
		st_E_Battlecruiser           = { 0, 9, 3 },
		st_heavy_Int_01              = { 0, 10, 4 },
		st_battleship_01             = { 0, 6, 6 },
		st_battleship_02             = { 0, 9, 6 },
		st_dreadnought_01            = { 0, 11, 9 },
		st_SSD                       = { 0, 18, 14 },

		-- Star Wars Rebel ships
		st_Rebel_01_Escort           = { 0, 2, 2 },
		st_R_light_cruiser           = { 0, 4, 2 },
		st_R_light_Int_01            = { 0, 5, 2 },
		st_R_Cruiser_01              = { 0, 6, 2 },
		st_R_Cruiser_02              = { 0, 6, 2 },
		st_R_Carrier_01              = { 0, 6, 2 },
		st_R_N_Battlecruiser         = { 0, 9, 3 },
		st_heavy_Sup_01              = { 0, 10, 4 },
		st_R_battleship_01           = { 0, 6, 6 },
		st_R_battleship_02           = { 0, 9, 6 },
		st_R_dreadnought             = { 0, 11, 9 },
		st_R_SSD                     = { 0, 18, 14 },

		-- Stellar Expansion: Voidcraft
		cofh_se_corvette_hvy         = { 0, 5, 0 },
		cofh_se_corvette_sup         = { 0, 4, 1 },
		cofh_se_destroyer_hvy        = { 0, 8, 0 },
		cofh_se_destroyer_sup        = { 0, 8, 0 },
		cofh_se_cruiser_hvy          = { 0, 6, 6 },
		cofh_se_cruiser_sup          = { 0, 6, 6 },
		cofh_se_battleship_hvy       = { 0, 0, 15 },
		cofh_se_battleship_sup       = { 0, 0, 15 },
		cofh_se_auxiliary_tender     = { 0, 3, 2 },

		-- Psicopro Overload
		overload_mobile_station_small      = { 2, 4, 2 },
		overload_mobile_station_medium     = { 4, 8, 4 },
		overload_mobile_station_large      = { 8, 8, 8 },

		-- Necro991, I don't know which mod it is
		neo_MS_scout                  = { 3, 2, 0 },
		neo_MS_1                      = { 3, 2, 0 },
		neo_MS_2                      = { 3, 2, 0 },
		neo_MS_3                      = { 3, 2, 0 },
		neo_MS_4                      = { 3, 2, 0 },
		neo_MS_5                      = { 3, 2, 0 },
		zeon_MS_scout                 = { 3, 2, 0 },
		zeon_MS_1                     = { 3, 2, 0 },
		zeon_MS_2                     = { 3, 2, 0 },
		zeon_MS_3                     = { 3, 2, 0 },
		zeon_MS_4                     = { 3, 2, 0 },
		zeon_MS_5                     = { 3, 2, 0 },
		zeon_MS_P                     = { 3, 2, 0 },
		axis_MS_scout                 = { 3, 2, 0 },
		axis_MS_1                     = { 3, 2, 0 },
		axis_MS_2                     = { 3, 2, 0 },
		axis_MS_3                     = { 3, 2, 0 },
		axis_MS_4                     = { 3, 2, 0 },
		axis_MS_5                     = { 3, 2, 0 },
		ball                          = { 3, 2, 0 },
		gm                            = { 3, 2, 0 },
		white_base                    = { 0, 0, 10 },

		-- http://steamcommunity.com/sharedfiles/filedetails/?id=932208450
		st_resurgent_01              = { 0, 16, 17 },

		SCX_Carrier                  = { 0, 8, 8 },
		SCX_Dreadnought              = { 0, 0, 16 },
		SCX_Superdreadnought         = { 0, 0, 20 },
	}
	actualShipComponents.rs_heavy_dreadnought_type_b = actualShipComponents.rs_heavy_dreadnought_type_a
	actualShipComponents.rs_heavy_dreadnought_type_c = actualShipComponents.rs_heavy_dreadnought_type_a
	actualShipComponents.rs_heavy_dreadnought_type_d = actualShipComponents.rs_heavy_dreadnought_type_a
	actualShipComponents.rs_heavy_dreadnought_type_e = actualShipComponents.rs_heavy_dreadnought_type_a
	actualShipComponents.rs_heavy_dreadnought_type_f = actualShipComponents.rs_heavy_dreadnought_type_a
	actualShipComponents.rs_heavy_dreadnought_type_g = actualShipComponents.rs_heavy_dreadnought_type_a
	actualShipComponents.rs_heavy_dreadnought = actualShipComponents.rs_heavy_dreadnought_type_a

	local numSmall = {}
	for k, slots in pairs(actualShipComponents) do
		local s = slots[1] + (slots[2] * 2) + (slots[3] * 4)
		numSmall[k] = s
	end
	-- Print analysis
	for ship, slots in pairs(numSmall) do
		local assignedSlots
		for _, entry in next, reactorSets do
			if entry.tokens[ship] then
				assignedSlots = entry.utility
				break
			end
		end
		if type(assignedSlots) ~= "number" then
			print(ship .. " not found, should have " .. tostring(slots) .. "s")
			local best = 0
			local lowestDiff = nil
			for _, entry in next, reactorSets do
				local difference = math.abs(slots - entry.utility)
				if (lowestDiff == nil or (difference < lowestDiff)) and (entry.utility >= slots) then
					best = entry.utility
					lowestDiff = difference
				end
			end
			print("  ! The set " .. tostring(best) .. "s seems the best fit\n")
		else
			if slots ~= assignedSlots then
				print(ship .. " should have " .. tostring(slots) .. "s, but has " .. tostring(assignedSlots))
				local difference = math.abs(slots - assignedSlots)
				for _, entry in next, reactorSets do
					if (math.abs(entry.utility - slots) < difference) then -- and (entry.utility >= slots)
						print("  ! The set " .. tostring(entry.utility) .. "s seems closer\n")
						break
					end
				end
			end
		end
	end
end

do
	local verifySizes = {}
	local verifySlots = {}
	for _, entry in next, reactorSets do
		-- Verify that sizes set in this set dont exist in any previous ones
		for s in pairs(entry.tokens) do
			if verifySizes[s] then
				print(s .. " SIZE from the " .. tostring(entry.utility) .. " set already exists, please review settings. Exiting.")
				os.exit()
			end
			verifySizes[s] = true
		end

		-- Verify that it's a unique utility-slot size
		if verifySlots[entry.utility] then
			print(entry.utility .. " set already exists, please review settings. Exiting.")
		else
			verifySlots[entry.utility] = true
		end
	end
end

-- Read in the templates
local emptyTmpl = [[
utility_component_template = {
	key = "POWAH_REACTOR_EMPTY"
	size = small
	icon = "GFX_ship_part_empty_ftl_drive"
	icon_frame = 1
	power = 0
	cost = 0
	should_ai_use = no
	component_set = "powerstation_components"
}
]]
local entryTmpl = [[
utility_component_template = {
	key = "POWAH_REACTOR_[key]_[index]"
	size = small
	icon = "[icon]"
	icon_frame = 1
	cost = [cost]
	power = [power]
	ai_weight = { weight = [index] }
	size_restriction = { [size] }
	prerequisites = { "[tech]" }
	component_set = "powerstation_components"
}
]]

-- Delete all files
os.remove(outputPath .. emptyfile)
for _, entry in pairs(reactorSets) do
	os.remove(outputPath .. entry.file)
end

local function calculatePower(slots, level)
	local r = math.ceil((slots * poweroutput[level]) / 2)
	local m = r % 5
	if m == 0 then return r end
	return r + 5 - m
end
local function calculateCost(power, level)
	local r = math.floor(power / cost[level])
	local m = r % 5
	if m == 0 then return r end
	return r - 5 - m
end

do
	local f = io.open(outputPath .. emptyfile, "a+")
	f:write(emptyTmpl)
	f:close()
end

for _, entry in next, reactorSets do
	do
		local f = io.open(outputPath .. entry.file, "a+")
		for count in next, poweroutput do
			local comp = entryTmpl
			local power = calculatePower(entry.utility, count)
			local entryCost = calculateCost(power, count)

			comp = comp:gsub("%[key%]", entry.utility)
			comp = comp:gsub("%[index%]", count)
			comp = comp:gsub("%[icon%]", icons[count])
			comp = comp:gsub("%[tech%]", tech[count])
			comp = comp:gsub("%[cost%]", entryCost)
			comp = comp:gsub("%[power%]", power)
			if type(entry.size) == "string" then
				comp = comp:gsub("%[size%]", entry.size)
			else
				comp = comp:gsub("\tsize_restriction %= %{ %[size%] %}\n", "")
			end
			--comp = comp:gsub("%[set%]", entry.set)

			f:write(comp)
			f:flush()
		end
		f:close()
	end
end


do
	local defaults = {}
	for _, data in next, unsortedData do
		defaults[#defaults+1] = data.name
	end
	local language = { mt = { __index = function(_, k) return defaults[k] end } }
	function language.new(t)
		setmetatable(t, language.mt)
		return t
	end

	local LANGUAGES = {
		language.new({}), -- First must always be english
		--language.new({
			--"Extracto de tachyonoz plz"
		--})
	}

	--do
		-- XXX verify that a language has the right number of keys
	--end

	--local keyprefix -- "POWAH_REACTOR_[key]"
	--local output = ""
	local blockTmpl = ""
	for i in next, poweroutput do
		blockTmpl = blockTmpl .. "[key]_" .. i .. ": \"[" .. i .. "]\"\n"
	end
	blockTmpl = blockTmpl .. "\n"

	--local languageRoot
	-- XXX ye ye we should just edit the localization files directly.
	local f = io.open("copyfromme.yml", "w+")
	for _, trans in next, LANGUAGES do

		-- This holds the block with [id] set to
		-- the first set
		local subBlock = blockTmpl

		for _, entry in next, reactorSets do
			local prefix = "POWAH_REACTOR_" .. entry.utility
			local root = subBlock
			root = root:gsub("%[key%]", prefix)
			for count in next, poweroutput do
				root = root:gsub("%[" .. count  .. "%]", trans[count])
			end
			f:write(root)
		end
		f:flush()
	end
	f:close()

end
