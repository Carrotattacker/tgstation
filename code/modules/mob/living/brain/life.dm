
/mob/living/brain/Life(delta_time = SSMOBS_DT, times_fired)
	if (notransform)
		return
	if(!loc)
		return
	. = ..()
	handle_emp_damage(delta_time, times_fired)

/mob/living/brain/update_stat()
	if(status_flags & GODMODE)
		return
	if(health > HEALTH_THRESHOLD_DEAD)
		return
	if(stat != DEAD)
		death()
	var/obj/item/organ/internal/brain/BR
	if(container?.brain)
		BR = container.brain
	else if(istype(loc, /obj/item/organ/internal/brain))
		BR = loc
	if(BR)
		BR.set_organ_damage(BRAIN_DAMAGE_DEATH) //beaten to a pulp

/mob/living/brain/proc/handle_emp_damage(delta_time, times_fired)
	if(!emp_damage)
		return

	if(stat == DEAD)
		emp_damage = 0
	else
		emp_damage = max(emp_damage - (0.5 * delta_time), 0)
