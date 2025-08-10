//WARRIOR VALEREN 3 - BURNING TOUCH
/datum/status_effect/burning_touch
	id = "burning_touch"
	status_type = STATUS_EFFECT_REFRESH
	duration = 6 SECONDS //Two turns
	tick_interval = 1 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/burning_touch
	var/mob/living/carbon/human/source

/atom/movable/screen/alert/status_effect/burning_touch
	name = "Burning Touch"
	desc = "THE PAIN!!! IT HURTS!!!"
	icon_state = "fire"

/datum/status_effect/burning_touch/on_creation(mob/living/carbon/new_owner, mob/living/carbon/human/new_source)
	. = ..()
	source = new_source

/datum/status_effect/burning_touch/tick()
	var/mob/living/carbon/grabber = owner
	if(source.pulling == grabber)
		grabber.adjustStaminaLoss(60, forced = TRUE)
		grabber.emote("scream")
		grabber.apply_status_effect(STATUS_EFFECT_BURNING_TOUCH, owner)

/datum/status_effect/burning_touch/Destroy()
	source = null
	return ..()