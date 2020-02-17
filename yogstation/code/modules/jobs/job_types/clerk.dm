/datum/job/clerk
	title = "Clerk"
	flag = CLERK
	department_head = list("Head of Personnel")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#dddddd"
	access = list(ACCESS_MANUFACTURING)
	minimal_access = list(ACCESS_MANUFACTURING)

	outfit = /datum/outfit/job/clerk
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_CLERK

	changed_maps = list("MinskyStation", "OmegaStation")

/datum/job/clerk/config_check()
	return FALSE

/datum/job/clerk/proc/MinskyStationChanges()
	total_positions = 2
	spawn_positions = 2

/datum/job/clerk/proc/OmegaStationChanges()
	return TRUE

/datum/outfit/job/clerk
	name = "Clerk"
	jobtype = /datum/job/clerk

	belt = /obj/item/pda
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/yogs/rank/clerk
	shoes = /obj/item/clothing/shoes/sneakers/black
	head = /obj/item/clothing/head/yogs/clerkcap
	backpack_contents = list(/obj/item/circuitboard/machine/paystand = 1)