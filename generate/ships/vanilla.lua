-- NOTE:
-- Hulls in this file are added to both the vanilla power_core set,
-- and the powerstation_components set.
-- In the vanilla set, they only get reactors from lvl 6-12,
-- since vanilla already includes lvl 1-6.
return {
	-- Vanilla
	colonizer               = { 3, 0, 0 },
	constructor             = { 3, 0, 0 },
	science                 = { 3, 0, 0 },
	transport               = { 3, 0, 0 },
	corvette                = { 3, 0, 0 },
	destroyer               = { 6, 0, 0 },
	cruiser                 = { 0, 6, 0 },
	battleship              = { 0, 0, 6 },
	titan                   = { 0, 0, 12 },
	ion_cannon              = { 0, 6, 0 },
	military_station_small  = { 8, 0, 0 },
	military_station_medium = { 8, 0, 0 },
	military_station_large  = { 8, 0, 0 },
}
