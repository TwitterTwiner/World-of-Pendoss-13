/datum/discipline/celerity
	name = "Celerity"
	desc = "Boosts your speed. Violates Masquerade."
	icon_state = "celerity"
	cost = 1
	ranged = FALSE
	delay = 7.5 SECONDS
	violates_masquerade = FALSE
	activate_sound = 'code/modules/wod13/sounds/celerity_activate.ogg'
	leveldelay = TRUE

/obj/effect/celerity
	name = "Damn"
	desc = "..."
	anchored = 1

/obj/effect/celerity/Initialize()
	. = ..()
	spawn(0.5 SECONDS)
		qdel(src)

/mob/living/carbon/human/Move(atom/newloc, direct, glide_size_override)
	. = ..()
//	update_shadow()
	if(celerity_visual)
		var/obj/effect/celerity/C = new(loc)
		C.name = name
		C.appearance = appearance
		C.dir = dir
		if(iscathayan(src))
			C.color = "#40ffb4"		////WE GIVE IT SANDEVISTAN LOOK YEEEHAAAAW
			animate(C, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), color = "#00196e", time = 5)
		else
			animate(C, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), alpha = 0, time = 5)
		if(CheckEyewitness(src, src, 7, FALSE))
			AdjustMasquerade(-1)

/datum/movespeed_modifier/celerity //That is the reason, why i fucking hate copy-pasting, you making systems complicated without the reason to do it
	multiplicative_slowdown = -0.5

/datum/movespeed_modifier/celerity2
	multiplicative_slowdown = -0.75

/datum/movespeed_modifier/celerity3
	multiplicative_slowdown = -1

/datum/movespeed_modifier/celerity4
	multiplicative_slowdown = -1.25

/datum/movespeed_modifier/celerity5
	multiplicative_slowdown = -1.5

/datum/movespeed_modifier/temporis5
	multiplicative_slowdown = -2.5

/datum/movespeed_modifier/wing
	multiplicative_slowdown = -0.25

/datum/movespeed_modifier/dominate
	multiplicative_slowdown = 5

/datum/movespeed_modifier/temporis
	multiplicative_slowdown = 7.5

/datum/discipline/celerity/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
	if (caster.temporis_visual || caster.temporis_blur) //sorry guys, no using two time powers at once
		to_chat(caster, "<span class='userdanger'>Your active Temporis causes Celerity to wrench your body's temporal field apart!</span>")
		caster.emote("scream")
		spawn(3 SECONDS)
			caster.gib()
		return
	switch(level_casting)
		if(1)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity)
			caster.celerity_visual = TRUE
			spawn((delay*level_casting)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/celerity_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity)
					caster.celerity_visual = FALSE
		if(2)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity2)
			caster.celerity_visual = TRUE
			spawn((delay*level_casting)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/celerity_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity2)
					caster.celerity_visual = FALSE
		if(3)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity3)
			caster.celerity_visual = TRUE
			spawn((delay*level_casting)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/celerity_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity3)
					caster.celerity_visual = FALSE
		if(4)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity4)
			caster.celerity_visual = TRUE
			spawn((delay*level_casting)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/celerity_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity4)
					caster.celerity_visual = FALSE
		if(5)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity5)
			caster.celerity_visual = TRUE
			spawn((delay*level_casting)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/celerity_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity5)
					caster.celerity_visual = FALSE
