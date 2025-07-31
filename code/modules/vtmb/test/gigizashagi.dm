/mob/living
	pixel_z = 8
	var/gigizashagi = 0

/mob/living/Life()
	. = ..()
	gigizashagi = gigizashagi+1
	if(gigizashagi >= 8)
		gigizashagi = 0

	switch(gigizashagi)
		if(0)
			pixel_x = 0
			pixel_y = 0
		if(1)
			pixel_x = 1
			pixel_y = 1
		if(2)
			pixel_x = 2
			pixel_y = 0
		if(3)
			pixel_x = 1
			pixel_y = -1
		if(4)
			pixel_x = 0
			pixel_y = 0
		if(5)
			pixel_x = -1
			pixel_y = 1
		if(6)
			pixel_x = -2
			pixel_y = 0
		if(7)
			pixel_x = -1
			pixel_y = -1


/mob/living/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	var/matrix/M = matrix()
	M.Turn(rand(-8, 8), 1)
	animate(src, pixel_y = 6, transform = M, time = 5)
	animate(pixel_x = 0, transform = null)

