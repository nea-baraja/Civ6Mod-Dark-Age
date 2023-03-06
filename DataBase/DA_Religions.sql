

UPDATE Map_GreatPersonClasses SET MaxWorldInstances = 999 WHERE GreatPersonClassType = 'GREAT_PERSON_CLASS_PROPHET';

UPDATE BeliefClasses SET MaxInReligion = 999, AdoptionOrder = 3 WHERE BeliefClassType != 'BELIEF_CLASS_PANTHEON' ;
UPDATE BeliefClasses SET MaxInReligion = 1, AdoptionOrder = 2 WHERE BeliefClassType = 'BELIEF_CLASS_FOLLOWER' ;
UPDATE BeliefClasses SET MaxInReligion = 1, AdoptionOrder = 3 WHERE BeliefClassType = 'BELIEF_CLASS_FOUNDER' ;

UPDATE GlobalParameters SET Value = 2 WHERE Name = 'RELIGION_INITIAL_BELIEFS' ;

INSERT INTO Modifiers 
(ModifierId,							ModifierType,							RunOnce,	Permanent,	SubjectRequirementSetId) 
VALUES
('DA_ADD_BELIEF',						'MODIFIER_PLAYER_ADD_BELIEF',			1,			1,			'RS_FOUNDED_RELIGION');

INSERT OR REPLACE INTO RequirementSets(RequirementSetId,	RequirementSetType)
values	('RS_FOUNDED_RELIGION',		'REQUIREMENTSET_TEST_ALL'),
		('RS_FOUNDED_NO_RELIGION',	'REQUIREMENTSET_TEST_ALL');

insert or replace into RequirementSetRequirements(RequirementSetId,		RequirementId)
values	('RS_FOUNDED_RELIGION',		'REQ_FOUNDED_RELIGION'),
		('RS_FOUNDED_NO_RELIGION',	'REQ_FOUNDED_NO_RELIGION');

insert or replace into Requirements(RequirementId,	RequirementType,Inverse)
	values('REQ_FOUNDED_RELIGION',	'REQUIREMENT_PLAYER_FOUNDED_NO_RELIGION',1),
		  ('REQ_FOUNDED_NO_RELIGION',	'REQUIREMENT_PLAYER_FOUNDED_NO_RELIGION',0);

--UPDATE Units SET EvangelizeBelief = 0 WHERE UnitType = 'UNIT_APOSTLE' ;


INSERT INTO ModifierArguments 
(ModifierId,							Name,			Value) 
VALUES 
('DA_ADD_BELIEF',						'Amount',		1);

insert or replace into BuildingModifiers(BuildingType, ModifierId)
	select BuildingType,	'DA_ADD_BELIEF'
	from Buildings where BuildingType in (
		'BUILDING_TEMPLE_ARTEMIS',
		'BUILDING_ETEMENANKI',
		'BUILDING_ORACLE',
		'BUILDING_COLOSSUS',
		'BUILDING_MAHABODHI_TEMPLE',
		'BUILDING_HUEY_TEOCALLI',
		'BUILDING_STATUE_OF_ZEUS',
		'BUILDING_HAGIA_SOPHIA',
		'BUILDING_CHICHEN_ITZA',
		'BUILDING_MONT_ST_MICHEL',
		'BUILDING_KOTOKU_IN',
		'BUILDING_MEENAKSHI_TEMPLE',
		'BUILDING_POTALA_PALACE',
		'BUILDING_ST_BASILS_CATHEDRAL',
		'BUILDING_STATUE_LIBERTY',
		'BUILDING_CRISTO_REDENTOR'
		);