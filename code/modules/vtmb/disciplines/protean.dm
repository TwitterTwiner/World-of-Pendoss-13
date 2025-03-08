/datum/discipline/protean
	name = "Protean"
	desc = "Lets your beast out, making you stronger and faster. Violates Masquerade."
	icon_state = "protean"
	cost = 1
	ranged = FALSE
	delay = 20 SECONDS
	violates_masquerade = TRUE
	activate_sound = 'code/modules/wod13/sounds/protean_activate.ogg'
	clane_restricted = TRUE

/datum/discipline/protean/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
	var/mod = min(4, level_casting)
//	var/mutable_appearance/protean_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "protean[mod]", -PROTEAN_LAYER)
	switch(mod)
		if(1)
			caster.drop_all_held_items()
			caster.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(caster))
			caster.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(caster))
			caster.add_client_colour(/datum/client_colour/glass_colour/red)
//			caster.dna.species.attack_verb = "slash"
//			caster.dna.species.attack_sound = 'sound/weapons/slash.ogg'
//			caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow+10
//			caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh+10
//			caster.remove_overlay(PROTEAN_LAYER)
//			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
//			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					for(var/obj/item/melee/vampirearms/knife/gangrel/G in caster.contents)
						if(G)
							qdel(G)
					caster.remove_client_colour(/datum/client_colour/glass_colour/red)
//					if(caster.dna)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
//						caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
//						caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)
//						caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow-10
//						caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh-10
//						caster.remove_overlay(PROTEAN_LAYER)
		if(2)
			caster.drop_all_held_items()
			caster.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(caster))
			caster.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(caster))
			caster.add_client_colour(/datum/client_colour/glass_colour/red)
//			caster.dna.species.attack_verb = "slash"
//			caster.dna.species.attack_sound = 'sound/weapons/slash.ogg'
//			caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow+15
//			caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh+15
			caster.add_movespeed_modifier(/datum/movespeed_modifier/protean2)
//			caster.remove_overlay(PROTEAN_LAYER)
//			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
//			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					for(var/obj/item/melee/vampirearms/knife/gangrel/G in caster.contents)
						if(G)
							qdel(G)
					caster.remove_client_colour(/datum/client_colour/glass_colour/red)
//					if(caster.dna)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
//						caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
//						caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)
//						caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow-15
//						caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh-15
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean2)
//						caster.remove_overlay(PROTEAN_LAYER)
		if(3)
			caster.drop_all_held_items()
			var/datum/warform/Warform = new
			Warform.transform(/mob/living/simple_animal/hostile/gangrel, caster, TRUE)
//			caster.dna.species.attack_verb = "slash"
//			caster.dna.species.attack_sound = 'sound/weapons/slash.ogg'
//			caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow+20
//			caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh+20
//			caster.add_movespeed_modifier(/datum/movespeed_modifier/protean3)
//			caster.remove_overlay(PROTEAN_LAYER)
//			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
//			caster.apply_overlay(PROTEAN_LAYER)
//			spawn(delay+caster.discipline_time_plus)
//				if(caster && caster.stat != DEAD)
//					GA.Restore(GA.myshape)
//					caster.Stun(15)
//					caster.do_jitter_animation(30)
//					if(caster.dna)
//					caster.playsound_local(caster, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
//						caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
//						caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)
//						caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow-20
//						caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh-20
//						caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean3)
//						caster.remove_overlay(PROTEAN_LAYER)
		if(4 to 5)
			caster.drop_all_held_items()
			if(level_casting == 4)
				var/datum/warform/Warform = new
				Warform.transform(/mob/living/simple_animal/hostile/gangrel/best, caster, TRUE)
			if(level_casting == 5)
				var/datum/warform/Warform = new
				Warform.transform(/mob/living/simple_animal/hostile/crinos_beast, caster, TRUE)
//			caster.dna.species.attack_verb = "slash"
//			caster.dna.species.attack_sound = 'sound/weapons/slash.ogg'
//			caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow+25
//			caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagelow+25
//			if(level_casting == 5)
//				caster.add_movespeed_modifier(/datum/movespeed_modifier/protean5)
//			else
//				caster.add_movespeed_modifier(/datum/movespeed_modifier/protean4)
//			caster.remove_overlay(PROTEAN_LAYER)
//			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
//			caster.apply_overlay(PROTEAN_LAYER)
//			spawn(delay+caster.discipline_time_plus)
//				if(caster && caster.stat != DEAD)
//					GA.Restore(GA.myshape)
//					caster.Stun(1 SECONDS)
//					caster.do_jitter_animation(1.5 SECONDS)
//					if(caster.dna)
//					caster.playsound_local(caster, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
//						caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
//						caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)
//						caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow-25
//						caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh-25
//						if(level_casting == 5)
//							caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean5)
//						else
//							caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean4)
//						caster.remove_overlay(PROTEAN_LAYER)

/datum/movespeed_modifier/protean2
	multiplicative_slowdown = -0.15
