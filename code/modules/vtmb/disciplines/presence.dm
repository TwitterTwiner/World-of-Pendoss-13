/datum/discipline/presence
	name = "Presence"
	desc = "Makes targets in radius more vulnerable to damages."
	icon_state = "presence"
	power_type = /datum/discipline_power/presence

/datum/discipline_power/presence
	name = "Presence power name"
	desc = "Presence power description"

	activate_sound = 'code/modules/wod13/sounds/presence_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/presence_deactivate.ogg'

/datum/discipline_power/presence/activate(mob/living/carbon/human/target)
	. = ..()
	if(iscathayan(target))
		if(target.mind.dharma?.Po == "Legalist")
			target.mind.dharma?.roll_po(owner, target)
//AWE
/datum/discipline_power/presence/awe
	name = "Awe"
	desc = "Make those around you admire and want to be closer to you."

	level = 1

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 5 SECONDS

/datum/discipline_power/presence/awe/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at sway!</span>")
		owner.emote("stare")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE

	return TRUE

/datum/discipline_power/presence/awe/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
	presence_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = presence_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	var/datum/cb = CALLBACK(target, /mob/living/carbon/human/proc/walk_to_caster, owner)
	for(var/i in 1 to 30)
		addtimer(cb, (i - 1) * target.total_multiplicative_slowdown())
	to_chat(target, "<span class='userlove'><b>COME HERE</b></span>")
	owner.say("COME HERE!!")

/datum/discipline_power/presence/awe/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

/mob/living/carbon/human/proc/walk_to_caster(mob/living/step_to)
	walk(src, 0)
	if(!CheckFrenzyMove())
		set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		step_to(src, step_to, 0)
		face_atom(step_to)

//DREAD GAZE
/datum/discipline_power/presence/dread_gaze
	name = "Dread Gaze"
	desc = "Incite fear in others through only your words and gaze."

	level = 2

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 5 SECONDS

/datum/discipline_power/presence/dread_gaze/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at sway!</span>")
		owner.emote("stare")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE

	return TRUE

/datum/discipline_power/presence/dread_gaze/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
	presence_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = presence_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	target.Stun(1 SECONDS)
	to_chat(target, "<span class='userlove'><b>REST</b></span>")
	owner.say("REST!!")
	if(target.body_position == STANDING_UP)
		target.toggle_resting()

/datum/discipline_power/presence/dread_gaze/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

/datum/discipline_power/presence/proc/presence_end(mob/living/target, mob/living/carbon/human/caster, initial_fights_anyway)
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

//ENTRANCEMENT
/datum/discipline_power/presence/entrancement
	name = "Entrancement"
	desc = "Manipulate minds by bending emotions to your will."

	level = 3

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 5 SECONDS

/datum/discipline_power/presence/entrancement/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at sway!</span>")
		owner.emote("stare")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE

	return TRUE

/datum/discipline_power/presence/entrancement/activate(mob/living/carbon/human/target)
	. = ..()
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
	presence_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = presence_overlay
	target.apply_overlay(MUTATIONS_LAYER)


	if(istype(target, /mob/living/carbon/human/npc) && owner.puppets.len < get_a_charisma(owner)+get_a_empathy(owner))
		var/mob/living/carbon/human/npc/N = target
		if(!N.presence_master)
			if(!length(owner.puppets))
				var/datum/action/presence_stay/E1 = new()
				E1.Grant(owner)
				var/datum/action/presence_deaggro/E2 = new()
				E2.Grant(owner)

			N.presence_master = owner

			N.presence_follow = TRUE
			N.remove_movespeed_modifier(/datum/movespeed_modifier/npc)
			owner.puppets |= N
			var/initial_fights_anyway = N.fights_anyway
			N.fights_anyway = TRUE
			owner.say("Come with me...")

			addtimer(CALLBACK(src, PROC_REF(presence_end), target, owner, initial_fights_anyway), 50 SECONDS * mypower)
	else
		var/obj/item/I1 = target.get_active_held_item()
		var/obj/item/I2 = target.get_inactive_held_item()
		to_chat(target, "<span class='userlove'><b>PLEASE ME</b></span>")
		owner.say("PLEASE ME!!")
		target.face_atom(owner)
		target.do_jitter_animation(3 SECONDS)
		target.Immobilize(1 SECONDS)
		target.drop_all_held_items()
		if(I1)
			I1.throw_at(get_turf(owner), 3, 1, target)
		if(I2)
			I2.throw_at(get_turf(owner), 3, 1, target)

/datum/discipline_power/presence/entrancement/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

//SUMMON
/datum/discipline_power/presence/summon
	name = "Summon"
	desc = "Call anyone you've ever met to be by your side."

	level = 4

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 5 SECONDS

/datum/discipline_power/presence/summon/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at sway!</span>")
		owner.emote("stare")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE

	return TRUE

/datum/discipline_power/presence/summon/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
	presence_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = presence_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	to_chat(target, "<span class='userlove'><b>FEAR ME</b></span>")
	owner.say("FEAR ME!!")
	var/datum/cb = CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, step_away_caster), owner)
	for(var/i in 1 to 30)
		addtimer(cb, (i - 1) * target.total_multiplicative_slowdown())
	target.emote("scream")
	target.do_jitter_animation(3 SECONDS)

/datum/discipline_power/presence/summon/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

/mob/living/carbon/human/proc/step_away_caster(mob/living/step_from)
	walk(src, 0)
	if(!CheckFrenzyMove())
		set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		step_away(src, step_from, 99)

//MAJESTY
/datum/discipline_power/presence/majesty
	name = "Majesty"
	desc = "Become so grand that others find it nearly impossible to disobey or harm you."

	level = 5

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 5 SECONDS

/datum/discipline_power/presence/majesty/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at sway!</span>")
		owner.emote("stare")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE

	return TRUE

/datum/discipline_power/presence/majesty/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
	presence_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = presence_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	to_chat(target, "<span class='userlove'><b>UNDRESS YOURSELF</b></span>")
	owner.say("UNDRESS YOURSELF!!")
	target.Immobilize(1 SECONDS)
	for(var/obj/item/clothing/W in target.contents)
		target.dropItemToGround(W, TRUE)

/datum/discipline_power/presence/majesty/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

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
