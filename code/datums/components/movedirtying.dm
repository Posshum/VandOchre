//Move Dirtying component. Whenever the parent moves into a new tile, has a chance of placing a new object when valid.
/datum/component/movedirtying

//How many steps was taken from the last time a dirty atom has spawned.
var/steps = 0

//The chance at which dirt will spawn when moving.
var/dirtychance = 3

//The given atom(s) which will spawn, from least filthy to most filthy.
var/static/list/filth_atom_list = list(/obj/effect/decal/cleanable/filth)

//The chosen current filth from the list to update with.
var/chosen_atom = list()

//Variable applied to dirty objects to check for different stages of filth.
var/curfilthrating

//Incrementing variable that can be used to increase dirtiness further than one level. Used for when a mob has trudged through mud/blood/dirt recently.
var/nextfilthrating = 1 //Currently unused.

/datum/component/movedirtying/Initialize(filth_atom_list_ = /obj/effect/decal/cleanable/filth/dirt1, dirtychance_ = 3)
	if(!isliving(parent) || !ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	filth_atom_list = filth_atom_list_
	dirtychance = dirtychance_
	RegisterSignal(parent, list(COMSIG_MOVABLE_MOVED), PROC_REF(make_dirty))

//Gets all of the valid filth objects on the turf if they exist.
/datum/component/movedirtying/proc/get_filth_obj()
	var/mob/living/carbon/human/H = parent
	for(var/obj/effect/decal/cleanable/filth/I in get_turf(H))
		return I

//Checks the dirtiness rating of the filth.
/* /datum/component/movedirtying/proc/next_filth_rating()
	curfilthrating = 0
		return curfilthrating */

//Replace the old filth with new filth if there is acceptable rating and match its dir with mob dir.
/datum/component/movedirtying/proc/replace_filth()
	var/curfilth = list(get_filth_obj())
	var/oldfilth
	var/mob/living/H = parent
	oldfilth = curfilth
	if(curfilth)
		for(var/obj/effect/decal/cleanable/filth/I in curfilth)
			curfilthrating = I.filth_rating + 1
			if(curfilthrating >= I.filth_rating)
				if(curfilthrating > filth_atom_list.len)
					return
				chosen_atom = filth_atom_list[curfilthrating]
				curfilthrating = 0
			else
				return
		del oldfilth[1]
		new chosen_atom(H.loc)
	if(curfilth)
		for(var/obj/effect/decal/cleanable/filth/I in curfilth)
			I.dir = H.dir



//Checks if you can actually step on this turf appropriately.
/datum/component/movedirtying/proc/prepare_step()
	var/turf/open/T = get_turf(parent)

	if(!istype(T))
		return

	var/mob/living/LM = parent
	if(T.can_be_dirty || LM.buckled || LM.body_position == LYING_DOWN || !CHECK_MULTIPLE_BITFIELDS(LM.mobility_flags, MOBILITY_STAND | MOBILITY_MOVE) || LM.throwing || LM.movement_type & (VENTCRAWLING | FLYING))
		if(LM.body_position == LYING_DOWN && !LM.buckled && !(LM.movement_type & (VENTCRAWLING | FLYING)))
			return //Crawling should have new/different sprites but they wont exist for a while.

	if(iscarbon(LM))
		var/mob/living/carbon/C = LM
		if(!C.get_bodypart(BODY_ZONE_L_LEG) && !C.get_bodypart(BODY_ZONE_R_LEG))
			return
	steps++

	if(steps >= 6)
		steps = 0

	if(steps % 2)
		return

	if(steps != 0 && !LM.has_gravity(T)) // don't need to get dirty as often when you hop around
		return
	return T

/datum/component/movedirtying/proc/make_dirty()
	var/turf/open/T = prepare_step()
	var/mob/living/carbon/human/H = parent
	var/obj/item/clothing/shoes/humshoes = H.shoes
	var/feetCover = (H.wear_armor && (H.wear_armor.body_parts_covered & FEET)) || (H.wear_pants && (H.wear_pants.body_parts_covered & FEET))

	if(T)
		return
	if(prob(dirtychance))
		if(HAS_TRAIT(H,TRAIT_LIGHT_STEP)) //We are naturally careful and clean.
			return
		if((humshoes && !humshoes?.is_barefoot) || feetCover) //Are we wearing shoes, and do they actually cover the sole?
			//if filth already exists here, replace and increase chance along with setting dir.
			if(get_filth_obj())
				replace_filth()
			else
				chosen_atom = filth_atom_list[1]
				new chosen_atom(H.loc)

		//Future proofing barefooted filth stuff down the road for more immersive ground filth.
		else
			if(get_filth_obj())
				replace_filth()
			else
				chosen_atom = filth_atom_list[1]
				new chosen_atom(H.loc)
