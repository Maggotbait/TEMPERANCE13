//stolen straight from LC13 & kinda gutted
//main goal is to clear jobs that arent used on the map

SUBSYSTEM_DEF(maptype)
	name = "Map Type"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_MAPTYPE
	var/maptype = "temperance"			//dont change this lol

	//All the map tags that delete all jobs and replace them with others.
	var/list/clearmaps = list("vos_arderla", "vraylaz")

	//What departments are we looking at
	var/list/departments = list("RISVON_ROLES", "PERSERDUN_ROLES", "KINGSROW_ROLES", "UNAFFILIATED_ROLES")



/datum/controller/subsystem/maptype/Initialize()
	..()

	//clear jobs & set departments based on maptype
	switch(SSmaptype.maptype)
		if("vos_arderla")
			departments = list("EMPIRE_DEFENSE", "EMPIRE_CIVS", "fuckassEnemyIDK")
		if("vraylaz")
			departments = list("RISVON_DEFENSE", "RISVON_CIVS", "risvonEnemyIDK")

	var/list/all_jobs = subtypesof(/datum/job)
	if(!all_jobs.len)
		to_chat(world, "<span class='boldannounce'>Error setting up jobs, no job datums found</span>")
		return FALSE
