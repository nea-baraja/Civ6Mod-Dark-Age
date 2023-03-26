


insert or replace into Types(Type,  Kind) values
    ('GOVERNMENT_CITY_STATE_ALLIANCE',      'KIND_GOVERNMENT'),
    ('GOVERNMENT_PRIEST_COUNCIL',           'KIND_GOVERNMENT'),    
    ('GOVERNMENT_TRIBE_UNITY',              'KIND_GOVERNMENT');
   -- ('GOVERNMENT_CITY_STATE_ALLIANCE',      'KIND_GOVERNMENT'),


insert or replace into GovernmentTiers(TierType,    Sorting) values
    ('Tier0',       0);

insert or replace into Governments(GovernmentType,  Name,   
    InherentBonusDesc,    BonusType,    AccumulatedBonusShortDesc,  AccumulatedBonusDesc,   
    PrereqCivic,    OtherGovernmentIntolerance,     
    InfluencePointsPerTurn,     InfluencePointsThreshold,   InfluenceTokensPerThreshold,    PolicyToUnlock,     Tier) values
('GOVERNMENT_CITY_STATE_ALLIANCE',      'LOC_GOVERNMENT_CITY_STATE_ALLIANCE_NAME',
'LOC_DA_GOVERNMENT_CITY_STATE_ALLIANCE_INHERENT_BONUS',     'GOVERNMENTBONUS_OVERALL_PRODUCTION',   'LOC_DA_GOVERNMENT_CITY_STATE_ALLIANCE_BONUS','LOC_DA_GOVERNMENT_CITY_STATE_ALLIANCE_BONUS',
'CIVIC_CODE_OF_LAWS',    0, 
4,  100,    1,  null,   'Tier0'),

('GOVERNMENT_PRIEST_COUNCIL',      'LOC_GOVERNMENT_PRIEST_COUNCIL_NAME',
'LOC_DA_GOVERNMENT_PRIEST_COUNCIL_INHERENT_BONUS',     'GOVERNMENTBONUS_OVERALL_PRODUCTION',   'LOC_DA_GOVERNMENT_PRIEST_COUNCIL_BONUS','LOC_DA_GOVERNMENT_PRIEST_COUNCIL_BONUS',
'CIVIC_SORCERY_AND_HERB',    0, 
1,  100,    1,  null,   'Tier0'),

('GOVERNMENT_TRIBE_UNITY',      'LOC_GOVERNMENT_TRIBE_UNITY_NAME',
'LOC_DA_GOVERNMENT_TRIBE_UNITY_INHERENT_BONUS',     'GOVERNMENTBONUS_OVERALL_PRODUCTION',   'LOC_DA_GOVERNMENT_TRIBE_UNITY_BONUS','LOC_DA_GOVERNMENT_TRIBE_UNITY_BONUS',
'CIVIC_NATIVE_LAND',    0, 
1,  100,    1,  null,   'Tier0');

--update Governments set PrereqCivic = 'CIVIC_NATIVE_LAND', Tier = 'Tier0' where GovernmentType = 'GOVERNMENT_CHIEFDOM';
delete from Governments where GovernmentType = 'GOVERNMENT_CHIEFDOM';


insert or replace into Governments_XP2(GovernmentType,  Favor) values
    ('GOVERNMENT_CITY_STATE_ALLIANCE',      0),
    ('GOVERNMENT_PRIEST_COUNCIL',           0),    
    ('GOVERNMENT_TRIBE_UNITY',              0);

delete from Government_SlotCounts where GovernmentType = 'GOVERNMENT_CHIEFDOM';
insert or replace into Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) values
    ('GOVERNMENT_CITY_STATE_ALLIANCE',      'SLOT_MILITARY',    1),
    ('GOVERNMENT_CITY_STATE_ALLIANCE',      'SLOT_ECONOMIC',    1),
    ('GOVERNMENT_PRIEST_COUNCIL',           'SLOT_ECONOMIC',    2),    
    ('GOVERNMENT_TRIBE_UNITY',              'SLOT_MILITARY',    2);



