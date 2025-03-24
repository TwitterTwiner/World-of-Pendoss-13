/datum/discipline/vicissitude
	name = "Vicissitude"
	desc = "It is widely known as Tzimisce art of flesh and bone shaping. Violates Masquerade."
	icon_state = "vicissitude"
	cost = 1
	ranged = FALSE
	delay = 12 SECONDS
	range_sh = 2
	violates_masquerade = TRUE
	clane_restricted = TRUE
	dead_restricted = FALSE
	var/last_hair
	var/last_facehair
	var/last_skintone
	var/last_gender
	var/last_bodytype
	var/last_haircolor
	var/last_facialhaircolor
	var/last_bodysprite
	var/last_eyecolor
	var/last_realname
	var/last_headshot
	var/last_age
	var/last_body_mode

	var/original_hair
	var/original_facehair
	var/original_headshot
	var/original_skintone
	var/original_gender
	var/original_bodytype
	var/original_haircolor
	var/original_facialhaircolor
	var/original_bodysprite
	var/original_eyecolor
	var/original_realname
	var/original_age
	var/original_body_mode
	var/furry_changed = FALSE

/obj/item/melee/touch_attack/vicissitude_touch
	name = "\improper flesh touch"
	desc = "Play twister with your friends."
	catchphrase = null
	on_use_sound = 'code/modules/wod13/sounds/vicissitude.ogg'
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "vicissitude"
	inhand_icon_state = "zapper"

/obj/item/melee/touch_attack/vicissitude_touch/Click()
	src.Destroy()

/obj/item/melee/touch_attack/vicissitude_touch/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.stat >= HARD_CRIT)
			if(istype(target, /mob/living/carbon/human/npc))
				var/mob/living/carbon/human/npc/NPC = target
				NPC.last_attacker = null
			if(!iskindred(target) && !isgarou(target) && !iscathayan(target))	//Who tf wrote this with || lmao
				if(H.stat != DEAD)
					H.death()
				var/obj/item/bodypart/B1 = H.get_bodypart(BODY_ZONE_R_ARM)
				var/obj/item/bodypart/B2 = H.get_bodypart(BODY_ZONE_L_ARM)
				var/obj/item/bodypart/B3 = H.get_bodypart(BODY_ZONE_R_LEG)
				var/obj/item/bodypart/B4 = H.get_bodypart(BODY_ZONE_L_LEG)
				var/obj/item/bodypart/CH = H.get_bodypart(BODY_ZONE_CHEST)
				var/obj/item/bodypart/HE = H.get_bodypart(BODY_ZONE_HEAD)
				if(B1)
					B1.drop_limb()
				if(B2)
					B2.drop_limb()
				if(B3)
					B3.drop_limb()
				if(B4)
					B4.drop_limb()
				if(CH)
					CH.dismember()
				if(HE)
					HE.dismember()
				new /obj/item/stack/human_flesh/fifty(target.loc)
				new /obj/item/guts(target.loc)
				new /obj/item/spine(target.loc)
				qdel(target)
		else
			H.emote("scream")
			H.apply_damage(30, BRUTE, BODY_ZONE_CHEST)
			H.apply_damage(10, CLONE)
			if(prob(5))
				var/obj/item/bodypart/B = H.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
				if(B)
					B.drop_limb()
	else if(isliving(target))
		var/mob/living/Twister = target
		Twister.Stun(20)
		Twister.apply_damage(30, BRUTE)
		Twister.apply_damage(10, CLONE)
		Twister.visible_message("<span class='danger'>[target]'s skin writhes like worms, twisting and contorting!</span>", "<span class='userdanger'>Your flesh twists unnaturally!</span>")

