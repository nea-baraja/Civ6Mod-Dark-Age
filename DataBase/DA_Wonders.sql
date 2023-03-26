
delete from BuildingModifiers where BuildingType in ('BUILDING_TEMPLE_ARTEMIS', 'BUILDING_ORACLE', 'BUILDING_HANGING_GARDENS');
delete from BuildingModifiers where BuildingType = 'BUILDING_PYRAMIDS' and ModifierId = 'PYRAMID_GRANT_BUILDERS';
update Buildings set Description = 'LOC_'||BuildingType||'_DESCRIPTION' where BuildingType in
	('BUILDING_PYRAMIDS', 'BUILDING_GREAT_BATH', 'BUILDING_TEMPLE_ARTEMIS', 'BUILDING_ORACLE', 'BUILDING_HANGING_GARDENS');

insert or ignore into BuildingModifiers(BuildingType,	ModifierId) values
	('BUILDING_PYRAMIDS',		'PRYAMID_BUILDER_EXTRA_MOVEMENTS'),
	('BUILDING_GREAT_BATH',		'GREAT_BATH_RIVER_DISTRICT_AMENITY');

insert or ignore into BuildingModifiers(BuildingType, ModifierId) select
	'BUILDING_HANGING_GARDENS',		'HANGING_GARDENS_DISTRICT_FOOD_FROM_'||TerrainType
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');


insert or ignore into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('PRYAMID_BUILDER_EXTRA_MOVEMENTS',			'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',					'RS_UNIT_IS_CLASS_BUILDER'),
	('GREAT_BATH_RIVER_DISTRICT_AMENITY',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_DISTRICT_AMENITY',		'RS_RIVER_DISTRICT');

insert or ignore into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) select
	'HANGING_GARDENS_DISTRICT_FOOD_FROM_'||TerrainType, 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',  'RS_NOT_WONDER_ON_'||TerrainType
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');

insert or ignore into Modifiers(ModifierId,	ModifierType) values
	('DA_GREAT_BATH_AMENITY', 		'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_AMENITY'),
	('DA_GREAT_BATH_HOUSING', 		'MODIFIER_SINGLE_CITY_ADJUST_POLICY_HOUSING'),
	('DA_GREAT_BATH_POPULATION', 	'MODIFIER_SINGLE_CITY_ADD_POPULATION');


insert or ignore into ModifierArguments(ModifierId, Name, Value) values
	('PRYAMID_BUILDER_EXTRA_MOVEMENTS',			'Amount',			1),
	('GREAT_BATH_RIVER_DISTRICT_AMENITY',		'Amount',			1),
	('DA_GREAT_BATH_AMENITY', 					'Amount',			1),
	('DA_GREAT_BATH_HOUSING', 					'Amount',			2),
	('DA_GREAT_BATH_POPULATION', 				'Amount',			1);

insert or ignore into ModifierArguments(ModifierId, Name, Value) select
	'HANGING_GARDENS_DISTRICT_FOOD_FROM_'||TerrainType, 'YieldType', YieldType
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');

insert or ignore into ModifierArguments(ModifierId, Name, Value) select
	'HANGING_GARDENS_DISTRICT_FOOD_FROM_'||TerrainType, 'Amount', YieldChange
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');

insert or ignore into RequirementSets(RequirementSetId,	RequirementSetType) select
	'RS_NOT_WONDER_ON_'||TerrainType, 'REQUIREMENTSET_TEST_ALL'
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');	

insert or ignore into RequirementSetRequirements(RequirementSetId,	RequirementId) select
	'RS_NOT_WONDER_ON_'||TerrainType, 'REQ_NOT_WONDER'
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');		

insert or ignore into RequirementSetRequirements(RequirementSetId,	RequirementId) select
	'RS_NOT_WONDER_ON_'||TerrainType, 'REQ_PLOT_IS_'||TerrainType
	from Terrain_YieldChanges
	where TerrainType not in ('TERRAIN_COAST', 'TERRAIN_OCEAN');	

