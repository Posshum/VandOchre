/datum/customizer/organ/frills
	abstract_type = /datum/customizer/organ/frills
	name = "Frills"
	allows_disabling = TRUE

/datum/customizer_choice/organ/frills
	abstract_type = /datum/customizer_choice/organ/frills
	name = "Frills"
	organ_type = /obj/item/organ/frills
	organ_slot = ORGAN_SLOT_FRILLS

/datum/customizer/organ/frills/sissean
	customizer_choices = list(/datum/customizer_choice/organ/frills/sissean)

/datum/customizer_choice/organ/frills/sissean
	name = "Frills"
	organ_type = /obj/item/organ/frills/sissean
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/frills/simple,
		/datum/sprite_accessory/frills/short,
		/datum/sprite_accessory/frills/aquatic,
		)

/datum/customizer/organ/frills/anthro
	customizer_choices = list(/datum/customizer_choice/organ/frills/anthro)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/organ/frills/anthro
	name = "Frills"
	organ_type = /obj/item/organ/frills
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/frills/simple,
		/datum/sprite_accessory/frills/short,
		/datum/sprite_accessory/frills/aquatic,
		)
