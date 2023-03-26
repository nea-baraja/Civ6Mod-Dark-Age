--删除艳后商路加成  删除埃及原河流加速  删除拉美西斯原能力
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_MEDITERRANEAN' and ModifierId like '%_TRADE_%';
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_ITERU' and ModifierId like 'TRAIT_RIVER_FASTER%';
delete from TraitModifiers where TraitType = 'TRAIT_LEADER_RAMSES';

create table "Egypt_Allies"(
'TraitType' TEXT NOT NULL,
'ModifierId' TEXT NOT NULL,
PRIMARY KEY('TraitType','ModifierId')
);

--重做艳后 地中海新年能力
insert or replace into Egypt_Allies (TraitType,	ModifierId)
		select TraitType,	ModifierId
	from TraitModifiers where TraitType  <> 'TRAIT_LEADER_MAJOR_CIV';

delete from Egypt_Allies where TraitType not in (select TraitType from LeaderTraits);

insert or replace into Types(Type, Kind) values
	('BUILDING_FLAG_NO_2_ALLIES',		'KIND_BUILDING');

insert or replace into Buildings (BuildingType,	Name,	Cost,	Description,		MustPurchase,	InternalOnly)
values ('BUILDING_FLAG_NO_2_ALLIES', 'FLAG',		1, 	'Internal only. Ignore it.',1,1);

insert or replace into Requirements (RequirementId, RequirementType)
values ('REQ_PLAYER_HAS_BUILDING_FLAG_NO_2_ALLIES', 'REQUIREMENT_CITY_HAS_BUILDING');

insert or replace into RequirementArguments (RequirementId, Name, Value)
values ('REQ_PLAYER_HAS_BUILDING_FLAG_NO_2_ALLIES', 'BuildingType',	'BUILDING_FLAG_NO_2_ALLIES');

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
values ('RS_PLAYER_HAS_BUILDING_FLAG_NO_2_ALLIES', 'REQUIREMENTSET_TEST_ALL');

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
values ('RS_PLAYER_HAS_BUILDING_FLAG_NO_2_ALLIES', 'REQ_PLAYER_HAS_BUILDING_FLAG_NO_2_ALLIES');

insert or replace into TraitModifiers(TraitType,		ModifierId) select
	TraitType,	'EGYPT_ALLY_'||ModifierId
from Egypt_Allies;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId) select
	'EGYPT_ALLY_'||ModifierId,		'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',		'RS_MEDITERRANEAN_WITH_ONE_ALLY'
from Egypt_Allies;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'EGYPT_ALLY_'||ModifierId,		'ModifierId',		ModifierId
from Egypt_Allies;


insert or replace into RequirementSets(RequirementSetId,	RequirementSetType) values
	('RS_MEDITERRANEAN_WITH_ONE_ALLY',				'REQUIREMENTSET_TEST_ALL');

insert or replace into RequirementSetRequirements(RequirementSetId,		RequirementId) values
	('RS_MEDITERRANEAN_WITH_ONE_ALLY',		'REQUIRES_PLAYER_ALLY'),
	('RS_MEDITERRANEAN_WITH_ONE_ALLY',		'REQUIRES_PLAYER_AT_PEACE'),
	('RS_MEDITERRANEAN_WITH_ONE_ALLY',		'REQUIRES_MAJOR_CIV_OPPONENT'),
	('RS_MEDITERRANEAN_WITH_ONE_ALLY',		'REQ_PLAYER_IS_LEADER_CLEOPATRA'),
	('RS_MEDITERRANEAN_WITH_ONE_ALLY',		'REQ_PLAYER_HAS_BUILDING_FLAG_NO_2_ALLIES');

--重做ua 古尼罗河

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_CIVILIZATION_ITERU',		'ITERU_RIVER_'||numbers||'_FASTER_DISTRICT'	
from counter where numbers >= 1 and numbers <= 10;

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_CIVILIZATION_ITERU',		'ITERU_RIVER_'||numbers||'_FASTER_WONDER'	
from counter where numbers >= 1 and numbers <= 10;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId) select
	'ITERU_RIVER_'||numbers||'_FASTER_DISTRICT',	'MODIFIER_PLAYER_CITIES_ADJUST_RIVER_DISTRICT_PRODUCTION',	'RS_RIVER_COUNT_'||numbers
