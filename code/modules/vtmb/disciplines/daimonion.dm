/datum/curse
	var/name

/datum/curse/daimonion
	var/genrequired

/datum/curse/daimonion/proc/activate(mob/living/target)
	return

/datum/curse/daimonion/lying_weakness
	name = "No Lying Tongue"
	genrequired = 13

/datum/curse/daimonion/physical_weakness
	name = "Baby Strength"
	genrequired = 10

/datum/curse/daimonion/mental_weakness
	name = "Reap Mentality"
	genrequired = 9

/datum/curse/daimonion/offspring_weakness
	name = "Sterile Vitae"
	genrequired = 8

/datum/curse/daimonion/success_weakness
	name = "The Mark Of Doom"
	genrequired = 7

/datum/curse/daimonion/lying_weakness/activate(mob/living/carbon/human/target)
	. = ..()
	target.gain_trauma(/datum/brain_trauma/mild/mind_echo, TRAUMA_RESILIENCE_ABSOLUTE)
	to_chat(target, "<span class='userdanger'><b>You feel like a great curse was placed on you!</span></b>")

/datum/curse/daimonion/physical_weakness/activate(mob/living/target)
	. = ..()
	var/mob/living/carbon/human/H = target
	if(get_a_strength(H) > 0)
		H.attributes.strength -= 1
	if(get_a_dexterity(H) > 0)
		H.attributes.dexterity -= 1
	if(get_a_stamina(H) > 0)
		H.attributes.stamina -= 1
	if(get_a_athletics(H) > 0)
		H.attributes.Athletics -= 1
	if(get_a_brawl(H) > 0)
		H.attributes.Brawl -= 1
	if(get_a_melee(H) > 0)
		H.attributes.Melee -= 1
	if(iskindred(target))
		var/mob/living/carbon/human/vampire = target
		for (var/datum/action/blood_power/blood_power in vampire.actions)
			if(blood_power)
				blood_power.Remove(vampire)
	to_chat(target, "<span class='userdanger'><b>You feel like a great curse was placed on you!</span></b>")

/datum/curse/daimonion/mental_weakness/activate(mob/living/target)
	. = ..()
	var/mob/living/carbon/human/H = target
	if(get_a_charisma(H) > 0)
		H.attributes.charisma -= 1
	if(get_a_manipulation(H) > 0)
		H.attributes.manipulation -= 1
	if(get_a_appearance(H) > 0)
		H.attributes.appearance -= 1
	if(get_a_perception(H) > 0)
		H.attributes.perception -= 1
	if(get_a_intelligence(H) > 0)
		H.attributes.intelligence -= 1
	if(get_a_wits(H) > 0)
		H.attributes.wits -= 1
	if(get_a_alertness(H) > 0)
		H.attributes.Alertness -= 1
	to_chat(target, "<span class='userdanger'><b>You feel like a great curse was placed on you!</span></b>")

/datum/curse/daimonion/offspring_weakness/activate(mob/living/target)
	. = ..()
	if(iskindred(target))
		var/mob/living/carbon/human/vampire = target
		for (var/datum/action/give_vitae/give_vitae in vampire.actions)
			if(give_vitae)
				give_vitae.Remove(vampire)
	to_chat(target, "<span class='userdanger'><b>You feel like a great curse was placed on you!</span></b>")

/datum/curse/daimonion/success_weakness/activate(mob/living/target)
	. = ..()
	var/mob/living/carbon/human/H = target
	H.attributes.diff_curse += 1
	to_chat(target, "<span class='userdanger'><b>You feel like a great curse was placed on you!</span></b>")

