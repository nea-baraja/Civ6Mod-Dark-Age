--CIVILIZATION_AZTEC
--------------------------------------------------------------
delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_LEGEND_FIVE_SUNS' and ModifierId = 'TRAIT_OWNED_LUXURY_EXTRA_AMENITIES';

-- insert or replace into TraitModifiers (TraitType, ModifierId) values
-- ('TRAIT_CIVILIZATION_LEGEND_FIVE_SUNS', 'DA_LEGEND_FIVE_SUNS_CAPTURE_WORKER');

-- insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
-- ('DA_LEGEND_FIVE_SUNS_CAPTURE_WORKER', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', NULL);

-- insert or replace into ModifierArguments (ModifierId, Name, Value) values
-- ('DA_LEGEND_FIVE_SUNS_CAPTURE_WORKER', 'AbilityType', 'ABILITY_LUXURY_STRENGTH_MELEE');

-- insert or replace into Types
-- 	(Type,														Kind)
-- values
-- 	('ABILITY_LUXURY_STRENGTH_EXTRA',							'KIND_ABILITY');

-- insert or replace into Tags(Tag,		Vocabulary) values
-- 	('CLASS_UNIT_AZTEC_EAGLE_WARRIOR',				'ABILITY_CLASS');

-- insert or replace into TypeTags
-- 	(Type,									Tag)
-- values
-- 	('UNIT_AZTEC_EAGLE_WARRIOR', 		'CLASS_UNIT_AZTEC_EAGLE_WARRIOR'),
-- 	('ABILITY_LUXURY_STRENGTH_EXTRA', 	'CLASS_UNIT_AZTEC_EAGLE_WARRIOR');

-- insert or replace into UnitAbilities(UnitAbilityType, Name, Description, Inactive) values

--     ('ABILITY_LUXURY_STRENGTH_EXTRA',
-- 	'LOC_ABILITY_LUXURY_STRENGTH_EXTRA_NAME',
-- 	'LOC_ABILITY_LUXURY_STRENGTH_EXTRA_DESCRIPTION',
--     1);

-- insert or replace into UnitAbilityModifiers
-- 	(UnitAbilityType,										ModifierId							) values
-- 	('ABILITY_LUXURY_STRENGTH_EXTRA',						'LUXURY_STRENGTH_EXTRA');

-- insert or replace into Modifiers(ModifierId, ModifierType) values
-- 	('LUXURY_STRENGTH_EXTRA',		'MODIFIER_PLAYER_UNIT_ADJUST_PER_LUXURY_ATTACK_MODIFIER');

-- insert or replace into ModifierArguments(ModifierId, Name, Value) values
-- 	('LUXURY_STRENGTH_EXTRA',		'Amount',   1);

-- insert or replace into ModifierStrings(ModifierId, Context, Text) values
-- 	('LUXURY_STRENGTH_EXTRA',		'Preview',   'LOC_PREVIEW_MONTEZUMA_COMBAT_BONUS_PER_LUXURY_DESCRIPTION');



update UnitAbilities set  Inactive = 1
where UnitAbilityType = 'ABILITY_CAPTIVE_WORKERS';
insert or replace into TypeTags (Type,									Tag) values	
--('ABILITY_CAPTIVE_WORKERS',				'CLASS_LIGHT_CAVALRY'),
--('ABILITY_CAPTIVE_WORKERS',			    'CLASS_HEAVY_CAVALRY'),
--('ABILITY_CAPTIVE_WORKERS',			    'CLASS_ANTI_CAVALRY'),
('ABILITY_CAPTIVE_WORKERS',			    'CLASS_MELEE');

/*
--奢侈品为建造者加移动力
insert or replace into TraitModifiers(TraitType,		ModifierId) select
	'TRAIT_LEADER_GIFTS_FOR_TLATOANI',		'DA_AZTEC_WORKER_MOVEMENT_FROM_'||ResourceType
	from Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId,		NewOnly) select
	'DA_AZTEC_WORKER_MOVEMENT_FROM_'||ResourceType,	'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',		'RS_PLAYER_HAS_IMPROVED_'||ResourceType,	1
	from Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'DA_AZTEC_WORKER_MOVEMENT_FROM_'||ResourceType,		'Amount',		1
	from Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

--奢侈品为建造者加劳动力
insert or replace into TraitModifiers(TraitType,		ModifierId) select
	'TRAIT_LEADER_GIFTS_FOR_TLATOANI',		'DA_AZTEC_WORKER_CHARGE_FROM_'||ResourceType
	from Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId,		NewOnly) select
	'DA_AZTEC_WORKER_CHARGE_FROM_'||ResourceType,	'MODIFIER_PLAYER_UNITS_ADJUST_BUILDER_CHARGES',		'RS_PLAYER_HAS_IMPROVED_'||ResourceType,	1
	from Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'DA_AZTEC_WORKER_CHARGE_FROM_'||ResourceType,		'Amount',		1
	from Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';
*/

insert or replace into Modifiers(ModifierId,	ModifierType) values
	('DA_AZTEC_AMENITY', 		'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_AMENITY'),
	('DA_AZTEC_HOUSING', 		'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_HOUSING'),
	('DA_AZTEC_FAITH', 			'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE'),
	('DA_AZTEC_CULTURE', 		'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE'),
	('DA_AZTEC_POPULATION', 	'MODIFIER_SINGLE_CITY_ADD_POPULATION');

insert or replace into ModifierArguments(ModifierId,	Name,	Value) values
	('DA_AZTEC_AMENITY', 		'Amount',		1),
	('DA_AZTEC_HOUSING', 		'Amount',		2),
	('DA_AZTEC_FAITH', 			'Amount',		3),
	('DA_AZTEC_FAITH', 			'YieldType',	'YIELD_FAITH'),
	('DA_AZTEC_CULTURE', 		'Amount',		2),
	('DA_AZTEC_CULTURE', 		'YieldType',	'YIELD_CULTURE'),
	('DA_AZTEC_POPULATION', 	'Amount',		1);

update Buildings set Cost = 75 where BuildingType = 'BUILDING_TLACHTLI'; 

/*
insert or replace into Types(Type,	Kind) values
	('ABILITY_BUILDER_MOVE',	'KIND_ABILITY');

insert or replace into Tags
	(Tag,									Vocabulary)
values
	('CLASS_BUILDER',						'ABILITY_CLASS');

insert or replace into TypeTags
	(Type,				Tag)
values
	('UNIT_BUILDER', 	'CLASS_BUILDER');


insert or replace into UnitAbilities (UnitAbilityType, Name, Description, Inactive) values
    ('ABILITY_BUILDER_MOVE',
    'LOC_ABILITY_BUILDER_MOVE_NAME',
    'LOC_ABILITY_BUILDER_MOVE_DESCRIPTION',
    1);

insert or replace into UnitAbilityModifiers
	(UnitAbilityType,								ModifierId							)
values
	('ABILITY_BUILDER_MOVE',						'BUILDER_MOVE_MODIFIER');

insert or replace into Modifiers(ModifierId, 			ModifierType) values
	('BUILDER_MOVE_MODIFIER',							'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT');


insert or replace into ModifierArguments
	(ModifierId,											Name,					Value)
values
	('BUILDER_MOVE_MODIFIER',								'Amount',				1);
*/

/*
临时写的其他东西
insert or replace into Modifiers(ModifierId,	ModifierType) select
	'E_'||DistrictType||'_ON_'||FeatureType,	'MODIFIER_PLAYER_CITIES_ADJUST_VALID_FEATURES_DISTRICTS'
	from Districts, Features;

insert or replace into ModifierArguments(ModifierId,		Name,	Value) select
	'E_'||DistrictType||'_ON_'||FeatureType,		'DistrictType',		DistrictType
	from Districts, Features;

insert or replace into ModifierArguments(ModifierId,		Name,	Value) select
	'E_'||DistrictType||'_ON_'||FeatureType,		'FeatureType',		FeatureType
	from Districts, Features;

insert or replace into TraitModifiers(TraitType,		ModifierId) select
	'TRAIT_LEADER_MAJOR_CIV',	'E_'||DistrictType||'_ON_'||FeatureType
	from Districts, Features;
*/
