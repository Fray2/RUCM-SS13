/datum/agent_objective/destroy
	description = ""
	var/max_amount = 5
	var/min_amount = 2
	var/event_to_listen_on = EVENT_WALL_DESTROYED
	var/obj_to_destroy_type = /turf/closed/wall
	var/destroyed_so_far = 0
	var/amount_to_destroy = 0
	var/areas_to_destroy_in = list(/area/almayer/medical/upper_medical, /area/almayer/shipboard/brig, /area/almayer/command/cic)

/datum/agent_objective/destroy/New(datum/agent/A)
	amount_to_destroy = rand(min_amount, max_amount)

	. = ..()

	registerListener(GLOBAL_EVENT, event_to_listen_on + "\ref[belonging_to_agent.source_human]", "\ref[src]_\ref[belonging_to_agent.source_human]", CALLBACK(src, .proc/count_destruction))

/datum/agent_objective/destroy/generate_objective_body_message()
	var/text_string = ""
	for(var/i = 1 to (length(areas_to_destroy_in) - 1))
		var/obj/thing = areas_to_destroy_in[i]
		var/name = "[initial(thing.name)]"
		text_string += ", [SPAN_BOLD("[SPAN_RED("[name]")]")]"

	var/obj/thingy = areas_to_destroy_in[length(areas_to_destroy_in)]
	var/namey = "[initial(thingy.name)]"
	text_string += " or [SPAN_BOLD("[SPAN_RED("[namey]")]")]"

	var/obj/thing = obj_to_destroy_type
	return "Weaken the structurals of [MAIN_SHIP_NAME] by [SPAN_BOLD("[SPAN_BLUE("destroying")]")] [SPAN_BOLD("[SPAN_RED("[amount_to_destroy] [initial(thing.name)]s")]")] at[text_string]."

/datum/agent_objective/destroy/generate_description()
	var/text_string = ""
	for(var/i = 1 to (length(areas_to_destroy_in) - 1))
		var/obj/thing = areas_to_destroy_in[i]
		var/name = "[initial(thing.name)]"
		text_string += ", [name]"

	var/obj/thingy = areas_to_destroy_in[length(areas_to_destroy_in)]
	var/namey = "[initial(thingy.name)]"
	text_string += " or [namey]"

	var/obj/thing = obj_to_destroy_type
	description = "Weaken the structurals of [MAIN_SHIP_NAME] by destroying [amount_to_destroy] [initial(thing.name)]s at[text_string]."

/datum/agent_objective/destroy/proc/count_destruction(var/type_path, var/area/area_passed)
	if(!ispath(type_path, obj_to_destroy_type) || !istype(area_passed))
		return

	if(area_passed.type in areas_to_destroy_in)
		destroyed_so_far++


/datum/agent_objective/destroy/check_completion_round_end()
	. = ..()
	if(!.)
		return FALSE

	// Check that we destroyed enough
	if(amount_to_destroy <= destroyed_so_far)
		return TRUE

	return FALSE

/datum/agent_objective/destroy/window
	event_to_listen_on = EVENT_WINDOW_DESTROYED
	obj_to_destroy_type = /obj/structure/window

/datum/agent_objective/destroy/airlock
	max_amount = 1
	min_amount = 1
	event_to_listen_on = EVENT_AIRLOCK_DESTROYED
	obj_to_destroy_type = /obj/structure/machinery/door/airlock