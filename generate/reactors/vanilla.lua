
-- DOCUMENTATION
-- level
-- The equivalent tech level for the reactor, from 1-12.
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
		level = 1,
		vanilla = true,
		tech = "tech_powah_1",
		icons = "GFX_ship_part_reactor_1",
		name = {
			english = "Fission Station",
			--braz_por = "Reator de Fissão",
		}
	},
	{
		level = 2,
		vanilla = true,
		tech = "tech_powah_2",
		icons = "GFX_ship_part_reactor_2",
		name = "Fusion Station",
	},
	{
		level = 3,
		vanilla = true,
		tech = "tech_powah_3",
		icons = "GFX_ship_part_reactor_3",
		name = "Cold Fusion Station",
	},
	{
		level = 4,
		vanilla = true,
		tech = "tech_powah_4",
		icons = "GFX_ship_part_reactor_4",
		name = "Antimatter Station",
	},
	{
		level = 5,
		vanilla = true,
		tech = "tech_powah_5",
		icons = "GFX_ship_part_reactor_5",
		name = "Zero Point Station",
	},
	{
		level = 6,
		vanilla = true,
		tech = "tech_powah_6",
		icons = "GFX_ship_part_enigmatic_power_core",
		name = "Enigmatic Station",
	},
}