update StartingGovernments set Change = 1 where Era = 'ERA_CLASSICAL';



--传承建筑
insert or replace into Types (Type, Kind) select 
	'BUILDING_'||GovernmentType||'_LEGACY',		'KIND_BUILDING'
	from Governments;

insert or replace into Buildings (BuildingType,	Name,	Cost,	Description,	PrereqDistrict,	MustPurchase)
select 'BUILDING_'||GovernmentType||'_LEGACY', 'LOC_BUILDING_'||GovernmentType||'_LEGACY_NAME',		1, 		'LOC_BUILDING_'||GovernmentType||'_LEGACY_DESCRIPTION',	'DISTRICT_GOVERNMENT',	1
from Governments;

insert or replace into Buildings_XP2 (BuildingType, Pillage)
select 'BUILDING_'||GovernmentType||'_LEGACY', 0 from Governments;

--政体文本修改
update Governments set InherentBonusDesc  = 'LOC_DA_'||GovernmentType||'_INHERENT_BONUS', AccumulatedBonusShortDesc = 'LOC_DA_'||GovernmentType||'_BONUS',  AccumulatedBonusDesc = 'LOC_DA_'||GovernmentType||'_BONUS'
    where GovernmentType in ('GOVERNMENT_AUTOCRACY',    'GOVERNMENT_OLIGARCHY', 'GOVERNMENT_CLASSICAL_REPUBLIC',    'GOVERNMENT_CHIEFDOM');

delete from GovernmentModifiers where GovernmentType in
	('GOVERNMENT_CHIEFDOM', 'GOVERNMENT_AUTOCRACY',	'GOVERNMENT_OLIGARCHY',	'GOVERNMENT_CLASSICAL_REPUBLIC');

insert or replace into GovernmentModifiers
	(GovernmentType,							ModifierId) values
  --  ('GOVERNMENT_CITY_STATE_ALLIANCE',          'CITY_STATE_ALLIANCE_FIRST_DOUBLE_ENVOY'),
    ('GOVERNMENT_CITY_STATE_ALLIANCE',          'CITY_STATE_ALLIANCE_GOLD_FROM_ENVOY'),
    ('GOVERNMENT_PRIEST_COUNCIL',               'PRIEST_COUNCIL_HOLY_SITE_ADJACENCY'),
    ('GOVERNMENT_TRIBE_UNITY',                  'TRIBE_UNITY_ANCIENT_UNIT_STRENGTH'),
	('GOVERNMENT_AUTOCRACY',					'AUTOCRACY_CAPITAL_WONDER_PRODUCTION'),
	('GOVERNMENT_OLIGARCHY',					'OLIGARCHY_EXTRA_GREATPEOPLE_POINTS');
  --  ('GOVERNMENT_CHIEFDOM',                     'CHIEFDOM_ECONOMIC_SLOT_FROM_COMMERCIAL_HUB'),


insert or replace into TraitModifiers(TraitType,    ModifierId) values
    ('TRAIT_LEADER_MAJOR_CIV',                  'TRIBE_UNITY_MILITARY_SLOT_FROM_BARB'),
    ('TRAIT_LEADER_MAJOR_CIV',                  'TRIBE_UNITY_ECONOMIC_SLOT_FROM_GOODY'),
    ('TRAIT_LEADER_MAJOR_CIV',                  'STATE_ALLIANCE_ECONOMIC_SLOT_FROM_SUZERAIN'),
    ('TRAIT_LEADER_MAJOR_CIV',                  'STATE_ALLIANCE_MILITARY_SLOT_FROM_SUZERAIN'),
    ('TRAIT_LEADER_MAJOR_CIV',                  'PRIEST_COUNCIL_ECONOMIC_SLOT_FROM_QUEST'),
    ('TRAIT_LEADER_MAJOR_CIV',                  'PRIEST_COUNCIL_MILITARY_SLOT_FROM_QUEST');


