/obj/machinery/terraforming/atmospheric
	name = "Atmospheric Terraformer"
	desc = "A large, power hungry machine that slowly changes the atmosphere of the terrestrial body it is on."
	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 250

	var/list/atmos_goal = null
	var/cost_modifier = 10

/obj/machinery/terraforming/atmospheric/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = 0, datum/tgui/master_ui = null, datum/ui_state/state = default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "Terraformer", name, 300, 300, master_ui, state)
		ui.open()

/obj/machinery/terraforming/atmospheric/ui_data(mob/user)
	var/list/data = list()
	data["goal"] = atmos_goal
	data["current"] = SSterraforming.getAtmos()

	return data
