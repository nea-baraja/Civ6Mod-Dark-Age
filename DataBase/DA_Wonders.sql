
delete from BuildingModifiers where BuildingType in ('BUILDING_TEMPLE_ARTEMIS', 'BUILDING_ORACLE');
update Buildings set Description = 'LOC_'||BuildingType||'_DESCRIPTION' where BuildingType in
	('BUILDING_PYRAMIDS', 'BUILDING_GREAT_BATH', 'BUILDING_TEMPLE_ARTEMIS', 'BUILDING_ORACLE');

insert or replace into BuildingModifiers(BuildingType,	ModifierId) values
	('BUILDING_PYRAMIDS',		'PRYAMID_BUILDER_EXTRA_MOVEMENTS'),
	('BUILDING_GREAT_BATH',		'GREAT_BATH_RIVER_DISTRICT_AMENITY');

insert or replace into Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) values
	('PRYAMID_BUILDER_EXTRA_MOVEMENTS',			'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',					'RS_UNIT_IS_CLASS_BUILDER'),
	('GREAT_BATH_RIVER_DISTRICT_AMENITY',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_DISTRICT_AMENITY',		'RS_RIVER_DISTRICT');

insert or replace into Modifiers(ModifierId,	ModifierType) values
	('DA_GREAT_BATH_AMENITY', 		'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_AMENITY'),
	('DA_GREAT_BATH_HOUSING', 		'MODIFIER_SINGLE_CITY_ADJUST_POLICY_HOUSING'),
	('DA_GREAT_BATH_POPULATION', 	'MODIFIER_SINGLE_CITY_ADD_POPULATION');


insert or replace into ModifierArguments(ModifierId, Name, Value) values
	('PRYAMID_BUILDER_EXTRA_MOVEMENTS',			'Amount',			1),
	('GREAT_BATH_RIVER_DISTRICT_AMENITY',		'Amount',			1),
	('DA_GREAT_BATH_AMENITY', 					'Amount',			1),
	('DA_GREAT_BATH_HOUSING', 					'Amount',			2),
	('DA_GREAT_BATH_POPULATION', 				'Amount',			1);


