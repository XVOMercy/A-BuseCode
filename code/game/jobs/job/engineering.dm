/datum/job/chief_engineer
	title = "Chief Engineer"
	flag = JOB_CHIEF
	department_flag = JOBCAT_ENGSEC
	total_positions = 1
	spawn_positions = 1
	is_engineering = 1
	supervisors = "the captain"
	department_head = list("Captain")
	selection_color = "#ffeeaa"
	req_admin_notify = 1
	access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS,
			            ACCESS_TELEPORTER, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_ATMOSPHERICS, ACCESS_EMERGENCY_STORAGE, ACCESS_EVA,
			            ACCESS_HEADS, ACCESS_CONSTRUCTION, ACCESS_SEC_DOORS,
			            ACCESS_CE, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_TCOMSAT, ACCESS_MINISAT, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS,
			            ACCESS_TELEPORTER, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_ATMOSPHERICS, ACCESS_EMERGENCY_STORAGE, ACCESS_EVA,
			            ACCESS_HEADS, ACCESS_CONSTRUCTION, ACCESS_SEC_DOORS,
			            ACCESS_CE, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_TCOMSAT, ACCESS_MINISAT, ACCESS_MINERAL_STOREROOM)
	minimal_player_age = 21
	exp_map = list(EXP_TYPE_ENGINEERING = 1200)
	outfit = /datum/outfit/job/chief_engineer
	important_information = "This role requires you to coordinate a department. You are required to be familiar with the Standard Operating Procedures of Engineering, basic job duties, and act professionally (roleplay)."

/datum/outfit/job/chief_engineer
	name = "Chief Engineer"
	jobtype = /datum/job/chief_engineer

	uniform = /obj/item/clothing/under/rank/chief_engineer
	belt = /obj/item/storage/belt/utility/chief/full
	gloves = /obj/item/clothing/gloves/color/black/ce
	shoes = /obj/item/clothing/shoes/brown
	head = /obj/item/clothing/head/hardhat/white
	l_ear = /obj/item/radio/headset/heads/ce
	id = /obj/item/card/id/ce
	l_pocket = /obj/item/t_scanner
	pda = /obj/item/pda/heads/ce
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1
	)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel_eng
	dufflebag = /obj/item/storage/backpack/duffel/engineering
	box = /obj/item/storage/box/engineer


/datum/job/engineer
	title = "Station Engineer"
	flag = JOB_ENGINEER
	department_flag = JOBCAT_ENGSEC
	total_positions = 5
	spawn_positions = 5
	is_engineering = 1
	supervisors = "the chief engineer"
	department_head = list("Chief Engineer")
	selection_color = "#fff5cc"
	access = list(ACCESS_EVA, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_EVA, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_MINERAL_STOREROOM)
	alt_titles = list("Maintenance Technician","Engine Technician","Electrician", "Life Support Specialist", "Atmospheric Technician")
	minimal_player_age = 7
	exp_map = list(EXP_TYPE_CREW = 300)
	outfit = /datum/outfit/job/engineer

/datum/outfit/job/engineer
	name = "Station Engineer"
	jobtype = /datum/job/engineer

	uniform = /obj/item/clothing/under/rank/engineer
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat
	l_ear = /obj/item/radio/headset/headset_eng
	id = /obj/item/card/id/engineering
	l_pocket = /obj/item/t_scanner
	pda = /obj/item/pda/engineering

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel_eng
	dufflebag = /obj/item/storage/backpack/duffel/engineering
	box = /obj/item/storage/box/engineer