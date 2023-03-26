

update Technologies set Description = 'LOC_'||TechnologyType||'_DESCRIPTION' where TechnologyType in
	('TECH_ARCHERY',	'TECH_HORSEBACK_RIDING', 'TECH_THE_WHEEL');

insert or replace into Boosts(BoostID, TechnologyType, TriggerDescription, BoostClass, Boost, TriggerLongDescription) values
	(601, 'TECH_MINING',			'LOC_BOOST_TRIGGER_OTHER',		'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', 40, ''),
	(602, 'TECH_ANIMAL_HUSBANDRY',	'LOC_BOOST_TRIGGER_OTHER',		'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', 40, ''),
	(603, 'TECH_POTTERY',			'LOC_BOOST_TRIGGER_OTHER',		'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', 40, '');