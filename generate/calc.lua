#!/usr/bin/lua

-- This script parses the vanilla reactors to generate the
-- progression the power and cost should have per S utility slot.
--
-- The reason I made a script for it instead of simply calculating it
-- once is because I presume they'll tweak the values quite a few times.



-- copy+paste from common/component_templates/00_utilities_reactors.txt
local reactors = [[
	#############
	#	POWER	#
	#############

	@corvette_power_1 = 75
	@corvette_power_2 = 100
	@corvette_power_3 = 130
	@corvette_power_4 = 170
	@corvette_power_5 = 220
	@corvette_power_6 = 285

	@destroyer_power_1 = 140
	@destroyer_power_2 = 180
	@destroyer_power_3 = 240
	@destroyer_power_4 = 320
	@destroyer_power_5 = 430
	@destroyer_power_6 = 550

	@cruiser_power_1 = 280
	@cruiser_power_2 = 360
	@cruiser_power_3 = 480
	@cruiser_power_4 = 620
	@cruiser_power_5 = 800
	@cruiser_power_6 = 1030

	@battleship_power_1 = 550
	@battleship_power_2 = 720
	@battleship_power_3 = 950
	@battleship_power_4 = 1250
	@battleship_power_5 = 1550
	@battleship_power_6 = 2000

	@titan_power_1 = 1100
	@titan_power_2 = 1450
	@titan_power_3 = 1900
	@titan_power_4 = 2500
	@titan_power_5 = 3200
	@titan_power_6 = 4200

	@colossus_power = 10000

	@starbase_power = 10000

	@platform_power_1 = 200
	@platform_power_2 = 260
	@platform_power_3 = 340
	@platform_power_4 = 440
	@platform_power_5 = 575
	@platform_power_6 = 750

	#############
	#	COST	#
	#############

	@corvette_cost_1 = 20
	@corvette_cost_2 = 25
	@corvette_cost_3 = 30
	@corvette_cost_4 = 35
	@corvette_cost_5 = 40
	@corvette_cost_6 = 45

	@destroyer_cost_1 = 40
	@destroyer_cost_2 = 50
	@destroyer_cost_3 = 60
	@destroyer_cost_4 = 70
	@destroyer_cost_5 = 80
	@destroyer_cost_6 = 90

	@cruiser_cost_1 = 100
	@cruiser_cost_2 = 130
	@cruiser_cost_3 = 160
	@cruiser_cost_4 = 190
	@cruiser_cost_5 = 220
	@cruiser_cost_6 = 250

	@battleship_cost_1 = 200
	@battleship_cost_2 = 260
	@battleship_cost_3 = 320
	@battleship_cost_4 = 380
	@battleship_cost_5 = 440
	@battleship_cost_6 = 500

	@titan_cost_1 = 400
	@titan_cost_2 = 450
	@titan_cost_3 = 500
	@titan_cost_4 = 550
	@titan_cost_5 = 1054
	@titan_cost_6 = 1370

	@colossus_cost_1 = 0

	@platform_cost_1 = 40
	@platform_cost_2 = 50
	@platform_cost_3 = 60
	@platform_cost_4 = 70
	@platform_cost_5 = 80
	@platform_cost_6 = 90

]]

-- S M L utility slots total per hull
local ships = {
	corvette = {3, 0, 0},
	destroyer = {6, 0, 0},
	cruiser = {0, 6, 0},
	battleship = {0, 0, 6},
	-- We disregard the titan entirely, because their numbers are completely
	-- fucked up for it currently. Cost per power for reactor level 5 and 6
	-- are higher than for level 4, for example. So there's no natural
	-- progression.
	--titan = {0, 0, 12},
}
local NUM_VANILLA_HULLS = 4


-- Power/ Cost  = Cost per power
-- 10   / 5     = 2       - Fission
-- 15   / 10    = 1.5     - Fusion
-- 20   / 15    = 1.3333  - Cold Fusion
-- 25   / 20    = 1.25    - Antimatter
-- 30   / 25    = 1.2     - Zero Point

local costPerPower = {}
local powerPerSmallSlot = {}