insert or replace into BuildingModifiers(BuildingType,					ModifierId) values
	('BUILDING_GOVERNMENT_AUTOCRACY_LEGACY',			'AUTOCRACY_LEGACY_CAPITAL_INFINITE_DISTRICTS'),
	('BUILDING_GOVERNMENT_OLIGARCHY_LEGACY',			'OLIGARCHY_MELEE'); --来自原版寡头的modifier


--政体传承效果
insert or replace into BuildingModifiers
    select BuildingType,    'GOV_AUTOCRACY_LEGACY'
    from Buildings where GovernmentTierRequirement = 'Tier1';

insert or replace into BuildingModifiers
    select BuildingType,    'GOV_OLIGARCHY_LEGACY'
    from Buildings where GovernmentTierRequirement = 'Tier1';

insert or replace into BuildingModifiers
    select BuildingType,    'GOV_CLASSICAL_REPUBLIC_LEGACY'
    from Buildings where GovernmentTierRequirement = 'Tier1';



insert or replace into Modifiers(ModifierId,		ModifierType,												SubjectRequirementSetId) values
    ('CITY_STATE_ALLIANCE_GOLD_FROM_ENVOY',         'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE_PER_USED_INFLUENCE_TOKEN',             NULL),
    ('PRIEST_COUNCIL_HOLY_SITE_ADJACENCY',          'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',          'RS_PLOT_HAS_DISTRICT_HOLY_SITE'),
    ('TRIBE_UNITY_ANCIENT_UNIT_STRENGTH',           'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',                      'RS_UNIT_IN_ERA_ANCIENT'),
   
    ('CITY_STATE_ALLIANCE_FIRST_DOUBLE_ENVOY',      'MODIFIER_PLAYER_ADJUST_DUPLICATE_FIRST_INFLUENCE_TOKEN',   NULL),
	('AUTOCRACY_CAPITAL_WONDER_PRODUCTION',			'MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION',			'RS_CITY_HAS_BUILDING_PALACE'),
	('OLIGARCHY_EXTRA_GREATPEOPLE_POINTS',			'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT_BONUS',	NULL),
	('AUTOCRACY_LEGACY_CAPITAL_INFINITE_DISTRICTS',	'MODIFIER_PLAYER_CITIES_EXTRA_DISTRICT',					'RS_CITY_HAS_BUILDING_PALACE'),
    ('GOV_AUTOCRACY_LEGACY',                        'GRANT_BUILDING_TO_ALL_CITIES_IGNORE',                      'RS_GOVERNMENT_AUTOCRACY_LEGACY'),  
    ('GOV_OLIGARCHY_LEGACY',                        'GRANT_BUILDING_TO_ALL_CITIES_IGNORE',                      'RS_GOVERNMENT_OLIGARCHY_LEGACY'),  
    ('GOV_CLASSICAL_REPUBLIC_LEGACY',               'GRANT_BUILDING_TO_ALL_CITIES_IGNORE',                      'RS_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY'),
    ('TRIBE_UNITY_ECONOMIC_SLOT_FROM_GOODY',        'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',                   'RS_TRIBE_BONUS_2'),
    ('TRIBE_UNITY_MILITARY_SLOT_FROM_BARB',         'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',                   'RS_TRIBE_BONUS_1'),
    ('STATE_ALLIANCE_ECONOMIC_SLOT_FROM_SUZERAIN',  'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',                   'RS_CITYSTATE_BONUS_2'),
    ('STATE_ALLIANCE_MILITARY_SLOT_FROM_SUZERAIN',  'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',                   'RS_CITYSTATE_BONUS_1'),
    ('PRIEST_COUNCIL_ECONOMIC_SLOT_FROM_QUEST',     'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',                   'RS_PRIEST_BONUS_2'),
    ('PRIEST_COUNCIL_MILITARY_SLOT_FROM_QUEST',     'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',                   'RS_PRIEST_BONUS_1'),
    ('PRIEST_COUNCIL_ECONOMIC_SLOT_FROM_QUEST_MOD',    'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', NULL),
    ('PRIEST_COUNCIL_MILITARY_SLOT_FROM_QUEST_MOD',     'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', NULL),
    ('TRIBE_UNITY_ECONOMIC_SLOT_FROM_GOODY_MOD',    'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', NULL),
    ('TRIBE_UNITY_MILITARY_SLOT_FROM_BARB_MOD',     'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', NULL),
    ('STATE_ALLIANCE_ECONOMIC_SLOT_FROM_SUZERAIN_MOD',    'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', NULL),
    ('STATE_ALLIANCE_MILITARY_SLOT_FROM_SUZERAIN_MOD',    'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER', NULL);        




