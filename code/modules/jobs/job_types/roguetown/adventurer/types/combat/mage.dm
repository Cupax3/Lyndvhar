/datum/advclass/mage
	name = "Mage"
	tutorial = "Mages are skilled in the arcyne. Weaving the threads of arcyne power is a very rare and dormant strength in only a few individuals. Scholars all over the world spend years studying magick - most do not succeed."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/mage
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	maximum_possible_slots = 2
	traits_applied = list(TRAIT_OUTLANDER)
	classes = list("Sorcerer" = "You are a learned magi and a scholar, having spent your life studying the arcyne and its ways.", 
					"Spellsinger" = "You belong to a school of bards renowned for their study of both the arcane and the arts.",
					"Spellblade" = "You learnt the art of both the blade while also acquiring a small modicum of arcyne tricks.")

/datum/outfit/job/roguetown/adventurer/mage/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Sorcerer","Spellsinger","Spellblade")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
	
		if("Sorcerer")
			to_chat(H, span_warning("You are a learned magi and a scholar, having spent your life studying the arcyne and its ways."))
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/woodstaff/prepared/ruby
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1, /obj/item/spellbook_unfinished/pre_arcyne = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
			H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				H.mind.adjust_spellpoints(1)
			H.change_stat("intelligence", 3)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)
			H.mind.adjust_spellpoints(7)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_ARCYNE_T3, TRAIT_GENERIC)
		if("Spellsinger")
			to_chat(H, span_warning("You belong to a school of bards renowned for their study of both the arcyne and the arts."))
			head = /obj/item/clothing/head/roguetown/bucklehat
			mask = /obj/item/clothing/mask/rogue/ragmask/black
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/purple
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/shirt/tunic/black
			cloak = /obj/item/clothing/cloak/raincloak/purple
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltr = /obj/item/rogueweapon/sword/iron/messer
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)
			H.mind.adjust_spellpoints(5)
			H.cmode_music = 'sound/music/combat_old.ogg'
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_ARCYNE_T2, TRAIT_GENERIC)
			var/weapons = list("Harp","Lute","Accordion","Guitar","Hurdy-Gurdy","Viola","Vocal Talisman")
			var/weapon_choice = input("Choose your instrument.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Harp")
					backr = /obj/item/rogue/instrument/harp
				if("Lute")
					backr = /obj/item/rogue/instrument/lute
				if("Accordion")
					backr = /obj/item/rogue/instrument/accord
				if("Guitar")
					backr = /obj/item/rogue/instrument/guitar
				if("Hurdy-Gurdy")
					backr = /obj/item/rogue/instrument/hurdygurdy
				if("Viola")
					backr = /obj/item/rogue/instrument/viola
				if("Vocal Talisman")
					backr = /obj/item/rogue/instrument/vocals
		if("Spellblade") // Spellblade blading out here. You get enchant weapon and SoW plus 2 SP
			to_chat(H, span_warning("You are skilled in both the arcyne art and the art of the blade. Instead of wearing armor or being quick on your feet you use both your arcyne tricks and intelligence to protect yourself."))
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather
			armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1, /obj/item/rogueweapon/huntingknife = 1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/enchant_weapon)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.change_stat("strength", 1)
			H.change_stat("intelligence", 3)
			H.change_stat("constitution", 1)
			H.change_stat("perception", -2)
			H.mind.adjust_spellpoints(3)
			H.cmode_music = 'sound/music/combat_old.ogg'
			ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SENTINELOFWITS, TRAIT_GENERIC) // Gave them this so they can use their Int score in melee as their magic SP is super restrictive.
			ADD_TRAIT(H, TRAIT_ARCYNE_T2, TRAIT_GENERIC)
			var/weapons = list("Old Longsword", "Sabre & Buckler")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			switch(weapon_choice)
				if("Old Longsword")
					beltr = /obj/item/rogueweapon/sword/long/heirloom
				if("Sabre & Buckler")
					beltr = /obj/item/rogueweapon/sword/sabre
					backr = /obj/item/rogueweapon/shield/buckler