/datum/daimonion/proc/baali_get_stolen_disciplines(target, owner)
	if(!owner || !target)
		return
	var/mob/living/carbon/human/vampire = target
	if(iskindred(vampire))
		var/datum/species/kindred/clan = vampire.dna.species
		if(clan.get_discipline("Quietus") && vampire.clane?.name != "Banu Haqim")
			to_chat(owner, "[target] fears that the fact they stole Banu Haqim's Quietus will be known.")
		if(clan.get_discipline("Protean") && vampire.clane?.name != "Gangrel")
			to_chat(owner, "[target] fears that the fact they stole Gangrel's Protean will be known.")
		if(clan.get_discipline("Serpentis") && vampire.clane?.name != "Followers of Set")
			to_chat(owner, "[target] fears that the fact they stole Ministry's Serpentis will be known.")
		if(clan.get_discipline("Necromancy") && vampire.clane?.name != "Giovanni" || clan.get_discipline("Necromancy") && vampire.clane?.name != "Cappadocian")
			to_chat(owner, "[target] fears that the fact they stole Giovanni's Necromancy will be known.")
		if(clan.get_discipline("Obtenebration") && vampire.clane?.name != "Lasombra" || clan.get_discipline("Obtenebration") && vampire.clane?.name != "Baali")
			to_chat(owner, "[target] fears that the fact they stole Lasombra's Obtenebration will be known.")
		if(clan.get_discipline("Dementation") && vampire.clane?.name != "Malkavian")
			to_chat(owner, "[target] fears that the fact they stole Malkavian's Dementation will be known.")
		if(clan.get_discipline("Thaumaturgy") && vampire.clane?.name != "Tremere" || clan.get_discipline("Thaumaturgy") && vampire.clane?.name != "Baali")
			to_chat(owner, "[target] fears that the fact they stole Tremere's Thaumaturgy will be known.")
		if(clan.get_discipline("Vicissitude") && vampire.clane?.name != "Tzimisce")
			to_chat(owner, "[target] fears that the fact they stole Tzimisce's Vicissitude will be known.")
		if(clan.get_discipline("Melpominee") && vampire.clane?.name != "Daughters of Cacophony")
			to_chat(owner, "[target] fears that the fact they stole Daughters of Cacophony's Melpominee will be known.")
		if(clan.get_discipline("Daimonion") && vampire.clane?.name != "Baali")
			to_chat(owner, "[target] fears that the fact they stole Baali's Daimonion will be known.")
		if(clan.get_discipline("Temporis") && vampire.clane?.name != "True Brujah")
			to_chat(owner, "[target] fears that the fact they stole True Brujah's Temporis will be known.")
		if(clan.get_discipline("Valeren") && vampire.clane?.name != "Salubri")
			to_chat(owner, "[target] fears that the fact they stole Salubri's Valeren will be known.")
		if(clan.get_discipline("Mytherceria") && vampire.clane?.name != "Kiasyd")
			to_chat(owner, "[target] fears that the fact they stole Kiasyd's Mytherceria will be known.")

/datum/daimonion/proc/baali_get_clan_weakness(target, owner)
	if(!owner || !target)
		return
	var/mob/living/carbon/human/vampire = target
	if(iskindred(vampire))
//		var/datum/species/kindred/clan = vampire.dna.species
		if(vampire.clane?.name)
			if(vampire.clane?.name == "Toreador")
				to_chat(owner, "[target] is too clingy to the art.")
				return
			if(vampire.clane?.name == "Daughters of Cacophony")
				to_chat(owner, "[target]'s mind is envelopped by nonstopping music.")
				return
			if(vampire.clane?.name == "Ventrue")
				to_chat(owner, "[target] finds no pleasure in poor's blood.")
				return
			if(vampire.clane?.name == "Lasombra")
				to_chat(owner, "[target] is afraid of modern technology.")
				return
			if(vampire.clane?.name == "Tzimisce")
				to_chat(owner, "[target] is tied to its domain.")
				return
			if(vampire.clane?.name == "Gangrel")
				to_chat(owner, "[target] is a feral being used to the nature.")
				return
			if(vampire.clane?.name == "Malkavian")
				to_chat(owner, "[target] is unstable, the mind is ill.")
				return
			if(vampire.clane?.name == "Brujah")
				to_chat(owner, "[target] is full of uncontrollable rage.")
				return
			if(vampire.clane?.name == "Nosferatu")
				to_chat(owner, "[target] is ugly and nothing will save them.")
				return
			if(vampire.clane?.name == "Tremere")
				to_chat(owner, "[target] is weak to kindred blood and vulnerable to blood bonds.")
				return
			if(vampire.clane?.name == "Baali")
				to_chat(owner, "[target] is afraid of holy.")
				return
			if(vampire.clane?.name == "Banu Haqim")
				to_chat(owner, "[target] is addicted to kindred vitae...")
				return
			if(vampire.clane?.name == "True Brujah")
				to_chat(owner, "[target] cant express emotions.")
				return
			if(vampire.clane?.name == "Salubri")
				to_chat(owner, "[target] is unable to feed on unwilling.")
				return
			if(vampire.clane?.name == "Giovanni")
				to_chat(owner, "[target]'s bite inflicts too much harm.")
				return
			if(vampire.clane?.name == "Cappadocian")
				to_chat(owner, "[target]'s skin will stay pale and lifeless no matter what.")
				return
			if(vampire.clane?.name == "Kiasyd")
				to_chat(owner, "[target] is afraid of cold iron.")
				return
			if(vampire.clane?.name == "Gargoyle")
				to_chat(owner, "[target] is too dependent on its masters, its mind is feeble.")
				return
			if(vampire.clane?.name == "Followers of Set")
				to_chat(owner, "[target] is afraid of bright lights.")
				return
			var/clan_not_found = TRUE
			if(clan_not_found)
				to_chat(owner, "[target] is a [vampire.clane?.name]")

