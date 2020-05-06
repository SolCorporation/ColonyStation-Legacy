/mob/living/key_down(datum/keyinfo/I, client/user)
	switch(I.action)
		if(ACTION_RESIST)
			resist()
			return
		if(ACTION_LOOKUP)
			look_up()
			return

	return ..()

/mob/living/key_up(datum/keyinfo/I, client/user)
	switch(I.action)
		if(ACTION_LOOKUP)
			stop_look_up()
			return

	return ..()