/mob/proc/intro_Sperma(text, time, rgb)
//rgb(r, g, b)
	if(!mind)
		return
	if(!client)
		return
	if(time == null)
		time = 10
	if(rgb == null)
		rgb = rgb(158, 3, 3)
	var/obj/screen/Kon4a_text/T = new()
	client.screen += T
	T.maptext = {"<span style='vertical-align:top; text-align:center;
				color:[rgb]; font-size: 300%;
				text-shadow: 1px 1px 2px black, 0 0 1em black, 0 0 0.2em black;
				font-family: "Blackmoor LET", "Pterra";'>[text]</span>"}
	T.maptext_width = 205
	T.maptext_height = 209
	T.maptext_x = 12
	T.maptext_y = 64
	playsound_local(src, 'code/modules/wod13/sounds/domination.ogg', 100, FALSE)
	animate(T, alpha = 255, time = time, easing = EASE_IN)
	addtimer(CALLBACK(src, .proc/clear_Sperma_text, T), 35)

/mob/proc/clear_Sperma_text(var/obj/screen/A)
	if(!A)
		return
	if(!client)
		return
	animate(A, alpha = 0, time = 10, easing = EASE_OUT)
	sleep(11)
	if(client)
		if(client.screen && A)
			client.screen -= A
			qdel(A)

/obj/screen/Kon4a_text
	icon = null
	icon_state = ""
	name = ""
	screen_loc = "5,5"
	layer = HUD_LAYER+0.02
	plane = HUD_PLANE
	alpha = 0
	var/reading

/////////////////////На будущее///////////////////////
/*
/mob/proc/into_fisheye()
	var/obj/screen/fullscreen/fisheye/F = new()
	client.screen += F
	animate(F, alpha = 255, time = 10, easing = EASE_IN)

/obj/screen/fullscreen/fisheye
	icon = null
	icon_state = ""
	name = ""
	screen_loc = "5,5"
	layer = HUD_LAYER+0.02
	plane = HUD_PLANE
	alpha = 0
	var/atom/movable/screen/fullscreen/warp_effect/warp


/obj/screen/fullscreen/fisheye/Initialize()
	. = ..()
	apply_wibbly_filters(src)

	warp = new(src)
	vis_contents += warp

/obj/screen/fullscreen/fisheye/Destroy()
	vis_contents -= warp
	warp = null
	return ..()

/atom/movable/screen/fullscreen/warp_effect
	plane = FULLSCREEN_PLANE
	appearance_flags = PIXEL_SCALE|LONG_GLIDE // no tile bound so you can see it around corners and so
	icon = 'icons/effects/light_overlays/light_352.dmi'
	icon_state = "light"
	pixel_x = -176
	pixel_y = -176
*/