/datum/discipline/daimonion
	name = "Daimonion"
	desc = "Get a help from the Hell creatures, resist THE FIRE, transform into an imp. Violates Masquerade."
	icon_state = "daimonion"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/daimonion

/datum/discipline_power/daimonion
	name = "Daimonion power name"
	desc = "Daimonion power description"
	range = 20

	activate_sound = 'code/modules/wod13/sounds/protean_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/protean_deactivate.ogg'

//SENSE THE SIN
/datum/discipline_power/daimonion/sense_the_sin
	name = "Sense the Sin"
	desc = "Become supernaturally resistant to fire."

	level = 1

	target_type = TARGET_HUMAN
	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 10 SECONDS

/datum/discipline_power/daimonion/sense_the_sin/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_perception(owner))+max(get_a_empathy(owner), get_a_intimidation(owner)), get_a_willpower(target), owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at harvesting any useful info!</span>")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/sense_the_sin/activate(mob/living/carbon/human/target)
	. = ..()
	if(get_a_strength(target) <= 4)
		to_chat(owner, "[target] lacks in strength.")
	if(get_a_dexterity(target) <= 4)
		to_chat(owner, "[target] doesn't have fast movements.")
	if(get_a_stamina(target) <= 4)
		to_chat(owner, "[target]'s body is weak and feeble.")
	if(get_a_charisma(target) <= 4)
		to_chat(owner, "[target] isn't charismatic at all.")
	if(get_a_manipulation(target) <= 4)
		to_chat(owner, "[target] struggles with manipulating others.")
	if(get_a_appearance(target) <= 4)
		to_chat(owner, "[target ] is ugly.")
	if(get_a_perception(target) <= 4)
		to_chat(owner, "[target ] struggles to notice small things.")
	if(get_a_intelligence(target ) <= 4)
		to_chat(owner, "[target] isn't wise.")
	if(get_a_wits(target) <= 4)
		to_chat(owner, "[target ] brain is porridge and uninspiring.")
	if(get_a_willpower(target) <= 4)
		to_chat(owner, "[target ] mind is weak and controllable.")
	if(isgarou(target))
		to_chat(owner, "[target]'s natural banishment is silver...")
	if(iskindred(target))
		var/datum/daimonion/daim = new
		daim.baali_get_stolen_disciplines(target , owner)
		daim.baali_get_clan_weakness(target , owner)
		if(target.generation >= 10)
			to_chat(owner, "[target]'s vitae is weak and thin. You can clearly see their fear for fire, it seems that's a kindred.")
		else
			to_chat(owner, "[target]'s vitae is thick and strong. You can clearly see their fear for fire, it seems that's a kindred.")
	if(isghoul(target))
		var/mob/living/carbon/human/ghoul = target
		if(ghoul.mind.enslaved_to)
			to_chat(owner, "[target]  is addicted to vampiric vitae and its true master is [ghoul.mind.enslaved_to]")
		else
			to_chat(owner, "[target] is addicted to vampiric vitae, but is independent and free.")
	if(iscathayan(target))
		if(target.mind.dharma?.Po == "Legalist")
			to_chat(owner, "[target] hates to be controlled!")
		if(target.mind.dharma?.Po == "Rebel")
			to_chat(owner, "[target] doesn't like to be touched.")
		if(target.mind.dharma?.Po == "Monkey")
			to_chat(owner, "[target] is too focused on money, toys and other sources of easy pleasure.")
		if(target.mind.dharma?.Po == "Demon")
			to_chat(owner, "[target] is addicted to pain, as well as to inflicting it to others.")
		if(target.mind.dharma?.Po == "Fool")
			to_chat(owner, "[target] doesn't like to be pointed at!")
	if(!iskindred(target) && !isghoul(target) && !isgarou(target) && !iscathayan(target))
		to_chat(owner, "[target] is a feeble worm with no strengths or visible weaknesses, a mere human.")

