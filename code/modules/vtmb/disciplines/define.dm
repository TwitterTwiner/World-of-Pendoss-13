/* ChillRaccoon
*	Please, try to avoid spaghetti code if it available option
*	I will try to refactor this a bit, for the name of readabillity and optimization
*	- Started in 25.02.25 | Completed in
*/

/// {T.WINER} ПЕРЕНОС ПЕНДОС КОДА

//targeting bitflags, NONE or 0 if targeting self exclusively
///Allows for self to also be selected in ranged targeting, SET TO 0 IF NOT TARGETED OR RANGED
#define TARGET_SELF (1<<0)
///Targets anything of type /obj and its children
#define TARGET_OBJ (1<<1)
///Targets anything of type /turf and its children
#define TARGET_TURF (1<<2)
///Targets anything of type /mob/living and its children only if it is not dead
#define TARGET_LIVING (1<<3)
///Targets anything of type /mob/dead and its children, ie targets ghosts
#define TARGET_GHOST (1<<4)
///Targets anything of type /mob/living and its children, dead or not
#define TARGET_MOB (1<<5)
///Targets anything of type /mob/living/carbon/human and its children
#define TARGET_HUMAN (1<<6)
///Targets anything of type /mob/living and its children only if it has a client attached to it
// #define TARGET_PLAYER (1<<7)
///Targets mobs only if they are vampires/Kindred
#define TARGET_VAMPIRE (1<<7)

#define MOB_LIVING_TARGETING (TARGET_MOB | TARGET_LIVING | TARGET_HUMAN | TARGET_VAMPIRE)

#define DISC_CHECK_TORPORED (1<<0)
///Caster must be conscious
#define DISC_CHECK_CONSCIOUS (1<<1)
///Caster must be capable of taking actions (not stunned)
#define DISC_CHECK_CAPABLE (1<<2)
///Caster must be standing up (not knocked down)
#define DISC_CHECK_LYING (1<<3)
///Caster must be capable of moving
#define DISC_CHECK_IMMOBILE (1<<4)
///Caster must have usable hands
#define DISC_CHECK_FREE_HAND (1<<5)
///Caster must be able to speak
#define DISC_CHECK_SPEAK (1<<6)
///Caster must be able to see
#define DISC_CHECK_SEE (1<<7)

/datum/discipline
	var/name = "Vampiric Discipline" ///Name of this Discipline.
	var/desc = "Discipline with powers such as..." ///Text description of this Discipline.
	var/icon_state ///Icon for this Discipline as in disciplines.dmi
	var/cost = 2 ///Cost in blood points of activating this Discipline.
	var/ranged = FALSE ///Whether this Discipline is ranged.
	var/range_sh = 8 ///The range from which this Discipline can be used on a target.
	var/delay = 5 ///Duration of the Discipline. //TODO, probably this is a WRONG COMMENTARY, delay is the delay, not a duration. Need to be checked later.
	var/violates_masquerade = FALSE ///Whether this Discipline causes a Masquerade breach when used in front of mortals.
	var/level = 1 ///What rank, or how many dots the caster has in this Discipline.
	var/leveled = TRUE
	var/activate_sound = 'code/modules/wod13/sounds/bloodhealing.ogg' ///The sound that plays when any power of this Discipline is activated.
	var/leveldelay = FALSE ///Whether this Discipline's cooldowns are multipled by the level it's being casted at.
	var/fearless = FALSE ///Whether this Discipline aggroes NPC targets.
	var/target_type = NONE
	var/hostile = FALSE

	var/level_casting = 1 ///What rank of this Discipline is currently being casted.
	var/clane_restricted = FALSE ///Whether this Discipline is exclusive to one Clan.
	var/dead_restricted = TRUE ///Whether this Discipline is restricted from affecting dead people.
	var/check_flags = NONE
	var/next_fire_after = 0

/datum/action/discipline
//	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS
//	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	button_icon = 'code/modules/wod13/UI/actions.dmi' //This is the file for the BACKGROUND icon
	background_icon_state = "discipline" //And this is the state for the background icon

	icon_icon = 'code/modules/wod13/UI/actions.dmi' //This is the file for the ACTION icon
	button_icon_state = "discipline" //And this is the state for the action icon
	vampiric = TRUE
	var/level_icon_state = "1" //And this is the state for the action icon
	var/datum/discipline/discipline
	var/active_check = FALSE

