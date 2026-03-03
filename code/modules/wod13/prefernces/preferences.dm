
/datum/preferences
	var/list/specialisation_craft = list("Woodworking", "shitie")


/datum/preferences/proc/character_creation()
	naem = input(user, "What is your character's name?", "Character Creation") as text|null

