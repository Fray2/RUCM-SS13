//Marine jobs. All marines are genericized when they first log in, then it auto assigns them to squads.

/datum/job/marine
	department_flag = ROLEGROUP_MARINE_SQUAD_MARINES
	supervisors = "the acting squad leader"
	selection_class = "job_marine"
	total_positions = 8
	spawn_positions = 8
	allow_additional = 1

/datum/job/marine/generate_entry_message(mob/living/carbon/human/H)
	if(H.assigned_squad)
		entry_message_intro = "You are a [title]!<br>You have been assigned to: <b><font size=3 color=[squad_colors[H.assigned_squad.color]]>[lowertext(H.assigned_squad.name)] squad</font></b>.[flags_startup_parameters & ROLE_ADD_TO_MODE ? " Make your way to the cafeteria for some post-cryosleep chow, and then get equipped in your squad's prep room." : ""]"
	return ..()

/datum/job/marine/generate_entry_conditions(mob/living/carbon/human/H)
	entry_message_body = ..()
	if(flags_startup_parameters & ROLE_ADD_TO_MODE) H.nutrition = rand(NUTRITION_VERYLOW, NUTRITION_LOW) //Start hungry for the default marine.

/datum/job/marine/leader
	title = JOB_SQUAD_LEADER
	flag = ROLE_MARINE_LEADER
	total_positions = 4
	spawn_positions = 4
	supervisors = "the acting commanding officer"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_MODE|ROLE_ADD_TO_SQUAD
	gear_preset = "USCM (Cryo) Squad Leader"
	minimum_playtimes = list(
		JOB_SQUAD_ROLES = HOURS_9
	)

/datum/job/marine/leader/generate_entry_message()
	entry_message_body = "You are responsible for the men and women of your squad. Make sure they are on task, working together, and communicating. You are also in charge of communicating with command and letting them know about the situation first hand. Keep out of harm's way."
	return ..()

/datum/job/marine/leader/equipped
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "USCM Cryo Squad Leader (Equipped)"

/datum/job/marine/leader/equipped/whiskey
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "WO Dust Raider Squad Leader"

/datum/job/marine/engineer
	title = JOB_SQUAD_ENGI
	total_positions = 12
	spawn_positions = 12
	allow_additional = 1
	flag = ROLE_MARINE_ENGINEER
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_MODE|ROLE_ADD_TO_SQUAD
	gear_preset = "USCM (Cryo) Squad Engineer"
	minimum_playtimes = list(
		JOB_SQUAD_ROLES = HOURS_3
	)

/datum/job/marine/engineer/generate_entry_message()
	entry_message_body = "You have the equipment and skill to build fortifications, reroute power lines, and bunker down. Your squaddies will look to you when it comes to construction in the field of battle."
	return ..()

/datum/job/marine/engineer/get_total_positions(var/latejoin=0)
	var/slots = engi_slot_formula(get_total_marines())

	if(slots <= total_positions_so_far)
		slots = total_positions_so_far
	else
		total_positions_so_far = slots

	if(latejoin)
		for(var/datum/squad/sq in RoleAuthority.squads)
			if(sq)
				sq.max_engineers = slots

	return (slots*4)

/datum/job/marine/engineer/equipped
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "USCM Cryo Engineer (Equipped)"

/datum/job/marine/engineer/equipped/whiskey
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "WO Dust Raider Squad Engineer"

/datum/job/marine/medic
	title = JOB_SQUAD_MEDIC
	total_positions = 16
	spawn_positions = 16
	allow_additional = 1
	flag = ROLE_MARINE_MEDIC
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_MODE|ROLE_ADD_TO_SQUAD
	gear_preset = "USCM (Cryo) Squad Medic"
	minimum_playtimes = list(
		JOB_DOCTOR = HOURS_3
	)

/datum/job/marine/medic/generate_entry_message()
	entry_message_body = "You must tend the wounds of your squad mates and make sure they are healthy and active. You may not be a fully-fledged doctor, but you stand between life and death when it matters."
	return ..()

/datum/job/marine/medic/get_total_positions(var/latejoin=0)
	var/slots = medic_slot_formula(get_total_marines())

	if(slots <= total_positions_so_far)
		slots = total_positions_so_far
	else
		total_positions_so_far = slots

	if(latejoin)
		for(var/datum/squad/sq in RoleAuthority.squads)
			if(sq)
				sq.max_medics = slots

	return (slots*4)

/datum/job/marine/medic/equipped
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "USCM Cryo Medic (Equipped)"

/datum/job/marine/medic/equipped/whiskey
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "WO Dust Raider Squad Medic"

/datum/job/marine/specialist
	title = JOB_SQUAD_SPECIALIST
	flag = ROLE_MARINE_SPECIALIST
	total_positions = 4
	spawn_positions = 4
	allow_additional = 1
	scaled = 1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_MODE|ROLE_ADD_TO_SQUAD
	gear_preset = "USCM (Cryo) Squad Specialist"
	minimum_playtimes = list(
		JOB_SQUAD_ROLES = HOURS_6
	)

/datum/job/marine/specialist/generate_entry_message()
	entry_message_body = "You are the very rare and valuable weapon expert, trained to use special equipment. You can serve a variety of roles, so choose carefully."
	return ..()

/datum/job/marine/specialist/set_spawn_positions(var/count)
	spawn_positions = spec_slot_formula(count)

/datum/job/marine/specialist/get_total_positions(var/latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = spec_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	return positions


/datum/job/marine/specialist/equipped
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "USCM Cryo Specialist (Equipped)"

/datum/job/marine/specialist/equipped/whiskey
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "WO Dust Raider Squad Specialist"

/datum/job/marine/smartgunner
	title = JOB_SQUAD_SMARTGUN
	flag = ROLE_MARINE_SMARTGUN
	total_positions = 4
	spawn_positions = 4
	allow_additional = 1
	scaled = 1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_MODE|ROLE_ADD_TO_SQUAD
	gear_preset = "USCM (Cryo) Smartgunner"
	minimum_playtimes = list(
		JOB_SQUAD_ROLES = HOURS_3
	)

/datum/job/marine/smartgunner/generate_entry_message()
	entry_message_body = "You are the smartgunner. Your job is to provide heavy weapons support."
	return ..()

/datum/job/marine/smartgunner/set_spawn_positions(var/count)
	spawn_positions = sg_slot_formula(count)

/datum/job/marine/smartgunner/get_total_positions(var/latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = sg_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	return positions

/datum/job/marine/smartgunner/equipped
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "USCM Smartgunner"

/datum/job/marine/smartgunner/equipped/whiskey
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "WO Dust Raider Squad Smartgunner"

/datum/job/marine/standard
	title = JOB_SQUAD_MARINE
	flag = ROLE_MARINE_STANDARD
	department_flag = ROLEGROUP_MARINE_SQUAD_MARINES
	total_positions = -1
	spawn_positions = -1
	minimum_playtimes = list()
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_MODE|ROLE_ADD_TO_SQUAD
	gear_preset = "USCM (Cryo) Squad Marine (PFC)"

/datum/job/marine/standard/generate_entry_message()
	entry_message_body = "You are a rank-and-file soldier of the USCM, and that is your strength. What you lack alone, you gain standing shoulder to shoulder with the men and women of the corps. Ooh-rah!"
	return ..()

/datum/job/marine/standard/equipped
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "USCM PFC (Pulse Rifle)"

/datum/job/marine/standard/equipped/whiskey
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = "WO Dust Raider Squad Marine (PFC)"