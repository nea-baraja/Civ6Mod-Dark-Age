insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) values
	('CAESAR_LOVE_PATRA',	'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'RS_IS_PATRA'),
	('PATRA_LOVE_CAESAR',	'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'RS_IS_CAESAR');

insert or replace into ModifierArguments(ModifierId,	Name,	Value) values
	('CAESAR_LOVE_PATRA',		'SimpleModifierDescription',	'LOC_TOOLTIP_DIPLOMACY_IS_PATRA'),
	('CAESAR_LOVE_PATRA',		'StatementKey',					'LOC_DIPLO_KUDO_LEADER_JULIUS_CAESAR_REASON_ANY'),
	('CAESAR_LOVE_PATRA',		'InitialValue',					50),
	('CAESAR_LOVE_PATRA',		'HiddenAgenda',					1),

	('PATRA_LOVE_CAESAR',		'SimpleModifierDescription',	'LOC_TOOLTIP_DIPLOMACY_IS_CAESAR'),
	('PATRA_LOVE_CAESAR',		'StatementKey',					'LOC_DIPLO_KUDO_LEADER_CLEOPATRA_REASON_ANY'),
	('PATRA_LOVE_CAESAR',		'InitialValue',					50),
	('PATRA_LOVE_CAESAR',		'HiddenAgenda',					1);

insert or replace into TraitModifiers(TraitType,	ModifierId) values
	('TRAIT_LEADER_CAESAR',				'CAESAR_LOVE_PATRA'),
	('TRAIT_LEADER_MEDITERRANEAN',		'PATRA_LOVE_CAESAR');

insert or ignore into RequirementArguments (RequirementId, Name, Value)
	values ('HAS_MONUMENT', 'BuildingType'	, 'BUILDING_MONUMENT');
insert or ignore into Requirements (RequirementId, RequirementType)
	values ('HAS_MONUMENT', 'REQUIREMENT_PLAYER_HAS_BUILDING');


insert or ignore into RequirementArguments (RequirementId, Name, Value)
	values ('REQ_IS_PATRA', 'LeaderType'	, 'LEADER_CLEOPATRA');
insert or ignore into Requirements (RequirementId, RequirementType)
	values ('REQ_IS_PATRA', 'REQUIREMENT_PLAYER_TYPE_MATCHES');
insert or ignore into RequirementSets (RequirementSetId, RequirementSetType)
	values ('RS_IS_PATRA', 	'REQUIREMENTSET_TEST_ALL');
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId)
	values ('RS_IS_PATRA', 	'REQ_IS_PATRA'),
		   ('RS_IS_PATRA', 	'HAS_MONUMENT');

insert or ignore into RequirementArguments (RequirementId, Name, Value)
	values ('REQ_IS_CAESAR', 'LeaderType'	, 'LEADER_JULIUS_CAESAR');
insert or ignore into Requirements (RequirementId, RequirementType)
	values ('REQ_IS_CAESAR', 'REQUIREMENT_PLAYER_TYPE_MATCHES');
insert or ignore into RequirementSets (RequirementSetId, RequirementSetType)
	values ('RS_IS_CAESAR', 	'REQUIREMENTSET_TEST_ALL');
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId)
	values ('RS_IS_CAESAR', 	'REQ_IS_CAESAR'),
		   ('RS_IS_CAESAR', 	'HAS_MONUMENT');
