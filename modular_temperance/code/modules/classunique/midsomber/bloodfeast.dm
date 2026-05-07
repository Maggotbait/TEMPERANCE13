/obj/effect/proc_holder/spell/invoked/bloodfeast
	name = "Bloodfeast"
	desc = "Anchor yourself into the ground, extending out your hand and starting a four-strike, 3-tile wide AOE attack that heals brute damage with each strike."
	clothes_req = FALSE
	range = 7
	overlay_state = "coagulated_blood"
	releasedrain = 30
	chargedrain = 1
	chargetime = 1
	recharge_time = 15 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokeblood
	invocation_type = "shout"
	gesture_required = TRUE
	xp_gain = FALSE
	var/damage = 60
	var/telegraph_delay = 4
	var/area_of_effect = 3

/obj/effect/proc_holder/spell/invoked/bloodfeast/cast(mob/living/target, list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		revert_cast()
		return

	if(QDELETED(H) || H.stat == DEAD)
		return

	var/def_zone = H.zone_selected || BODY_ZONE_CHEST

	playsound(H, 'modular_temperance/sounds/midsomber/yesforyouwholieindeathsembrace.ogg', 100, FALSE)
	H.say("Yes... For you who lie in death's embrace...")

	for(var/turf/affected_turf in get_hear(area_of_effect, H)) //first hit
		new /obj/effect/temp_visual/smash_effect/red(affected_turf)
		for(var/mob/living/victim in affected_turf)
			if(victim == H || victim.stat == DEAD)
				continue
			arcyne_strike(user, victim, null, damage, def_zone, BCLASS_CUT)
	playsound(H, 'modular_temperance/sounds/midsomber/harvest.ogg', 100, FALSE)
	sleep(1 SECONDS)
	for(var/turf/affected_turf in get_hear(area_of_effect, H)) // second hit
		new /obj/effect/temp_visual/smash_effect/red(affected_turf)
		for(var/mob/living/victim in affected_turf)
			if(victim == H || victim.stat == DEAD)
				continue
			arcyne_strike(user, victim, null, damage, def_zone, BCLASS_CUT)
	playsound(H, 'modular_temperance/sounds/midsomber/harvest.ogg', 100, FALSE)
	sleep(1 SECONDS)
	for(var/turf/affected_turf in get_hear(area_of_effect, H)) //third hit
		new /obj/effect/temp_visual/smash_effect/red(affected_turf)
		for(var/mob/living/victim in affected_turf)
			if(victim == H || victim.stat == DEAD)
				continue
			arcyne_strike(user, victim, null, damage, def_zone, BCLASS_CUT)
	playsound(H, 'modular_temperance/sounds/midsomber/harvest.ogg', 100, FALSE)
	sleep(1 SECONDS)
	for(var/turf/affected_turf in get_hear(area_of_effect, H)) //fourth hit
		new /obj/effect/temp_visual/smash_effect/red(affected_turf)
		for(var/mob/living/victim in affected_turf)
			if(victim == H || victim.stat == DEAD)
				continue
			arcyne_strike(user, victim, null, damage, def_zone, BCLASS_CUT)
	playsound(H, 'modular_temperance/sounds/midsomber/harvest.ogg', 100, FALSE)
	sleep(1 SECONDS)
	log_combat(H, null, "used Bloodfeast")
	return TRUE

/obj/effect/temp_visual/bloodfeast_telegraph
	icon = 'icons/effects/blood.dmi'
	icon_state = "pool2"
	light_outer_range = 1
	duration = 3
	layer = MASSIVE_OBJ_LAYER