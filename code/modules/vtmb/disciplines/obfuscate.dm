/datum/discipline/obfuscate
	name = "Obfuscate"
	desc = "Makes you less noticable for living and un-living beings."
	icon_state = "obfuscate"
	cost = 1
	ranged = FALSE
	delay = 30 SECONDS
	activate_sound = 'code/modules/wod13/sounds/obfuscate_activate.ogg'

/datum/discipline/obfuscate/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if(NPC)
			if(NPC.danger_source == caster)
				NPC.danger_source = null
	caster.invisibility = INVISIBILITY_LEVEL_OBFUSCATE+level_casting
	caster.alpha = 100
	caster.obfuscate_level = level_casting
	if(level_casting != 1)
		spawn((delay)+caster.discipline_time_plus)
			if(caster)
				if(caster.invisibility != initial(caster.invisibility))
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/obfuscate_deactivate.ogg', 50, FALSE)
					caster.invisibility = initial(caster.invisibility)
					caster.alpha = 255
