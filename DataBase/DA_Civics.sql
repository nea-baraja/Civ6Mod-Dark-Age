
delete from StartingCivics;

update DiplomaticActions set
	InitiatorPrereqCivic = 'CIVIC_POLITICAL_PHILOSOPHY',
	TargetPrereqCivic = 'CIVIC_POLITICAL_PHILOSOPHY'
	where DiplomaticActionType in ('DIPLOACTION_ALLIANCE_ECONOMIC',	'DIPLOACTION_ALLIANCE_MILITARY');

insert or replace into Types(Type,	Kind) values
	('CIVIC_NATIVE_LAND',			'KIND_CIVIC'),
	('CIVIC_SORCERY_AND_HERB',		'KIND_CIVIC');


insert or replace into Civics(CivicType,	Name,	Description,	Cost,	AdvisorType,	EraType,	UITreeRow) values
	('CIVIC_NATIVE_LAND',			'LOC_CIVIC_NATIVE_LAND_NAME',		NULL,		25,	'ADVISOR_GENERIC',	'ERA_ANCIENT',	-3),
	('CIVIC_SORCERY_AND_HERB',		'LOC_CIVIC_SORCERY_AND_HERB_NAME',	'LOC_CIVIC_SORCERY_AND_HERB_DESCRIPTION',	25,	'ADVISOR_GENERIC',	'ERA_ANCIENT',	3);

update Civics set UITreeRow = -1 where CivicType = 'CIVIC_STATE_WORKFORCE';
update Civics set UITreeRow = -1 where CivicType = 'CIVIC_CRAFTSMANSHIP';
update Civics set UITreeRow = 1 where CivicType = 'CIVIC_FOREIGN_TRADE';


--远古市政价格 25 45 75
update Civics set Cost = 25 where CivicType = 'CIVIC_CODE_OF_LAWS';
update Civics set Cost = 45 
	where CivicType in ('CIVIC_MILITARY_TRADITION', 'CIVIC_MYSTICISM', 'CIVIC_FOREIGN_TRADE', 'CIVIC_CRAFTSMANSHIP');
update Civics set Cost = 75 
	where CivicType in ('CIVIC_STATE_WORKFORCE', 'CIVIC_EARLY_EMPIRE');


delete from CivicPrereqs where Civic in ('CIVIC_MILITARY_TRADITION', 'CIVIC_MYSTICISM');



insert or replace into CivicPrereqs(Civic,	PrereqCivic) values
	('CIVIC_MILITARY_TRADITION',		'CIVIC_NATIVE_LAND'),
	('CIVIC_MYSTICISM',					'CIVIC_SORCERY_AND_HERB'),
	('CIVIC_STATE_WORKFORCE',			'CIVIC_MILITARY_TRADITION'),
	('CIVIC_EARLY_EMPIRE',				'CIVIC_MYSTICISM');

insert or replace into Boosts(BoostID, CivicType, TriggerDescription, BoostClass, Boost, TriggerLongDescription) values
	(501, 'CIVIC_CODE_OF_LAWS',			'LOC_BOOST_TRIGGER_OTHER',		'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', 40, ''),
	(502, 'CIVIC_NATIVE_LAND',			'LOC_BOOST_TRIGGER_OTHER',		'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', 40, ''),
	(503, 'CIVIC_SORCERY_AND_HERB',		'LOC_BOOST_TRIGGER_OTHER',		'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', 40, '');

update Boosts set BoostClass = 'BOOST_TRIGGER_HAVE_X_BUILDINGS', BuildingType = 'BUILDING_PAPER_MAKER', NumItems = 1, DistrictType = null
	where CivicType = 'CIVIC_RECORDED_HISTORY';