/datum/action/discipline/Trigger()
	if(discipline && isliving(owner))
		var/mob/living/owning = owner
		if(discipline.ranged)
			if(!active_check)
				active_check = TRUE
				if(owning.discipline_ranged)
					owning.discipline_ranged.Trigger()
				owning.discipline_ranged = src
				if(button)
					button.color = "#970000"
			else
				active_check = FALSE
				owning.discipline_ranged = null
				button.color = "#ffffff"
		else
			if(discipline)
				if(discipline.check_activated(owner, owner))
					discipline.activate(owner, owner)
	. = ..()

/datum/action/discipline/proc/switch_level()
	SEND_SOUND(owner, sound('code/modules/wod13/sounds/highlight.ogg', 0, 0, 50))
	if(discipline)
		if(discipline.level_casting < discipline.level)
			discipline.level_casting = discipline.level_casting+1
			if(button)
				ApplyIcon(button, TRUE)
			return
		else
			discipline.level_casting = 1
			if(button)
				ApplyIcon(button, TRUE)
			return

/datum/discipline/proc/post_gain(var/mob/living/carbon/human/H)
	return

/datum/action/discipline/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	if(owner)
		if(owner.client)
			if(owner.client.prefs)
				if(owner.client.prefs.old_discipline)
					button_icon = 'code/modules/wod13/disciplines.dmi'
					icon_icon = 'code/modules/wod13/disciplines.dmi'
				else
					button_icon = 'code/modules/wod13/UI/actions.dmi'
					icon_icon = 'code/modules/wod13/UI/actions.dmi'
	if(icon_icon && button_icon_state && ((current_button.button_icon_state != button_icon_state) || force))
		current_button.cut_overlays(TRUE)
		if(discipline)
			current_button.name = discipline.name
			current_button.desc = discipline.desc
			current_button.add_overlay(mutable_appearance(icon_icon, "[discipline.icon_state]"))
			current_button.button_icon_state = "[discipline.icon_state]"
			if(discipline.leveled)
				current_button.add_overlay(mutable_appearance(icon_icon, "[discipline.level_casting]"))
		else
			current_button.add_overlay(mutable_appearance(icon_icon, button_icon_state))
			current_button.button_icon_state = button_icon_state

/datum/discipline/proc/check_activated(atom/target, var/mob/living/carbon/human/caster)
// HAS_TRAIT(caster, TRAIT_RESTRAINED)
//	if(caster.stat >= HARD_CRIT || caster.IsSleeping() || caster.IsUnconscious() || caster.IsParalyzed() || !isturf(caster.loc))
//		return FALSE

//////{T.WINER} Не спиздили, а адаптировали.

	if((check_flags & DISC_CHECK_FREE_HAND) && HAS_TRAIT(caster, TRAIT_HANDS_BLOCKED))
		return FALSE
	if((check_flags & DISC_CHECK_TORPORED) && HAS_TRAIT(caster, TRAIT_TORPOR))
		return FALSE
	if((check_flags & DISC_CHECK_CAPABLE) && HAS_TRAIT(caster, TRAIT_INCAPACITATED))
		return FALSE
	if((check_flags & DISC_CHECK_LYING) && HAS_TRAIT(caster, DISC_CHECK_LYING))
		return FALSE
	if((check_flags & DISC_CHECK_IMMOBILE) && HAS_TRAIT(caster, TRAIT_IMMOBILIZED))
		return FALSE
	if((check_flags & DISC_CHECK_SPEAK) && HAS_TRAIT(caster, TRAIT_MUTE))
		return FALSE
	if((check_flags & DISC_CHECK_SEE) && HAS_TRAIT(caster, TRAIT_BLIND))
		return FALSE

	if (target_type == NONE)
		return TRUE

	if (target == caster)
		if (target_type & TARGET_SELF)
			return TRUE
		else
		//	if (alert)
			to_chat(caster, span_warning("You can't use this power on yourself!"))
			return FALSE

	//check target type
	// mob/living with a bunch of extra conditions
	if ((target_type & MOB_LIVING_TARGETING) && isliving(target))
		//make sure our LIVING target isn't DEAD
		var/mob/living/living_target = target
		if ((target_type & TARGET_LIVING) && (living_target.stat == DEAD))
		//	if (alert)
			to_chat(caster, span_warning("You cannot cast [src] on dead things!"))
			return FALSE

	//	if ((target_type & TARGET_PLAYER) && !living_target.client)
	//	//	if (alert)
	//		to_chat(caster, span_warning("You can only cast [src] on other players!"))
	//		return FALSE

		if ((target_type & TARGET_VAMPIRE) && !iskindred(target))
		//	if (alert)
			to_chat(caster, span_warning("You can only cast [src] on Kindred!"))
			return FALSE


		if (ishuman(target))
			var/mob/living/carbon/human/target_ZV = living_target
			if(target_ZV.resistant_to_disciplines || target_ZV.spell_immunity)
				to_chat(caster, "<span class='danger'>[target_ZV] resists your powers!</span>")
				return FALSE

			if (target_type & TARGET_HUMAN)
				return TRUE

		if (target_type & TARGET_HUMAN)
		//	if (alert)
			to_chat(caster, span_warning("You can only cast [src] on humans!"))
			return FALSE

	//	return TRUE

	if ((target_type & TARGET_OBJ) && istype(target, /obj))
		return FALSE

	if ((target_type & TARGET_GHOST) && istype(target, /mob/dead))
		return FALSE

	if ((target_type & TARGET_TURF) && istype(target, /turf))
		return FALSE

	if (HAS_TRAIT(caster, TRAIT_PACIFISM))
	//	if (alert)
		to_chat(caster, span_warning("You cannot cast [src] as a pacifist!"))
	//	return FALSE
	//target doesn't match any targeted types, so can't activate on them