/datum/discipline/vicissitude/activate(mob/living/target, mob/living/carbon/human/caster)
	. = ..()
	switch(level_casting)
		if(1)
			var/mob/living/carbon/human/H = caster
			var/list/nibbers = list()
			for(var/mob/living/carbon/human/HU in oviewers(6, H))
				if(HU)
					nibbers += HU
			if(!furry_changed)
				if(last_hair)
					if(alert("Continue with last saved appearance?",,"Yes","No")=="Yes")
						caster.switch_masquerade(H)
						original_hair = H.hairstyle
						original_facehair = H.facial_hairstyle
						original_skintone = H.skin_tone
						original_gender = H.gender
						original_bodytype = H.body_type
						original_haircolor = H.hair_color
						original_facialhaircolor = H.facial_hair_color
						original_bodysprite = H.unique_body_sprite
						original_eyecolor = H.eye_color
						original_realname = H.real_name
						original_headshot = H.headshot_link
						original_age = H.age
						original_body_mode = H.base_body_mod
						playsound(get_turf(H), 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE, -6)
						H.Stun(10)
						H.do_jitter_animation(10)
						H.hairstyle = last_hair
						H.facial_hairstyle = last_facehair
						H.skin_tone = last_skintone
						H.gender = last_gender
						H.body_type = last_bodytype
						H.hair_color = last_haircolor
						H.facial_hair_color = last_facialhaircolor
						H.unique_body_sprite = last_bodysprite
						H.eye_color = last_eyecolor
						H.real_name = last_realname
						H.headshot_link = last_headshot
						H.name = H.real_name
						H.age = last_age
						H.base_body_mod = last_body_mode
						H.update_body()
						H.update_hair()
						H.update_body_parts()
						furry_changed = TRUE
						return
				if(length(nibbers) >= 1)
					var/victim = input(caster, "Choose victim to copy:", "Vicissitude Appearance") as null|mob in nibbers
					if(victim)
						H.switch_masquerade(H)
						original_hair = H.hairstyle
						original_facehair = H.facial_hairstyle
						original_skintone = H.skin_tone
						original_gender = H.gender
						original_bodytype = H.body_type
						original_haircolor = H.hair_color
						original_facialhaircolor = H.facial_hair_color
						original_bodysprite = H.unique_body_sprite
						original_eyecolor = H.eye_color
						original_realname = H.real_name
						original_headshot = H.headshot_link
						original_age = H.age
						original_body_mode = H.base_body_mod
						playsound(get_turf(H), 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE, -6)
						H.Stun(10)
						H.do_jitter_animation(10)
						var/mob/living/carbon/human/ZV = victim
						H.hairstyle = ZV.hairstyle
						H.facial_hairstyle = ZV.facial_hairstyle
						H.skin_tone = ZV.skin_tone
						H.gender = ZV.gender
						H.body_type = ZV.body_type
						H.hair_color = ZV.hair_color
						H.facial_hair_color = ZV.facial_hair_color
						H.unique_body_sprite = ZV.unique_body_sprite
						H.eye_color = ZV.eye_color
						H.real_name = ZV.real_name
						H.headshot_link = ZV.headshot_link
						H.name = H.real_name
						H.age = ZV.age
						H.base_body_mod = ZV.base_body_mod
						H.update_body()
						H.update_hair()
						H.update_body_parts()
						last_hair = H.hairstyle
						last_facehair = H.facial_hairstyle
						last_skintone = H.skin_tone
						last_gender = H.gender
						last_bodytype = H.body_type
						last_haircolor = H.hair_color
						last_facialhaircolor = H.facial_hair_color
						last_bodysprite = H.unique_body_sprite
						last_eyecolor = H.eye_color
						last_realname = H.real_name
						last_headshot = H.headshot_link
						last_age = H.age
						last_body_mode = H.base_body_mod
						furry_changed = TRUE
					else
						return
				else
					to_chat(H, "<span class='warning'>You see no soul which can be copied...</span>")
					return
				return
			else
				H.switch_masquerade(H)
				playsound(get_turf(H), 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE, -6)
				H.Stun(10)
				H.do_jitter_animation(10)
				H.hairstyle = original_hair
				H.facial_hairstyle = original_facehair
				H.skin_tone = original_skintone
				H.gender = original_gender
				H.body_type = original_bodytype
				H.hair_color = original_haircolor
				H.facial_hair_color = original_facialhaircolor
				H.unique_body_sprite = original_bodysprite
				if(H.additional_armor)
					H.unique_body_sprite = "tziarmor"
				H.eye_color = original_eyecolor
				H.real_name = original_realname
				H.name = H.real_name
				H.headshot_link = original_headshot
				H.age = original_age
				H.base_body_mod = original_body_mode
				H.update_body()
				H.update_hair()
				H.update_body_parts()
				furry_changed = FALSE
				return
		if(2)
			caster.drop_all_held_items()
			caster.put_in_active_hand(new /obj/item/melee/touch_attack/vicissitude_touch(caster))
		if(3)
			var/obj/item/gun/magic/hook/flesh_shintai/fleshhook = new (caster)
			caster.drop_all_held_items()
			caster.put_in_active_hand(fleshhook)
			spawn(delay+caster.discipline_time_plus)
				qdel(fleshhook)
		if(4)
			var/datum/warform/Warform = new
			Warform.transform(/mob/living/simple_animal/hostile/bloodcrawler, caster, TRUE)
		if(5)
			var/datum/warform/Warform = new
			Warform.transform(/mob/living/simple_animal/hostile/tzimisce_beast, caster, TRUE)
	//else
		//target.death() - Removed until a better solution is found to not have insta-kills on player mobs, unsure of side effects for normal vicissitude use but call death above already so should be fine?
