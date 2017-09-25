#!/usr/bin/lua

-- ADDING NEW POWER STATION TECHS
-- If you are here to add support for your reactor mod, please
-- make a new file that contains your reactor data and add it below.
-- The order does not matter, you can insert it anywhere.
local _REACTORS = {
	"reactors.vanilla",
	"reactors.nsc",
	"reactors.nh-shipcomponents",
	"reactors.tfw-bosp",
}

-- ADDING SUPPORT FOR NEW SHIP TYPES
-- If you want to add support for more ships, please
-- make a new file that contains your ship data and add it below.
-- The order does not matter, you can insert it anywhere.
local _SHIPS = {
	"ships.vanilla",
	"ships.isbs",
	"ships.necro991",
	"ships.nsc",
	"ships.psicopro",
	"ships.realships",
	"ships.scx",
	"ships.st-resurgent",
	"ships.stellar-expansion",
	"ships.swes",
	"ships.swrs",
	"ships.zhow",
}

-- If you came here to add support for your ships or reactors,
-- you can ignore the rest of the script below safely.
-------------------------------------------------------------------------------

local _sets = { 7, 10, 14, 24, 28, 36, 40, 56, 60, 64, 72, 76, 84, 120 }

local _PATH_COMPONENTS = "../common/component_templates/"
local _PATH_L10N = "../localisation/"
local _FILE_COMPONENTS = "util_powah_%d.txt"
local _FILE_L10N = "powah_stations_%s.yml"

local _ships = {}
do
	for _, id in next, _SHIPS do
		local add = require(id)
		for k, slots in pairs(add) do
			local s = slots[1] + (slots[2] * 2) + (slots[3] * 4)
			_ships[#_ships + 1] = { k, s }
		end
	end
	-- We use an array instead of map mostly for the print output
	table.sort(_ships, function(a, b) return a[1] < b[1] end)
end

-- Find the ideal sets
do
	local ideal = setmetatable({}, {
		__index = function(self, k) self[k] = {}; return self[k] end,
	})
	for _, data in next, _ships do
		local ship, slots = unpack(data)
		table.insert(ideal[slots], ship)
	end
	local sortedIdeals = {}
	for set, shipIds in pairs(ideal) do
		table.insert(sortedIdeals, {#shipIds, set})
	end
	table.sort(sortedIdeals, function(a, b) return b[1] < a[1] end)
	local sets = {}
	for i = 1, #_sets do sets[i] = sortedIdeals[i][2] end
	table.sort(sets)
	print("Current sets: " .. table.concat(_sets, " "))
	print("Ideal sets:   " .. table.concat(sets, " "))
end

local _shipsPerSet = {}
for _, set in next, _sets do _shipsPerSet[set] = {} end

do
	print("WANT\tGETS\tDIFFERENCE\tSHIP SIZE ID")
	local msgBest = "%d\t%d\t%d\t\t%s"
	local msgIdeal = "And %d ships found their ideal set."

	local ideal = 0
	for _, data in next, _ships do
		local ship, slots = unpack(data)
		local best = _sets[1]
		for _, set in next, _sets do
			if math.abs(slots - set) < math.abs(slots - best) then
				best = set
			end
		end
		table.insert(_shipsPerSet[best], ship)
		if (best - slots) ~= 0 then
			print(msgBest:format(slots, best, best - slots, ship))
		else
			ideal = ideal + 1
		end
	end
	if ideal ~= 0 then print(msgIdeal:format(ideal)) end
end
for _, shipIds in next, _shipsPerSet do table.sort(shipIds) end

do
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
	local f = io.open(_PATH_COMPONENTS .. "util_powah_1.txt", "w+")
	f:write(emptyTmpl)
	f:close()
end

-- Delete all files
for _, set in next, _sets do
	os.remove(_PATH_COMPONENTS .. _FILE_COMPONENTS:format(set))
end

local _reactorData = {}
do
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
	for _, supplier in next, _REACTORS do
		local add = require(supplier)
		for _, data in next, add do
			data.cost = data.power / data.cost
			_reactorData[#_reactorData+1] = data
		end
	end
	table.sort(_reactorData, function(a, b)
		if a.power == b.power then return a.cost < b.cost end
		return a.power < b.power
	end)

	local function calculatePower(slots, power)
		local r = math.ceil((slots * power) / 2)
		local m = r % 5
		if m == 0 then return r end
		return r + 5 - m
	end
	local function calculateCost(power, cost)
		local r = math.floor(power / cost)
		local m = r % 5
		if m == 0 then return r end
		return r - 5 - m
	end

	for _, set in next, _sets do
		local f = io.open(_PATH_COMPONENTS .. _FILE_COMPONENTS:format(set), "a+")
		for index, data in next, _reactorData do
			local comp = entryTmpl
			local power = calculatePower(set, data.power)
			local entryCost = calculateCost(power, data.cost)

			comp = comp:gsub("%[key%]", set)
			comp = comp:gsub("%[index%]", index)
			comp = comp:gsub("%[icon%]", data.icons)
			comp = comp:gsub("%[tech%]", data.tech)
			comp = comp:gsub("%[cost%]", entryCost)
			comp = comp:gsub("%[power%]", power)
			comp = comp:gsub("%[size%]", table.concat(_shipsPerSet[set], " "))

			f:write(comp)
			f:flush()
		end
		f:close()
	end
end

do
	local languages = {
		"english",
		"braz_por",
		"french",
		"german",
		"polish",
		"russian",
		"spanish",
	}
	local bom = string.char(0xEF) .. string.char(0xBB) .. string.char(0xBF)

	for _, lang in next, languages do
		local f = io.open(_PATH_L10N .. _FILE_L10N:format(lang), "w+")
		f:write(bom)
		f:write("l_" .. lang .. ":\n")
		for _, set in next, _sets do
			for index, data in next, _reactorData do
				f:write( ("POWAH_REACTOR_%d_%d: %q\n"):format(set, index, data.name) )
			end
			f:write("\n")
		end
		f:close()
	end
end
