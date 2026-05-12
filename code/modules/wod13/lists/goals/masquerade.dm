/datum/vampire_goal/masquerade
	name = "Support the masquerade"
//	desc = "Maintain the masquerade at all costs."


/datum/vampire_goal/masquerade/check_completion()
	if(..())
		return TRUE
	if(SSmasquerade.total_level >= 900)
		return TRUE
	else
		return FALSE
