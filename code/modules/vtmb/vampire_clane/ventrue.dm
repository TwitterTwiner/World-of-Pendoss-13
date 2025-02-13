/datum/vampireclane/ventrue
	name = "Ventrue"
	desc = "The Ventrue are not called the Clan of Kings for nothing. Carefully choosing their progeny from mortals familiar with power, wealth, and influence, the Ventrue style themselves the aristocrats of the vampire world. Their members are expected to assume command wherever possible, and they’re willing to endure storms for the sake of leading from the front."
	curse = "Low-rank and animal blood is disgusting."
	clane_disciplines = list(
		/datum/discipline/dominate,
		/datum/discipline/fortitude,
		/datum/discipline/presence
	)
	male_clothes = /obj/item/clothing/under/vampire/ventrue
	female_clothes = /obj/item/clothing/under/vampire/ventrue/female
	clan_keys = /obj/item/vamp/keys/ventrue

/datum/discipline/presence/post_gain(mob/living/carbon/human/H)
	if(level >= 5)
		var/obj/effect/proc_holder/spell/voice_of_god/S = new(H)
		H.mind.AddSpell(S)

/datum/discipline/dominate/post_gain(mob/living/carbon/human/H)
	var/datum/action/dominate/DOMINATE = new()
	DOMINATE.Grant(H)

/datum/action/dominate
	name = "Dominate"
	desc = "Dominate over other living or un-living beings."
	button_icon_state = "dominate"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/cool_down = 0

/datum/action/dominate/Trigger()
	. = ..()
	if((cool_down + 5 SECONDS) >= world.time)
		return
	var/mob/living/carbon/human/A = owner
	if(HAS_TRAIT(A, TRAIT_MUTE))
		to_chat(A, "<span class='warning'>You find yourself unable to speak!</span>")
		return
	var/list/mob/living/carbon/human/victims_list = list()
	for (var/mob/living/carbon/human/adding_victim in oviewers(5, owner))
		victims_list += adding_victim
	if(!length(victims_list))
		to_chat(owner, "<span class='warning'>There's no one to <b>DOMINATE</b> around...</span>")
		return

	var/mob/living/carbon/human/victim = input(owner, "Choose the target to Dominate over", "Dominate") as null|anything in victims_list
	if(victim)
		var/dominate_me = get_a_wits(victim)+2
		if(victim.clane?.name == "Gargoyle")
			dominate_me = 1
		if(secret_vampireroll(max(get_a_manipulation(owner), get_a_strength(owner))+get_a_intimidation(owner), dominate_me, owner) < 3)
			to_chat(owner, "<span class='warning'>You fail to <b>DOMINATE</b>...</span>")
			return
		var/new_say = input(owner, "What are you trying to say?", "Say") as null|text
		new_say = sanitize_text(new_say)
		if(new_say)
			owner.say(new_say)
			victim.cure_trauma_type(/datum/brain_trauma/hypnosis/dominate, TRAUMA_RESILIENCE_MAGIC)
			victim.gain_trauma(new /datum/brain_trauma/hypnosis/dominate(new_say), TRAUMA_RESILIENCE_MAGIC)

			spawn(60 SECONDS)
				if(victim)
					victim.cure_trauma_type(/datum/brain_trauma/hypnosis/dominate, TRAUMA_RESILIENCE_MAGIC)

