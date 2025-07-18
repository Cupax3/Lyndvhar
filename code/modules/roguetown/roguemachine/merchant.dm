/obj/item/roguemachine/merchant
	name = "navigator"
	desc = "A machine that attracts the attention of trading balloons."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "ballooner"
	density = TRUE
	blade_dulling = DULLING_BASH
	var/next_airlift
	max_integrity = 0
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC

/obj/structure/roguemachine/balloon_pad
	name = ""
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = ""
	density = FALSE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE

/obj/item/roguemachine/merchant/attack_hand(mob/living/user)
	if(!anchored)
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)

	var/contents

	contents += "<center>MERCHANT'S GUILD<BR>"
	contents += "--------------<BR>"
	contents += "Next Balloon: [time2text((next_airlift - world.time), "mm:ss")]</center><BR>"

	if(!user.can_read(src, TRUE))
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 300)
	popup.set_content(contents)
	popup.open()

/obj/item/roguemachine/merchant/update_icon()
	if(!anchored)
		w_class = WEIGHT_CLASS_BULKY
		set_light(0)
		return
	w_class = WEIGHT_CLASS_GIGANTIC
	set_light(2, 2, 2, l_color = "#1b7bf1")

/obj/item/roguemachine/merchant/Initialize()
	. = ..()
	if(anchored)
		START_PROCESSING(SSroguemachine, src)
	update_icon()
	for(var/X in GLOB.alldirs)
		var/T = get_step(src, X)
		if(!T)
			continue
		new /obj/structure/roguemachine/balloon_pad(T)

/obj/item/roguemachine/merchant/Destroy()
	STOP_PROCESSING(SSroguemachine, src)
	set_light(0)
	return ..()

/obj/item/roguemachine/merchant/process()
	if(!anchored)
		return TRUE
	if(world.time > next_airlift)
		next_airlift = world.time + rand(2 MINUTES, 3 MINUTES)
#ifdef TESTSERVER
		next_airlift = world.time + 5 SECONDS
#endif
		var/play_sound = FALSE
		for(var/D in GLOB.alldirs)
			var/budgie = 0
			var/turf/T = get_step(src, D)
			if(!T)
				continue
			var/obj/structure/roguemachine/balloon_pad/E = locate() in T
			if(!E)
				continue
			for(var/obj/I in T)
				if(I.anchored || !isturf(I.loc) || istype(I, /obj/item/roguecoin))
					continue
				var/prize = I.get_real_price() - (I.get_real_price() * SStreasury.queens_tax)
				if(prize >= 1)
					play_sound=TRUE
					budgie += prize
					I.visible_message(span_warning("[I] is sucked into the air!"))
					qdel(I)
			budgie = round(budgie)
			if(budgie > 0)
				play_sound=TRUE
				E.budget2change(budgie)
				budgie = 0
		if(play_sound)
			playsound(src.loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

#define UPGRADE_NOTAX		(1<<0)
#define UPGRADE_ARMOR		(1<<1)
#define UPGRADE_WEAPONS		(1<<2)
#define UPGRADE_FOOD		(1<<3)
#define UPGRADE_WARDROBE	(1<<4)
#define UPGRADE_ALCOHOLS	(1<<5)
#define UPGRADE_LIVESTOCK   (1<<6)

/obj/structure/roguemachine/merchantvend
	name = "GOLDFACE"
	desc = "Gilded tombs do worms enfold."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "streetvendor1"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/list/held_items = list()
	var/locked = FALSE
	var/budget = 0
	var/upgrade_flags
	var/current_cat = "1"
	var/lockid = "merchant"

/obj/structure/roguemachine/merchantvend/Initialize()
	. = ..()
	update_icon()

/obj/structure/roguemachine/merchantvend/update_icon()
	cut_overlays()
	if(obj_broken)
		set_light(0)
		return
	set_light(1, 1, 1, l_color = "#1b7bf1")
	add_overlay(mutable_appearance(icon, "vendor-merch"))


/obj/structure/roguemachine/merchantvend/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/roguekey))
		var/obj/item/roguekey/K = P
		if(K.lockid == lockid)
			locked = !locked
			playsound(loc, 'sound/misc/gold_misc.ogg', 100, FALSE, -1)
			update_icon()
			return attack_hand(user)
		else
			to_chat(user, span_warning("Wrong key."))
			return
	if(istype(P, /obj/item/storage/keyring))
		var/obj/item/storage/keyring/K = P
		for(var/obj/item/roguekey/KE in K.keys)
			if(KE.lockid == lockid)
				locked = !locked
				playsound(loc, 'sound/misc/gold_misc.ogg', 100, FALSE, -1)
				update_icon()
				return attack_hand(user)
	if(istype(P, /obj/item/roguecoin))
		budget += P.get_real_price()
		qdel(P)
		update_icon()
		playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
		return attack_hand(user)
	..()

