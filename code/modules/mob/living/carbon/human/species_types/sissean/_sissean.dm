/mob/living/carbon/human/species/sissean
	race = /datum/species/sissean

/datum/species/sissean
	name = "Sissean"
	id = "sissean"
	changesource_flags = WABBAJACK
	desc = "<b>Sissean</b><br>\
	The lore has not yet been solidified."


	possible_ages = NORMAL_AGES_LIST
	use_skintones = FALSE
	species_traits = list(MUTCOLORS, NO_UNDERWEAR, HAIR, OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP, TRAIT_GOOD_SWIM, TRAIT_STRONGBITE)
	inherent_skills = list(
		/datum/skill/labor/fishing = 3,
		/datum/skill/misc/swimming = 4,
	)

	specstats_m = list()
	specstats_f = list()

	//limbs_icon_m = 'icons/roguetown/mob/bodies/m/triton.dmi'
	//limbs_icon_f = 'icons/roguetown/mob/bodies/f/triton.dmi'

	soundpack_m = /datum/voicepack/female
	soundpack_f = /datum/voicepack/male

	exotic_bloodtype = /datum/blood_type/human/triton
	enflamed_icon = "widefire"

	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/triton,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/lizard,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
		ORGAN_SLOT_HORNS = /obj/item/organ/horns,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/sissean,
		ORGAN_SLOT_SNOUT = /datum/customizer_choice/organ/frills,
	)

	customizers = list(
		/datum/customizer/organ/tail/sissean,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/bodypart_feature/underwear,
		/datum/customizer/organ/horns/humanoid/sissean,
		/datum/customizer/organ/penis/lizard,
		/datum/customizer/organ/breasts/human,
		/datum/customizer/organ/belly/human,
		/datum/customizer/organ/vagina/human_anthro,
	)

	body_markings = list(
		/datum/body_marking/tonage,
	)

/datum/species/sissean/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)

/datum/species/sissean/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/sissean/check_roundstart_eligible()
	return TRUE

/datum/species/sissean/qualifies_for_rank(rank, list/features)
	return TRUE
