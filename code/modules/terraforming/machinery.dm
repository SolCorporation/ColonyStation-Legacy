/obj/machinery/terraformer
	name = "Atmospheric Terraformer"
	icon = 'icons/obj/pda.dmi'
	icon_state = "pdapainter"
	desc = "A large, power hungry machine that slowly changes the atmosphere of the terrestrial body it is on."
	use_power = IDLE_POWER_USE
	idle_power_usage = 500
	active_power_usage = 250000
	circuit = /obj/item/circuitboard/machine/terraformer

	var/cooldown = 300
	var/cooldownTimer

	var/list/possibleGasses = list()

	var/molesPerProcess = 0.25


/obj/machinery/terraformer/Initialize()
	for(var/D in subtypesof(/datum/terraforming_gas))
		possibleGasses += new D()
	. = ..()

/obj/machinery/terraformer/process()
	. = ..()
	if(cooldownTimer < world.time)
		HandleTerraforming()
		cooldownTimer = world.time + cooldown

/obj/machinery/terraformer/proc/HandleTerraforming()
	if(stat & NOPOWER)
		return
	var/list/updatedAtmos = list()
	for(var/datum/terraforming_gas/gasD in possibleGasses)
		if(gasD.active)
			updatedAtmos[gasD.gas] = molesPerProcess

	SSterraforming.updateAtmosphere(updatedAtmos)


/obj/machinery/terraformer/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, \
									datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)

	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "terraformer", name, 475, 800, master_ui, state)
		ui.open()

/obj/machinery/terraformer/ui_data()
	var/list/data = list()

	data["drones"] = list()
	for(var/obj/machinery/mining/bot/drones in GLOB.mining_bots)
		var/list/upgrades = list()
		for(var/obj/item/mining_upgrade/upgradesBot in drones.appliedUpgrades)
			upgrades += list("upName" = upgradesBot.upgrade.name)
		data["drones"] += list(list("cargo" = drones.cargo, "name" = drones.name, "cargoLen" = drones.cargo.len, "cargoMax" = drones.maxCargo,
		"mining" = drones.mining, "botID" = REF(drones), "upgradesLen" = drones.appliedUpgrades.len, "upgradesMax" = drones.maxUpgrades,
		"upgrades" = upgrades, "charge" = drones.battery.charge, "chargePercent" = drones.battery.percent(), "maxcharge" = drones.battery.maxcharge,
		"mineDelay" = (drones.miningCooldown / 10), "mineAmount" = drones.oresPerCycle, "powerUsage" = drones.powerUsage))
	return data

/obj/machinery/terraformer/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("toggleMining")
			var/obj/machinery/mining/bot/bot = locate(params["bot"])
			bot.toggleMining()
			. = TRUE
		if("unload")
			var/obj/machinery/mining/bot/bot = locate(params["bot"])
			if(!bot.mining)
				bot.Unload()
				. = TRUE

/datum/terraforming_gas
	var/name = "TEST"
	var/gas = "TEST"
	var/active = FALSE

/datum/terraforming_gas/oxy
	name = "Oxygen"
	gas = "o2"
	active = FALSE