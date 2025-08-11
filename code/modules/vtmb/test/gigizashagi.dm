/mob/living
	pixel_z = 8
	var/gigizashagi = 0

/mob/living/Life()
	. = ..()
	gigizashagi = gigizashagi+1
	to_chat(src, "[gigizashagi]")
	animate(src, pixel_x = 1, pixel_y = 1, time = 2, loop = -1)
	if(gigizashagi >= 8)
		gigizashagi = 0

	switch(gigizashagi)
		if(0)
		//	pixel_x = 0
		//	pixel_y = 0
			animate(pixel_x = 0, pixel_y = 0, time = 3)
		if(1)
		//	pixel_x = 1
		//	pixel_y = 1
			animate(pixel_x = 1, pixel_y = 1, time = 3)
		if(2)
		//	pixel_x = 2
		//	pixel_y = 0
			animate(pixel_x = 2, pixel_y = 0, time = 3)
		if(3)
			pixel_x = 1
			pixel_y = -1
			animate(pixel_x = 1, pixel_y = -1, time = 3)
		if(4)
		//	pixel_x = 0
		//	pixel_y = 0
			animate(pixel_x = 0, pixel_y = 0, time = 3)
		if(5)
			pixel_x = -1
			pixel_y = 1
			animate(pixel_x = -1, pixel_y = 1, time = 3)
		if(6)
		//	pixel_x = -2
		//	pixel_y = 0
			animate(pixel_x = -2, pixel_y = 0, time = 3)
		if(7)
		//	pixel_x = -1
		//	pixel_y = -1
			animate(pixel_x = -1, pixel_y = -1, time = 3)


/mob/living/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	if(pixel_x != 0 || pixel_y != 0)
		animate(src, pixel_x = 0, pixel_y = 0)
	var/matrix/M = matrix()
	M.Turn(rand(-8, 8), 1)
	animate(src, pixel_y = 6, transform = M, time = 5)
	animate(pixel_x = 0, transform = null)

