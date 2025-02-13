/obj/item/dagon
	name = "Dagon"
	desc = "Wand. Has different gradations of strength"
	icon_state = "wiredrod"
	var/dagon_power = 400
/obj/item/dagon/two
	dagon_power = 500
/obj/item/dagon/three
	dagon_power = 600
/obj/item/dagon/fourth
	dagon_power = 700
/obj/item/dagon/five
	dagon_power = 800
/obj/item/dagon/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/victim = target
		victim.apply_damage(dagon_power, BURN,)

/mob/living/simple_animal/hostile/bear/wod13
	name = "bear"
	desc = "IS THAT A FUCKING BEAR-"
	icon = 'code/modules/wod13/64x64.dmi'
	emote_hear = list("roars.")
	emote_see = list("shakes its head.", "stomps.")
	butcher_results = list(/obj/item/food/meat/slab = 7)
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "gently pushes"
	response_disarm_simple = "gently push"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"


	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 8
	maxbloodpool = 8
	del_on_death = 1
	maxHealth = 500
	health = 500
	cached_multiplicative_slowdown = 2

	bloodpool = 1
	maxbloodpool = 1
	maxHealth = 850
	health = 850


	melee_damage_lower = 35
	melee_damage_upper = 40
