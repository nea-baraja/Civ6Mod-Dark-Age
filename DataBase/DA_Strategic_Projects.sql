/*
--战略项目信息表
create table 'StrategicProjects'(
	'Id' TEXT NOT NULL,
	'ProjectType'	TEXT,
	'BuildingType'	TEXT,
	'EnableCivicType' TEXT,
	'EnableTechType' TEXT,
	'Cost' INT NOT NULL,
	'PreDistrict' TEXT,
	'ResourceType'	TEXT,
	'Amount' INT,
	'Maintenance' INT,
	PRIMARY KEY('Id')
);


--填写战略项目信息
insert or replace into StrategicProjects
(Id,					EnableCivicType,			EnableTechType,		    	Cost,		PreDistrict,				ResourceType,		Amount,		Maintenance) values
('SET_IRON_OFFICER',	NULL,						'TECH_IRON_WORKING',		20,			'DISTRICT_CITY_CENTER',		'RESOURCE_IRON',	20,			3),
('FORGE_WEAPON',		NULL,						'TECH_IRON_WORKING',		20,			'DISTRICT_CITY_CENTER',		'RESOURCE_IRON',	10,			2),
('IRON_FARM_TOOL',		NULL,						'TECH_IRON_WORKING',		20,			'DISTRICT_CITY_CENTER',		'RESOURCE_IRON',	10,			2),
('ANIMAL_POWER',		NULL,						'TECH_HORSEBACK_RIDING',	20,			'DISTRICT_CITY_CENTER',		'RESOURCE_HORSES',	10,			2),
('CARRIAGE_TRANSPORT',	NULL,						'TECH_HORSEBACK_RIDING',	20,			'DISTRICT_CITY_CENTER',		'RESOURCE_HORSES',	10,			2);

update StrategicProjects set
	BuildingType 		= 'BUILDING_STG_' || Id,
	ProjectType 		= 'PROJECT_STG_' || Id;

--生成对应项目与效果建筑
insert or replace into Types (Type, Kind) select BuildingType, 'KIND_BUILDING' from StrategicProjects;
insert or replace into Types (Type, Kind) select ProjectType, 'KIND_PROJECT' from StrategicProjects;

insert or replace into Buildings (BuildingType,	Name,	Cost,	Description,	PrereqDistrict,	MustPurchase)
select BuildingType, 'LOC_'||BuildingType||'_NAME',		1, 		'LOC_'||BuildingType||'_DESCRIPTION',	PreDistrict,	1
from StrategicProjects;

insert or replace into Buildings_XP2 (BuildingType, Pillage)
select BuildingType, 0 from StrategicProjects;

insert or replace into Projects
	(ProjectType, Name, ShortName, Description, Cost, PrereqCivic, PrereqTech, AdvisorType, PrereqDistrict)
select
	ProjectType,
	'LOC_'||ProjectType||'_NAME',
	'LOC_'||ProjectType||'_SHORT_NAME',
	'LOC_'||ProjectType||'_DESCRIPTION',
	Cost,
	EnableCivicType,
	EnableTechType,
	'ADVISOR_GENERIC',
	PreDistrict
from StrategicProjects;

insert or replace into Projects_XP2
	(ProjectType,		CreateBuilding)
select
	ProjectType,		BuildingType
from StrategicProjects;

insert or replace into Project_ResourceCosts
	(ProjectType,		ResourceType,		StartProductionCost)
select
	ProjectType,		ResourceType,		Amount
from StrategicProjects;
	



insert or replace into BuildingModifiers(BuildingType,		ModifierId)	values
	('BUILDING_STG_SET_IRON_OFFICER',		'SET_IRON_OFFICER_EXTRA_DISTRICT'),
	('BUILDING_STG_FORGE_WEAPON',			'FORGE_WEAPON_TRAINED_STRENGTH'),
	('BUILDING_STG_IRON_FARM_TOOL',			'FARM_TOOL_POP_FOOD'),
	--('BUILDING_STG_ANIMAL_POWER',			'FARM_TOOL_POP_FOOD'),   畜力机械相关于postprocess
	('BUILDING_STG_CARRIAGE_TRANSPORT',		'CARRIAGE_TRANSPORT_TRAINED_SPEED');

insert or replace into Modifiers
	(ModifierId,										ModifierType,												SubjectRequirementSetId)
values
--城市
	('SET_IRON_OFFICER_EXTRA_DISTRICT',					'MODIFIER_SINGLE_CITY_EXTRA_DISTRICT',						NULL),
	('FORGE_WEAPON_TRAINED_STRENGTH',					'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS',		NULL),
	('FARM_TOOL_POP_FOOD',								'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
	('CARRIAGE_TRANSPORT_TRAINED_SPEED',				'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS',		NULL);


update Modifiers set Permanent = 1 where ModifierId = 'FORGE_WEAPON_TRAINED_STRENGTH';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) values
	('SET_IRON_OFFICER_EXTRA_DISTRICT',					'Amount',			1),
	('FORGE_WEAPON_TRAINED_STRENGTH',					'AbilityType',		'ABILITY_FORGE_WEAPON_STRENGTH'),
	('FARM_TOOL_POP_FOOD',								'YieldType',		'YIELD_FOOD'),
	('FARM_TOOL_POP_FOOD',								'Amount',			0.5),
	('CARRIAGE_TRANSPORT_TRAINED_SPEED',				'AbilityType',		'ABILITY_CARRIAGE_TRANSPORT_MOVEMENT');









insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_LEADER_MAJOR_CIV',	Id||'_LACK_RESOURCE_IRON_COST_PRODUCTION'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_LEADER_MAJOR_CIV',	Id||'_LACK_RESOURCE_IRON_IMPROVED_IRON_RETURN_PRODUCTION'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_LEADER_MAJOR_CIV',	Id||'_LACK_RESOURCE_IRON_BUILDING_BARRACKS_RETURN_PRODUCTION'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';



insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_IRON_COST_PRODUCTION',	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_LACK_RESOURCE_IRON'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into Modifiers(ModifierId,		ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_IRON_IMPROVED_IRON_RETURN_PRODUCTION',	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_LACK_RESOURCE_IRON_IMPROVED_IRON'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into Modifiers(ModifierId,		ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_IRON_BUILDING_BARRACKS_RETURN_PRODUCTION',	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_LACK_RESOURCE_IRON_BUILDING_BARRACKS'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';



insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_IRON_COST_PRODUCTION_MOD',	'MODIFIER_BUILDING_YIELD_CHANGE',	NULL
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_IRON_IMPROVED_IRON_RETURN_PRODUCTION_MOD',	'MODIFIER_BUILDING_YIELD_CHANGE',	NULL
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_IRON_BUILDING_BARRACKS_RETURN_PRODUCTION_MOD',	'MODIFIER_BUILDING_YIELD_CHANGE',	NULL
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';


insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_COST_PRODUCTION',	'ModifierId',	Id||'_LACK_RESOURCE_IRON_COST_PRODUCTION_MOD'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_IMPROVED_IRON_RETURN_PRODUCTION',	'ModifierId',	Id||'_LACK_RESOURCE_IRON_IMPROVED_IRON_RETURN_PRODUCTION_MOD'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_BUILDING_BARRACKS_RETURN_PRODUCTION',	'ModifierId',	Id||'_LACK_RESOURCE_IRON_BUILDING_BARRACKS_RETURN_PRODUCTION_MOD'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';


insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_COST_PRODUCTION_MOD',	'BuildingType',	BuildingType
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_IMPROVED_IRON_RETURN_PRODUCTION_MOD',	'BuildingType',	BuildingType
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_BUILDING_BARRACKS_RETURN_PRODUCTION_MOD',	'BuildingType',	BuildingType
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_COST_PRODUCTION_MOD',	'YieldType',	'YIELD_PRODUCTION'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_IMPROVED_IRON_RETURN_PRODUCTION_MOD',	'YieldType',	'YIELD_PRODUCTION'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_BUILDING_BARRACKS_RETURN_PRODUCTION_MOD',	'YieldType',	'YIELD_PRODUCTION'
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_COST_PRODUCTION_MOD',	'Amount',	- Maintenance * 3
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_IMPROVED_IRON_RETURN_PRODUCTION_MOD',	'Amount',	Maintenance
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_IRON_BUILDING_BARRACKS_RETURN_PRODUCTION_MOD',	'Amount',	Maintenance
	from StrategicProjects where ResourceType = 'RESOURCE_IRON';



insert or replace into RequirementSets(RequirementSetId,	RequirementSetType) values
	('RS_LACK_RESOURCE_IRON_IMPROVED_IRON',				'REQUIREMENTSET_TEST_ALL'),
	('RS_LACK_RESOURCE_IRON_BUILDING_BARRACKS',		'REQUIREMENTSET_TEST_ALL');

insert or replace into RequirementSetRequirements(RequirementSetId,		RequirementId) values
	('RS_LACK_RESOURCE_IRON_IMPROVED_IRON',				'REQ_LACK_RESOURCE_IRON'),
	('RS_LACK_RESOURCE_IRON_IMPROVED_IRON',				'REQ_CITY_HAS_IMPROVED_RESOURCE_IRON'),
	('RS_LACK_RESOURCE_IRON_BUILDING_BARRACKS',			'REQ_LACK_RESOURCE_IRON'),
	('RS_LACK_RESOURCE_IRON_BUILDING_BARRACKS',			'REQ_CITY_HAS_BUILDING_BARRACKS');




insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_LEADER_MAJOR_CIV',	Id||'_LACK_RESOURCE_HORSES_COST_FOOD'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_LEADER_MAJOR_CIV',	Id||'_LACK_RESOURCE_HORSES_IMPROVED_HORSES_RETURN_FOOD'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_LEADER_MAJOR_CIV',	Id||'_LACK_RESOURCE_HORSES_BUILDING_STABLE_RETURN_FOOD'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';



insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_HORSES_COST_FOOD',	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_LACK_RESOURCE_HORSES'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into Modifiers(ModifierId,		ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_HORSES_IMPROVED_HORSES_RETURN_FOOD',	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_LACK_RESOURCE_HORSES_IMPROVED_HORSES'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into Modifiers(ModifierId,		ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_HORSES_BUILDING_STABLE_RETURN_FOOD',	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_LACK_RESOURCE_HORSES_BUILDING_STABLE'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';



insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_HORSES_COST_FOOD_MOD',	'MODIFIER_BUILDING_YIELD_CHANGE',	NULL
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_HORSES_IMPROVED_HORSES_RETURN_FOOD_MOD',	'MODIFIER_BUILDING_YIELD_CHANGE',	NULL
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) select
	Id||'_LACK_RESOURCE_HORSES_BUILDING_STABLE_RETURN_FOOD_MOD',	'MODIFIER_BUILDING_YIELD_CHANGE',	NULL
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';


insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_COST_FOOD',	'ModifierId',	Id||'_LACK_RESOURCE_HORSES_COST_FOOD_MOD'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_IMPROVED_HORSES_RETURN_FOOD',	'ModifierId',	Id||'_LACK_RESOURCE_HORSES_IMPROVED_HORSES_RETURN_FOOD_MOD'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_BUILDING_STABLE_RETURN_FOOD',	'ModifierId',	Id||'_LACK_RESOURCE_HORSES_BUILDING_STABLE_RETURN_FOOD_MOD'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';


insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_COST_FOOD_MOD',	'BuildingType',	BuildingType
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_IMPROVED_HORSES_RETURN_FOOD_MOD',	'BuildingType',	BuildingType
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_BUILDING_STABLE_RETURN_FOOD_MOD',	'BuildingType',	BuildingType
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_COST_FOOD_MOD',	'YieldType',	'YIELD_FOOD'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_IMPROVED_HORSES_RETURN_FOOD_MOD',	'YieldType',	'YIELD_FOOD'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_BUILDING_STABLE_RETURN_FOOD_MOD',	'YieldType',	'YIELD_FOOD'
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_COST_FOOD_MOD',	'Amount',	- Maintenance * 3
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_IMPROVED_HORSES_RETURN_FOOD_MOD',	'Amount',	Maintenance
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	Id||'_LACK_RESOURCE_HORSES_BUILDING_STABLE_RETURN_FOOD_MOD',	'Amount',	Maintenance
	from StrategicProjects where ResourceType = 'RESOURCE_HORSES';



insert or replace into RequirementSets(RequirementSetId,	RequirementSetType) values
	('RS_LACK_RESOURCE_HORSES_IMPROVED_HORSES',				'REQUIREMENTSET_TEST_ALL'),
	('RS_LACK_RESOURCE_HORSES_BUILDING_STABLE',				'REQUIREMENTSET_TEST_ALL');

insert or replace into RequirementSetRequirements(RequirementSetId,		RequirementId) values
	('RS_LACK_RESOURCE_HORSES_IMPROVED_HORSES',			'REQ_LACK_RESOURCE_HORSES'),
	('RS_LACK_RESOURCE_HORSES_IMPROVED_HORSES',			'REQ_CITY_HAS_IMPROVED_RESOURCE_HORSES'),
	('RS_LACK_RESOURCE_HORSES_BUILDING_STABLE',			'REQ_LACK_RESOURCE_HORSES'),
	('RS_LACK_RESOURCE_HORSES_BUILDING_STABLE',			'REQ_CITY_HAS_BUILDING_STABLE');
*/