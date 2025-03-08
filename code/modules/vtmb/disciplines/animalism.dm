/obj/effect/spectral_wolf
	name = "Spectral Wolf"
	desc = "Bites enemies in other dimensions."
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "wolf"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/proc_holder/spell/targeted/shapeshift/animalism
	name = "Animalism Form"
	desc = "Take on the shape a rat."
	charge_max = 50
	cooldown_min = 50
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/pet/rat

/datum/discipline/animalism
	name = "Animalism"
	desc = "Summons Spectral Animals over your targets. Violates Masquerade."
	icon_state = "animalism"
	cost = 1
	delay = 20 SECONDS
	ranged = FALSE
	violates_masquerade = TRUE
	activate_sound = 'code/modules/wod13/sounds/wolves.ogg'
	dead_restricted = FALSE

/datum/discipline/animalism/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
	var/limit = get_a_charisma(caster)+get_a_empathy(caster)
	if(length(caster.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/B = pick(caster.beastmaster)
		B.death()
	switch(level_casting)
		if(1)
			if(!length(caster.beastmaster))
				var/datum/action/beastmaster_stay/E1 = new()
				E1.Grant(caster)
				var/datum/action/beastmaster_deaggro/E2 = new()
				E2.Grant(caster)
			var/mob/living/simple_animal/hostile/beastmaster/rat/R = new(get_turf(caster))
//			R.my_creator = caster
			caster.beastmaster |= R
			R.beastmaster = caster
		if(2)
			if(!length(caster.beastmaster))
				var/datum/action/beastmaster_stay/E1 = new()
				E1.Grant(caster)
				var/datum/action/beastmaster_deaggro/E2 = new()
				E2.Grant(caster)
			var/mob/living/simple_animal/hostile/beastmaster/cat/C = new(get_turf(caster))
//			C.my_creator = caster
			caster.beastmaster |= C
			C.beastmaster = caster
		if(3)
			if(!length(caster.beastmaster))
				var/datum/action/beastmaster_stay/E1 = new()
				E1.Grant(caster)
				var/datum/action/beastmaster_deaggro/E2 = new()
				E2.Grant(caster)
			var/mob/living/simple_animal/hostile/beastmaster/D = new(get_turf(caster))
//			D.my_creator = caster
			caster.beastmaster |= D
			D.beastmaster = caster
		if(4)
			if(!length(caster.beastmaster))
				var/datum/action/beastmaster_stay/E1 = new()
				E1.Grant(caster)
				var/datum/action/beastmaster_deaggro/E2 = new()
				E2.Grant(caster)
			var/mob/living/simple_animal/hostile/beastmaster/rat/flying/F = new(get_turf(caster))
//			F.my_creator = caster
			caster.beastmaster |= F
			F.beastmaster = caster
		if(5)
			var/datum/warform/Warform = new
			Warform.transform(/mob/living/simple_animal/hostile/rat_beastform, caster, FALSE)

