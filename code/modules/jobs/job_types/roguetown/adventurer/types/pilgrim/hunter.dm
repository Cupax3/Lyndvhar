/datum/advclass/hunter
	name = "Hunter"
	tutorial = "You are a hunter, with your bow you hunt the fauna in the bog, skinning what you kill to use in skincrafting. \
	Cooking any meat left over, your role is one that is not done by many, but important in the circulation of clothing and light armor."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/hunter

	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER, CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/hunter/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backr = /obj/item/storage/backpack/rogue/satchel
	r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/quiver/arrows
	beltl = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/bait = 1,
						/obj/item/rogueweapon/huntingknife = 1,
						/obj/item/flashlight/flare/torch = 1,
						)
	gloves = /obj/item/clothing/gloves/roguetown/leather
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 3)
		H.change_stat("speed", 1)