-- @corvette_power_1 = 75
-- @corvette_power_2 = 100
-- @corvette_power_3 = 130
-- @corvette_power_4 = 170
-- @corvette_power_5 = 220
-- @corvette_power_6 = 285
-- @corvette_cost_1 = 20
-- @corvette_cost_2 = 25
-- @corvette_cost_3 = 30
-- @corvette_cost_4 = 35
-- @corvette_cost_5 = 40
-- @corvette_cost_6 = 45

local powerTemplate = "@%s_power_%d = (%%d+)"
local costTemplate = "@%s_cost_%d = (%%d+)"

for ship, slots in next, ships do
	local small = slots[1] + (slots[2] * 2) + (slots[3] * 4)
	local power = {}
	local cost = {}

	for i = 1, 6 do
		local p = reactors:match(powerTemplate:format(ship, i))
		local c = reactors:match(costTemplate:format(ship, i))
		table.insert(power, p)
		table.insert(cost, c)
	end
	local cpp = {}
	for i = 1, 6 do table.insert(cpp, cost[i] / power[i]) end
	local ppss = {}
	for i = 1, 6 do table.insert(ppss, power[i] / small) end

	costPerPower[ship] = cpp
	powerPerSmallSlot[ship] = ppss
end

-- So, from running the above code for Stellaris 2.0, it's immediately obvious
-- that the values are different from hull to hull, and also that progressions
-- are different depending on the hull type.
-- Uncomment the below code to see for yourself:
-- local s = require("serpent")
-- print("COST PER POWER")
-- print(s.block(costPerPower))
-- print("POWER PER SMALL SLOT")
-- print(s.block(powerPerSmallSlot))

-- Which means that we need to generate an average progression for
-- both CPP and PPSS.
-- I think, without really having thought it through, that the best way
-- to calculate that in a way that can progress beyond the vanilla reactor
-- levels, is to summarize the totals for levels 1 and 6, and calculate
-- a progression based on those.

do
	local cppTotals = {}
	for _, data in pairs(costPerPower) do
		for i = 1, 6 do cppTotals[i] = (cppTotals[i] or 0) + data[i] end
	end
	local cppAverages = {}
	for i = 1, 6 do cppAverages[i] = cppTotals[i] / NUM_VANILLA_HULLS end

	local step = (cppAverages[1] - cppAverages[6]) / 5
	local base = cppAverages[1]
	print("COST PER POWER PER REACTOR LEVEL")
	print("local _cpp = {")
	for i = 0, 11 do
		print("\t" .. base - (step*i) .. ",")
	end
	print("}")
end

-- gaaaah the power per small slot numbers are absolutely insane in vanilla 2.0
-- REACTOR 1   2   3   4   5   6
-- Corv    25, 33, 43, 57, 73, 95
-- Dest    23, 30, 40, 53, 72, 92
-- Crus    23, 30, 40, 52, 67, 86
-- BS      23, 30, 40, 52, 65, 83
-- Titan   23, 30, 40, 52, 67, 86
-- (the above numbers are rounded to nearest integer)
--
-- Note that there is a perfectly reasonable explanation for this:
-- TLDR Pre-2.0, 1L=2M=4S. That's no longer true.
--
-- 1 LARGE utility slot no longer has the same value as 4 SMALL slots, and
-- 1 MEDIUM slot no longer has the same value as 2 SMALL slots.
-- Now, 1 MEDIUM slot has 2xSMALL + X value, and 1 LARGE has 4xSMALL + X.
-- I am not sure of the value of X, and I can't be bothered to find out,
-- since this mod generates all values from S slots anyway at the moment.

do
	local ppssTotals = {}
	for _, data in pairs(powerPerSmallSlot) do
		for i = 1, 6 do ppssTotals[i] = (ppssTotals[i] or 0) + data[i] end
	end
	local ppssAverages = {}
	for i = 1, 6 do ppssAverages[i] = ppssTotals[i] / NUM_VANILLA_HULLS end

	local step = (ppssAverages[1] - ppssAverages[6]) / 5
	local base = ppssAverages[1]
	print("POWER PER SMALL SLOT")
	print("local _ppss = {")
	for i = 0, 11 do
		print("\t" .. base - (step*i) .. ",")
	end
	print("}")

--	local s = require("serpent")
--	print(s.block(ppssAverages))
end