//	if (alert)
//	to_chat(caster, span_warning("You cannot cast [src] on [target]!"))
	return FALSE


	var/plus = 0
	if(HAS_TRAIT(caster, TRAIT_HUNGRY))
		plus = 1
	if(caster.bloodpool < cost+plus)
		SEND_SOUND(caster, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
		to_chat(caster, "<span class='warning'>You don't have enough <b>BLOOD</b> to use this discipline.</span>")
		return FALSE
	if(world.time < next_fire_after)
		to_chat(caster, "<span class='warning'>It's too soon to use this discipline again!</span>")
		return FALSE
//	if(target.stat == DEAD && dead_restricted) // {T.WINER} - 180-ая строчка
//		return FALSE
	if(ranged)
		if(get_dist(caster, target) > range_sh)
			return FALSE
	if(HAS_TRAIT(caster, TRAIT_PACIFISM))
		return FALSE
	caster.bloodpool = max(0, caster.bloodpool-(cost+plus))
	caster.update_blood_hud()
	if(ranged)
		to_chat(caster, "<span class='notice'>You activate [name] on [target].</span>")
	else
		to_chat(caster, "<span class='notice'>You activate [name].</span>")
	if(ranged)
		if(isnpc(target) && !fearless)
			var/mob/living/carbon/human/npc/NPC = target
			NPC.Aggro(caster, TRUE)
	if(activate_sound)
		caster.playsound_local(caster, activate_sound, 50, FALSE)
//	if(caster.key)
//		var/datum/preferences/P = GLOB.preferences_datums[ckey(caster.key)]
//		if(P)
//			if(!HAS_TRAIT(caster, TRAIT_NON_INT))
//				P.exper = min(calculate_mob_max_exper(caster), P.exper+10+caster.experience_plus)
//			P.save_preferences()
//			P.save_character()
	if(violates_masquerade)
		if(caster.CheckEyewitness(target, caster, 7, TRUE))
			caster.AdjustMasquerade(-1)
	return TRUE

/datum/discipline/proc/activate(var/mob/living/target, var/mob/living/carbon/human/caster)
	if(!target)
		return
	if(!caster)
		return

	if(leveldelay)
		next_fire_after = world.time+delay*level_casting
	else
		next_fire_after = world.time+delay

	log_attack("[key_name(caster)] casted level [src.level_casting] of the Discipline [src.name][target == caster ? "." : " on [key_name(target)]"]")

/* ATOM */

/atom
	var/last_investigated = 0

/atom/movable/screen/movable/action_button/Click(location,control,params)
	if(istype(linked_action, /datum/action/discipline))
		var/list/modifiers = params2list(params)
		if(LAZYACCESS(modifiers, "right"))
			var/datum/action/discipline/D = linked_action
			D.switch_level()
			return
	. = ..()

//! So much spaghetti code, but it's can't be avoided

/atom/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/Z = user
		if(Z.auspex_examine)
			if(!isturf(src) && !isobj(src) && !ismob(src))
				return
			var/list/fingerprints = list()
			var/list/blood = return_blood_DNA()
			var/list/fibers = return_fibers()
			var/list/reagents = list()

			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(!H.gloves)
					fingerprints += md5(H.dna.uni_identity)

			else if(!ismob(src))
				fingerprints = return_fingerprints()


				if(isturf(src))
					var/turf/T = src
					// Only get reagents from non-mobs.
					if(T.reagents && T.reagents.reagent_list.len)

						for(var/datum/reagent/R in T.reagents.reagent_list)
							T.reagents[R.name] = R.volume

							// Get blood data from the blood reagent.
							if(istype(R, /datum/reagent/blood))

								if(R.data["blood_DNA"] && R.data["blood_type"])
									var/blood_DNA = R.data["blood_DNA"]
									var/blood_type = R.data["blood_type"]
									LAZYINITLIST(blood)
									blood[blood_DNA] = blood_type
				if(isobj(src))
					var/obj/T = src
					// Only get reagents from non-mobs.
					if(T.reagents && T.reagents.reagent_list.len)

						for(var/datum/reagent/R in T.reagents.reagent_list)
							T.reagents[R.name] = R.volume

							// Get blood data from the blood reagent.
							if(istype(R, /datum/reagent/blood))

								if(R.data["blood_DNA"] && R.data["blood_type"])
									var/blood_DNA = R.data["blood_DNA"]
									var/blood_type = R.data["blood_type"]
									LAZYINITLIST(blood)
									blood[blood_DNA] = blood_type

			// We gathered everything. Create a fork and slowly display the results to the holder of the scanner.

			var/found_something = FALSE

			// Fingerprints
			if(length(fingerprints))
				to_chat(user, "<span class='info'><B>Prints:</B></span>")
				for(var/finger in fingerprints)
					to_chat(user, "[finger]")
				found_something = TRUE

			//Killer
			if(isliving(src))
				var/mob/living/LivedYoung = src
				if(LivedYoung.lastattacker)
					for(var/mob/living/carbon/human/huLi in GLOB.player_list)
						if(huLi?.dna?.real_name == LivedYoung.lastattacker)
							to_chat(user, "<span class='info'><B>Aggressive prints:</B> [md5(huLi.dna.uni_identity)]</span>")
							found_something = TRUE

			// Blood
			if (length(blood))
				to_chat(user, "<span class='info'><B>Blood:</B></span>")
				found_something = TRUE
				for(var/B in blood)
					to_chat(user, "Type: <font color='red'>[blood[B]]</font> DNA (UE): <font color='red'>[B]</font>")

			//Fibers
			if(length(fibers))
				to_chat(user, "<span class='info'><B>Fibers:</B></span>")
				for(var/fiber in fibers)
					to_chat(user, "[fiber]")
				found_something = TRUE

			//Reagents
			if(length(reagents))
				to_chat(user, "<span class='info'><B>Reagents:</B></span>")
				for(var/R in reagents)
					to_chat(user, "Reagent: <font color='red'>[R]</font> Volume: <font color='red'>[reagents[R]]</font>")
				found_something = TRUE

			if(!found_something)
				to_chat(user, "<I># No forensic traces found #</I>") // Don't display this to the holder user
			return
		else if((isobj(src) || ismob(src)) && last_investigated <= world.time)
			last_investigated = world.time+30 SECONDS
			if(secret_vampireroll(get_a_perception(user)+get_a_investigation(user), 6, user) < 3)
				return

			var/list/fingerprints = list()
			var/list/fibers = return_fibers()

			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(!H.gloves)
					fingerprints += md5(H.dna.uni_identity)

			else if(!ismob(src))
				fingerprints = return_fingerprints()

			var/found_something = FALSE

			// Fingerprints
			if(length(fingerprints))
				to_chat(user, "<span class='info'><B>Prints:</B></span>")
				for(var/finger in fingerprints)
					to_chat(user, "[finger]")
				found_something = TRUE

			//Killer
			if(isliving(src))
				var/mob/living/LivedYoung = src
				if(LivedYoung.lastattacker)
					for(var/mob/living/carbon/human/huLi in GLOB.player_list)
						if(huLi?.dna?.real_name == LivedYoung.lastattacker)
							to_chat(user, "<span class='info'><B>Aggressive prints:</B> [md5(huLi.dna.uni_identity)]</span>")
							found_something = TRUE
			//Fibers
			if(length(fibers))
				to_chat(user, "<span class='info'><B>Fibers:</B></span>")
				for(var/fiber in fibers)
					to_chat(user, "[fiber]")
				found_something = TRUE

			if(!found_something)
				to_chat(user, "<I># No forensic traces found #</I>") // Don't display this to the holder user
			return
