/obj/item/undies
	name = "smallclothes"
	desc = "An Eoran designed undergarment to cover the loins."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "undies"
	resistance_flags = FLAMMABLE
	obj_flags = CAN_BE_HIT
	break_sound = 'sound/foley/cloth_rip.ogg'
	blade_dulling = DULLING_CUT
	max_integrity = 200
	integrity_failure = 0.1
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	var/gendered = MALE
	var/race
	var/cached_undies
	var/covers_breasts = FALSE

	///Whether this underwear covers the rear. If it doesn't, genital information may still be shown in certain circumstances
	var/covers_rear = TRUE

/obj/item/undies/f
	name = "women's smallclothes"
	desc = "An Eoran designed undergarment to cover the privates and chest."
	icon_state = "girlundies"
	gendered = FEMALE

/obj/item/undies/attack(mob/M, mob/user, def_zone)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.gender != gendered)
			return
		if(H.underwear == "Nude" && H.cached_underwear != "Nude")
			user.visible_message("<span class='notice'>[user] tries to put [src] on [H]...</span>")
			if(do_after(user, 5 SECONDS, H))
				get_location_accessible(H, BODY_ZONE_PRECISE_GROIN)
				H.underwear = H.cached_underwear
				H.underwear_color = color
				H.update_body()
				qdel(src)

/obj/item/undies/bikini
	name = "bikini"
	icon_state = "bikini"
	covers_breasts = TRUE

/obj/item/undies/panties
	name = "panties"
	icon_state = "panties"

/obj/item/undies/leotard
	name = "leotard"
	icon_state = "leotard"
	covers_breasts = TRUE

/obj/item/undies/loincloth
	name = "loincloth"
	icon_state = "loincloth"
	covers_rear = FALSE
	desc = "An absolute necessity. Slightly less effective."
