GLOBAL_LIST_EMPTY(masterclad)
GLOBAL_LIST_EMPTY(miniclad)
GLOBAL_LIST_EMPTY(grafity)
GLOBAL_LIST_EMPTY(hydra)



/obj/structure/vamp/zakladkagrafity
	var/global/adress = null
	icon = 'code/modules/wod13/Zakladki/CLAD.dmi'
	icon_state = "Malenkiiklad"
	name = "Графити"
	desc = "Топ сайт "


/obj/structure/vamp/zakladkagrafity/Initialize(mapload)
	. = ..()
	GLOB.grafity += src

	if(adress == null)
		generate_adress()
	else
		desc = adress





/obj/structure/vamp/zakladkagrafity/proc/generate_adress()
	var/newAdress
	newAdress += "www."
	newAdress += pick("seradin", "nigger", "weed", "alphaPVP", "pendosi", "you", "crack", "Omega", "snow", "dead", "drunk", "cock", "meth")
	newAdress += pick("diamond", "beer", "mushroom", "assistant", "clown", "captain", "twinkie", "security", "nuke", "small", "big", "escape", "yellow", "gloves", "monkey", "engine", "nuclear", "ai")
	newAdress += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	newAdress += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	newAdress += ".luc"
	desc += newAdress
	adress = "Топ сайт [newAdress]"
	GLOB.hydra += src

/obj/structure/vamp/zakladkagrafity/Destroy()
	.=..()
	GLOB.grafity -= src
	GLOB.hydra -= src


/*
/obj/structure/vamp/zakladkagrafity/examine(mob/user)
	. = ..()


	. += adress
*/


/obj/item/vamp/zakladka
	icon = 'code/modules/wod13/Zakladki/CLAD.dmi'




/obj/item/vamp/zakladka/masterclad
	name = "Мастерклад"
	desc = "Лялялялля"
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "Masterklad1"

/obj/item/vamp/zakladka/masterclad/Initialize()
	.=..()
	GLOB.masterclad += src

/obj/item/vamp/zakladka/masterclad/Destroy()
	.=..()
	GLOB.masterclad -= src

/obj/item/vamp/zakladka/masterclad/update_icon()
	. = ..()
	icon_state = "Malenkiiklad"

/obj/item/vamp/zakladka/masterclad/interact(mob/user)

	to_chat(user, "<span class='notice'>Ты начинаешь распоковку мастерклада.</span>")
	update_icon()
	var/vibor = alert("На сколько частей ты хочешь разделить?","Мастерклад","2", "4", "6")
	switch(vibor)
		if("2")
			var/nega = 2
			src.Destroy()
			while(nega)
				nega--
				var/obj/item/vamp/zakladka/Klad/big/B = new(get_turf(user.loc))

		if("4")
			var/nega = 4
			src.Destroy()
			while(nega)
				nega--
				var/obj/item/vamp/zakladka/Klad/normal/N = new(get_turf(user.loc))

		if("6")
			var/nega = 6
			src.Destroy()
			while(nega)
				nega--
				var/obj/item/vamp/zakladka/Klad/small/S = new(get_turf(user.loc))


	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)

/obj/item/vamp/zakladka/masterclad/proc/zaklad(mob/user)






/obj/item/vamp/zakladka/Klad/small
	name = "Закладка"
	desc = "ЪУЪ ПЕНДОСЫ"
	icon_state = "Malenkiiklad"
	w_class = WEIGHT_CLASS_TINY

/obj/item/vamp/zakladka/Klad/normal
	name = "Закладка"
	desc = "ЪУЪ VTKRB ПЕНДОСЫ"
	icon_state = "Malenkiiklad"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/vamp/zakladka/Klad/big
	name = "Закладка"
	desc = "ЪУЪ ОВОЩ ПЕНДОСЫ"
	icon_state = "Malenkiiklad"
	w_class = WEIGHT_CLASS_SMALL