from counter where numbers >= 1 and numbers <= 10;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId) select
	'ITERU_RIVER_'||numbers||'_FASTER_WONDER',		'MODIFIER_PLAYER_CITIES_ADJUST_RIVER_WONDER_PRODUCTION',	'RS_RIVER_COUNT_'||numbers
from counter where numbers >= 1 and numbers <= 10;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ITERU_RIVER_'||numbers||'_FASTER_DISTRICT',	'Amount',	10
from counter where numbers >= 1 and numbers <= 10;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ITERU_RIVER_'||numbers||'_FASTER_WONDER',	'Amount',	10
from counter where numbers >= 1 and numbers <= 10;



insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_RIVER_COUNT_'||numbers, 'REQUIREMENT_PLOT_PROPERTY_MATCHES'
from counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_RIVER_COUNT_'||numbers, 'PropertyMinimum', numbers
from counter where numbers >= 1 and numbers <= 10;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_RIVER_COUNT_'||numbers, 'PropertyName', 'PROP_RIVER_COUNT'
from counter where numbers >= 1 and numbers <= 10;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_RIVER_COUNT_'||numbers,				'REQUIREMENTSET_TEST_ALL'
from counter where numbers >= 1 and numbers <= 10;

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_RIVER_COUNT_'||numbers,				'REQ_RIVER_COUNT_'||numbers
from counter where numbers >= 1 and numbers <= 10;


--UI狮身人面像
update Improvements set 
	SameAdjacentValid = 1,
	OnePerCity = 1
where ImprovementType = 'IMPROVEMENT_SPHINX';

delete from ImprovementModifiers where ModifierId = 'SPHINX_FLOODPLAINS_CULTURE';

update Improvement_YieldChanges set 
	YieldChange = 0
where ImprovementType = 'IMPROVEMENT_SPHINX';

insert or replace into Improvement_BonusYieldChanges(ImprovementType,	YieldType,	BonusYieldChange,	PrereqCivic) values
	('IMPROVEMENT_SPHINX',		'YIELD_FAITH',	2,	'CIVIC_THEOLOGY');


insert or replace into Improvement_Adjacencies(ImprovementType,		YieldChangeId) values
	('IMPROVEMENT_SPHINX',		'SPHINX_ADJACENT_WONDER_CULTURE'),
	('IMPROVEMENT_SPHINX',		'SPHINX_ADJACENT_FLOODPLAINS_FAITH'),
	('IMPROVEMENT_SPHINX',		'SPHINX_ADJACENT_GRASS_FLOODPLAINS_FAITH'),
	('IMPROVEMENT_SPHINX',		'SPHINX_ADJACENT_PLAIN_FLOODPLAINS_FAITH');


insert or replace into Adjacency_YieldChanges(ID,	Description,	YieldType,	YieldChange,	TilesRequired,	AdjacentFeature,	AdjacentWonder) values
	('SPHINX_ADJACENT_WONDER_CULTURE',				'LOC_SPHINX_ADJACENT_WONDER_CULTURE_DESCRIPTION',			'YIELD_CULTURE',	2,	1,	null,								1),
	('SPHINX_ADJACENT_FLOODPLAINS_FAITH',			'LOC_SPHINX_ADJACENT_FLOODPLAINS_FAITH_DESCRIPTION',		'YIELD_FAITH',		1,	1,	'FEATURE_FLOODPLAINS',				0),
	('SPHINX_ADJACENT_GRASS_FLOODPLAINS_FAITH',		'LOC_SPHINX_ADJACENT_GRASS_FLOODPLAINS_FAITH_DESCRIPTION',	'YIELD_FAITH',		1,	1,	'FEATURE_FLOODPLAINS_GRASSLAND',	0),
	('SPHINX_ADJACENT_PLAIN_FLOODPLAINS_FAITH',		'LOC_SPHINX_ADJACENT_PLAIN_FLOODPLAINS_FAITH_DESCRIPTION',	'YIELD_FAITH',		1,	1,	'FEATURE_FLOODPLAINS_PLAINS',		0);



