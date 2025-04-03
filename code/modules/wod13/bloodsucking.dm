/mob/living/carbon/human/proc/add_bite_animation()
	remove_overlay(BITE_LAYER)
	var/mutable_appearance/bite_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "bite", -BITE_LAYER)
	overlays_standing[BITE_LAYER] = bite_overlay
	apply_overlay(BITE_LAYER)
	spawn(15)
		if(src)
			remove_overlay(BITE_LAYER)

/proc/get_needed_difference_between_numbers(var/number1, var/number2)
	if(number1 > number2)
		return number1 - number2
	else if(number1 < number2)
		return number2 - number1
	else
		return 1

/mob/living/carbon/human/proc/drinksomeblood(var/mob/living/carbon/human/user, var/mob/living/target)
	last_drinkblood_use = world.time

	if(client)
		client.images -= suckbar
	qdel(suckbar)
	suckbar_loc = target
	suckbar = image('code/modules/wod13/bloodcounter.dmi', suckbar_loc, "[round(14*(target.bloodpool/target.maxbloodpool))]", HUD_LAYER)
	suckbar.pixel_z = 40
	suckbar.plane = ABOVE_HUD_PLANE
	suckbar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA

	if(client)
		client.images += suckbar

	if(iskindred(target) || iscathayan(target) || isgarou(target) || iswerewolf(target))
		var/mob/living/carbon/human/carbon = target

		var/selfcontrol = 3

		if(carbon.MyPath)
			selfcontrol = carbon.MyPath.selfcontrol

		var/modifikator = secret_vampireroll(selfcontrol, 8, carbon, TRUE)

		if(modifikator == -1)
			target.visible_message("<span class='danger'>[user]'s misses [carbon]!</span>", \
				"<span class='danger'>You avoid [user]'s kiss!</span>", "<span class='hear'>You hear a slurp!</span>", COMBAT_MESSAGE_RANGE, user)
			to_chat(user, "<span class='warning'>[carbon] shakes you off!</span>")
			log_combat(user, carbon, "attempted to kiss")
			last_drinkblood_use += 50
			if(client)
				client.images -= suckbar
				qdel(suckbar)
			if(carbon.pulledby)
				carbon.pulledby.stop_pulling()
			if(carbon.IsStun())
				carbon.SetStun(0)
			return
		else if(modifikator == 0)
			target.visible_message("<span class='danger'>[user]'s misses [carbon]!</span>", \
				"<span class='danger'>You avoid [user]'s kiss!</span>", "<span class='hear'>You hear a slurp!</span>", COMBAT_MESSAGE_RANGE, user)
			to_chat(user, "<span class='warning'>[carbon] shakes you off!</span>")
			log_combat(user, carbon, "attempted to kiss")
			last_drinkblood_use += 10
			if(client)
				client.images -= suckbar
				qdel(suckbar)
			if(carbon.pulledby)
				carbon.pulledby.stop_pulling()
			if(carbon.IsStun())
				carbon.SetStun(0)
			return

	var/sound/heartbeat = sound('code/modules/wod13/sounds/drinkblood2.ogg', repeat = TRUE)
	if(HAS_TRAIT(src, TRAIT_BLOODY_SUCKER))
		src.emote("moan")
		Immobilize(30, TRUE)
	playsound_local(src, heartbeat, 75, 0, channel = CHANNEL_BLOOD, use_reverb = FALSE)
	if(isnpc(target))
		var/mob/living/carbon/human/npc/NPC = target
		NPC.danger_source = null
