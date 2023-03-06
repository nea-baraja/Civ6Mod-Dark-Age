insert or replace into Types(Type,			Kind) values
	('HAPPINESS_FURIOUS',		'KIND_HAPPINESS'),
	('HAPPINESS_JOYOUS',		'KIND_HAPPINESS'),
	('HAPPINESS_ELATED',		'KIND_HAPPINESS'),
	('HAPPINESS_UTOPIA',		'KIND_HAPPINESS');

insert or replace into Happinesses(HappinessType,		Name,  			MinimumAmenityScore,	MaximumAmenityScore,	GrowthModifier, NonFoodYieldModifier, RebellionPoints)
values	('HAPPINESS_REVOLT',	'LOC_HAPPINESS_REVOLT_NAME',	null,	-9,		-60,	0,	5),
		('HAPPINESS_UNREST',	'LOC_HAPPINESS_UNREST_NAME',	-8,		-7,		-48,	0,	3),
		('HAPPINESS_FURIOUS',	'LOC_HAPPINESS_FURIOUS_NAME',	-6,		-5,		-36,	0,	1),
		('HAPPINESS_UNHAPPY',	'LOC_HAPPINESS_UNHAPPY_NAME',	-4,		-3,		-24,	0,	0),
		('HAPPINESS_DISPLEASED','LOC_HAPPINESS_DISPLEASED_NAME',-2,		-1,		-12,	0,	0),
		('HAPPINESS_CONTENT',	'LOC_HAPPINESS_CONTENT_NAME',	0,		1,		0,		0,	0),
		('HAPPINESS_HAPPY',		'LOC_HAPPINESS_HAPPY_NAME',		2,		3,		12,		0,	-1),
		('HAPPINESS_JOYOUS',	'LOC_HAPPINESS_JOYOUS_NAME',	4,		5,		24,		0,	-1),
		('HAPPINESS_ELATED',	'LOC_HAPPINESS_ELATED_NAME',	6,		7,		36,		0,	-2),
		('HAPPINESS_ECSTATIC',	'LOC_HAPPINESS_ECSTATIC_NAME',	8,		9,		48,		0,	-2),
		('HAPPINESS_UTOPIA',	'LOC_HAPPINESS_UTOPIA_NAME',	10,		null,	60,		0,	-3);

insert or replace into Happinesses_XP1(HappinessType,	IdentityPerTurnChange) values
	('HAPPINESS_REVOLT',	-20),
	('HAPPINESS_UNREST',	-16),
	('HAPPINESS_FURIOUS',	-12),
	('HAPPINESS_UNHAPPY',	-8),
	('HAPPINESS_DISPLEASED',-4),
	('HAPPINESS_CONTENT',	0),
	('HAPPINESS_HAPPY',		4),
	('HAPPINESS_JOYOUS',	8),
	('HAPPINESS_ELATED',	12),
	('HAPPINESS_ECSTATIC',	16),
	('HAPPINESS_UTOPIA',	20);

-----------------
insert or replace into DistrictModifiers(DistrictType,	ModifierId) select
	'DISTRICT_CITY_CENTER',		'HAPPINESS_'||(numbers * 2)||'_SCIENCE'
	from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId) select
	'HAPPINESS_'||(numbers * 2)||'_SCIENCE',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',	'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
	from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,	Name,		Value) select
	'HAPPINESS_'||(numbers * 2)||'_SCIENCE',	'YieldType',	'YIELD_SCIENCE'
	from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,	Name,		Value) select
	'HAPPINESS_'||(numbers * 2)||'_SCIENCE',	'Amount',	-6
	from counter where numbers >= -5 and numbers <= -1;


insert or replace into DistrictModifiers(DistrictType,  ModifierId) select
    'DISTRICT_CITY_CENTER',     'HAPPINESS_'||(numbers * 2)||'_CULTURE'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_'||(numbers * 2)||'_CULTURE',    'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_CULTURE',    'YieldType',    'YIELD_CULTURE'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_CULTURE',    'Amount',   -6
    from counter where numbers >= -5 and numbers <= -1;


insert or replace into DistrictModifiers(DistrictType,  ModifierId) select
    'DISTRICT_CITY_CENTER',     'HAPPINESS_'||(numbers * 2)||'_GOLD'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_'||(numbers * 2)||'_GOLD',    'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_GOLD',    'YieldType',    'YIELD_GOLD'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_GOLD',    'Amount',   6
    from counter where numbers >= -5 and numbers <= -1;


insert or replace into DistrictModifiers(DistrictType,  ModifierId) select
    'DISTRICT_CITY_CENTER',     'HAPPINESS_'||(numbers * 2)||'_PRODUCTION'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_'||(numbers * 2)||'_PRODUCTION',    'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_PRODUCTION',    'YieldType',    'YIELD_PRODUCTION'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_PRODUCTION',    'Amount',   6
    from counter where numbers >= -5 and numbers <= -1;
--------------------

insert or replace into DistrictModifiers(DistrictType,  ModifierId) select
    'DISTRICT_CITY_CENTER',     'HAPPINESS_'||(numbers * 2)||'_TOURISM'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_'||(numbers * 2)||'_TOURISM',    'MODIFIER_SINGLE_CITY_ADJUST_TOURISM_LATE_ERAS',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_TOURISM',    'MinimumEra',    'ERA_ANCIENT'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_TOURISM',    'Modifier',   12
    from counter where numbers >= 1 and numbers <= 5;
-------------------------

insert or replace into DistrictModifiers(DistrictType,  ModifierId) select
    'DISTRICT_CITY_CENTER',     'HAPPINESS_'||(numbers * 2)||'_SCIENCE'
    from counter where numbers >= 1 and numbers <= 5;

 insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_'||(numbers * 2)||'_SCIENCE',    'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_SCIENCE',    'YieldType',    'YIELD_SCIENCE'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_SCIENCE',    'Amount',   6
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into DistrictModifiers(DistrictType,  ModifierId) select
    'DISTRICT_CITY_CENTER',     'HAPPINESS_'||(numbers * 2)||'_CULTURE'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_'||(numbers * 2)||'_CULTURE',    'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_CULTURE',    'YieldType',    'YIELD_CULTURE'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_CULTURE',    'Amount',   6
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into DistrictModifiers(DistrictType,  ModifierId) select
    'DISTRICT_CITY_CENTER',     'HAPPINESS_'||(numbers * 2)||'_GOLD'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_'||(numbers * 2)||'_GOLD',    'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_GOLD',    'YieldType',    'YIELD_GOLD'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_GOLD',    'Amount',   -6
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into DistrictModifiers(DistrictType,  ModifierId) select
    'DISTRICT_CITY_CENTER',     'HAPPINESS_'||(numbers * 2)||'_PRODUCTION'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_'||(numbers * 2)||'_PRODUCTION',    'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_PRODUCTION',    'YieldType',    'YIELD_PRODUCTION'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_'||(numbers * 2)||'_PRODUCTION',    'Amount',   -6
    from counter where numbers >= 1 and numbers <= 5;