insert or replace into ModifierArguments(ModifierId,				Name,				Value) values    
    ('CITY_STATE_ALLIANCE_GOLD_FROM_ENVOY',         'YieldType',        'YIELD_GOLD'),
    ('CITY_STATE_ALLIANCE_GOLD_FROM_ENVOY',         'Amount',           1),
    ('PRIEST_COUNCIL_HOLY_SITE_ADJACENCY',          'YieldType',        'YIELD_FAITH'),
    ('PRIEST_COUNCIL_HOLY_SITE_ADJACENCY',          'Amount',           50),
    ('TRIBE_UNITY_ANCIENT_UNIT_STRENGTH',           'AbilityType',      'ABILITY_TRIBE_STRENGTH'),
    ('CITY_STATE_ALLIANCE_FIRST_DOUBLE_ENVOY',      'Amount',           1),
    ('AUTOCRACY_CAPITAL_WONDER_PRODUCTION',         'Amount',           25),
	('OLIGARCHY_EXTRA_GREATPEOPLE_POINTS',			'Amount',			50),
	('AUTOCRACY_LEGACY_CAPITAL_INFINITE_DISTRICTS',	'Amount',			99),
    ('GOV_AUTOCRACY_LEGACY',                        'BuildingType',     'BUILDING_GOVERNMENT_AUTOCRACY_LEGACY' ),   
    ('GOV_OLIGARCHY_LEGACY',                        'BuildingType',     'BUILDING_GOVERNMENT_OLIGARCHY_LEGACY'),
    ('GOV_CLASSICAL_REPUBLIC_LEGACY',               'BuildingType',     'BUILDING_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY'),
    ('TRIBE_UNITY_ECONOMIC_SLOT_FROM_GOODY',        'ModifierId',       'TRIBE_UNITY_ECONOMIC_SLOT_FROM_GOODY_MOD'),
    ('TRIBE_UNITY_MILITARY_SLOT_FROM_BARB',         'ModifierId',       'TRIBE_UNITY_MILITARY_SLOT_FROM_BARB_MOD'),
    ('STATE_ALLIANCE_ECONOMIC_SLOT_FROM_SUZERAIN',  'ModifierId',       'STATE_ALLIANCE_ECONOMIC_SLOT_FROM_SUZERAIN_MOD'),
    ('STATE_ALLIANCE_MILITARY_SLOT_FROM_SUZERAIN',  'ModifierId',       'STATE_ALLIANCE_MILITARY_SLOT_FROM_SUZERAIN_MOD'),

    ('PRIEST_COUNCIL_ECONOMIC_SLOT_FROM_QUEST',     'ModifierId',       'PRIEST_COUNCIL_ECONOMIC_SLOT_FROM_QUEST_MOD'),
    ('PRIEST_COUNCIL_MILITARY_SLOT_FROM_QUEST',     'ModifierId',       'PRIEST_COUNCIL_MILITARY_SLOT_FROM_QUEST_MOD'),
    ('PRIEST_COUNCIL_ECONOMIC_SLOT_FROM_QUEST_MOD',    'GovernmentSlotType',     'SLOT_ECONOMIC'),
    ('PRIEST_COUNCIL_MILITARY_SLOT_FROM_QUEST_MOD',     'GovernmentSlotType',     'SLOT_MILITARY'),

    ('TRIBE_UNITY_ECONOMIC_SLOT_FROM_GOODY_MOD',    'GovernmentSlotType',     'SLOT_ECONOMIC'),
    ('TRIBE_UNITY_MILITARY_SLOT_FROM_BARB_MOD',     'GovernmentSlotType',     'SLOT_MILITARY'),
    ('STATE_ALLIANCE_ECONOMIC_SLOT_FROM_SUZERAIN_MOD',    'GovernmentSlotType',     'SLOT_ECONOMIC'),
    ('STATE_ALLIANCE_MILITARY_SLOT_FROM_SUZERAIN_MOD',     'GovernmentSlotType',     'SLOT_MILITARY');


