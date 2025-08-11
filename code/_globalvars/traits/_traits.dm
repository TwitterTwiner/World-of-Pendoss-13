// This file should contain every single global trait in the game in a type-based list, as well as any additional trait-related information that's useful to have on a global basis.
// This file is used in linting, so make sure to add everything alphabetically and what-not.
// Do consider adding your trait entry to the similar list in `admin_tooling.dm` if you want it to be accessible to admins (which is probably the case for 75% of traits).
// ... whenever I get around to adding that.
// Please do note that there is absolutely no bearing on what traits are added to what subtype of `/datum`, this is just an easily referenceable list sorted by type.
// The only thing that truly matters about traits is the code that is built to handle the traits, and where that code is located. Nothing else.
GLOBAL_LIST_INIT(traits_by_type, list(
	/mob = list(
		"TRAIT_SALUBRI_EYE_OPEN" = TRAIT_SALUBRI_EYE_OPEN,
		"TRAIT_SALUBRI_EYE" = TRAIT_SALUBRI_EYE
	),
	/obj/item/bodypart = list(),
	/obj/item/organ/liver = list(),
	/obj/item = list(),
	/atom = list(),
	/atom/movable = list()
))

/// value -> trait name, generated on use from trait_by_type global
GLOBAL_LIST(trait_name_map)

/proc/generate_trait_name_map()
	. = list()
	for(var/key in GLOB.traits_by_type)
		for(var/tname in GLOB.traits_by_type[key])
			var/val = GLOB.traits_by_type[key][tname]
			.[val] = tname



