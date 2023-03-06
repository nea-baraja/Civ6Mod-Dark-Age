insert or replace into Types(Type, Kind) values
	('VICTORY_HARMONY_IN_DIVERSTY',		'KIND_VICTORY'),
	('BUILDING_VICTORY_HARMONY_IN_DIVERSTY',		'KIND_BUILDING');

insert or replace into Victories(VictoryType, Name, Blurb, Description, RequirementSetId, CriticalPercentage, OneMoreTurn, Icon) values
('VICTORY_HARMONY_IN_DIVERSTY',	'LOC_VICTORY_HARMONY_IN_DIVERSTY_NAME','LOC_VICTORY_HARMONY_IN_DIVERSTY_BLURB','LOC_VICTORY_HARMONY_IN_DIVERSTY_DESCRIPTION','RS_PLAYER_HAS_BUILDING_VICTORY_HARMONY_IN_DIVERSTY',10,1,'VICTORY_HARMONY_IN_DIVERSTY');

insert or replace into Buildings (BuildingType,	Name,	Cost,	Description,		MustPurchase)
values ('BUILDING_VICTORY_HARMONY_IN_DIVERSTY', 'LOC_BUILDING_VICTORY_HARMONY_IN_DIVERSTY_NAME',		100, 		'LOC_BUILDING_VICTORY_HARMONY_IN_DIVERSTY_DESCRIPTION',1);

--在百科中屏蔽
insert or replace into CivilopediaPageExcludes(SectionId,   PageId) values
('BUILDINGS',  'BUILDING_VICTORY_HARMONY_IN_DIVERSTY');

insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_PLAYER_HAS_'||BuildingType, 'REQUIREMENT_PLAYER_HAS_BUILDING'
from Buildings;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_PLAYER_HAS_'||BuildingType, 'BuildingType', BuildingType
from Buildings;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_PLAYER_HAS_'||BuildingType,				'REQUIREMENTSET_TEST_ALL'
from Buildings;                                

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_PLAYER_HAS_'||BuildingType,				'REQ_PLAYER_HAS_'||BuildingType
from Buildings;