//		NPC.last_attacker = src


	target.Stun(3 SECONDS)


	if(target.bloodpool <= 1 && target.maxbloodpool > 1)
		to_chat(src, "<span class='warning'>You feel small amount of <b>BLOOD</b> in your victim.</span>")
		if(iskindred(target) && iskindred(src) && !src.in_frenzy)
			if(!target.client)
				to_chat(src, "<span class='warning'>You need [target]'s attention to do that...</span>")
				return
			message_admins("[ADMIN_LOOKUPFLW(src)] is attempting to Diablerize [ADMIN_LOOKUPFLW(target)]")
			log_attack("[key_name(src)] is attempting to Diablerize [key_name(target)].")
			if(target.key)
				if(!GLOB.canon_event)
					to_chat(src, "<span class='warning'>It's not a canon event!</span>")
					return

				to_chat(src, "<span class='userdanger'><b>YOU TRY TO COMMIT DIABLERIE OVER [target].</b></span>")
			else
				to_chat(src, "<span class='warning'>You need [target]'s attention to do that...</span>")
				return

	if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
		if(CheckEyewitness(src, src, 7, FALSE))
			AdjustMasquerade(-1)
	if(do_after(src, 30, target = target, timed_action_flags = NONE, progress = FALSE))
		if(!iscarbon(target))
			if(istype(target, /mob/living/simple_animal/pet/rat))
				if(MyPath)
					MyPath.trigger_morality("ratdrink")
			else
				if(MyPath)
					MyPath.trigger_morality("animaldrink")
		else
			switch(target.bloodquality)
				if(BLOOD_QUALITY_HIGH)
					if(MyPath)
						MyPath.trigger_morality("gooddrink")
				if(BLOOD_QUALITY_LOW)
					if(MyPath)
						MyPath.trigger_morality("baddrink")
				if(BLOOD_QUALITY_NORMAL)
					if(MyPath)
						MyPath.trigger_morality("firstfeed")
		target.bloodpool = max(0, target.bloodpool-1)
		suckbar.icon_state = "[round(14*(target.bloodpool/target.maxbloodpool))]"
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			drunked_of |= "[H.dna.real_name]"
			if(!iskindred(target))
				H.blood_volume = max(H.blood_volume-50, 150)
			if(iscathayan(src))
				if(target.yang_chi > 0 || target.yin_chi > 0)
					if(target.yang_chi > target.yin_chi)
						target.yang_chi = target.yang_chi-1
						yang_chi = min(yang_chi+1, max_yang_chi)
						to_chat(src, "<span class='engradio'>Some <b>Yang</b> Chi energy enters you...</span>")
					else
						target.yin_chi = target.yin_chi-1
						yin_chi = min(yin_chi+1, max_yin_chi)
						to_chat(src, "<span class='medradio'>Some <b>Yin</b> Chi energy enters you...</span>")
					COOLDOWN_START(target, chi_restore, 30 SECONDS)
					update_chi_hud()
				else
					to_chat(src, "<span class='warning'>The <b>BLOOD</b> feels tasteless...</span>")
			if(H.reagents)
				if(length(H.reagents.reagent_list))
					H.reagents.trans_to(src, min(10, H.reagents.total_volume), transfered_by = target, methods = VAMPIRE)
		if(clane)
			if(clane.name == "Giovanni")
				target.adjustBruteLoss(20, TRUE)
			if(clane.name == "Ventrue" && target.bloodquality < BLOOD_QUALITY_NORMAL)	//Ventrue can suck on normal people, but not homeless people and animals. BLOOD_QUALITY_LOV - 1, BLOOD_QUALITY_NORMAL - 2, BLOOD_QUALITY_HIGH - 3. Blue blood gives +1 to suction
				to_chat(src, "<span class='warning'>You are too privileged to drink that awful <b>BLOOD</b>. Go get something better.</span>")
				visible_message("<span class='danger'>[src] throws up!</span>", "<span class='userdanger'>You throw up!</span>")
				playsound(get_turf(src), 'code/modules/wod13/sounds/vomit.ogg', 75, TRUE)
				if(isturf(loc))
					add_splatter_floor(loc)
				stop_sound_channel(CHANNEL_BLOOD)
				if(client)
					client.images -= suckbar
				qdel(suckbar)
				return
		if(iskindred(target))
			to_chat(src, "<span class='userlove'>[target]'s blood tastes HEAVENLY...</span>")
			adjustBruteLoss(-25, TRUE)
			adjustFireLoss(-10, TRUE)
		else
			to_chat(src, "<span class='warning'>You sip some <b>BLOOD</b> from your victim. It feels good.</span>")
		bloodpool = min(maxbloodpool, bloodpool+1*max(1, target.bloodquality-1))
		adjustBruteLoss(-10, TRUE)
		adjustFireLoss(-5, TRUE)
		update_damage_overlays()
		update_health_hud()
		update_blood_hud()
		if(target.bloodpool <= 0)
			if(ishuman(target))
				var/mob/living/carbon/human/K = target
				if(iskindred(target) && iskindred(src))
					var/datum/preferences/P = GLOB.preferences_datums[ckey(key)]
					var/datum/preferences/P2 = GLOB.preferences_datums[ckey(target.key)]
					AdjustHumanity(-1, 0)
					AdjustMasquerade(-1)
					if(K.generation >= generation)
						message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(target)]")
						log_attack("[key_name(src)] successfully Diablerized [key_name(target)].")
						if(key)
							if(P)
								P.diablerist = 1
							diablerist = 1
						if(K.client)
