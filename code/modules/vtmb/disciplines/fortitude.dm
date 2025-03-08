/datum/discipline/fortitude
	name = "Fortitude"
	desc = "Boosts armor."
	icon_state = "fortitude"
	cost = 1
	ranged = FALSE
	delay = 30 SECONDS
	activate_sound = 'code/modules/wod13/sounds/fortitude_activate.ogg'

/datum/discipline/fortitude/post_gain(mob/living/carbon/human/H)
	H.attributes.passive_fortitude = level

/datum/discipline/fortitude/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
//	caster.remove_overlay(FORTITUDE_LAYER)
//	var/mutable_appearance/fortitude_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "fortitude", -FORTITUDE_LAYER)
//	caster.overlays_standing[FORTITUDE_LAYER] = fortitude_overlay
//	caster.apply_overlay(FORTITUDE_LAYER)
	caster.attributes.fortitude_bonus = level_casting
	spawn(delay+caster.discipline_time_plus)
		if(caster)
			caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/fortitude_deactivate.ogg', 50, FALSE)
			caster.attributes.fortitude_bonus = 0
//			caster.remove_overlay(FORTITUDE_LAYER)
