/obj/machinery/exploration/machines
	name = "ARTIFACT MACHINE"
	desc = "Look away, this is embarrasing!"
	density = TRUE
	use_power = IDLE_POWER_USE
	var/act
	var/specific

	var/obj/item/artifact/art

	var/cooldown = 90

	var/cooldownTimer = 0

/obj/machinery/exploration/machines/proc/applyAct()
	if(cooldownTimer > world.time)
		visible_message("<span class='warning'>Cooldown period active. Please wait [(cooldownTimer - world.time) / 10] second(s)</span>")
		return

	if(!art)
		visible_message("<span class='warning'>No artifact loaded</span>")
		return
	art.onAttempt(act, specific, src)
	cooldownTimer = world.time + cooldown

/obj/machinery/exploration/machines/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/artifact))
		if(art)
			return
		art = W
		W.forceMove(src)
		visible_message("<span class='notice'>Artifact recieved...</span>")

	..()

/obj/machinery/exploration/machines/proc/remove()
	if(art)
		art.forceMove(get_turf(src))
	art = null
	visible_message("<span class='notice'>Ejecting artifact...</span>")

/obj/machinery/exploration/machines/proc/success()
	art = null