/datum/discipline/dominate
	name = "Dominate"
	desc = "Supresses will of your targets and forces them to obey you, if their will is not more powerful than yours."
	icon_state = "dominate"
	cost = 1
	ranged = TRUE
	delay = 15 SECONDS
	activate_sound = 'code/modules/wod13/sounds/dominate.ogg'
	fearless = TRUE
	var/obj/effect/proc_holder/spell/pointed/mind_transfer/MT

/datum/discipline/dominate/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
	if(!MT)
		MT = new (caster)
	if(iscathayan(target))
		if(target.mind.dharma?.Po == "Legalist")
			target.mind.dharma?.roll_po(caster, target)
	if(target.spell_immunity)
		return
	var/dominate_me = FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.clane?.name == "Gargoyle")
			dominate_me = TRUE
	if(HAS_TRAIT(caster, TRAIT_MUTE))
		to_chat(caster, "<span class='warning'>You find yourself unable to speak!</span>")
		return
	if(target.generation < caster.generation)
		to_chat(caster, "<span class='warning'>[target]'s blood is too potence to dominate!</span>")
		return
	var/difficulties_dominating = get_a_willpower(target)
	if(dominate_me)
		difficulties_dominating = 1
	var/mypower = secret_vampireroll(max(get_a_strength(caster), get_a_manipulation(caster))+get_a_intimidation(caster), difficulties_dominating, caster)
	if(mypower < 3)
		to_chat(caster, "<span class='warning'>You fail at dominating!</span>")
		caster.emote("stare")
		if(mypower == -1)
			caster.Stun(3 SECONDS)
			caster.do_jitter_animation(10)
		return
	var/mob/living/carbon/human/TRGT
	if(ishuman(target))
		TRGT = target
		TRGT.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/dominate_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "dominate", -MUTATIONS_LAYER)
		dominate_overlay.pixel_z = 2
		TRGT.overlays_standing[MUTATIONS_LAYER] = dominate_overlay
		TRGT.apply_overlay(MUTATIONS_LAYER)
	switch(level_casting)
		if(1)
			to_chat(target, "<span class='userdanger'><b>FORGET ABOUT IT</b></span>")
			caster.say("FORGET ABOUT IT!!")
			ADD_TRAIT(target, TRAIT_BLIND, "dominate")
			spawn(30)
				if(target)
					REMOVE_TRAIT(target, TRAIT_BLIND, "dominate")
		if(2)
			target.Immobilize(5)
			if(target.body_position == STANDING_UP)
				to_chat(target, "<span class='userdanger'><b>GET DOWN</b></span>")
				target.toggle_resting()
				caster.say("GET DOWN!!")
			else
				to_chat(target, "<span class='userdanger'><b>STAY DOWN</b></span>")
				caster.say("STAY DOWN!!")
		if(3)
			to_chat(target, "<span class='userdanger'><b>THINK TWICE</b></span>")
			caster.say("THINK TWICE!!")
			target.add_movespeed_modifier(/datum/movespeed_modifier/dominate)
			spawn(30)
				if(target)
					target.remove_movespeed_modifier(/datum/movespeed_modifier/dominate)
		if(4)
			to_chat(target, "<span class='userdanger'><b>THINK TWICE</b></span>")
			caster.say("THINK TWICE!!")
			target.add_movespeed_modifier(/datum/movespeed_modifier/dominate)
			spawn(60)
				if(target)
					target.remove_movespeed_modifier(/datum/movespeed_modifier/dominate)
		if(5)
//			MT.cast(list(target), caster, FALSE)
			if(!target.spell_immunity)
				to_chat(target, "<span class='userdanger'><b>YOU SHOULD KILL YOURSELF NOW</b></span>")
				caster.say("YOU SHOULD KILL YOURSELF NOW!!")
				target.Immobilize(5 SECONDS, TRUE)
				if(do_mob(target, target, 6 SECONDS))
					if(ishuman(target))
						var/mob/living/carbon/human/suicider = target
						suicider.suicide()

	spawn(2 SECONDS)
		if(TRGT)
			TRGT.remove_overlay(MUTATIONS_LAYER)
