-- ```Vanilla
-- Power/ Cost  = Cost per power
-- 10   / 5     = 2       - Fission
-- 15   / 10    = 1.5     - Fusion
-- 20   / 15    = 1.3333  - Cold Fusion
-- 25   / 20    = 1.25    - Antimatter
-- 30   / 25    = 1.2     - Zero Point
-- ```

-- DOCUMENTATION
-- power
-- Power output of a SMALL version of the reactor utility component.
--
-- cost
-- Mineral cost of a SMALL version of the reactor utility component.
--
-- tech
-- technology used to unlock the reactor components.
-- This only supports one tech for now.
--
-- icons
-- Same GFX reference you use in the utility component.
--
-- name
-- Either just a string that will be used for all languages,
-- or a table where the key is the language, and the value
-- is the name for that language.
--

return {
	{
		power = 10,
		cost = 5,
		tech = "tech_powah_1",
		icons = "GFX_ship_part_reactor_1",
		name = {
			english = "Fission Station",
			--braz_por = "Reator de Fissão",
		}
	},
	{
		power = 15,
		cost = 10,
		tech = "tech_powah_2",
		icons = "GFX_ship_part_reactor_2",
		name = "Fusion Station",
	},
	{
		power = 20,
		cost = 15,
		tech = "tech_powah_3",
		icons = "GFX_ship_part_reactor_3",
		name = "Cold Fusion Station",
	},
	{
		power = 25,
		cost = 20,
		tech = "tech_powah_4",
		icons = "GFX_ship_part_reactor_4",
		name = "Antimatter Station",
	},
	{
		power = 30,
		cost = 25,
		tech = "tech_powah_5",
		icons = "GFX_ship_part_reactor_5",
		name = "Zero Point Station",
	},
	{
		power = 35,
		cost = 30,
		tech = "tech_powah_6",
		icons = "GFX_ship_part_enigmatic_power_core",
		name = "Enigmatic Station",
	},
}
