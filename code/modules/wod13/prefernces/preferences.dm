//#define POINTS 30  // The total level of free points to

GLOBAL_LIST_INIT(BackstoryCommon, list("Солдат", "Архитектор", "Историк"))
GLOBAL_LIST_INIT(BackstoryTeen, list("Ребенок", "Идеалист"))
GLOBAL_LIST_INIT(BackstoryElder, list("Опекун", "Гуру"))


/datum/preferences
	var/list/specialisation_craft = list("Woodworking", "shitie")
	var/back_story = "Nobody"
	var/list/abl_prior = list("Talents" = 1, "Skills" = 2, "Knowledges" = 3)


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
	dat += "<center><b>Current backs:</b> [back_story]</center>"
//	dat += "<center>[GetPositiveQuirkCount()] / [MAX_QUIRKS] max positive quirks<br>\

	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>Quirk Preferences</div>", 900, 600) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/get_adbl_points(categor)
	var/talent_priorities = 0
	var/skills_priorities = 0
	var/knowledge_priorities = 0
	var/back_priorities = 0
	for(var/i in abl_prior)
		if(i == "Talents")
			switch(priorities[i])
				if(1)
					talent_priorities = 6
				if(2)
					talent_priorities = 4
				if(3)
					talent_priorities = 2
		if(i == "Skills")
			switch(priorities[i])
				if(1)
					skills_priorities = 6
				if(2)
					skills_priorities = 4
				if(3)
					skills_priorities = 2
		if(i == "Knowledges")
			switch(priorities[i])
				if(1)
					knowledge_priorities = 6
				if(2)
					knowledge_priorities = 4
				if(3)
					knowledge_priorities = 2

	var/used_talents = max(0, Alertness - 1) + max(0, Athletics - 1) + max(0, Brawl - 1) + max(0, Empathy - 1) + max(0, Intimidation - 1) + max(0, Expression - 1)
	var/used_skills = max(0, Crafts - 1) + max(0, Melee - 1) + max(0, Firearms - 1) + max(0, Drive - 1) + max(0, Security - 1) + max(0, Fleshcraft - 1) + max(0, Performance - 1)
	var/used_know = max(0, Finance - 1) + max(0, Investigation - 1) + max(0, Medicine - 1) + max(0, Linguistics - 1) + max(0, Occult - 1)
//	var/used_back =

	talent_priorities = max(0,  talent_priorities - used_talents)
	skills_priorities = max(0, skills_priorities - used_skills)
	knowledge_priorities = max(0, knowledge_priorities - used_know)

	switch(categor)
		if("Talents")
			return talent_priorities
		if("Skills")
			return skills_priorities
		if("Knowledges")
			return knowledge_priorities
	//	if("Soldier")
	//		return soldier_priorities
	return 0
