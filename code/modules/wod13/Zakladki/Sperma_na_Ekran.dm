/mob/proc/intro_Sperma(text)
	if(!mind)
		return
	if(!client)
		return
	var/obj/screen/Kon4a_text/T = new()
	client.screen += T
	T.maptext = {"<span style='vertical-align:top; text-align:center;
				color: #820000; font-size: 300%;
				text-shadow: 1px 1px 2px black, 0 0 1em black, 0 0 0.2em black;
				font-family: "Blackmoor LET", "Pterra";'>[text]</span>"}
	T.maptext_width = 205
	T.maptext_height = 209
	T.maptext_x = 12
	T.maptext_y = 64
	playsound_local(src, 'sound/winxp/error.wav', 100, FALSE)
	animate(T, alpha = 255, time = 10, easing = EASE_IN)
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
