//The Holy Grail of Androids
//Their operating system controls all their perks, debuffs and anything of the sort. Their brain.

/datum/action/innate/android_os
	name = "Access Operating System"
	desc = "Monitor and Configure internal settings"
	icon_icon = 'icons/obj/modular_laptop.dmi'
	button_icon_state = "laptop-off"
	background_icon_state = "bg_tech"
	var/datum/operating_system/os

/datum/action/innate/android_os/New(target_os)
	. = ..()
	button.name = name
	if(istype(target_os, /datum/operating_system))
		os = target_os

/datum/action/innate/android_os/Activate()
	os.ui_interact(owner)


/datum/operating_system
	var/name = "Operating System"
	var/datum/species/android/android

/datum/operating_system/New(new_android)
	. = ..()
	android = new_android

/datum/operating_system/Destroy()
	android = null
	. = ..()

/datum/operating_system/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.always_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "operating_system", name, 900, 480, master_ui, state)
		ui.set_style("ntos")
		ui.open()

/datum/operating_system/ui_data(mob/user)
	var/list/data = list()


	return data

/datum/operating_system/ui_act(action, params)
	if(..())
		return

	/*
	switch(action)
		if("readapt")
			if(changeling.canrespec)
				changeling.readapt()
		if("evolve")
			var/sting_name = params["name"]
			changeling.purchase_power(sting_name) */