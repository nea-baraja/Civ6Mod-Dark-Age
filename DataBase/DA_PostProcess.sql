

--城市守护女神  区域相邻信仰

insert or replace into BeliefModifiers 	(BeliefType,	ModifierID)
	select 'BELIEF_CITY_PATRON_GODDESS',	'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH'
	from Districts, ConfigValues where ConfigId = 'CONFIG_BELIEF' and ConfigVal = 1;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',	'PLAYER_HAS_PANTHEON_REQUIREMENTS'
	from Districts;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId)
	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'MODIFIER_PLAYER_CITIES_DISTRICT_ADJACENCY',	NULL
	from Districts;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH',	'ModifierId',	'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD'
	from Districts;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'Amount',	1
	from Districts;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'DistrictType',	DistrictType
	from Districts;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'YieldType',	'YIELD_FAITH'
	from Districts;




/*
insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'CITY_PATRON_GODDESS_'||DistrictType||'_ADJACENCY_FAITH_MOD',	'Description',	'???'
	from Districts;
	*/

--畜力机械
/*
insert or replace into BuildingModifiers(BuildingType,	ModifierId)	select
	'BUILDING_STG_ANIMAL_POWER',		'ANIMAL_POWER_FOR_'||BuildingType
	from Building_YieldChanges;

insert or replace into Modifiers(ModifierId,	ModifierType) select
	'ANIMAL_POWER_FOR_'||BuildingType,	'MODIFIER_BUILDING_YIELD_CHANGE'
	from Building_YieldChanges;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ANIMAL_POWER_FOR_'||BuildingType,	'BuildingType',		BuildingType
	from Building_YieldChanges;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ANIMAL_POWER_FOR_'||BuildingType,	'YieldType',		'YIELD_PRODUCTION'
	from Building_YieldChanges;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ANIMAL_POWER_FOR_'||BuildingType,	'Amount',		1
	from Building_YieldChanges;
*/

--包容da新增的建筑
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_CITY_HAS_'||BuildingType, 'REQUIREMENT_CITY_HAS_BUILDING'
from Buildings;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||BuildingType, 'BuildingType', BuildingType
from Buildings;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_'||BuildingType,				'REQUIREMENTSET_TEST_ALL'
from Buildings;                                

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_'||BuildingType,				'REQ_CITY_HAS_'||BuildingType
from Buildings;


insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
values	('RS_CITY_HAS_BUILDING',							'REQUIREMENTSET_TEST_ANY');

insert or replace into RequirementSetRequirements(RequirementSetId,		RequirementId) select
	'RS_CITY_HAS_BUILDING',			'REQ_CITY_HAS_'||BuildingType
	from Buildings where BuildingType not like '%CITY_POLICY%' and BuildingType not like '%FLAG%' and BuildingType not like '%CTZY%'; 


insert or replace into UnitOperations(OperationType, Description, Icon, VisibleInUI, HoldCycling, CategoryInUI, InterfaceMode, BaseProbability, LevelProbChange, EnemyProbChange, EnemyLevelProbChange, TargetDistrict, Offensive) values
	('UNITOPERATION_SPY_TEST', 'LOC_UNITOPERATION_SPY_TEST_DESCRIPTION',	'ICON_UNITOPERATION_SPY_TEST',	1, 1, 'OFFENSIVESPY','INTERFACEMODE_SPY_CHOOSE_MISSION', 50, 1, 1, 1, 'DISTRICT_HOLY_SITE',	1);

--删除原生单万神殿
delete from BeliefModifiers where BeliefType in (select BeliefType from Beliefs where BeliefClassType =='Pantheon' and BeliefType not like '%_WITH_%');

delete from Beliefs where BeliefClassType =='BELIEF_CLASS_PANTHEON' and BeliefType not like '%_WITH_%';






