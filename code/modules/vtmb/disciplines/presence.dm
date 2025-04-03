/datum/discipline/presence
	name = "Presence"
	desc = "Makes targets in radius more vulnerable to damages."
	icon_state = "presence"
	cost = 1
	ranged = TRUE
	delay = 5 SECONDS
	activate_sound = 'code/modules/wod13/sounds/presence_activate.ogg'
	leveldelay = FALSE
	fearless = TRUE

/datum/discipline/presence/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
	if(iscathayan(target))
		if(target.mind.dharma?.Po == "Legalist")
			target.mind.dharma?.roll_po(caster, target)
	var/mypower = secret_vampireroll(max(get_a_charisma(caster), get_a_appearance(caster))+get_a_empathy(caster), get_a_willpower(target), caster)
	if(mypower < 3)
		to_chat(caster, "<span class='warning'>You fail at sway!</span>")
		caster.emote("stare")
		if(mypower == -1)
			caster.Stun(3 SECONDS)
			caster.do_jitter_animation(10)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
		presence_overlay.pixel_z = 1
		H.overlays_standing[MUTATIONS_LAYER] = presence_overlay
		H.apply_overlay(MUTATIONS_LAYER)
		H.caster = caster
		switch(level_casting)
			if(1)
				var/datum/cb = CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, walk_to_caster))
				for(var/i in 1 to 30)
					addtimer(cb, (i - 1)*H.total_multiplicative_slowdown())
				to_chat(target, "<span class='userlove'><b>COME HERE</b></span>")
				caster.say("COME HERE!!")
			if(2)
				target.Stun(10)
				to_chat(target, "<span class='userlove'><b>REST</b></span>")
				caster.say("REST!!")
				if(target.body_position == STANDING_UP)
					target.toggle_resting()
			if(3)
				// If target is an NPC, link them
				if(istype(target, /mob/living/carbon/human/npc) && caster.puppets.len < get_a_charisma(caster)+get_a_empathy(caster))
					var/mob/living/carbon/human/npc/N = target
					if(!N.presence_master)
						if(!length(caster.puppets))
							var/datum/action/presence_stay/E1 = new()
							E1.Grant(caster)
							var/datum/action/presence_deaggro/E2 = new()
							E2.Grant(caster)

						N.presence_master = caster

						N.presence_follow = TRUE
						N.remove_movespeed_modifier(/datum/movespeed_modifier/npc)
						caster.puppets |= N
						var/initial_fights_anyway = N.fights_anyway
						N.fights_anyway = TRUE
						caster.say("Come with me...")

						addtimer(CALLBACK(src, PROC_REF(presence_end), target, caster, initial_fights_anyway), 50 SECONDS * mypower)
				else
					// continue your normal presence code for players
					var/obj/item/I1 = H.get_active_held_item()
					var/obj/item/I2 = H.get_inactive_held_item()
					to_chat(target, "<span class='userlove'><b>PLEASE ME</b></span>")
					caster.say("PLEASE ME!!")
					target.face_atom(caster)
					target.do_jitter_animation(30)
					target.Immobilize(10)
					target.drop_all_held_items()
					if(I1)
						I1.throw_at(get_turf(caster), 3, 1, target)
					if(I2)
						I2.throw_at(get_turf(caster), 3, 1, target)
			if(4)
				to_chat(target, "<span class='userlove'><b>FEAR ME</b></span>")
				caster.say("FEAR ME!!")
				var/datum/cb = CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, step_away_caster))
				for(var/i in 1 to 30)
					addtimer(cb, (i - 1)*H.total_multiplicative_slowdown())
				target.emote("scream")
				target.do_jitter_animation(30)
			if(5)
				to_chat(target, "<span class='userlove'><b>UNDRESS YOURSELF</b></span>")
				caster.say("UNDRESS YOURSELF!!")
				target.Immobilize(10)
				for(var/obj/item/clothing/W in H.contents)
					if(W)
						H.dropItemToGround(W, TRUE)
		spawn(delay + caster.discipline_time_plus)
			if(H)
				H.remove_overlay(MUTATIONS_LAYER)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/presence_deactivate.ogg', 50, FALSE)