/*insert or replace into RequirementSets(RequirementSetId,               RequirementSetType) values
    ('RS_CAN_HAVE_AUTOCRACY_LEGACY',            'REQUIREMENTSET_TEST_ALL'),
    ('RS_CAN_HAVE_OLIGARCHY_LEGACY',            'REQUIREMENTSET_TEST_ALL'),
    ('RS_CAN_HAVE_CLASSICAL_REPUBLIC_LEGACY',   'REQUIREMENTSET_TEST_ALL');



insert or replace into RequirementSetRequirements(RequirementSetId,         RequirementId) values
    ('RS_CAN_HAVE_AUTOCRACY_LEGACY',            'REQUIRES_CITY_HAS_TIER_1_GOV_BUILDING'),    --Expansion2_Leaders.xml
    ('RS_CAN_HAVE_AUTOCRACY_LEGACY',            'REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_OLIGARCHY_LEGACY'),
    ('RS_CAN_HAVE_AUTOCRACY_LEGACY',            'REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY'),
    ('RS_CAN_HAVE_OLIGARCHY_LEGACY',            'REQUIRES_CITY_HAS_TIER_1_GOV_BUILDING'),
    ('RS_CAN_HAVE_OLIGARCHY_LEGACY',            'REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_AUTOCRACY_LEGACY'),
    ('RS_CAN_HAVE_OLIGARCHY_LEGACY',            'REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY'),
    ('RS_CAN_HAVE_CLASSICAL_REPUBLIC_LEGACY',   'REQUIRES_CITY_HAS_TIER_1_GOV_BUILDING'),
    ('RS_CAN_HAVE_CLASSICAL_REPUBLIC_LEGACY',   'REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_AUTOCRACY_LEGACY'),
    ('RS_CAN_HAVE_CLASSICAL_REPUBLIC_LEGACY',   'REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_OLIGARCHY_LEGACY');


insert or replace into Requirements(RequirementId,      RequirementType,    Inverse) values
    ('REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_AUTOCRACY_LEGACY',            'REQUIREMENT_CITY_HAS_BUILDING',    1),
    ('REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_OLIGARCHY_LEGACY',            'REQUIREMENT_CITY_HAS_BUILDING',    1),
    ('REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY',   'REQUIREMENT_CITY_HAS_BUILDING',    1);

insert or replace into RequirementArguments(RequirementId,      Name,       Value) values
    ('REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_AUTOCRACY_LEGACY',               'BuildingType',         'BUILDING_GOVERNMENT_AUTOCRACY_LEGACY'),
    ('REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_OLIGARCHY_LEGACY',               'BuildingType',         'BUILDING_GOVERNMENT_OLIGARCHY_LEGACY'),
    ('REQ_CITY_NOT_HAS_BUILDING_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY',      'BuildingType',         'BUILDING_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY');
*/