//							P2.reset_character()
							var/datum/brain_trauma/special/imaginary_friend/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend)
							trauma.friend.key = K.key
						target.death()
						if(P2)
							P2.reset_character()
							P2.reason_of_death =  "Diablerized by [true_real_name ? true_real_name : real_name] ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
						adjustBruteLoss(-50, TRUE)
						adjustFireLoss(-50, TRUE)
					else
						var/start_prob = 10
						if(HAS_TRAIT(src, TRAIT_DIABLERIE))
							start_prob = 30
						if(prob(min(99, start_prob+((generation-K.generation)*10))))
							to_chat(src, "<span class='userdanger'><b>[K]'s SOUL OVERCOMES YOURS AND GAIN CONTROL OF YOUR BODY.</b></span>")
							message_admins("[ADMIN_LOOKUPFLW(src)] tried to Diablerize [ADMIN_LOOKUPFLW(target)] and was overtaken.")
							log_attack("[key_name(src)] tried to Diablerize [key_name(target)] and was overtaken.")
							death()
							if(P)
								P.reset_character()
								P.reason_of_death = "Failed the Diablerie ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
//							ghostize(FALSE)
//							key = K.key
//							generation = K.generation
//							maxHealth = initial(maxHealth)+100*(13-generation)
//							health = initial(health)+100*(13-generation)
//							mob.death()
						else
							message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(target)]")
							log_attack("[key_name(src)] successfully Diablerized [key_name(target)].")
							if(P)
								P.diablerist = 1
								P.generation_bonus = generation-target.generation
								generation = target.generation
//								P.generation = mob.generation
							diablerist = 1
//							if(P2)
//								P2.reset_character()
//							maxHealth = initial(maxHealth)+max(0, 50*(13-generation))
//							health = initial(health)+max(0, 50*(13-generation))
							var/datum/brain_trauma/special/imaginary_friend/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend)
							trauma.friend.key = K.key
							target.death()
							if(P2)
								P2.reset_character()
								P2.reason_of_death = "Diablerized by [true_real_name ? true_real_name : real_name] ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
					if(client)
						client.images -= suckbar
					qdel(suckbar)
					return
				else
					K.blood_volume = 0
			if(ishuman(target) && !iskindred(target))
				if(target.stat != DEAD)
					if(isnpc(target))
						var/mob/living/carbon/human/npc/Npc = target
						Npc.last_attacker = null
						killed_count = killed_count+1
						if(killed_count >= 5)
//							GLOB.fuckers |= src
							SEND_SOUND(src, sound('code/modules/wod13/sounds/humanity_loss.ogg', 0, 0, 75))
							to_chat(src, "<span class='userdanger'><b>POLICE ASSAULT IN PROGRESS</b></span>")
					SEND_SOUND(src, sound('code/modules/wod13/sounds/feed_failed.ogg', 0, 0, 75))
					to_chat(src, "<span class='warning'>This sad sacrifice for your own pleasure affects something deep in your mind.</span>")
					AdjustMasquerade(-1)
					if(MyPath)
						MyPath.trigger_morality("drying")
					else
						AdjustHumanity(-1, 0)
					target.death()
			if(!ishuman(target))
				if(target.stat != DEAD)
					target.death()
			stop_sound_channel(CHANNEL_BLOOD)
			last_drinkblood_use = 0
			if(client)
				client.images -= suckbar
			qdel(suckbar)
			return
		if(grab_state >= GRAB_PASSIVE)

			stop_sound_channel(CHANNEL_BLOOD)
			user.drinksomeblood(user, target)
	else
		last_drinkblood_use += 10
		if(client)
			client.images -= suckbar
		qdel(suckbar)
		stop_sound_channel(CHANNEL_BLOOD)
		if(!iskindred(target) || !iscathayan(target))
			target.SetSleeping(50)
