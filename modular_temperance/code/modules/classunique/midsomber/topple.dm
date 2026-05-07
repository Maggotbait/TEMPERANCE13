/obj/effect/proc_holder/spell/invoked/topple
	name = "Topple"
	desc = "Lunge forward, punching a single target thrice and dealing heavy damage."
	clothes_req = FALSE
	range = 7
	overlay_state = "topple"
	releasedrain = 30
	chargedrain = 1
	chargetime = 1
	recharge_time = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokeblood
	invocation_type = "shout"
	gesture_required = TRUE
	xp_gain = FALSE
	var/delay = 10
	var/base_damage = 80
	var/momentum_cost = 3
	var/empowered_mult = 2
	var/beam_color = COLOR_BLOODRED
	var/combo_sounds = list ('modular_temperance/sounds/midsomber/punch1.ogg', 'modular_temperance/sounds/midsomber/punch2.ogg', 'modular_temperance/sounds/midsomber/punch3.ogg')


///dash helper - uses forcemove but i think it should be fine
/obj/effect/proc_holder/spell/invoked/topple/proc/topple_dash_to(mob/living/user, turf/destination, mob/living/target, beam_color)
	var/turf/origin = get_turf(user)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, user)
	user.forceMove(destination)
	user.dir = get_dir(user, target)
	var/datum/beam/trail = origin.Beam(user, "1-full", time = 2)
	if(trail && beam_color)
		trail.visuals.color = beam_color

/obj/effect/proc_holder/spell/invoked/topple/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		revert_cast()
		return

//insert grunts here
	var/damage = base_damage
	var/def_zone = H.zone_selected || BODY_ZONE_CHEST

	for(var/mob/living/carbon/human/victim in targets)
		if(!victim || !user) //first hit
			return
		var/turf/dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		playsound(H, 'modular_temperance/sounds/midsomber/shout.ogg', 80, FALSE)
		topple_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, null, damage, def_zone, BCLASS_CUT)
		playsound(H, pick(combo_sounds), 80, FALSE)
		sleep(0.3 SECONDS)

		if(!victim|| !user) //second hit
			return
		dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		topple_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, null, damage, def_zone, BCLASS_CUT)
		playsound(H, pick(combo_sounds), 80, FALSE)
		sleep(0.7 SECONDS)

		if(!victim|| !user) //third hit
			return
		dest = get_ranged_target_turf_direct(user, victim, get_dist(user, victim) + 2)
		if(!dest)
			dest = get_turf(victim)
		topple_dash_to(user, dest, victim, beam_color)
		arcyne_strike(user, victim, null, damage, def_zone, BCLASS_CUT)
		playsound(H, pick(combo_sounds), 80, FALSE)
		playsound(H, 'modular_temperance/sounds/midsomber/gasp.ogg', 80, FALSE)
		sleep(0.3 SECONDS)