/obj/structure/roguemachine/merchantvend/Topic(href, href_list)
	. = ..()
	if(!ishuman(usr))
		return
	if(!usr.canUseTopic(src, BE_CLOSE) || locked)
		return
	if(href_list["buy"])
		var/mob/M = usr
		var/path = text2path(href_list["buy"])
		if(!ispath(path, /datum/supply_pack))
			message_admins("silly MOTHERFUCKER [usr.key] IS TRYING TO BUY A [path] WITH THE GOLDFACE")
			return
		var/datum/supply_pack/PA = SSmerchant.supply_packs[path]
		var/cost = PA.cost
		var/tax_amt=round(SStreasury.tax_value * cost)
		cost=cost+tax_amt
		if(upgrade_flags & UPGRADE_NOTAX)
			cost = PA.cost
		if(budget >= cost)
			budget -= cost
			if(!(upgrade_flags & UPGRADE_NOTAX))
				SStreasury.give_money_treasury(tax_amt, "goldface import tax")
		else
			say("Not enough!")
			return
		var/shoplength = PA.contains.len
		var/l
		for(l=1,l<=shoplength,l++)
			var/pathi = pick(PA.contains)
			new pathi(get_turf(M))
	if(href_list["change"])
		if(budget > 0)
			budget2change(budget, usr)
			budget = 0
	if(href_list["changecat"])
		current_cat = href_list["changecat"]
	if(href_list["secrets"])
		var/list/options = list()
		if(upgrade_flags & UPGRADE_NOTAX)
			options += "Enable Paying Taxes"
		else
			options += "Stop Paying Taxes"
		if(!(upgrade_flags & UPGRADE_ARMOR))
			options += "Purchase Armors License (150)"
		if(!(upgrade_flags & UPGRADE_WEAPONS))
			options += "Purchase Weapons License (110)"
		if(!(upgrade_flags & UPGRADE_FOOD))
			options += "Purchase Pantry License (50)"
		if(!(upgrade_flags & UPGRADE_WARDROBE))
			options += "Purchase Wardrobe License (50)"
		if(!(upgrade_flags & UPGRADE_ALCOHOLS))
			options += "Purchase Alcohols License (50)"
		if(!(upgrade_flags & UPGRADE_LIVESTOCK))
			options += "Purchase Livestock License (50)"
		var/select = input(usr, "Please select an option.", "", null) as null|anything in options
		if(!select)
			return
		if(!usr.canUseTopic(src, BE_CLOSE) || locked)
			return
		switch(select)
			if("Enable Paying Taxes")
				upgrade_flags &= ~UPGRADE_NOTAX
				playsound(loc, 'sound/misc/gold_misc.ogg', 100, FALSE, -1)
			if("Stop Paying Taxes")
				upgrade_flags |= UPGRADE_NOTAX
				playsound(loc, 'sound/misc/gold_misc.ogg', 100, FALSE, -1)
			if("Purchase Armors License (150)")
				if(upgrade_flags & UPGRADE_ARMOR)
					return
				if(budget < 150)
					say("Ask again when you're serious.")
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					return
				budget -= 150
				upgrade_flags |= UPGRADE_ARMOR
				playsound(loc, 'sound/misc/gold_license.ogg', 100, FALSE, -1)
			if("Purchase Weapons License (110)")
				if(upgrade_flags & UPGRADE_WEAPONS)
					return
				if(budget < 110)
					say("Ask again when you're serious.")
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					return
				budget -= 110
				upgrade_flags |= UPGRADE_WEAPONS
				playsound(loc, 'sound/misc/gold_license.ogg', 100, FALSE, -1)
			if("Purchase Pantry License (50)")
				if(upgrade_flags & UPGRADE_FOOD)
					return
				if(budget < 50)
					say("Ask again when you're serious.")
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					return
				budget -= 50
				upgrade_flags |= UPGRADE_FOOD
				playsound(loc, 'sound/misc/gold_license.ogg', 100, FALSE, -1)
			if("Purchase Wardrobe License (50)")
				if(upgrade_flags & UPGRADE_WARDROBE)
					return
				if(budget < 50)
					say("Ask again when you're serious.")
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					return
				budget -= 50
				upgrade_flags |= UPGRADE_WARDROBE
				playsound(loc, 'sound/misc/gold_license.ogg', 100, FALSE, -1)
			if("Purchase Alcohols License (50)")
				if(upgrade_flags & UPGRADE_ALCOHOLS)
					return
				if(budget < 50)
					say("Ask again when you're serious.")
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					return
				budget -= 50
				upgrade_flags |= UPGRADE_ALCOHOLS
				playsound(loc, 'sound/misc/gold_license.ogg', 100, FALSE, -1)
			if("Purchase Livestock License (50)")
				if(upgrade_flags & UPGRADE_LIVESTOCK)
					return
				if(budget < 50)
					say("Ask again when you're serious.")
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					return
				budget -= 50
				upgrade_flags |= UPGRADE_LIVESTOCK
				playsound(loc, 'sound/misc/gold_license.ogg', 100, FALSE, -1)
	return attack_hand(usr)

