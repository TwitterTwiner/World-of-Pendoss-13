GLOBAL_LIST_INIT(BackstoryCommon, list("Солдат", "Архитектор", "Историк"))
GLOBAL_LIST_INIT(BackstoryTeen, list("Ребенок", "Идеалист"))
GLOBAL_LIST_INIT(BackstoryElder, list("Опекун", "Гуру"))


/datum/preferences
	var/list/specialisation_craft = list("Woodworking", "shitie")
	var/back_story = "Nobody"


/datum/preferences/proc/character_creation(mob/user)
	real_name = input(user, "What is your character's name?", "Character Creation") as text|null

/datum/preferences/proc/Set_Story(mob/user)
	if(slotlocked)
		return

	var/list/dat = list()
	var/list/backstory = GLOB.BackstoryCommon
	if(total_age > 400)
		backstory += GLOB.BackstoryElder
	else
		backstory += GLOB.BackstoryTeen
	dat += "<center><b>Choose Backstory setup</b></center><br>"
	dat += "<div align='center'>Left-click to add or remove quirks. You need negative quirks to have positive ones.<br>\
	Quirks are applied at roundstart and cannot normally be removed.</div>"
	dat += "<center><a href='byond://?_src_=prefs;preference=trait;task=close'>Done</a></center>"
	dat += "<hr>"
	dat += "<center><b>Current backs:</b> [back_story"]</center>"
//	dat += "<center>[GetPositiveQuirkCount()] / [MAX_QUIRKS] max positive quirks<br>\

	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>Quirk Preferences</div>", 900, 600) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)