--古典共和传承，区域需求人口 -1
insert or replace into BuildingModifiers(BuildingType,			ModifierId) select
    'BUILDING_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY',     		'CLASSICAL_REPUBLIC_LEGACY_'||(1 + numbers * 4)||'_POP_MORE_DISTRICTS'
    from counter where numbers >= 1 and numbers <= 9;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'CLASSICAL_REPUBLIC_LEGACY_'||(1 + numbers * 4)||'_POP_MORE_DISTRICTS',    'MODIFIER_PLAYER_CITIES_EXTRA_DISTRICT',  'RS_CITY_HAS_'||(1 + numbers * 4)||'_POPULATION'
    from counter where numbers >= 1 and numbers <= 9;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'CLASSICAL_REPUBLIC_LEGACY_'||(1 + numbers * 4)||'_POP_MORE_DISTRICTS',    'Amount',    1
    from counter where numbers >= 1 and numbers <= 9;


insert or replace into BuildingModifiers(BuildingType,			ModifierId) select
    'BUILDING_GOVERNMENT_CLASSICAL_REPUBLIC_LEGACY',     		'CLASSICAL_REPUBLIC_LEGACY_'||(1 + numbers * 5)||'_POP_LESS_DISTRICTS'
    from counter where numbers >= 1 and numbers <= 9;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'CLASSICAL_REPUBLIC_LEGACY_'||(1 + numbers * 5)||'_POP_LESS_DISTRICTS',    'MODIFIER_PLAYER_CITIES_EXTRA_DISTRICT',  'RS_CITY_HAS_'||(1 + numbers * 5)||'_POPULATION'
    from counter where numbers >= 1 and numbers <= 9;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'CLASSICAL_REPUBLIC_LEGACY_'||(1 + numbers * 5)||'_POP_LESS_DISTRICTS',    'Amount',    -1
    from counter where numbers >= 1 and numbers <= 9;


--古典共和的宜居度影响翻倍
insert or replace into GovernmentModifiers(GovernmentType,  ModifierId) select
    'GOVERNMENT_CLASSICAL_REPUBLIC',     'HAPPINESS_GOV_'||(numbers * 2)||'_SCIENCE'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_SCIENCE',    'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES_WITHOUT_SLAVE_GLADIATUS'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_SCIENCE',    'YieldType',    'YIELD_SCIENCE'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_SCIENCE',    'Amount',   -6
    from counter where numbers >= -5 and numbers <= -1;


insert or replace into GovernmentModifiers(GovernmentType,  ModifierId) select
    'GOVERNMENT_CLASSICAL_REPUBLIC',     'HAPPINESS_GOV_'||(numbers * 2)||'_CULTURE'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_CULTURE',    'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES_WITHOUT_SLAVE_GLADIATUS'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_CULTURE',    'YieldType',    'YIELD_CULTURE'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_CULTURE',    'Amount',   -6
    from counter where numbers >= -5 and numbers <= -1;


insert or replace into GovernmentModifiers(GovernmentType,  ModifierId) select
    'GOVERNMENT_CLASSICAL_REPUBLIC',     'HAPPINESS_GOV_'||(numbers * 2)||'_GOLD'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_GOLD',    'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_GOLD',    'YieldType',    'YIELD_GOLD'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_GOLD',    'Amount',   6
    from counter where numbers >= -5 and numbers <= -1;


insert or replace into GovernmentModifiers(GovernmentType,  ModifierId) select
    'GOVERNMENT_CLASSICAL_REPUBLIC',     'HAPPINESS_GOV_'||(numbers * 2)||'_PRODUCTION'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_PRODUCTION',    'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_PRODUCTION',    'YieldType',    'YIELD_PRODUCTION'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_PRODUCTION',    'Amount',   6
    from counter where numbers >= -5 and numbers <= -1;