/datum/discipline/presence/proc/presence_end(mob/living/target, mob/living/carbon/human/caster, var/initial_fights_anyway)
	var/mob/living/carbon/human/npc/N = target
	if(N && N.presence_master == caster)
		// End presence effect
		N.presence_master = null
		N.add_movespeed_modifier(/datum/movespeed_modifier/npc)
		N.presence_follow = FALSE
		N.remove_overlay(MUTATIONS_LAYER)
		N.presence_enemies = list()
		N.danger_source = null
		caster.puppets -= N
		N.fights_anyway = initial_fights_anyway
		if(!length(caster.puppets))
			for(var/datum/action/presence_stay/VI in caster.actions)
				if(VI)
					VI.Remove(caster)
			for(var/datum/action/presence_deaggro/VI in caster.actions)
				if(VI)
					VI.Remove(caster)


/mob/living/carbon/human/proc/walk_to_caster()
	walk(src, 0)
	if(!CheckFrenzyMove())
		set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		step_to(src,caster,0)
		face_atom(caster)

/mob/living/carbon/human/proc/step_away_caster()
	walk(src, 0)
	if(!CheckFrenzyMove())
		set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		step_away(src,caster,99)
		face_atom(caster)

/mob/living/carbon/human/proc/attack_myself_command()
	if(!CheckFrenzyMove())
		a_intent = INTENT_HARM
		var/obj/item/I = get_active_held_item()
		if(I)
			if(I.force)
				ClickOn(src)
			else
				drop_all_held_items()
				ClickOn(src)
		else
			ClickOn(src)

/mob/living/carbon/human/npc/proc/handle_presence_movement()
	if(!presence_master || stat >= DEAD)
		return
	if(presence_enemies.len)
		var/dist = 100
		var/mob/enemy = null
		for(var/mob/i in presence_enemies)
			if(get_dist(presence_master,i) < dist && i.stat < 2)
				dist = get_dist(presence_master,i)
				enemy = i
		danger_source = enemy

	if(!presence_follow && !danger_source)
		walktarget = null
	if(presence_follow)
		if(presence_master.z == z && get_dist(src, presence_master) > 3)
			walktarget = presence_master
		else
			walktarget = null
	else
		face_atom(presence_master)


/* ACTIONS */

/datum/action/presence_stay
	name = "Stay/Follow (Presence)"
	desc = "Tell your Presence-thralled NPC to stay put or follow."
	button_icon_state = "wait"
	var/cool_down = 0
	var/following = TRUE
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/presence_stay/Trigger()
	. = ..()
	if(ishuman(owner))
		if(cool_down + 10 >= world.time)
			return
		cool_down = world.time
		var/mob/living/carbon/human/H = owner
			// flip “following” on or off
		following = !following
		if(following)
			H.say("Follow me")
			to_chat(H, "You call your thralls to follow you.")
			for(var/mob/living/carbon/human/npc/HPC in H.puppets)
				if(HPC)
					if(HPC.stat == 0 && !HPC.key && !HPC.IsSleeping() && !HPC.IsUnconscious() && !HPC.IsParalyzed() && !HPC.IsKnockdown() && !HPC.IsStun() && !HAS_TRAIT(HPC, TRAIT_RESTRAINED) && !HPC.pulledby)
						HPC.forceMove(get_turf(H))
		else
			H.say("Stay here")
			to_chat(H, "You command your thralls to remain here.")
			// For each Presence’d NPC you control, apply the new setting
		for(var/mob/living/carbon/human/npc/N in GLOB.npc_list)
			if(N.presence_master == H)
				N.presence_follow = following

/datum/action/presence_deaggro
	name = "Loose Aggression (Presence)"
	desc = "Command to stop your Presence-thralled NPC any aggressive moves."
	button_icon_state = "deaggro"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/cool_down = 0

/datum/action/presence_deaggro/Trigger()
	. = ..()
	if(ishuman(owner))
		if(cool_down+10 >= world.time)
			return
		cool_down = world.time
		var/mob/living/carbon/human/H = owner
		H.say("Stop it!")
		to_chat(H, "You order your thralls to stop attacking.")
		for(var/mob/living/carbon/human/npc/N in H.puppets)
			N.presence_enemies = list()
			N.danger_source = null
