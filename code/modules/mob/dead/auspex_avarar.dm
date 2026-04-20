GLOBAL_LIST_INIT(avatar_banned_verbs, list(
	/mob/dead/observer/verb/follow,
	/mob/dead/observer/verb/jumptomob,
	/mob/dead/observer/verb/toggle_ghostsee,
	/mob/dead/observer/verb/toggle_darkness,
	/mob/dead/observer/verb/view_manifest,
	/mob/dead/observer/verb/toggle_data_huds,
	/mob/dead/observer/verb/observe,
	/mob/dead/observer/verb/register_pai_candidate,
	/mob/dead/observer/verb/stay_dead,
	/mob/dead/observer/proc/dead_tele,
	/mob/dead/observer/proc/open_spawners_menu
))

/// Выход в атсрал 5-ая точка ауспекс || For 5-th dot auspex
/mob/dead/observer/avatar
	invisibility = INVISIBILITY_LEVEL_OBFUSCATE+5
	see_invisible = SEE_INVISIBLE_LEVEL_OBFUSCATE+5
	can_reenter_corpse = TRUE
	var/mob_biotype = MOB_SPIRIT

/mob/camera/auspex
	name = "Auspex Eye"
	real_name = "Auspex Eye"
	desc = ""
	icon = 'icons/mob/cameramob.dmi'
	icon_state = "marker"
	mouse_opacity = MOUSE_OPACITY_ICON
	move_on_shuttle = FALSE
	see_in_dark = 8
	invisibility = INVISIBILITY_LEVEL_OBFUSCATE+5
	see_invisible = SEE_INVISIBLE_LEVEL_OBFUSCATE+5
	layer = MOB_LAYER
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	sight = SEE_SELF|SEE_THRU
	movement_type = GROUND|PHASING|FLYING
	initial_language_holder = /datum/language_holder/universal

	var/mob/living/holder

/mob/camera/auspex/Initialize(mapload)
	. = ..()
	add_to_avatar_list()

/mob/camera/auspex/Destroy()
	remove_from_avatar_list()

	return ..()

/mob/camera/auspex/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	return holder.say(message)

/mob/camera/auspex/Move(NewLoc, Dir = 0)
	forceMove(NewLoc)

/mob/camera/auspex/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list())
	. = ..()
	var/atom/movable/to_follow = speaker
	if(radio_freq)
		var/atom/movable/virtualspeaker/V = speaker
		to_follow = V.source
	var/link
	link = FOLLOW_LINK(src, to_follow)
	// Create map text prior to modifying message for goonchat
	if (client?.prefs.chat_on_map && (client.prefs.see_chat_non_mob || ismob(speaker)))
		create_chat_message(speaker, message_language, raw_message, spans)
	// Recompose the message, because it's scrambled by default
	message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mods)
	to_chat(src, "[link] [message]")

/mob/dead/observer/avatar/Initialize(mapload)
	. = ..()
	set_invisibility(INVISIBILITY_LEVEL_OBFUSCATE+5)
	add_to_avatar_list()

	remove_verb(src, GLOB.avatar_banned_verbs)

	sight = NONE
	movement_type = FLYING | GROUND | PHASING

/mob/dead/observer/avatar/Destroy()
	remove_from_avatar_list()

	return ..()

/mob/dead/observer/avatar/reenter_corpse()
	if(!client)
		return FALSE
	if(!mind || QDELETED(mind.current))
		to_chat(src, span_warning("You have no body."))
		return FALSE
	if(!can_reenter_corpse)
		to_chat(src, span_warning("You cannot re-enter your body."))
		return FALSE

	var/mob/living/carbon/human/original_body = mind.current
	var/turf/current_turf = get_turf(src)
	var/turf/body_turf = get_turf(original_body)

	if(isnull(body_turf) || isnull(current_turf))
		return FALSE
	if(!(body_turf == current_turf))
		to_chat(src, span_warning("Your body is not here. It is located at coordinates: [body_turf.x], [body_turf.y], [body_turf.z]."))
		to_chat(src, span_warning("Your current coordinates are: [current_turf.x], [current_turf.y], [current_turf.z]."))
		return FALSE
	if(mind.current.key && mind.current.key[1] != "@")	//makes sure we don't accidentally kick any clients
		to_chat(usr, span_warning("Another consciousness is in your body...It is resisting you."))
		return FALSE

	client.view_size.setDefault(getScreenSize(client.prefs.widescreenpref))//Let's reset so people can't become allseeing gods
	SStgui.on_transfer(src, mind.current)
	mind.current.key = key
	mind.current.client.init_verbs()
	original_body.soul_state = SOUL_PRESENT

	return TRUE

/mob/dead/observer/avatar/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	return

/mob/dead/observer/avatar/say_dead(message)
	return

// Auspex Avatars can't manually orbit people.
/mob/dead/observer/avatar/ManualFollow(atom/movable/target)
	return

///////////// HUMAN PROCS ////////////

/mob/living/carbon/human/proc/enter_avatar()
	RETURN_TYPE(/mob/dead/observer/avatar)

	stop_sound_channel(CHANNEL_HEARTBEAT)
	var/mob/camera/auspex/auspex_avatar = new(src)

	SStgui.on_transfer(src, auspex_avatar)
	auspex_avatar.appearance = appearance
	auspex_avatar.key = key
	auspex_avatar.client = src.client
	auspex_avatar.client.init_verbs()
	auspex_avatar.holder = src
	auspex_avatar.real_name = real_name
	auspex_avatar.name = real_name
	auspex_avatar.alpha = 180
	var/datum/action/reenterauspex/R = new
	R.Grant(auspex_avatar)

	return auspex_avatar

/datum/action/reenterauspex
	name = "Re-Enter Body"
	button_icon_state = "ghost"

/datum/action/reenterauspex/Trigger()
	if(isauspexavatar(usr))
		var/mob/camera/auspex/A = usr
		SStgui.on_transfer(A, A.holder)
		A.holder.key = A.key
		A.holder.client = A.client
		A.holder.client.init_verbs()
		qdel(A)
