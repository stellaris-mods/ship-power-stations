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

return {
	{ -- TFW s6
		power = 35,
		cost = 30,
		tech = "tech_fusion_power_energon",
		icons = "GFX_ship_part_reactor_r6",
		name = "Energon Station",
	},
	{ -- TFW s7
		power = 40,
		cost = 35,
		tech = "tech_antimatter_power_optimized",
		icons = "GFX_ship_part_reactor_r7",
		name = "Antimatter Fusion Station",
	},
	{ -- TFW s8
		power = 45,
		cost = 40,
		tech = "tech_darkmatter_power",
		icons = "GFX_ship_part_reactor_r8",
		name = "Dark Matter Station",
	},
	{ -- TFW s9
		power = 50,
		cost = 45,
		tech = "tech_darkmatter_power_optimized",
		icons = "GFX_ship_part_reactor_r9",
		name = "Optimized Dark Matter Station",
	},
	{ -- TFW S10
		power = 60,
		cost = 55,
		tech = "tech_singularity_power",
		icons = "GFX_ship_part_reactor_r10",
		name = "Singularity Station",
	},
	{ -- TFW s11
		power = 70,
		cost = 65,
		tech = "tech_singularity_power_opt",
		icons = "GFX_ship_part_reactor_r10st",
		name = "Trisingularity Station",
	},
	{ -- TFW S11bio
		power = 70,
		cost = 50,
		tech = "tech_bio_power_1",
		icons = "GFX_ship_part_bioreactor_1",
		name = "Bio Station I",
	},
	{ -- TFW s11psi
		power = 75,
		cost = 75,
		tech = "tech_psi_power_1",
		icons = "GFX_ship_part_reactor_psi1",
		name = "Psi Network Station",
	},
	{ -- TFW s11synt
		power = 80,
		cost = 90,
		tech = "tech_tachyon_power",
		icons = "GFX_ship_part_reactor_r11",
		name = "Tachyon Station",
	},
	{ -- TFW s12bio
		power = 80,
		cost = 70,
		tech = "tech_bio_power_2",
		icons = "GFX_ship_part_bioreactor_2",
		name = "Bio Station II",
	},
	{ -- TFW s12synt
		power = 90,
		cost = 120,
		tech = "tech_wimp_power",
		icons = "GFX_ship_part_reactor_r12",
		name = "WIMP-Extractor Station",
	},
}
