/datum/discipline/protean
	name = "Protean"
	desc = "Lets your beast out, making you stronger and faster. Violates Masquerade."
	icon_state = "protean"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/protean

/datum/discipline_power/protean
	name = "Protean power name"
	desc = "Protean power description"

	activate_sound = 'code/modules/wod13/sounds/protean_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/protean_deactivate.ogg'

//EYES OF THE BEAST
/datum/discipline_power/protean/eyes_of_the_beast
	name = "Eyes of the Beast"
	desc = "Let your eyes be a gateway to your Beast. Gain its eyes."

	level = 1

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS

	grouped_powers = list(
		/datum/discipline_power/protean/feral_claws,
		/datum/discipline_power/protean/earth_meld,
		/datum/discipline_power/protean/shape_of_the_beast,
		/datum/discipline_power/protean/mist_form
	)

/datum/discipline_power/protean/eyes_of_the_beast/activate()
	. = ..()
	owner.drop_all_held_items()
	owner.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.add_client_colour(/datum/client_colour/glass_colour/red)

/datum/discipline_power/protean/eyes_of_the_beast/deactivate()
	. = ..()
	for(var/obj/item/melee/vampirearms/knife/gangrel/G in owner.contents)
		qdel(G)
	owner.remove_client_colour(/datum/client_colour/glass_colour/red)

//FERAL CLAWS
/datum/movespeed_modifier/protean2
	multiplicative_slowdown = -0.15

/datum/discipline_power/protean/feral_claws
	name = "Feral Claws"
	desc = "Become a predator and grow hideous talons."

	level = 2

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS

	grouped_powers = list(
		/datum/discipline_power/protean/eyes_of_the_beast,
		/datum/discipline_power/protean/earth_meld,
		/datum/discipline_power/protean/shape_of_the_beast,
		/datum/discipline_power/protean/mist_form
	)

/datum/discipline_power/protean/feral_claws/activate()
	. = ..()
	owner.drop_all_held_items()
	owner.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.add_client_colour(/datum/client_colour/glass_colour/red)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/protean2)

/datum/discipline_power/protean/feral_claws/deactivate()
	. = ..()
	for(var/obj/item/melee/vampirearms/knife/gangrel/G in owner.contents)
		qdel(G)
	owner.remove_client_colour(/datum/client_colour/glass_colour/red)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean2)

//EARTH MELD
/datum/discipline_power/protean/earth_meld
	name = "Earth Meld"
	desc = "Hide yourself in the earth itself."

	level = 3

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS


/datum/discipline_power/protean/earth_meld/activate()
	. = ..()
	var/obj/structure/bury_pit/burial_pit = new (get_turf(owner))
	burial_pit.icon_state = "pit1"
	owner.forceMove(burial_pit)


/datum/discipline_power/protean/earth_meld/deactivate()
	owner.forceMove(get_turf(owner))

//SHAPE OF THE BEAST
/*
/obj/effect/proc_holder/spell/targeted/shapeshift/gangrel
	name = "Gangrel Form"
	desc = "Take on the shape a wolf."
	charge_max = 50
	cooldown_min = 5 SECONDS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = null
	possible_shapes = list(
		/mob/living/simple_animal/hostile/bear/wod13/vampire, \
		/mob/living/simple_animal/hostile/beastmaster/rat/flying/vampire, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift, \
		/mob/living/simple_animal/pet/dog/corgi, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf/gray, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf/red, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf/white, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf/ginger, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf/brown
	)
	var/non_gangrel_shapes = list(
		/mob/living/simple_animal/hostile/beastmaster/rat/flying, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf
	)
	var/is_gangrel = FALSE

/obj/effect/proc_holder/spell/targeted/shapeshift/gangrel/cast(list/targets,mob/user = usr)
	if(src in user.mob_spell_list)
		LAZYREMOVE(user.mob_spell_list, src)
		user.mind.AddSpell(src)
	if(user.buckled)
		user.buckled.unbuckle_mob(src,force=TRUE)
	for(var/mob/living/M in targets)
		if(!shapeshift_type)
			var/list/animal_list = list()
			var/list/display_animals = list()
			if(!is_gangrel)
				for(var/path in non_gangrel_shapes)
					var/mob/living/simple_animal/animal = path
					animal_list[initial(animal.name)] = path
					var/image/animal_image = image(icon = initial(animal.icon), icon_state = initial(animal.icon_state))
					display_animals += list(initial(animal.name) = animal_image)
			else
				for(var/path in possible_shapes)
					var/mob/living/simple_animal/animal = path
					animal_list[initial(animal.name)] = path
					var/image/animal_image = image(icon = initial(animal.icon), icon_state = initial(animal.icon_state))
					display_animals += list(initial(animal.name) = animal_image)

			sort_list(display_animals)
			var/new_shapeshift_type = show_radial_menu(M, M, display_animals, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 38, require_near = TRUE)
			if(shapeshift_type)
				return
			shapeshift_type = new_shapeshift_type
			if(!shapeshift_type) //If you aren't gonna decide I am!
				shapeshift_type = pick(animal_list)
			shapeshift_type = animal_list[shapeshift_type]

		var/obj/shapeshift_holder/S = locate() in M
		if(S)
			M = Restore(M)
		else
			M = Shapeshift(M)
*/
/datum/discipline_power/protean/shape_of_the_beast
	name = "Shape of the Beast"
	desc = "Assume the form of an animal and retain your power."

	level = 4

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE
	violates_masquerade = TRUE
	var/shapeshift_type = null

	var/possible_shapes = list(
		/mob/living/simple_animal/hostile/bear/wod13/vampire, \
		/mob/living/simple_animal/hostile/beastmaster/rat/flying/vampire, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift, \
		/mob/living/simple_animal/pet/dog/corgi, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf
	)
	var/non_gangrel_shapes = list(
		/mob/living/simple_animal/hostile/beastmaster/rat/flying, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf
	)

	var/is_gangrel = FALSE
	cancelable = TRUE
	cooldown_length = 20 SECONDS


