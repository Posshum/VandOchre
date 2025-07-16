/datum/sprite_accessory/underwear
	icon = 'icons/roguetown/mob/underwear.dmi'
	var/underwear_type
	use_static = FALSE
	///Whether this underwear includes a top (Because gender = FEMALE doesn't actually apply here.). Hides breasts, nothing more.
	var/hides_breasts = FALSE
	var/covers_breasts = FALSE

/datum/sprite_accessory/underwear/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_UNDIES)

/datum/sprite_accessory/underwear/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(hides_breasts)
		if(is_human_part_visible(owner, HIDECROTCH) || is_human_part_visible(owner, HIDEBOOB))
			return TRUE
	return is_human_part_visible(owner, HIDECROTCH)

/datum/sprite_accessory/underwear/regm
	name = "Undies"
	icon_state = "male"
	gender = MALE
	specuse = RACES_UNDERWEAR_MALE

/datum/sprite_accessory/underwear/regme
	name = "Undiese"
	icon_state = "male_elf"
	gender = MALE
	specuse = list("elf")

/datum/sprite_accessory/underwear/regmd
	name = "Undiesd"
	icon_state = "male_dwarf"
	gender = MALE
	specuse = list("dwarf")

/datum/sprite_accessory/underwear/female_bikini
	name = "Femundies"
	icon_state = "female"
	gender = FEMALE
	specuse = RACES_UNDERWEAR_FEMALE

/datum/sprite_accessory/underwear/female_dwarf
	name = "FemUndiesD"
	icon_state = "female_dwarf"
	gender = FEMALE
	specuse = list("dwarf")

/datum/sprite_accessory/underwear/female_leotard
	name = "Femleotard"
	icon_state = "female_leotard"
	gender = FEMALE
	specuse = RACES_UNDERWEAR_FEMALE
	roundstart = FALSE

//For use on Younglings
/datum/sprite_accessory/underwear/child
	name = "Youngling"
	icon_state = "male_child"
	gender = MALE
	specuse = ALL_RACES_LIST
	roundstart = FALSE

/datum/sprite_accessory/underwear/child_f
	name = "FemYoungling"
	icon_state = "female_child"
	gender = FEMALE
	specuse = ALL_RACES_LIST
	roundstart = FALSE

/datum/sprite_accessory/underwear/briefs
	name = "Briefs"
	icon_state = "male_reg"
	underwear_type = /obj/item/undies

/datum/sprite_accessory/underwear/briefs/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(is_species(owner,/datum/species/dwarf))
		return "maledwarf_reg"
	if(owner.gender == FEMALE)
		return "maleelf_reg"
	return "male_reg"

/datum/sprite_accessory/underwear/bikini
	name = "Bikini"
	icon_state = "female_bikini"
	underwear_type = /obj/item/undies/bikini
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/panties
	name = "Panties"
	icon_state = "panties"
	underwear_type = /obj/item/undies/panties

/datum/sprite_accessory/underwear/leotard
	name = "Leotard"
	icon_state = "female_leotard"
	underwear_type = /obj/item/undies/leotard
	hides_breasts = TRUE

/datum/sprite_accessory/underwear/leotard/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(owner.gender == MALE)
		return "male_leotard"
	return "female_leotard"

/datum/sprite_accessory/underwear/loincloth
	name = "Loincloth"
	icon_state = "loincloth"
	underwear_type = /obj/item/undies/loincloth
