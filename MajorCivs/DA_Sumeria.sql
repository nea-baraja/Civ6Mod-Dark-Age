

-- insert or replace into TraitModifiers(TraitType,	ModifierId) select
-- 	'TRAIT_CIVILIZATION_FIRST_CIVILIZATION',	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS'
-- from counter where numbers > 0 and numbers < 16;

-- insert or replace into TraitModifiers(TraitType,	ModifierId) select
-- 	'TRAIT_CIVILIZATION_FIRST_CIVILIZATION',	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES'
-- from counter where numbers > 0 and numbers < 8;


-- insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
-- 	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS',		'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_PROP_CONQUEST_COUNT_'||numbers
-- from counter where numbers > 0 and numbers < 16;

-- insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
-- 	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES',		'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_PROP_ALLY_COUNT_'||numbers
-- from counter where numbers > 0 and numbers < 8;


-- insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
-- 	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS_MOD',		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_ZIGGURAT'
-- from counter where numbers > 0 and numbers < 16;

-- insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
-- 	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES_MOD',		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_ZIGGURAT'
-- from counter where numbers > 0 and numbers < 8;


-- insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
-- 	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS',		'ModifierId',	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS_MOD'
-- from counter where numbers > 0 and numbers < 16;

-- insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
-- 	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES',		'ModifierId',	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES_MOD'
-- from counter where numbers > 0 and numbers < 8;

insert or replace into Modifiers(ModifierId,	ModifierType) values
	('DA_SUMERIA_FAITH', 				'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE'),
	('DA_SUMERIA_CULTURE', 				'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE'),
	('DA_SUMERIA_GOLD', 				'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE'),
	('DA_SUMERIA_SCIENCE', 				'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE'),
	('DA_SUMERIA_PRODUCTION_UNIT', 		'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PRODUCTION_CHANGE'),
	('DA_SUMERIA_PRODUCTION_BUILDING', 	'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION_CHANGE');


insert or replace into ModifierArguments(ModifierId,	Name,	Value) values
	('DA_SUMERIA_PRODUCTION_UNIT', 		'Amount',		2),
	('DA_SUMERIA_PRODUCTION_BUILDING', 	'Amount',		2),
	('DA_SUMERIA_GOLD', 				'YieldType',	'YIELD_GOLD'),
	('DA_SUMERIA_GOLD', 				'Amount',		3),	
	('DA_SUMERIA_SCIENCE', 				'YieldType',	'YIELD_SCIENCE'),
	('DA_SUMERIA_SCIENCE', 				'Amount',		1),	
	('DA_SUMERIA_FAITH', 				'YieldType',	'YIELD_FAITH'),
	('DA_SUMERIA_FAITH', 				'Amount',		2),
	('DA_SUMERIA_CULTURE', 				'YieldType',	'YIELD_CULTURE'),
	('DA_SUMERIA_CULTURE', 				'Amount',		1);

delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_FIRST_CIVILIZATION' and ModifierId = 'TRAIT_LEVY_DISCOUNT';