//FEAR OF THE VOID BELOW
/datum/discipline_power/daimonion/fear_of_the_void_below
	name = "Fear of the Void Below"
	desc = "WILD FEAR."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_LYING | DISC_CHECK_IMMOBILE
	target_type = TARGET_HUMAN | TARGET_VAMPIRE
	violates_masquerade = TRUE

	cancelable = TRUE
	cooldown_length = 20 SECONDS

/datum/discipline_power/daimonion/fear_of_the_void_below/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_manipulation(owner), get_a_intelligence(owner))+max(get_a_intimidation(owner), get_a_occult(owner)), get_a_wits(target)+2, owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at corrupting!</span>")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/fear_of_the_void_below/activate(mob/living/carbon/human/target)
	. = ..()
	var/mob/living/carbon/human/frenzied_target = target
	if(iskindred(frenzied_target))
		if(!frenzied_target.in_frenzy) // Cause target to frenzy
			frenzied_target.enter_frenzymod()
			addtimer(CALLBACK(frenzied_target, TYPE_PROC_REF(/mob/living/carbon, exit_frenzymod)), 5 SECONDS)
	else
		if(!(frenzied_target.stat >= UNCONSCIOUS || frenzied_target.IsSleeping() || frenzied_target.IsUnconscious()))
			frenzied_target.Sleeping(20)
	frenzied_target.overlay_fullscreen("STRAH", /atom/movable/screen/fullscreen/yomi_world)
	frenzied_target.clear_fullscreen("STRAH", 3)


//CONFLAGRATION
/datum/discipline_power/daimonion/conflagration
	name = "Conflagration"
	desc = "Turn your hands into deadly claws."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE
	target_type = TARGET_MOB | TARGET_OBJ | TARGET_TURF
	cooldown_length = 10 SECONDS

/datum/discipline_power/daimonion/conflagration/activate(atom/target)
	. = ..()
	var/turf/start = get_turf(owner)
	var/obj/projectile/magic/aoe/fireball/baali/created_fireball = new(start)
	created_fireball.firer = owner
	created_fireball.preparePixelProjectile(target, start)
	created_fireball.fire(direct_target = target)
/*

/datum/discipline_power/daimonion/conflagration/post_gain()
	. = ..()
	var/obj/effect/proc_holder/spell/aimed/fireball/baali/balefire = new(owner)
	owner.mind.AddSpell(balefire)

/obj/effect/proc_holder/spell/aimed/fireball/baali
	name = "Infernal Fireball"
	desc = "This spell fires an explosive fireball at a target."
	school = "evocation"
	charge_max = 60
	clothes_req = FALSE
	invocation = "FR BRTH"
	invocation_type = INVOCATION_WHISPER
	range = 20
	cooldown_min = 20 //10 deciseconds reduction per rank
	projectile_type = /obj/projectile/magic/aoe/fireball/baali
	base_icon_state = "infernaball"
	action_icon_state = "infernaball0"
	sound = 'sound/magic/fireball.ogg'
	active_msg = "You prepare to cast your fireball spell!"
	deactive_msg = "You extinguish your fireball... for now."
	active = FALSE
*/

//PSYCHOMACHIA
/datum/discipline_power/daimonion/psychomachia
	name = "Psychomachia"
	desc = "FEAR."

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING
	target_type = TARGET_HUMAN

	violates_masquerade = TRUE
	target_type = TARGET_HUMAN
	duration_length = 30 SECONDS
	cooldown_length = 10 SECONDS


/datum/discipline_power/daimonion/psychomachia/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_appearance(owner), get_a_charisma(owner))+max(get_a_empathy(owner), get_a_intimidation(owner)), get_a_wits(target)+2, owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at inducing fear!</span>")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/psychomachia/activate(mob/living/carbon/human/target)
	. = ..()
	to_chat(target, "<span class='warning'><b>You hear infernal laugh!</span></b>")
	new /datum/hallucination/baali(target, TRUE)

//CONDEMNTATION
/datum/discipline_power/daimonion/condemnation
	name = "Condemnation"
	desc = "CURSE OF VTM13."

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING
	target_type = TARGET_HUMAN | TARGET_LIVING

	violates_masquerade = TRUE
	cooldown_length = 10 SECONDS

