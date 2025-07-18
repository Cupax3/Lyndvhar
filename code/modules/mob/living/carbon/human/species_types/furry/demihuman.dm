/mob/living/carbon/human/species/demihuman
	race = /datum/species/demihuman

/datum/species/demihuman
	name = "Half-Kin"
	id = "demihuman"
	desc = "<b>Half-Kin</b><br>\
	With the advent and rise of more of the inhumen and denmorian races beginning to become larger communities in Llewyn and abroad, it was only natural that eventually half-humen and half-wild would begin to form. These beings retain much of their humen forms, however usually behave much in the same way of the animal or being that they are half of. Due to their union being one of humen they fair much better with other races, but their wild side often becomes a detriment due to differing tempers and behaviours. For this reason it is quite rare to see a half-kin in positions of power, usually working in lower-working jobs.<br>"
	skin_tone_wording = "Ancestry"
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY,MUTCOLORS_PARTSONLY)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = TRUE
	possible_ages = ALL_AGES_LIST
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mt.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male
	soundpack_f = /datum/voicepack/female
	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,-1), \
		)
	//race_bonus = list(STAT_PERCEPTION = 1, STAT_ENDURANCE = 1)
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/wild_tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		)
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/bodypart_feature/underwear,
		/datum/customizer/organ/ears/demihuman,
		/datum/customizer/organ/horns/demihuman,
		/datum/customizer/organ/tail/demihuman,
		/datum/customizer/organ/wings/anthro,
		/datum/customizer/organ/testicles/anthro,
		/datum/customizer/organ/penis/anthro,
		/datum/customizer/organ/breasts/animal,
		/datum/customizer/organ/vagina/animal,
		)
	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/socks,
	)
	body_markings = list(
		/datum/body_marking/flushed_cheeks,
		/datum/body_marking/eyeliner,
		/datum/body_marking/tonage,
		/datum/body_marking/socklonger,
		/datum/body_marking/tips,
		/datum/body_marking/nose,
	)
	descriptor_choices = list(
		/datum/descriptor_choice/height,
		/datum/descriptor_choice/body,
		/datum/descriptor_choice/stature,
		/datum/descriptor_choice/face,
		/datum/descriptor_choice/face_exp,
		/datum/descriptor_choice/skin,
		/datum/descriptor_choice/voice,
		/datum/descriptor_choice/prominent_one_wild,
		/datum/descriptor_choice/prominent_two_wild,
		/datum/descriptor_choice/prominent_three_wild,
		/datum/descriptor_choice/prominent_four_wild,
	)
	
/datum/species/demihuman/check_roundstart_eligible()
	return TRUE

/datum/species/demihuman/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/demihuman/on_species_gain(mob/living/carbon/foreign, datum/species/old_species)
	..()
	languages(foreign)
	
/datum/species/demihuman/proc/languages(mob/living/carbon/human/foreign)
	if(foreign.skin_tone == SKIN_COLOR_GRENZELHOFT)
		foreign.grant_language(/datum/language/grenzelhoftian)

/datum/species/demihuman/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/random = rand(1,8)
	//Choose from a variety of mostly brightish, animal, matching colors
	switch(random)
		if(1)
			main_color = ORANGE_FUR
		if(2)
			main_color = LIGHTGREY_FUR
		if(3)
			main_color = DARKGREY_FUR
		if(4)
			main_color = LIGHTORANGE_FUR
		if(5)
			main_color = LIGHTBROWN_FUR
		if(6)
			main_color = WHITEBROWN_FUR
		if(7)
			main_color = DARKBROWN_FUR
		if(8)
			main_color = BLACK_FUR
	returned["mcolor"] = main_color
	returned["mcolor2"] = main_color
	returned["mcolor3"] = main_color
	return returned

/datum/species/demihuman/get_skin_list()
	return list(
		"Grenzelhoft" = SKIN_COLOR_GRENZELHOFT,
		"Lyndhardtian" = SKIN_COLOR_LYNDHARDTIAN,         // Was Hammerhold
		"Rhaenvalian" = SKIN_COLOR_RHAENVALIAN,          // Was Avar
		"Dunargi" = SKIN_COLOR_DUNARGI,              // Was Rockhill
		"Valorian" = SKIN_COLOR_VALORIAN,             // Was Otava
		"Calmirixian" = SKIN_COLOR_CALMIRIXIAN,          // Was Etrusca
		"Atvergian" = SKIN_COLOR_ATVERGIAN,            // Was Gronn
		"Northern Zybantium" = SKIN_COLOR_NORTHERN_ZYBANTIUM,   // Was North Zybantia (Giza)
		"Western Zybantium" = SKIN_COLOR_WESTERN_ZYBANTIUM,    // Was West Zybantia (Shalvistine)
		"Eastern Zybantium" = SKIN_COLOR_EASTERN_ZYBANTIUM,    // Was East Zybantia (Lalvestine)
		"Khazumian" = SKIN_COLOR_KHAZUMIAN,            // Was Naledi
		"Salvumite" = SKIN_COLOR_SALVUMITE,             // Was Kazengun
		"Saltlian" = SKIN_COLOR_SALTLIAN
	)

/datum/species/demihuman/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	RegisterSignal(C, COMSIG_MOB_SAY , PROC_REF(handle_speech))
	// adds Demihuman specific emotes
	C.verbs += list(
        /mob/proc/howl,
        /mob/proc/growl,
		/mob/proc/meow,
		/mob/proc/purr,
		/mob/proc/moo,
		/mob/proc/bark,
		/mob/proc/growl,
		/mob/proc/bleat,
		/mob/proc/caw,
		/mob/proc/peep,
		/mob/proc/hoot,
		/mob/proc/squeak,
		/mob/proc/hiss,
		/mob/proc/phiss,
		/mob/proc/howl,
		/mob/proc/cackle,
		/mob/proc/whine,
		/mob/proc/chitter,
		/mob/proc/flutter,
	)

/datum/species/demihuman/on_species_loss(mob/living/carbon/C)
    . = ..()
    UnregisterSignal(C, COMSIG_MOB_SAY)
    // Remove demihuman-specific emotes
    C.verbs -= list(
        /mob/proc/howl, //
        /mob/proc/growl, //
		/mob/proc/meow, //
		/mob/proc/purr, //
		/mob/proc/moo,
		/mob/proc/bark, //
		/mob/proc/growl, //
		/mob/proc/bleat, //
		/mob/proc/caw, //
		/mob/proc/peep, //
		/mob/proc/hoot, //
		/mob/proc/squeak, //
		/mob/proc/hiss, //
		/mob/proc/phiss, //
		/mob/proc/cackle, //
		/mob/proc/whine, //
		/mob/proc/chitter,
		/mob/proc/flutter,
    )
