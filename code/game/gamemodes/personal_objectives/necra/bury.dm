/datum/objective/proper_burial
	name = "Consecrate Graves"
	var/burials_completed = 0
	var/required_burials = 1

/datum/objective/proper_burial/on_creation()
	. = ..()
	if(owner?.current)
		if(owner.current.job == "Gravetender" || istype(owner.current.mind?.assigned_role, /datum/job/undertaker))
			required_burials = 2
		RegisterSignal(owner.current, COMSIG_GRAVE_CONSECRATED, PROC_REF(on_grave_consecrated))
	update_explanation_text()

/datum/objective/proper_burial/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_GRAVE_CONSECRATED)
	return ..()

/datum/objective/proper_burial/proc/on_grave_consecrated(datum/source, obj/structure/closet/dirthole/hole)
	SIGNAL_HANDLER
	if(completed)
		return

	burials_completed++
	if(burials_completed >= required_burials)
		complete_objective()
	else
		to_chat(owner.current, span_notice("Grave consecrated! Consecrate [required_burials - burials_completed] more to complete Necra's trial."))

/datum/objective/proper_burial/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have consecrated enough graves to earn Necra's approval!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence("Necra", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_GRAVE_CONSECRATED)

/datum/objective/proper_burial/update_explanation_text()
	explanation_text = "Consecrate [required_burials] grave\s by building a grave marker or using funeral rites to earn Necra's approval."
