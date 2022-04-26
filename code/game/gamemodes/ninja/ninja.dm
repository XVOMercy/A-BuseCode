/datum/game_mode
	/// A list of all minds which have the ninja antag datum.
	var/list/datum/mind/ninjas = list()

/datum/game_mode/ninja
	name = "ninja"
	config_tag = "ninja"
	restricted_jobs = list("Cyborg", "AI")//They are part of the AI if he is ninja so are they, they use to get double chances
	protected_jobs = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Blueshield", "Nanotrasen Representative", "Magistrate", "Internal Affairs Agent", "Nanotrasen Navy Officer", "Special Operations Officer", "Syndicate Officer", "Solar Federation General")
	required_players = 0
	required_enemies = 1
	recommended_enemies = 1
	/// A list containing references to the minds of soon-to-be ninjas. This is seperate to avoid duplicate entries in the `ninjas` list.
	var/list/datum/mind/pre_ninjas = list()
	/// Hard limit on ninjas if scaling is turned off.
	var/ninjas_possible = 1

/datum/game_mode/ninja/announce()
	to_chat(world, "<B>The current game mode is - ninja!</B>")
	to_chat(world, "<B>There is a syndicate ninja on the station. Do not let the ninja succeed!</B>")


/datum/game_mode/ninja/pre_setup()

	if(GLOB.configuration.gamemode.prevent_mindshield_antags)
		restricted_jobs += protected_jobs

	var/list/possible_ninjas = get_players_for_role(ROLE_NINJA)

	for(var/datum/mind/candidate in possible_ninjas)
		if(candidate.special_role == SPECIAL_ROLE_VAMPIRE) // no ninja vampires
			possible_ninjas.Remove(candidate)

	// stop setup if no possible ninjas
	if(!length(possible_ninjas))
		return FALSE

	var/num_ninjas = 1

	num_ninjas = max(1, min(num_players(), ninjas_possible))

	for(var/i in 1 to num_ninjas)
		if(!length(possible_ninjas))
			break
		var/datum/mind/ninja = pick_n_take(possible_ninjas)
		pre_ninjas += ninja
		ninja.special_role = SPECIAL_ROLE_NINJA
		ninja.restricted_roles = restricted_jobs

	if(!length(pre_ninjas))
		return FALSE
	return TRUE


/datum/game_mode/ninja/post_setup()
	for(var/t in pre_ninjas)
		var/datum/mind/ninja = t
		ninja.add_antag_datum(/datum/antagonist/ninja)
	..()


/datum/game_mode/ninja/declare_completion()
	..()
	return//ninjas will be checked as part of check_extra_completion. Leaving this here as a reminder.

/datum/game_mode/proc/auto_declare_completion_ninja()
	if(length(ninjas))
		var/text = "<FONT size = 2><B>The ninjas were:</B></FONT><br>"
		for(var/datum/mind/ninja in ninjas)
			var/ninjawin = TRUE
			text += printplayer(ninja)

			var/TC_uses = 0
			var/used_uplink = FALSE
			var/purchases = ""
			for(var/obj/item/uplink/H in GLOB.world_uplinks)
				if(H && H.uplink_owner && H.uplink_owner == ninja.key)
					TC_uses += H.used_TC
					used_uplink = TRUE
					purchases += H.purchase_log

			if(used_uplink)
				text += " (used [TC_uses] TC) [purchases]"

			var/all_objectives = ninja.get_all_objectives()

			if(length(all_objectives))//If the ninja had no objectives, don't need to process this.
				var/count = 1
				for(var/datum/objective/objective in all_objectives)
					if(objective.check_completion())
						text += "<br><B>Objective #[count]</B>: [objective.explanation_text] <font color='green'><B>Success!</B></font>"
						SSblackbox.record_feedback("nested tally", "ninja_objective", 1, list("[objective.type]", "SUCCESS"))
					else
						text += "<br><B>Objective #[count]</B>: [objective.explanation_text] <font color='red'>Fail.</font>"
						SSblackbox.record_feedback("nested tally", "ninja_objective", 1, list("[objective.type]", "FAIL"))
						ninjawin = FALSE
					count++

			var/special_role_text
			if(ninja.special_role)
				special_role_text = lowertext(ninja.special_role)
			else
				special_role_text = "antagonist"

			var/datum/contractor_hub/H = LAZYACCESS(GLOB.contractors, ninja)
			if(H)
				var/count = 1
				var/earned_tc = H.reward_tc_paid_out
				for(var/c in H.contracts)
					var/datum/syndicate_contract/C = c
					// Locations
					var/locations = list()
					for(var/a in C.contract.candidate_zones)
						var/area/A = a
						locations += (A == C.contract.extraction_zone ? "<b><u>[A.map_name]</u></b>" : A.map_name)
					var/display_locations = english_list(locations, and_text = " or ")
					// Result
					var/result = ""
					if(C.status == CONTRACT_STATUS_COMPLETED)
						result = "<font color='green'><B>Success!</B></font>"
					else if(C.status != CONTRACT_STATUS_INACTIVE)
						result = "<font color='red'>Fail.</font>"
					text += "<br><font color='orange'><B>Contract #[count]</B></font>: Kidnap and extract [C.target_name] at [display_locations]. [result]"
					count++
				text += "<br><font color='orange'><B>[earned_tc] TC were earned from the contracts.</B></font>"

			if(ninjawin)
				text += "<br><font color='green'><B>The [special_role_text] was successful!</B></font><br>"
				SSblackbox.record_feedback("tally", "ninja_success", 1, "SUCCESS")
			else
				text += "<br><font color='red'><B>The [special_role_text] has failed!</B></font><br>"
				SSblackbox.record_feedback("tally", "ninja_success", 1, "FAIL")

		var/phrases = jointext(GLOB.syndicate_code_phrase, ", ")
		var/responses = jointext(GLOB.syndicate_code_response, ", ")

		text += "<br><br><b>The code phrases were:</b> <span class='danger'>[phrases]</span><br>\
					<b>The code responses were:</b> <span class='danger'>[responses]</span><br><br>"

		to_chat(world, text)
	return TRUE
