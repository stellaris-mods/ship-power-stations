-- ```NSC
-- Power/ Cost  = Cost per power
-- 35   / 11.7  = 2.9914   - Gravitron
-- 40   / 12.5  = 3.2000   - Dark Matter
-- 45   / 13.2  = 3.4090   - etc
-- 50   / 13.9  = 3.5971
-- 55   / 14.5  = 3.7931
-- 60   / 15    = 4.0000
-- ```

return {
	{ -- t6
		power = 35,
		cost = 30,
		tech = "nhsc_tech_advzeropointreactor_1",
		icons = "GFX_ship_part_reactor_nhsc_6",
		name = "Imp. Zero Point Station",
	},
	{ -- t7
		power = 45,
		cost = 40,
		tech = "nhsc_tech_advzeropointreactor_2",
		icons = "GFX_ship_part_reactor_nhsc_7",
		name = "Singularity Station",
	},
	{ -- t7.5
		power = 50,
		cost = 45,
		tech = "nhsc_tech_enigmatic_power_2",
		icons = "GFX_ship_part_nhsc_enigmatic_core_2",
		name = "Imp. Enigmatic Station",
	},
	{ -- t8
		power = 55,
		cost = 50,
		tech = "nhsc_tech_advzeropointreactor_3",
		icons = "GFX_ship_part_reactor_nhsc_8",
		name = "Imp. Singularity Station",
	},
}
