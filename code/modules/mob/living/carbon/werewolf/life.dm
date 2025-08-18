/mob/living/carbon/werewolf/Life()
	update_icons()
	update_rage_hud()
	return..()

/mob/living/carbon/Life()
	. = ..()
	if(isgarou(src) || iswerewolf(src))
		if(key && stat <= HARD_CRIT)
			var/datum/preferences/P = GLOB.preferences_datums[ckey(key)]
			if(P)
				if(P.masquerade != masquerade)
					P.masquerade = masquerade
					P.save_preferences()
					P.save_character()

/mob/living/carbon/werewolf/check_breath(datum/gas_mixture/breath)
	return

/mob/living/carbon/werewolf/handle_status_effects()
	..()
	//natural reduction of movement delay due to stun.
	if(move_delay_add > 0)
		move_delay_add = max(0, move_delay_add - rand(1, 2))

/mob/living/carbon/werewolf/handle_changeling()
	return

/mob/living/carbon/werewolf/handle_fire()//Aliens on fire code
	. = ..()
	if(.) //if the mob isn't on fire anymore
		return
	adjust_bodytemperature(BODYTEMP_HEATING_MAX) //If you're on fire, you heat up!

/mob/living/carbon/proc/adjust_veil(var/amount)
	if(!GLOB.canon_event)
		return
	if(last_veil_adjusting+200 >= world.time)
		return
	if(amount > 0)
		if(HAS_TRAIT(src, TRAIT_VIOLATOR))
			return
	if(amount < 0)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.zone_type != "masquerade")
				return
	last_veil_adjusting = world.time
	var/special_role_name
	if(mind)
		if(mind.special_role)
			var/datum/antagonist/A = mind.special_role
			special_role_name = A.name
	if(!is_special_character(src) || special_role_name == "Ambitious")
		if(amount < 0)
			if(masquerade > 0)
				SEND_SOUND(src, sound('code/modules/wod13/sounds/veil_violation.ogg', 0, 0, 75))
				to_chat(src, "<span class='boldnotice'><b>VEIL VIOLATION</b></span>")
				masquerade = max(0, masquerade+amount)
		if(amount > 0)
			if(masquerade < 5)
				SEND_SOUND(src, sound('code/modules/wod13/sounds/humanity_gain.ogg', 0, 0, 75))
				to_chat(src, "<span class='boldnotice'><b>VEIL REINFORCEMENT</b></span>")
				masquerade = min(5, masquerade+amount)

	var/mob/humanform = src.transformator.human_form

	var/mob/crinosform = src.transformator.crinos_form

	if(amount < 0)
		if(masquerade <= 2)
			var/list/landmarkslist = list()
			for(var/obj/effect/landmark/start/S in GLOB.start_landmarks_list)
				if(S.name == "Caitiff")
					landmarkslist += S
			var/obj/effect/landmark/start/startmark = pick(landmarkslist)
			//H.forceMove(startmark.loc)
			var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as hunter to hunt [humanform] ([crinosform])?", null, null, null, 50, src)
			for(var/mob/dead/observer/G in GLOB.player_list)
				if(G.key)
					to_chat(G, "<span class='ghostalert'>[humanform] ([crinosform]) revealed their abnormal nature, you can play as hunter to punish them.</span>")
			if(LAZYLEN(candidates))
//				var/mob/dead/observer/C = pick(candidates)
				for(var/i in 1 to 5)
					if(length(candidates))
						var/mob/candidate = pick(candidates)
						candidates -= candidate
						var/mob/living/carbon/human/npc/hunter/smallhunter = new (startmark.loc)
						new /obj/item/gun/ballistic/automatic/vampire/ak74 (startmark.loc)
						smallhunter.key = candidate.key
						if(!smallhunter.mind)
							smallhunter.mind = new /datum/mind
						var/datum/antagonist/ANTAG = smallhunter.mind.add_antag_datum(/datum/antagonist/small_hunter)
						var/datum/objective/assassinate/die_objective = new
						die_objective.owner = smallhunter
						die_objective.target = src
						ANTAG.objectives += die_objective
						smallhunter.remove_movespeed_modifier(/datum/movespeed_modifier/npc)