/*
/datum/discipline_power/daimonion/condemnation/pre_activation_checks(mob/living/target)

*/
/datum/discipline_power/daimonion/condemnation/activate(mob/living/carbon/human/target)
	. = ..()
	var/list/curses_names = list()
	if(GLOB.who_is_cursed.len > 0 && !(GLOB.who_is_cursed.Find(target)) || GLOB.who_is_cursed.len == 0)
		for(var/i in subtypesof(/datum/curse/daimonion))
			var/datum/curse/daimonion/D = i
			if(owner.generation <= D.genrequired)
				curses_names += initial(D.name)
		to_chat(owner, "<span class='userdanger'><b>To place a curse on someone is to pay the great price. Are you willing to take the risks?</b></span>")
		var/choosecurse = input(owner, "Choose curse to use:", "Daimonion") as null|anything in curses_names
		if(choosecurse)
			var/mob/living/BP = owner
			var/datum/curse/daimonion/D = choosecurse
			if(D == "No Lying Tongue")
				var/datum/curse/daimonion/lying_weakness/curs = new
				if(owner.maxbloodpool > 1)
					curs.activate(target)
					BP.cursed_bloodpool += 1
					BP.update_blood_hud()
					GLOB.who_is_cursed += target
				else
					to_chat(owner, "<span class='warning'>You don't have enough vitae to cast this curse.</span>")
			if(D == "Baby Strength")
				var/datum/curse/daimonion/physical_weakness/curs = new
				if(owner.maxbloodpool > 2)
					curs.activate(target)
					BP.cursed_bloodpool += 2
					BP.update_blood_hud()
					GLOB.who_is_cursed += target
				else
					to_chat(owner, "<span class='warning'>You don't have enough vitae to cast this curse.</span>")
			if(D == "Reap Mentality")
				var/datum/curse/daimonion/mental_weakness/curs = new
				if(owner.maxbloodpool > 3)
					curs.activate(target)
					BP.cursed_bloodpool += 3
					BP.update_blood_hud()
					GLOB.who_is_cursed += target
				else
					to_chat(owner, "<span class='warning'>You don't have enough vitae to cast this curse.</span>")
			if(D == "Sterile Vitae")
				if(iskindred(target))
					var/datum/curse/daimonion/offspring_weakness/curs = new
					if(owner.maxbloodpool > 4)
						curs.activate(target)
						BP.cursed_bloodpool += 4
						BP.update_blood_hud()
						GLOB.who_is_cursed += target
					else
						to_chat(owner, "<span class='warning'>You don't have enough vitae to cast this curse.</span>")
				else
					to_chat(owner, "<span class='warning'>[target]  is not a kindred!</span>")
			if(D == "The Mark Of Doom")
				var/datum/curse/daimonion/success_weakness/curs = new
				if(owner.maxbloodpool > 5)
					curs.activate(target)
					BP.cursed_bloodpool += 5
					BP.update_blood_hud()
					GLOB.who_is_cursed += target
				else
					to_chat(owner, "<span class='warning'>You don't have enough vitae to cast this curse.</span>")
	else
		to_chat(owner, "<span class='warning'>[target] is already cursed!</span>")

/datum/discipline_power/daimonion/condemnation/post_gain()
	. = ..()
	var/datum/action/antifrenzy/antifrenzy_contract = new()
	antifrenzy_contract.Grant(owner)

/datum/action/antifrenzy
	name = "Resist Beast"
	desc = "Resist Frenzy and Rotshreck by signing a contract with Demons."
	button_icon_state = "resist"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/used = FALSE

/datum/action/antifrenzy/Trigger()
	var/mob/living/carbon/human/user = owner
	if(user.stat >= UNCONSCIOUS || user.IsSleeping() || user.IsUnconscious() || user.IsParalyzed() || user.IsKnockdown() || user.IsStun() || HAS_TRAIT(user, TRAIT_RESTRAINED) || !isturf(user.loc))
		return
	if(used)
		to_chat(owner, span_warning("You've already signed this contract!"))
		return
	used = TRUE
	user.antifrenzy = TRUE
	SEND_SOUND(owner, sound('sound/magic/curse.ogg', 0, 0, 50))
	to_chat(owner, span_warning("You feel control over your Beast, but at what cost..."))
	qdel(src)
