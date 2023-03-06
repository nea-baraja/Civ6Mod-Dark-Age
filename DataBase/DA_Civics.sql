
delete from StartingCivics;

update DiplomaticActions set
	InitiatorPrereqCivic = 'CIVIC_POLITICAL_PHILOSOPHY',
	TargetPrereqCivic = 'CIVIC_POLITICAL_PHILOSOPHY'
	where DiplomaticActionType in ('DIPLOACTION_ALLIANCE_ECONOMIC',	'DIPLOACTION_ALLIANCE_MILITARY');

insert or replace into Types(Type,	Kind) values
	('CIVIC_NATIVE_LAND',			'KIND_CIVIC'),
	('CIVIC_SORCERY_AND_HERB',		'KIND_CIVIC');


insert or replace into Civics(CivicType,	Name,	Description,	Cost,	AdvisorType,	EraType,	UITreeRow) values
	('CIVIC_NATIVE_LAND',			'LOC_CIVIC_NATIVE_LAND_NAME',		NULL,		20,	'ADVISOR_GENERIC',	'ERA_ANCIENT',	-3),
	('CIVIC_SORCERY_AND_HERB',		'LOC_CIVIC_SORCERY_AND_HERB_NAME',	'LOC_CIVIC_SORCERY_AND_HERB_DESCRIPTION',	20,	'ADVISOR_GENERIC',	'ERA_ANCIENT',	3);


delete from CivicPrereqs where Civic in ('CIVIC_MILITARY_TRADITION', 'CIVIC_MYSTICISM');
insert or replace into CivicPrereqs(Civic,	PrereqCivic) values
	('CIVIC_MILITARY_TRADITION',		'CIVIC_NATIVE_LAND'),
	('CIVIC_MYSTICISM',					'CIVIC_SORCERY_AND_HERB');

--insert or replace into Boosts()




