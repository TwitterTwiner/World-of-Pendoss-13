GLOBAL_LIST_EMPTY(masterclad)
GLOBAL_LIST_EMPTY(miniclad)
GLOBAL_LIST_EMPTY(grafity)


/obj/structure/vamp/zakladkagrafity
	icon = null
	icon_state = null
	name = ""
	desc = ""


/obj/structure/vamp/zakladkagrafity/Initialize()
	GLOB.grafity += src

/obj/item/vamp/zakladka
	icon = 'code/modules/wod13/Zakladki/clad.dmi'




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







/obj/item/vamp/zakladka/Klad
	name = "Закладка"
	desc = "ЪУЪ ПЕНДОСЫ"
	icon_state = "Malenkiiklad"
	w_class = WEIGHT_CLASS_SMALL