/datum/discipline_power/protean/shape_of_the_beast/pre_activation_checks(mob/living/target)
	if(owner.clane.name == "Gangrel")
		is_gangrel = TRUE
	if(!shapeshift_type)
		var/list/animal_list = list()
		var/list/display_animals = list()
		if(!is_gangrel)
			for(var/path in non_gangrel_shapes)
				var/mob/living/simple_animal/animal = path
				animal_list[initial(animal.name)] = path
				var/image/animal_image = image(icon = initial(animal.icon), icon_state = initial(animal.icon_state))
				display_animals += list(initial(animal.name) = animal_image)
		else
			for(var/path in possible_shapes)
				var/mob/living/simple_animal/animal = path
				animal_list[initial(animal.name)] = path
				var/image/animal_image = image(icon = initial(animal.icon), icon_state = initial(animal.icon_state))
				display_animals += list(initial(animal.name) = animal_image)
		sortList(display_animals)
		var/new_shapeshift_type = show_radial_menu(owner, owner, display_animals, custom_check = CALLBACK(src, PROC_REF(check_menu), owner), radius = 38, require_near = TRUE)
		if(!new_shapeshift_type)
			return FALSE
		shapeshift_type = new_shapeshift_type
		shapeshift_type = animal_list[shapeshift_type]
	return TRUE

/datum/discipline_power/protean/shape_of_the_beast/activate()
	. = ..()
	owner.drop_all_held_items()
	var/datum/warform/Warform = new
	Warform.transform(shapeshift_type, owner, TRUE)


/mob/living/simple_animal/hostile/smokecrawler/mist
	name = "Mist"
	desc = "Levitating Spritz of Water."
	speed = -1
	alpha = 20
	color = "#0920eeff"
	damage_coeff = list(BRUTE = 0, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)

//MIST FORM
/datum/discipline_power/protean/mist_form
	name = "Mist Form"
	desc = "Dissipate your body and move as mist."

	level = 5
	vitae_cost = 2

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	cooldown_length = 20 SECONDS

	var/obj/effect/proc_holder/spell/targeted/shapeshift/gangrel/best/GA

/datum/discipline_power/protean/mist_form/activate()
	. = ..()
	owner.drop_all_held_items()
	var/datum/warform/Warform = new
	Warform.transform(/mob/living/simple_animal/hostile/smokecrawler/mist, owner, TRUE)



///// FORMS for Shape of The Beast

/mob/living/simple_animal/hostile/beastmaster/shapeshift //Only used for Shapeshifting
	speed = -0.50
	maxHealth = 200
	health = 200
	harm_intent_damage = 20
	melee_damage_lower = 24
	melee_damage_upper = 42
	melee_damage_type = CLONE
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)

/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf
	name = "Black Wolf"
	desc = "Howling and Snarling."
	icon = 'code/modules/wod13/werewolf_lupus.dmi'
	icon_state = "black"
	icon_living = "black"
	icon_dead = "black_rest"

/mob/living/simple_animal/hostile/bear/wod13/vampire
	bloodquality = BLOOD_QUALITY_HIGH
	melee_damage_type = CLONE
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)

/mob/living/simple_animal/hostile/beastmaster/rat/flying/vampire
	melee_damage_type = CLONE
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)
