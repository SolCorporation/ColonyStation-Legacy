//Used for figuring out the order in which to do artifacts

/obj/machinery/exploration/machines/analyzer
	name = "artifact analyzer"
	desc = "Learn science by... Analyzing... Things.."
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "d_analyzer"

	act = "SCANNER"
	specific = "SCANNER"


	cooldown = 180

	var/running = FALSE

/obj/machinery/exploration/machines/analyzer/Initialize()
	START_PROCESSING(SSobj, src)
	..()

/obj/machinery/exploration/machines/analyzer/process()
	if(running)
		if(world.time > cooldownTimer)
			Finished()

/obj/machinery/exploration/machines/analyzer/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(art)
		art.forceMove(get_turf(src))
	art = null
	..()

/obj/machinery/exploration/machines/analyzer/proc/Begin()
	if(running)
		return
	if(!art)
		return
	cooldownTimer = world.time + cooldown

	running = TRUE
	update_icon()



/obj/machinery/exploration/machines/analyzer/proc/Finished()
	if(!running)
		return
	if(!art)
		visible_message("<span class='warning'>No artifact loaded</span>")

	visible_message("<span class='warning'>The scanner reports that the next step should be: [art.getNextStep()]</span>")

	running = FALSE
	update_icon()

/obj/machinery/exploration/machines/analyzer/update_icon()
	if(running)
		icon_state = "d_analyzer_process"
	else if(!running && art)
		icon_state = "d_analyzer_l"
	else
		icon_state = initial(icon_state)

/obj/machinery/exploration/machines/analyzer/success()
	return

/obj/machinery/exploration/machines/attackby(obj/item/W, mob/user, params)
	..()
	if(istype(W, /obj/item/artifact))
		if(art)
			flick("d_analyzer_la", src)
			update_icon()

