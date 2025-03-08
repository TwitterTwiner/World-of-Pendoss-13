/datum/discipline/obtenebration
	name = "Obtenebration"
	desc = "Controls the darkness around you."
	icon_state = "obtenebration"
	cost = 1
	ranged = TRUE
	delay = 100
	violates_masquerade = TRUE
	clane_restricted = TRUE
	activate_sound = 'sound/magic/voidblink.ogg'

/datum/discipline/obtenebration/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
	if(level_casting == 1)
		var/atom/movable/AM = new(target)
		AM.set_light(3, -7)
		spawn(delay+caster.discipline_time_plus)
			AM.set_light(0)
	else
		target.Stun(10*(level_casting-1))
		var/obj/item/ammo_casing/magic/tentacle/lasombra/casing = new (caster.loc)
		casing.fire_casing(target, caster, null, null, null, ran_zone(), 0,  caster)
