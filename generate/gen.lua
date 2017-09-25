#!/usr/bin/lua

-- If you are here to add support for your reactor mod, please
-- make a new file that contains your reactor data and add it below.
local suppliers = {
	"reactors.vanilla",
	"reactors.nsc",
	"reactors.nh-shipcomponents",
	"reactors.tfw-bosp"
}

-- If you want to add support for more ships, please
-- make a new file that contains your ship data and add it below.
local ships = {
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

local outputPath = "../common/component_templates/"
local emptyfile = "util_powah_1.txt"

-- XXX Note that the script doesnt touch
-- localisation files. Make sure they are updated.
local unsortedData = {}
for _, supplier in next, suppliers do
	local add = require(supplier)
	for _, data in next, add do
		data.cost = data.power / data.cost
		unsortedData[#unsortedData+1] = data
	end
end
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

local _sets = { 7, 10, 14, 24, 28, 36, 40, 56, 60, 64, 72, 76, 84, 120 }
local _SET_FILENAME = "util_powah_%d.txt"

local _ships = {}
do
	for _, id in next, ships do
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
	--print(#sortedIdeals)
	--print(table.concat(max, ", "))
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
	local f = io.open(outputPath .. emptyfile, "w+")
	f:write(emptyTmpl)
	f:close()
end

-- Delete all files
for _, set in next, _sets do
	os.remove(outputPath .. _SET_FILENAME:format(set))
end

for _, set in next, _sets do
	do
		local f = io.open(outputPath .. _SET_FILENAME:format(set), "a+")
		for count in next, poweroutput do
			local comp = entryTmpl
			local power = calculatePower(set, count)
			local entryCost = calculateCost(power, count)

			comp = comp:gsub("%[key%]", set)
			comp = comp:gsub("%[index%]", count)
			comp = comp:gsub("%[icon%]", icons[count])
			comp = comp:gsub("%[tech%]", tech[count])
			comp = comp:gsub("%[cost%]", entryCost)
			comp = comp:gsub("%[power%]", power)
			comp = comp:gsub("%[size%]", table.concat(_shipsPerSet[set], " "))
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

		for _, set in next, _sets do
			local prefix = "POWAH_REACTOR_" .. set
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
