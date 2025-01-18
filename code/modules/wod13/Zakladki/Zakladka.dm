GLOBAL_LIST_EMPTY(masterclad)
GLOBAL_LIST_EMPTY(miniclad)
GLOBAL_LIST_EMPTY(grafity)


/obj/structure/vamp/zakladkagrafity
	icon = 'code/modules/wod13/Zakladki/CLAD.dmi'
	icon_state = "Malenkiiklad"
	name = "Графити"
	desc = "Топ сайт "


/obj/structure/vamp/zakladkagrafity/Initialize()
	. = ..()
	GLOB.grafity += src
//	var/datum/app/cheburnet/site/narko/N = drak
	desc = replacetext(desc, "NAME", name)




/obj/structure/vamp/zakladkagrafity/Destroy()
	GLOB.grafity -= src

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


/obj/item/vamp/zakladka/masterclad/update_icon()
	. = ..()
	icon_state = "Malenkiiklad"

/obj/item/vamp/zakladka/masterclad/proc/raspakovka(mob/user)
	to_chat(user, "<span class='notice'>Ты начинаешь распоковку мастерклада.</span>")
	update_icon()
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	GLOB.masterclad -= src






/obj/item/vamp/zakladka/Klad
	name = "Закладка"
	desc = "ЪУЪ ПЕНДОСЫ"
	icon_state = "Malenkiiklad"
	w_class = WEIGHT_CLASS_SMALL
