/datum/martial_art/soap_fu
	name = "Soap Fu"

/datum/martial_art/cqc/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	MARTIAL_ARTS_ACT_CHECK
	var/obj/item/grab/G = D.grabbedby(A, 1)
	if(G)
		G.state = GRAB_AGGRESSIVE //Instant aggressive grab
		add_attack_logs(A, D, "Melee attacked with martial-art [src] : aggressively grabbed", ATKLOG_ALL)

	return TRUE

/datum/martial_art/soap_fu/teach(mob/living/carbon/human/H, make_temporary=0)
	..()
	if(HAS_TRAIT(H, TRAIT_PACIFISM))
		to_chat(H, "<span class='warning'>The arts of Soap-Fu echo uselessly in your head, the thought of their violence repulsive to you!</span>")
		return
	to_chat(H, "<span class = 'userdanger'>You know the arts of Soap-Fu!</span>")
	to_chat(H, "<span class = 'danger'>You can now instantly grab people into an aggressive hold.</span>")