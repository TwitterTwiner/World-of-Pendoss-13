/datum/vampireclane/giovanni
	name = "Giovanni"
	desc = "The Giovanni are the usurpers of Clan Cappadocian and one of the youngest clans. The Giovanni has historically been both a clan and a family. They Embrace almost exclusively within their family, and are heavily focused on the goals of money and necromantic power."
	curse = "Harmful bites."
	clane_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/dominate,
		/datum/discipline/necromancy
	)
	male_clothes = /obj/item/clothing/under/vampire/suit
	female_clothes = /obj/item/clothing/under/vampire/suit/female
	whitelisted = FALSE

/datum/discipline/necromancy/post_gain(mob/living/carbon/human/H)
	H.faction |= "Giovanni"
	H.grant_language(/datum/language/italian)
	if(level >= 2)
		var/datum/action/ghost_hear/GH = new()
		GH.Grant(H)

/datum/action/ghost_hear
	name = "Oblivion Communication"
	desc = "Allows you to see and hear ghosts."
	button_icon_state = "ghost"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/next_activation = 0

/datum/action/ghost_hear/Trigger()
	. = ..()
	if(next_activation > world.time)
		to_chat(owner, "<span class='warning'>It's too soon to use Oblivion Communication again.</span>")
		return
	next_activation = world.time+10 SECONDS
	if(isliving(owner))
		var/mob/living/L = owner
		if(!L.hearing_ghosts)
			L.see_invisible = SEE_INVISIBLE_OBSERVER
			L.client.prefs.chat_toggles ^= CHAT_DEAD
			notify_ghosts("All ghosts are being called by [L]!", source = L, action = NOTIFY_ORBIT, header = "Ghost Summoning")
			to_chat(owner, "<span class='notice'>You activate the Oblivion Communication.</span>")
		else
			L.update_sight()
			L.client?.prefs.chat_toggles &= ~CHAT_DEAD
			to_chat(owner, "<span class='warning'>You deactivate the Oblivion Communication.</span>")