/obj/structure/roguemachine/merchantvend/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	if(locked)
		to_chat(user, span_warning("It's locked. Of course."))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/gold_menu.ogg', 100, FALSE, -1)
	var/canread = user.can_read(src, TRUE)
	var/contents
	contents = "<center>GOLDFACE - In the name of greed.<BR>"
	contents += "<a href='?src=[REF(src)];change=1'>MAMMON LOADED:</a> [budget]<BR>"

	var/mob/living/carbon/human/H = user
	if(H.job in list("Merchant","Shophand"))
		if(canread)
			contents += "<a href='?src=[REF(src)];secrets=1'>Secrets</a>"
		else
			contents += "<a href='?src=[REF(src)];secrets=1'>[stars("Secrets")]</a>"

	contents += "</center><BR>"

	var/list/unlocked_cats = list("Apparel","Tools","Seeds","Luxury","Raw Materials","Armor","Weapons","Consumable","Wardrobe","Alcohols","Livestock") //Added the unlockable categories by default. Revert this or rework this later, its a lowpop contingency.
	if(upgrade_flags & UPGRADE_ARMOR)
		unlocked_cats+="Armor"
	if(upgrade_flags & UPGRADE_WEAPONS)
		unlocked_cats+="Weapons"
	if(upgrade_flags & UPGRADE_FOOD)
		unlocked_cats+="Consumable"
	if(upgrade_flags & UPGRADE_WARDROBE)
		unlocked_cats+="Wardrobe"
	if(upgrade_flags & UPGRADE_ALCOHOLS)
		unlocked_cats+="Alcohols"
	if(upgrade_flags & UPGRADE_LIVESTOCK)
		unlocked_cats+="Livestock"

	if(current_cat == "1")
		contents += "<center>"
		for(var/X in unlocked_cats)
			contents += "<a href='?src=[REF(src)];changecat=[X]'>[X]</a><BR>"
		contents += "</center>"
	else
		contents += "<center>[current_cat]<BR></center>"
		contents += "<center><a href='?src=[REF(src)];changecat=1'>\[RETURN\]</a><BR><BR></center>"
		var/list/pax = list()
		for(var/pack in SSmerchant.supply_packs)
			var/datum/supply_pack/PA = SSmerchant.supply_packs[pack]
			if(PA.group == current_cat)
				pax += PA
		for(var/datum/supply_pack/PA in sortList(pax))
			var/costy = PA.cost
			if(!(upgrade_flags & UPGRADE_NOTAX))
				costy=round(costy+(SStreasury.tax_value * costy))
			contents += "[PA.name] [PA.contains.len > 1?"x[PA.contains.len]":""] - ([costy])<a href='?src=[REF(src)];buy=[PA.type]'>BUY</a><BR>"

	if(!canread)
		contents = stars(contents)

	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 600)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/merchantvend/obj_break(damage_flag)
	..()
	budget2change(budget)
	set_light(0)
	update_icon()
	icon_state = "goldvendor0"

/obj/structure/roguemachine/merchantvend/Destroy()
	set_light(0)
	return ..()

/obj/structure/roguemachine/merchantvend/Initialize()
	. = ..()
	update_icon()
//	held_items[/obj/item/reagent_containers/glass/bottle/rogue/wine] = list("PRICE" = rand(23,33),"NAME" = "vino")
//	held_items[/obj/item/dmusicbox] = list("PRICE" = rand(444,777),"NAME" = "Music Box")

#undef UPGRADE_NOTAX
