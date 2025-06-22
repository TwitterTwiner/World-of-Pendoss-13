/datum/discipline/necromancy
	name = "Necromancy"
	desc = "Offers control over another, undead reality."
	icon_state = "necromancy"
	cost = 1
	ranged = TRUE
	range_sh = 2
	delay = 50
	violates_masquerade = TRUE
	clane_restricted = TRUE
	dead_restricted = FALSE

/datum/discipline/necromancy/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
	caster.playsound_local(target.loc, 'code/modules/wod13/sounds/necromancy.ogg', 50, TRUE)
	var/limit = min(3, level)+get_a_intelligence(caster)+get_a_occult(caster)
	if(length(caster.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/B = pick(caster.beastmaster)
		B.death()
	if(target.stat == DEAD)
		if(istype(target, /mob/living/simple_animal))
			if(istype(target, /mob/living/simple_animal/pet/rat))
				to_chat(caster, "[caster], ты че, долбаеб?") // {T.WINER} ВРЕМЕННАЯ ЗАТЫЧКА
			to_chat(caster, "Это тело уже не поднять...")
			return
		switch(level_casting)
			if(1)
				if(!length(caster.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(caster)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(caster)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level1(caster.loc)
				M.my_creator = caster
				caster.beastmaster |= M
				M.beastmaster = caster
//				if(target.key)
//					M.key = target.key
//				else
//					M.give_player()
				target.gib()
			if(2)
				if(!length(caster.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(caster)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(caster)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level2(caster.loc)
				M.my_creator = caster
				caster.beastmaster |= M
				M.beastmaster = caster
				target.gib()
			if(3)
				if(!length(caster.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(caster)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(caster)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level3(caster.loc)
				M.my_creator = caster
				caster.beastmaster |= M
				M.beastmaster = caster
				target.gib()
			if(4)
				if(!length(caster.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(caster)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(caster)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level4(caster.loc)
				M.my_creator = caster
				caster.beastmaster |= M
				M.beastmaster = caster
				target.gib()
			if(5)
				if(!length(caster.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(caster)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(caster)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level5(caster.loc)
				M.my_creator = caster
				caster.beastmaster |= M
				M.beastmaster = caster
				target.gib()
	else
		target.apply_damage(5 * level_casting, BRUTE, caster.zone_selected)
		target.apply_damage(6 * level_casting, CLONE, caster.zone_selected)
		target.emote("scream")
