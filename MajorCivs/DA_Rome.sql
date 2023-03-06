delete from TraitModifiers where TraitType = 'TRAJANS_COLUMN_TRAIT' and ModifierId = 'TRAIT_ADJUST_NON_CAPITAL_FREE_CHEAPEST_BUILDING';

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAJANS_COLUMN_TRAIT',			'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType
	from Buildings;

insert or replace into Modifiers(ModifierId,		ModifierType,		SubjectRequirementSetId) select
	'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType,		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION',	'RS_PLAYER_HAS_'||BuildingType
	from Buildings;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType,	'BuildingType',		BuildingType
	from Buildings;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType,	'Amount',		25
	from Buildings;	

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'TRAJANS_COLUMN_PRODUCTION_FOR_SECOND_'||BuildingType,	'Amount',		50
	from Buildings where PrereqDistrict = 'DISTRICT_CITY_CENTER';	


insert or replace into TraitModifiers(TraitType,	ModifierId) values
	('TRAIT_CIVILIZATION_ALL_ROADS_TO_ROME',		'ROME_UNITS_MOVEMENT_IN_CITY_CENTER'),
	('TRAIT_CIVILIZATION_ALL_ROADS_TO_ROME',		'ROME_UNITS_MOVEMENT_IN_ROME');

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) values
	('ROME_UNITS_MOVEMENT_IN_CITY_CENTER',			'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	null),
	('ROME_UNITS_MOVEMENT_IN_ROME',					'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_CITY_HAS_BUILDING_PALACE'),
	('ROME_UNITS_MOVEMENT_IN_CITY_CENTER_MOD',		'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',	'RS_OBJECT_SAME_PLOT'),
	('ROME_UNITS_MOVEMENT_IN_ROME_MOD',				'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',	'RS_OBJECT_SAME_PLOT');

insert or replace into ModifierArguments(ModifierId,	Name,	Value) values
	('ROME_UNITS_MOVEMENT_IN_CITY_CENTER',			'ModifierId',			'ROME_UNITS_MOVEMENT_IN_CITY_CENTER_MOD'),
	('ROME_UNITS_MOVEMENT_IN_ROME',					'ModifierId',			'ROME_UNITS_MOVEMENT_IN_ROME_MOD'),
	('ROME_UNITS_MOVEMENT_IN_CITY_CENTER_MOD',		'Amount',				2),
	('ROME_UNITS_MOVEMENT_IN_ROME_MOD',				'Amount',				2);

