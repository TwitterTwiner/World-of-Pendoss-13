/client/proc/dsay(msg as text)
	set category = "Admin.Game"
	set name = "Dsay"
	set hidden = TRUE
	if(!holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	if(!mob)
		return
	if(prefs.muted & MUTE_DEADCHAT)
		to_chat(src, "<span class='danger'>You cannot send DSAY messages (muted).</span>", confidential = TRUE)
		return

	if (handle_spam_prevention(msg,MUTE_DEADCHAT))
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	mob.log_talk(msg, LOG_DSAY)

	if (!msg)
		return
	var/rank_name = holder.rank
	var/admin_name = key
	if(holder.fakekey)
		rank_name = pick(strings("admin_nicknames.json", "ranks", "config"))
		admin_name = pick(strings("admin_nicknames.json", "names", "config"))
	var/rendered = "<span class='game deadsay'><span class='name'>[rank_name]([admin_name])</span> says, <span class='message'>\"[emoji_parse(msg)]\"</span></span>" //<span class='prefix'>DEAD:</span> [ChillRaccoon] - removed due to a maggot developer

	for (var/mob/M in GLOB.player_list)
		if(isnewplayer(M))
			continue
		if (M.stat == DEAD || (M.client.holder && (M.client.prefs.chat_toggles & CHAT_DEAD))) //admins can toggle deadchat on and off. This is a proc in admin.dm and is only give to Administrators and above
			to_chat(M, rendered, confidential = TRUE)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Dsay") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/get_dead_say()
	var/msg = input(src, null, "dsay \"text\"") as text|null

	if (isnull(msg))
		return

	dsay(msg)