-------------------------
insert or replace into GovernmentModifiers(GovernmentType,  ModifierId) select
    'GOVERNMENT_CLASSICAL_REPUBLIC',     'HAPPINESS_GOV_'||(numbers * 2)||'_FAITH'  --当奥林匹克激活时启用
    from counter where numbers >= 1 and numbers <= 5;

 insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_FAITH',    'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES_WITH_OLYMPIC'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_FAITH',    'YieldType',    'YIELD_FAITH'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_FAITH',    'Amount',   6
    from counter where numbers >= 1 and numbers <= 5;



insert or replace into GovernmentModifiers(GovernmentType,  ModifierId) select
    'GOVERNMENT_CLASSICAL_REPUBLIC',     'HAPPINESS_GOV_'||(numbers * 2)||'_SCIENCE'
    from counter where numbers >= 1 and numbers <= 5;

 insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_SCIENCE',    'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_SCIENCE',    'YieldType',    'YIELD_SCIENCE'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_SCIENCE',    'Amount',   6
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into GovernmentModifiers(GovernmentType,  ModifierId) select
    'GOVERNMENT_CLASSICAL_REPUBLIC',     'HAPPINESS_GOV_'||(numbers * 2)||'_CULTURE'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_CULTURE',    'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_CULTURE',    'YieldType',    'YIELD_CULTURE'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_CULTURE',    'Amount',   6
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into GovernmentModifiers(GovernmentType,  ModifierId) select
    'GOVERNMENT_CLASSICAL_REPUBLIC',     'HAPPINESS_GOV_'||(numbers * 2)||'_GOLD'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_GOLD',    'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES_WITHOUT_OLYMPIC'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_GOLD',    'YieldType',    'YIELD_GOLD'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_GOLD',    'Amount',   -6
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into GovernmentModifiers(GovernmentType,  ModifierId) select
    'GOVERNMENT_CLASSICAL_REPUBLIC',     'HAPPINESS_GOV_'||(numbers * 2)||'_PRODUCTION'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,    ModifierType,       SubjectRequirementSetId) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_PRODUCTION',    'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',  'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES_WITHOUT_OLYMPIC'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_PRODUCTION',    'YieldType',    'YIELD_PRODUCTION'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,    Name,       Value) select
    'HAPPINESS_GOV_'||(numbers * 2)||'_PRODUCTION',    'Amount',   -6
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into RequirementSets(RequirementSetId,    RequirementSetType) select
    'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES_WITHOUT_SLAVE_GLADIATUS',    'REQUIREMENTSET_TEST_ALL'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into RequirementSetRequirements(RequirementSetId,     RequirementId) select
    'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES_WITHOUT_SLAVE_GLADIATUS',    'REQ_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into RequirementSetRequirements(RequirementSetId,     RequirementId) select
    'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES_WITHOUT_SLAVE_GLADIATUS',    'REQ_CITY_NO_BUILDING_CITY_POLICY_SLAVE_GLADIATUS'
    from counter where numbers >= -5 and numbers <= -1;


insert or replace into RequirementSets(RequirementSetId,    RequirementSetType) select
    'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES_WITHOUT_OLYMPIC',    'REQUIREMENTSET_TEST_ALL'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into RequirementSetRequirements(RequirementSetId,     RequirementId) select
    'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES_WITHOUT_OLYMPIC',    'REQ_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into RequirementSetRequirements(RequirementSetId,     RequirementId) select
    'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES_WITHOUT_OLYMPIC',    'REQ_CITY_NO_BUILDING_CITY_POLICY_OLYMPIC'
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into RequirementSets(RequirementSetId,    RequirementSetType) select
    'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES_WITH_OLYMPIC',    'REQUIREMENTSET_TEST_ALL'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into RequirementSetRequirements(RequirementSetId,     RequirementId) select
    'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES_WITH_OLYMPIC',    'REQ_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into RequirementSetRequirements(RequirementSetId,     RequirementId) select
    'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES_WITH_OLYMPIC',    'REQ_CITY_HAS_BUILDING_CITY_POLICY_OLYMPIC'
    from counter where numbers >= 1 and numbers <= 5;

