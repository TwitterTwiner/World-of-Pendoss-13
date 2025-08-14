/datum/discipline/thaumaturgy_path_of_flames
	name = "Thaumaturgy: The Lure of Flames"
	desc = "This ability grants the thaumaturge the ability to summon magical flames - initially a small flame, but experienced mages can create large flames. Violates Masquerade."
	icon_state = "thaumaturgy"
	learnable_by_clans = list(/datum/vampireclane/tremere)
	power_type = /datum/discipline_power/thaumaturgy_path_of_flames

/datum/discipline/thaumaturgy_path_of_flames/post_gain()
	. = ..()
	owner.faction |= "Tremere"
	ADD_TRAIT(owner, TRAIT_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/arctome)

/datum/discipline_power/thaumaturgy_path_of_flames
	name = "Thaumaturgy: The Lure of Flames power name"
	desc = "Thaumaturgy: The Lure of Flames description"

	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED
	target_type = TARGET_MOB | TARGET_OBJ | TARGET_TURF
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE
	range = 20

	cooldown_length = 3 TURNS
	var/success_roll
	var/fire_damage
	var/fortitude_hardness
	var/fortitude_absorb = 1

/datum/discipline_power/thaumaturgy_path_of_flames/pre_activation_checks(atom/target)
	. = ..()
	success_roll = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll < 0)
		to_chat(owner, span_danger("You lose the control of the flames as they coat you!"))
		lure_of_flames_botch_effect()
		return FALSE
	else if(success_roll == 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE



/datum/discipline_power/thaumaturgy_path_of_flames/proc/lure_of_flames_botch_effect()
	var/turf/start = get_turf(owner)
	var/obj/projectile/magic/aoe/fireball/created_fireball = new(start)
	created_fireball.damage_type = CLONE
	created_fireball.damage = fire_damage
	created_fireball.firer = owner
	created_fireball.preparePixelProjectile(owner, start)
	created_fireball.fire(direct_target = owner)

/datum/discipline_power/thaumaturgy_path_of_flames/candle
	name = "Candle"
	desc = "Summon magical flames"
	fire_damage = 25
	fortitude_hardness = 3
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame,
		/datum/discipline_power/thaumaturgy_path_of_flames/campfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/bonfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	)

/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame
	name = "Palm of flame"
	desc = "Summon magical flames"
	fire_damage = 25
	fortitude_hardness = 4
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/candle,
		/datum/discipline_power/thaumaturgy_path_of_flames/campfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/bonfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	)

/datum/discipline_power/thaumaturgy_path_of_flames/campfire
	name = "Campfire"
	desc = "Summon magical flames"
	fire_damage = 50
	fortitude_hardness = 5
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/candle,
		/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame,
		/datum/discipline_power/thaumaturgy_path_of_flames/bonfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	)

/datum/discipline_power/thaumaturgy_path_of_flames/bonfire
	name = "Bonfire"
	desc = "Summon magical flames"
	fire_damage = 50
	fortitude_hardness = 7
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/candle,
		/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame,
		/datum/discipline_power/thaumaturgy_path_of_flames/campfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	)

/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	name = "Inferno"
	desc = "Summon magical flames"
	fire_damage = 75
	fortitude_hardness = 9
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/candle,
		/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame,
		/datum/discipline_power/thaumaturgy_path_of_flames/campfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/bonfire
	)


/datum/discipline_power/thaumaturgy_path_of_flames/activate(atom/target)
	. = ..()
	if(istype(target, /mob/living))
		if(get_fortitude_dices(target))
			fortitude_absorb = max(1, secret_vampireroll(get_fortitude_dices(target), fortitude_hardness, target))
	var/turf/start = get_turf(owner)
	var/obj/projectile/magic/aoe/fireball/created_fireball = new(start)
	created_fireball.damage_type = CLONE
	created_fireball.damage = fire_damage/fortitude_absorb
	created_fireball.firer = owner
	created_fireball.preparePixelProjectile(target, start)
	created_fireball.fire(direct_target = target)


