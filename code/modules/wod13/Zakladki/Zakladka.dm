GLOBAL_LIST_EMPTY(masterclad)
GLOBAL_LIST_EMPTY(miniclad)
GLOBAL_LIST_EMPTY(grafity)
GLOBAL_LIST_EMPTY(hydra)

/obj
	var/zaklad = FALSE
	var/list/klad = list()
	var/max_clad =  2

/obj/AltClick(mob/user)

/obj/structure/vamp/zakladkagrafity
	var/adress = null
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
		desc = "Топ сайт [adress]"





/obj/structure/vamp/zakladkagrafity/proc/generate_adress()
	var/newAdress
	newAdress += "www."
	newAdress += pick("seradin", "nigger", "weed", "alphaPVP", "pendosi", "you", "crack", "Omega", "snow", "dead", "drunk", "cock", "meth")
	newAdress += pick("diamond", "beer", "mushroom", "assistant", "clown", "captain", "twinkie", "security", "nuke", "small", "big", "escape", "yellow", "gloves", "monkey", "engine", "nuclear", "ai")
	newAdress += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	newAdress += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	newAdress += ".luc"
	desc += newAdress
	adress = newAdress
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
	var/datum/component/storage/ss



/obj/item/vamp/zakladka/proc/attach(obj/U, user)
	var/datum/component/storage/storage = GetComponent(/datum/component/storage)
	if(storage)
		if(SEND_SIGNAL(U, COMSIG_CONTAINS_STORAGE))
			return FALSE
		U.TakeComponent(storage)
		ss = storage
//	U.clad = src
	forceMove(U)
	layer = FLOAT_LAYER
	plane = FLOAT_PLANE

	return TRUE

/obj/item/vamp/zakladka/proc/detach(obj/U, user)
	if(ss && ss.parent == U)
		TakeComponent(ss)

	layer = initial(layer)
	plane = initial(plane)

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
	var/vibor = alert("На сколько частей ты хочешь разделить?","Мастерклад","Мет", "Конопля")
	switch(vibor)
		if("Мет")
			src.Destroy()
			var/obj/item/vamp/zakladka/raw/meth/M = new(user.loc)
			user.put_in_active_hand(M)

		if("Конопля")
			src.Destroy()
			var/obj/item/vamp/zakladka/raw/weed/W = new(user.loc)
			user.put_in_active_hand(W)



	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)




/*
/obj/item/vamp/zakladka/masterclad/attack_obj(obj/structure/S)
	if(zaklad == TRUE)
*/

/obj/item/vamp/zakladka/masterclad/attack_obj(obj/target, /obj/item/vamp/zakladka/Z, proximity, params)
	if(!proximity)
		return
	src.attach()
	src.Destroy()
/*
	if(isobj(target) && (target.zaklad & TRUE))
		spawn(10 SECONDS)
			Z.Add(src)
			SEND_SIGNAL(target, COMSIG_OBJ_ZAKLADEN)
			src.Destroy()
*/


/obj/item/vamp/zakladka/raw/weed
	name = "Конопля"
	desc = "ЪУЪ VTKRB ПЕНДОСЫ"
	icon_state = "Malenkiiklad"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/vamp/zakladka/raw/meth
	name = "Метамфетамин"
	desc = "ЪУЪ VTKRB ПЕНДОСЫ"
	icon_state = "Malenkiiklad"
	w_class = WEIGHT_CLASS_NORMAL


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
