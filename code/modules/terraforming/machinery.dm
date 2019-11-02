/obj/machinery/terraforming/atmospheric
	name = "Atmospheric Terraformer"
	desc = "A large, power hungry machine that slowly changes the atmosphere of the terrestrial body it is on."
	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 250

	var/list/atmos_goal = null
	var/cost_modifier = 10
	var/list/cur_atmos = null

/obj/machinery/terraforming/atmospheric/Initialize()
	. = ..()
	cur_atmos = SSterraforming.atmos.getAtmos()

/obj/machinery/terraforming/atmospheric/ui_interact(mob/user)
	. = ..()
	/var/dat = "Terraformer<br><br>"
	if(powered(power_channel))
		dat += "Current Atmosphere: [cur_atmos]"
	user << browse(dat, "window=terraformer")
	onclose(user, "terraformer")
