
update Buildings set Description = 'LOC_BUILDING_GRANARY_DESCRIPTION' where BuildingType = 'BUILDING_GRANARY';
update Buildings set Description = 'LOC_BUILDING_AMPHITHEATER_DESCRIPTION' where BuildingType = 'BUILDING_AMPHITHEATER';







insert or replace into Types
    (Type,                                      Kind)
values
    ('BUILDING_FLAG_ONE_DISTRICT',             'KIND_BUILDING'),
    --('BUILDING_FORGING',                        'KIND_BUILDING'),
    ('BUILDING_MASON',                         'KIND_BUILDING'),
    ('BUILDING_PAPER_MAKER',                   'KIND_BUILDING');

insert or replace into Buildings
    (BuildingType,                      Name,                                       Cost,   Maintenance,    Description,                                        
        PrereqTech,                     PrereqCivic,                                PrereqDistrict,         PurchaseYield,          Housing) 
values
    ('BUILDING_FLAG_ONE_DISTRICT',     'LOC_BUILDING_FLAG_ONE_DISTRICT_NAME',       1,      0,              'LOC_BUILDING_FLAG_ONE_DISTRICT_DESCRIPTION',                
    null,                               null,                                       'DISTRICT_CITY_CENTER', null,           null),
    --('BUILDING_FORGING',                  'LOC_BUILDING_FORGING_NAME',              75,     3,              'LOC_BUILDING_FORGING_DESCRIPTION',                
   -- 'TECH_BRONZE_WORKING',              null,                                       'DISTRICT_CITY_CENTER', 'YIELD_GOLD',           null),
    ('BUILDING_MASON',                  'LOC_BUILDING_MASON_NAME',                  70,     3,              'LOC_BUILDING_MASON_DESCRIPTION',                
    'TECH_MINING',                      null,                                       'DISTRICT_CITY_CENTER', 'YIELD_GOLD',           null),
    ('BUILDING_PAPER_MAKER',            'LOC_BUILDING_PAPER_MAKER_NAME',            75,     3,              'LOC_BUILDING_PAPER_MAKER_DESCRIPTION',                
    'TECH_CURRENCY',                      null,                                       'DISTRICT_CITY_CENTER', 'YIELD_GOLD',           null);

update Buildings set RequiresAdjacentRiver = 0 where BuildingType = 'BUILDING_WATER_MILL';

update Buildings set MustPurchase = 1 ,InternalOnly = 0 where BuildingType = 'BUILDING_FLAG_ONE_DISTRICT';


insert or replace into BuildingPrereqs(Building,    PrereqBuilding) values
   -- ('BUILDING_FORGING',                'BUILDING_FLAG_ONE_DISTRICT'),
    ('BUILDING_WATER_MILL',             'BUILDING_FLAG_ONE_DISTRICT'),
    ('BUILDING_PAPER_MAKER',            'BUILDING_FLAG_ONE_DISTRICT');

insert or replace into DistrictModifiers(DistrictType,  ModifierId) values
    ('DISTRICT_CITY_CENTER',        'ONE_DISTRICT_GRANT_FLAG');

insert or replace into Modifiers(ModifierId,    ModifierType,   SubjectRequirementSetId) values
    ('ONE_DISTRICT_GRANT_FLAG',         'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',   'RS_CITY_HAS_1_DISTRICTS');

insert or replace into ModifierArguments(ModifierId,    Name,   Value) values
    ('ONE_DISTRICT_GRANT_FLAG',     'BuildingType',     'BUILDING_FLAG_ONE_DISTRICT');

--在百科中屏蔽
insert or replace into CivilopediaPageExcludes(SectionId,   PageId) values
('BUILDINGS',  'ONE_DISTRICT_GRANT_FLAG');



delete from Building_CitizenYieldChanges
    where BuildingType in ('BUILDING_LIBRARY','BUILDING_AMPHITHEATER','BUILDING_SHRINE','BUILDING_TEMPLE','BUILDING_LIGHTHOUSE','BUILDING_BARRACKS','BUILDING_MARKET');
insert or replace into Building_CitizenYieldChanges
    (BuildingType,                          YieldType,          YieldChange)
values
    -- Campus
    ('BUILDING_LIBRARY',                    'YIELD_SCIENCE',    1),

    ('BUILDING_AMPHITHEATER',               'YIELD_CULTURE',    1),

    ('BUILDING_SHRINE',                     'YIELD_FAITH',      2),
    ('BUILDING_TEMPLE',                     'YIELD_FAITH',      2),
    ('BUILDING_TEMPLE',                     'YIELD_GOLD',       -3),

    ('BUILDING_LIGHTHOUSE',                 'YIELD_FOOD',       1),

    ('BUILDING_BARRACKS',                   'YIELD_PRODUCTION', 1),
    ('BUILDING_STABLE',                     'YIELD_FOOD',       1),

    ('BUILDING_MARKET',                     'YIELD_GOLD',       3);


-- 不再从建筑本身获得伟人点
--注意  未来可能会需要有建筑的大音乐家大艺术家点
delete from Building_GreatPersonPoints;

update Buildings set Entertainment = 1
where BuildingType = 'BUILDING_ARENA';

update Buildings set Housing = 1
where BuildingType = 'BUILDING_GRANARY'  or BuildingType = 'BUILDING_WATER_MILL';

delete from Building_YieldChanges 
    where BuildingType in ('BUILDING_PALACE','BUILDING_MONUMENT','BUILDING_SHRINE','BUILDING_TEMPLE','BUILDING_LIBRARY','BUILDING_AMPHITHEATER','BUILDING_LIGHTHOUSE',
        'BUILDING_BARRACKS','BUILDING_STABLE','BUILDING_MARKET','BUILDING_GRANARY','BUILDING_WATER_MILL','BUILDING_ARENA');
insert or replace into Building_YieldChanges
    (BuildingType,                  YieldType,              YieldChange)
values
    -- City Center
    ('BUILDING_PALACE',             'YIELD_FOOD',           1),
    ('BUILDING_PALACE',             'YIELD_PRODUCTION',     3),
    ('BUILDING_PALACE',             'YIELD_SCIENCE',        2),
    ('BUILDING_PALACE',             'YIELD_CULTURE',        2),
    ('BUILDING_PALACE',             'YIELD_GOLD',           7),

    --('BUILDING_MONUMENT',           'YIELD_CULTURE',        2),

    ('BUILDING_GRANARY',            'YIELD_FOOD',           1),
    ('BUILDING_MASON',              'YIELD_PRODUCTION',     1),
    --('BUILDING_FORGING',            'YIELD_PRODUCTION',     2),

    ('BUILDING_WATER_MILL',         'YIELD_FOOD',           2),
    ('BUILDING_PAPER_MAKER',        'YIELD_SCIENCE',        1),
    ('BUILDING_PAPER_MAKER',        'YIELD_CULTURE',        1),


    ('BUILDING_SHRINE',             'YIELD_FAITH',          4),
    ('BUILDING_TEMPLE',             'YIELD_FAITH',          8),

    ('BUILDING_LIBRARY',            'YIELD_SCIENCE',        2),

    ('BUILDING_AMPHITHEATER',       'YIELD_CULTURE',        2),

    ('BUILDING_LIGHTHOUSE',         'YIELD_FOOD',           2);


-- Maintainance and Cost
-- City Center
update Buildings set Maintenance = 2,   Cost = 60   where BuildingType = 'BUILDING_MONUMENT';
update Buildings set Maintenance = 3,   Cost = 70   where BuildingType = 'BUILDING_GRANARY';
update Buildings set Maintenance = 3,   Cost = 75   where BuildingType = 'BUILDING_WATER_MILL';

update Buildings set Maintenance = 3,   Cost = 75  where BuildingType = 'BUILDING_LIBRARY';

update Buildings set Maintenance = 3,   Cost = 75  where BuildingType = 'BUILDING_AMPHITHEATER';

update Buildings set Maintenance = 0,   Cost = 75   where BuildingType = 'BUILDING_MARKET';

update Buildings set Maintenance = 3,   Cost = 75   where BuildingType = 'BUILDING_SHRINE';
update Buildings set Maintenance = 5,   Cost = 90   where BuildingType = 'BUILDING_TEMPLE';

update Buildings set Maintenance = 3,   Cost = 75   where BuildingType = 'BUILDING_BARRACKS';
update Buildings set Maintenance = 3,   Cost = 75   where BuildingType = 'BUILDING_STABLE';

update Buildings set Maintenance = 3,   Cost = 75   where BuildingType = 'BUILDING_LIGHTHOUSE';

update Buildings set Maintenance = 3,   Cost = 75   where BuildingType = 'BUILDING_ARENA';

/*
insert or replace into Building_YieldsPerEra
    (BuildingType,                  YieldType,          YieldChange)  values
    ('BUILDING_MONUMENT',           'YIELD_CULTURE',    '1');
*/


delete from BuildingModifiers
     where BuildingType in ('BUILDING_PALACE','BUILDING_MONUMENT','BUILDING_SHRINE','BUILDING_TEMPLE','BUILDING_LIBRARY','BUILDING_AMPHITHEATER','BUILDING_LIGHTHOUSE',
        'BUILDING_BARRACKS','BUILDING_STABLE','BUILDING_MARKET','BUILDING_GRANARY','BUILDING_WATER_MILL','BUILDING_ARENA');




insert or replace into BuildingModifiers
    (BuildingType,                  ModifierId)
values
 --   ('BUILDING_GRANARY',            'GRANARY_POP_GROWTH'),
 --   ('BUILDING_WATER_MILL',         'WATER_MILL_FOOD_FOR_RIVER_FARM'),
  --  ('BUILDING_WATER_MILL',         'WATER_MILL_FOOD_FOR_RIVER_PLANTATION'),
 --   ('BUILDING_WATER_MILL',         'WATER_MILL_PRODUCTION_FOR_RIVER_LUMBER_MILL'),
    ('BUILDING_GRANARY',            'GRANARY_PLANTATION_FOOD'),
 --   ('BUILDING_GRANARY',            'GRANARY_ADJACENT_GRASS_FOOD'),
 --   ('BUILDING_GRANARY',            'GRANARY_ADJACENT_PLAINS_FOOD'),       
  --  ('BUILDING_WATER_MILL',         'WATER_MILL_DISTRICTS_PRODUCTION'),
    ('BUILDING_MASON',              'MASON_QUARRY_PRODUCTION'),
  --  ('BUILDING_MASON',              'MASON_ADJACENT_GRASS_HILL_PRODUCTION'),
  --  ('BUILDING_MASON',              'MASON_ADJACENT_PLAINS_HILL_PRODUCTION'),
   --('BUILDING_MONUMENT',             'MONUMENT_CAN_BUILD_TEST'),
    ('BUILDING_MONUMENT',           'MONUMENT_SCIENCE_WITHOUT_CAMPUS'),
    ('BUILDING_MONUMENT',           'MONUMENT_CULTURE_WITHOUT_THEATER'),
    ('BUILDING_MONUMENT',           'MONUMENT_FAITH_WITHOUT_HOLY_SITE'),
    ('BUILDING_MONUMENT',           'MONUMENT_LOYALTY_WITH_ALL_THREE'),



    ('BUILDING_SHRINE',             'SHRINE_BUILDER_PURCHASE'),
    ('BUILDING_TEMPLE',             'TEMPLE_SETTLER_PURCHASE'),
    ('BUILDING_BARRACKS',           'BARRACKS_UNIT_PRODUCTION'),
    ('BUILDING_STABLE',             'STABLE_UNIT_PRODUCTION'),

    ('BUILDING_BARRACKS',           'BARRACKS_TRAINED_UNIT_PROMOTION'),
    ('BUILDING_MARKET',             'MARKET_TRADE_ROUTE_CAPACITY'),
  --  ('BUILDING_MARKET',             'MARKET_GOLD_FOR_CAMP'),
   -- ('BUILDING_MARKET',             'MARKET_GOLD_FOR_PANTATION'),
   -- ('BUILDING_ARENA',              'ARENA_CULTURE_FOR_CAMP'),
  --  ('BUILDING_ARENA',              'ARENA_CULTURE_FOR_PASTURE'),
   -- ('BUILDING_STABLE',             'STABLE_PRODUCTION_FOR_PASTURE'),
    ('BUILDING_STABLE',             'STABLE_TRAINED_UNIT_PROMOTION'),
    ('BUILDING_LIGHTHOUSE',         'LIGHTHOUSE_TRADE_ROUTE_CAPACITY');
   -- ('BUILDING_LIGHTHOUSE',         'LIGHTHOUSE_FOOD_FOR_FISHING_BOATS');
   
insert or replace into TraitModifiers
    (TraitType,                         ModifierId)
values
    --('TRAIT_LEADER_MAJOR_CIV',          'WATER_MILL_DISTRICTS_PRODUCTION_MOD'),
   -- ('TRAIT_LEADER_MAJOR_CIV',          'AMPHITHEATER_WRITING_CULTURE_BOOST'),
    --('TRAIT_LEADER_MAJOR_CIV',          'AMPHITHEATER_WRITING_TOURISM_BOOST'),
    --('TRAIT_LEADER_MAJOR_CIV',          'PLAYERS_HOLY_SITE_FAITH_PURCHASE'),
    ('TRAIT_LEADER_MAJOR_CIV',          'GRANARY_ADJACENT_GRASS_FOOD'),
    ('TRAIT_LEADER_MAJOR_CIV',          'GRANARY_ADJACENT_PLAINS_FOOD'),
    ('TRAIT_LEADER_MAJOR_CIV',          'GRANARY_ADJACENT_FLOODPLAINS_FOOD'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_GRASS_HILL_PRODUCTION'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_PLAINS_HILL_PRODUCTION'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION'),
    ('TRAIT_LEADER_MAJOR_CIV',          'MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION');

insert or replace into TraitModifiers select
    'TRAIT_LEADER_MAJOR_CIV',   BuildingType||'_FAITH_PURCHASE'
    from Buildings
    where PrereqDistrict = 'DISTRICT_HOLY_SITE' 
    and BuildingType not like '%CITY_POLICY%'
    and BuildingType not like '%CTZY%'
    and BuildingType not like '%FLAG%';



insert or replace into Modifiers
    (ModifierId,                                    ModifierType,                                                   SubjectRequirementSetId)
values
  --   ('MONUMENT_CAN_BUILD_TEST',                     'MODIFIER_PLAYER_ADJUST_DISTRICT_UNLOCK',                     NULL),
  
    --('GRANARY_POP_GROWTH',                          'MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH',                      NULL),
    ('SHRINE_BUILDER_PURCHASE',                     'MODIFIER_CITY_ENABLE_UNIT_FAITH_PURCHASE',                     NULL),
    ('TEMPLE_SETTLER_PURCHASE',                     'MODIFIER_CITY_ENABLE_UNIT_FAITH_PURCHASE',                     NULL),
    ('BARRACKS_UNIT_PRODUCTION',                    'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PRODUCTION_CHANGE',           NULL),
    ('STABLE_UNIT_PRODUCTION',                      'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PRODUCTION_CHANGE',           NULL),
    ('MARKET_TRADE_ROUTE_CAPACITY',                 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY',                  NULL),
    ('LIGHTHOUSE_TRADE_ROUTE_CAPACITY',             'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY',                  NULL),
    ('MONUMENT_SCIENCE_WITHOUT_CAMPUS',             'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',                   'RS_CITY_NO_DISTRICT_CAMPUS'),
    ('MONUMENT_CULTURE_WITHOUT_THEATER',            'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',                   'RS_CITY_NO_DISTRICT_THEATER'),
    ('MONUMENT_FAITH_WITHOUT_HOLY_SITE',            'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_YIELD',                   'RS_CITY_NO_DISTRICT_HOLY_SITE'),
    ('MONUMENT_LOYALTY_WITH_ALL_THREE',             'MODIFIER_SINGLE_CITY_ADJUST_IDENTITY_PER_TURN',                'RS_CITY_HAS_MONUMENT_DISTRICTS'),

--    ('WATER_MILL_FOOD_FOR_RIVER_FARM',              'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_RIVER_FARM'),
--    ('WATER_MILL_PRODUCTION_FOR_RIVER_LUMBER_MILL', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_RIVER_LUMBER_MILL'),
   -- ('MARKET_GOLD_FOR_CAMP',                        'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_CAMP'),
   -- ('MARKET_GOLD_FOR_PANTATION',                   'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_PLANTATION'),
 --   ('ARENA_CULTURE_FOR_CAMP',                      'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_CAMP'),
   -- ('ARENA_CULTURE_FOR_PASTURE',                   'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_PASTURE'),
  --  ('STABLE_PRODUCTION_FOR_PASTURE',               'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_PASTURE'),
   -- ('LIGHTHOUSE_FOOD_FOR_FISHING_BOATS',           'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_FISHING_BOATS'),
    ('AMPHITHEATER_WRITING_CULTURE_BOOST',          'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',                       'RS_AT_LEAST_4_AMENITIES_AND_HAS_AMPHITHEATER'),--RS_AT_LEAST_4_HAPPINESS
    ('AMPHITHEATER_WRITING_TOURISM_BOOST',          'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',                       'RS_AT_LEAST_4_AMENITIES_AND_HAS_AMPHITHEATER'),
    ('AMPHITHEATER_WRITING_CULTURE_BOOST_MOD',      'MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD',                  NULL),
    ('AMPHITHEATER_WRITING_TOURISM_BOOST_MOD',      'MODIFIER_SINGLE_CITY_ADJUST_TOURISM',                          NULL),
    ('BARRACKS_TRAINED_UNIT_PROMOTION',             'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE',          'BARRACKS_UNIT_REQUIREMENTS'),
    ('STABLE_TRAINED_UNIT_PROMOTION',               'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE',          'STABLE_UNIT_REQUIREMENTS'),
    ('PLAYERS_HOLY_SITE_FAITH_PURCHASE',            'MODIFIER_PLAYER_CITIES_ENABLE_BUILDING_FAITH_PURCHASE',        NULL),
    --('WATER_MILL_DISTRICTS_PRODUCTION',             'MODIFIER_CITY_OWNER_ATTACH_MODIFIER',                          NULL),
    ('WATER_MILL_DISTRICTS_PRODUCTION_MOD',         'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',                'CITY_ADJACENT_TO_RIVER_AND_HAS_WATER_MILL'),
    ('GRANARY_PLANTATION_FOOD',                     'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_PLANTATION'),
    ('MASON_QUARRY_PRODUCTION',                     'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',                  'RS_PLOT_HAS_IMPROVEMENT_QUARRY'),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_GRANARY'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_GRANARY'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'MODIFIER_PLAYER_CITIES_FEATURE_ADJACENCY',                     'RS_CITY_HAS_BUILDING_GRANARY'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',                     'RS_CITY_HAS_BUILDING_MASON');  
   
insert or replace into Modifiers(ModifierId,    ModifierType) select
    BuildingType||'_FAITH_PURCHASE',    'MODIFIER_PLAYER_CITIES_ENABLE_SPECIFIC_BUILDING_FAITH_PURCHASE'
    from Buildings
    where PrereqDistrict = 'DISTRICT_HOLY_SITE' 
    and BuildingType not like '%CITY_POLICY%'
    and BuildingType not like '%CTZY%'
    and BuildingType not like '%FLAG%';


insert or replace into ModifierArguments
    (ModifierId,                                    Name,                       Value)
values

    ('SHRINE_BUILDER_PURCHASE',                     'Tag',                      'CLASS_BUILDER'),
    ('SHRINE_BUILDER_PURCHASE',                     'Tag',                      'CLASS_BUILDER'),
    ('TEMPLE_SETTLER_PURCHASE',                     'Tag',                      'CLASS_SETTLER'),
    ('TEMPLE_SETTLER_PURCHASE',                     'Tag',                      'CLASS_SETTLER'),
    ('BARRACKS_UNIT_PRODUCTION',                    'Amount',                   '4'),
    ('STABLE_UNIT_PRODUCTION',                      'Amount',                   '4'),
    ('MARKET_TRADE_ROUTE_CAPACITY',                 'Amount',                   '1'),
    ('LIGHTHOUSE_TRADE_ROUTE_CAPACITY',             'Amount',                   '1'),

    ('MONUMENT_SCIENCE_WITHOUT_CAMPUS',             'YieldType',                'YIELD_SCIENCE'),
    ('MONUMENT_SCIENCE_WITHOUT_CAMPUS',             'Amount',                   1),
    ('MONUMENT_SCIENCE_WITHOUT_CAMPUS',             'BuildingType',             'BUILDING_MONUMENT'),
    ('MONUMENT_CULTURE_WITHOUT_THEATER',            'YieldType',                'YIELD_CULTURE'),
    ('MONUMENT_CULTURE_WITHOUT_THEATER',            'Amount',                   1),
    ('MONUMENT_CULTURE_WITHOUT_THEATER',            'BuildingType',             'BUILDING_MONUMENT'),
    ('MONUMENT_FAITH_WITHOUT_HOLY_SITE',            'YieldType',                'YIELD_FAITH'),
    ('MONUMENT_FAITH_WITHOUT_HOLY_SITE',            'Amount',                   1),
    ('MONUMENT_FAITH_WITHOUT_HOLY_SITE',            'BuildingType',             'BUILDING_MONUMENT'),
    ('MONUMENT_LOYALTY_WITH_ALL_THREE',             'Amount',                   5),


    ('AMPHITHEATER_WRITING_CULTURE_BOOST_MOD',      'GreatWorkObjectType',      'GREATWORKOBJECT_WRITING'),
    ('AMPHITHEATER_WRITING_CULTURE_BOOST_MOD',      'YieldType',                'YIELD_CULTURE'),
    ('AMPHITHEATER_WRITING_CULTURE_BOOST_MOD',      'ScalingFactor',            '200'),
    ('AMPHITHEATER_WRITING_TOURISM_BOOST_MOD',      'GreatWorkObjectType',      'GREATWORKOBJECT_WRITING'),
    ('AMPHITHEATER_WRITING_TOURISM_BOOST_MOD',      'ScalingFactor',            '200'),
    ('AMPHITHEATER_WRITING_CULTURE_BOOST',          'ModifierId',               'AMPHITHEATER_WRITING_CULTURE_BOOST_MOD'),
    ('AMPHITHEATER_WRITING_TOURISM_BOOST',          'ModifierId',               'AMPHITHEATER_WRITING_TOURISM_BOOST_MOD'),
    ('BARRACKS_TRAINED_UNIT_PROMOTION',             'Amount',                   '-1'),
    ('STABLE_TRAINED_UNIT_PROMOTION',               'Amount',                   '-1'),
    ('PLAYERS_HOLY_SITE_FAITH_PURCHASE',            'DistrictType',             'DISTRICT_HOLY_SITE'),
    --('WATER_MILL_DISTRICTS_PRODUCTION',             'ModifierId',               'WATER_MILL_DISTRICTS_PRODUCTION_MOD'),
    ('WATER_MILL_DISTRICTS_PRODUCTION_MOD',         'Amount',                   '2'),
    ('WATER_MILL_DISTRICTS_PRODUCTION_MOD',         'YieldType',                'YIELD_PRODUCTION'),

    ('GRANARY_ADJACENT_GRASS_FOOD',                 'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'Amount',                   1),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'TerrainType',              'TERRAIN_GRASS'),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'YieldType',                'YIELD_FOOD'),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'Description',              'LOC_BUILDING_GRANARY_GRASS_FOOD'),
    ('GRANARY_ADJACENT_GRASS_FOOD',                 'TilesRequired',            2),

    ('GRANARY_ADJACENT_PLAINS_FOOD',                'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'Amount',                   1),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'TerrainType',              'TERRAIN_PLAINS'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'YieldType',                'YIELD_FOOD'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'Description',              'LOC_BUILDING_GRANARY_PLAINS_FOOD'),
    ('GRANARY_ADJACENT_PLAINS_FOOD',                'TilesRequired',            2),

    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'Amount',                   1),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'FeatureType',              'FEATURE_FLOODPLAINS'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'YieldType',                'YIELD_FOOD'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'Description',              'LOC_BUILDING_GRANARY_FLOODPLAINS_FOOD'),
    ('GRANARY_ADJACENT_FLOODPLAINS_FOOD',           'TilesRequired',            2),

    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'Amount',                   '1'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'TerrainType',              'TERRAIN_GRASS_HILLS'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'Description',              'LOC_BUILDING_MASON_GRASS_HILLS_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_HILL_PRODUCTION',        'TilesRequired',            2),

    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'Amount',                   '1'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'TerrainType',              'TERRAIN_PLAINS_HILLS'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'Description',              'LOC_BUILDING_MASON_PLAINS_HILLS_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_HILL_PRODUCTION',       'TilesRequired',            2),

    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'Amount',                   '1'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'TerrainType',              'TERRAIN_GRASS_MOUNTAIN'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'Description',              'LOC_BUILDING_MASON_GRASS_MOUNTAIN_PRODUCTION'),
    ('MASON_ADJACENT_GRASS_MOUNTAIN_PRODUCTION',    'TilesRequired',            '1'),
    
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'Amount',                   '1'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'TerrainType',              'TERRAIN_PLAINS_MOUNTAIN'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'YieldType',                'YIELD_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'Description',              'LOC_BUILDING_MASON_PLAINS_MOUNTAIN_PRODUCTION'),
    ('MASON_ADJACENT_PLAINS_MOUNTAIN_PRODUCTION',   'TilesRequired',            '1'),

    ('GRANARY_PLANTATION_FOOD',                     'Amount',                   '1'),
    ('GRANARY_PLANTATION_FOOD',                     'YieldType',                'YIELD_FOOD'),
    ('MASON_QUARRY_PRODUCTION',                     'Amount',                   '1'),
    ('MASON_QUARRY_PRODUCTION',                     'YieldType',                'YIELD_PRODUCTION');

insert or replace into ModifierArguments(ModifierId,    Name,   Value) select
    BuildingType||'_FAITH_PURCHASE',    'BuildingType',     BuildingType
    from Buildings
    where PrereqDistrict = 'DISTRICT_HOLY_SITE' 
    and BuildingType not like '%CITY_POLICY%'
    and BuildingType not like '%CTZY%'
    and BuildingType not like '%FLAG%';


insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
values
    ('RS_CITY_HAS_MONUMENT_DISTRICTS',                  'REQUIREMENTSET_TEST_ALL'),
    ('CITY_ADJACENT_TO_RIVER_AND_HAS_WATER_MILL',       'REQUIREMENTSET_TEST_ALL'),
    ('RS_RIVER_FARM',                                   'REQUIREMENTSET_TEST_ALL'),
    ('RS_RIVER_PLANTATION',                             'REQUIREMENTSET_TEST_ALL'),
    ('RS_RIVER_LUMBER_MILL',                            'REQUIREMENTSET_TEST_ALL'),
    ('RS_AT_LEAST_4_AMENITIES_AND_HAS_AMPHITHEATER',    'REQUIREMENTSET_TEST_ALL');


insert or ignore into Requirements
    (RequirementId,                                     RequirementType)
values
    ('REQ_RIVER_PLOT',                                  'REQUIREMENT_PLOT_ADJACENT_TO_RIVER'),
    ('HD_REQUIRES_DISTRICT_IS_NOT_DISTRICT_WONDER','REQUIREMENT_DISTRICT_TYPE_MATCHES');
--update Requirements set Inverse = 1 where RequirementId = 'HD_REQUIRES_DISTRICT_IS_NOT_DISTRICT_WONDER';

/*insert or ignore into RequirementArguments
    (RequirementId,                                     Name,                   Value)
values
    ('HD_REQUIRES_DISTRICT_IS_NOT_DISTRICT_WONDER','DistrictType',  'DISTRICT_WONDER');

   */

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
values
    ('CITY_ADJACENT_TO_RIVER_AND_HAS_WATER_MILL',       'REQ_RIVER_PLOT'),
    ('CITY_ADJACENT_TO_RIVER_AND_HAS_WATER_MILL',       'REQ_CITY_HAS_BUILDING_WATER_MILL'),

    ('RS_CITY_HAS_MONUMENT_DISTRICTS',                  'REQ_CITY_HAS_DISTRICT_CAMPUS'),
    ('RS_CITY_HAS_MONUMENT_DISTRICTS',                  'REQ_CITY_HAS_DISTRICT_THEATER'),
    ('RS_CITY_HAS_MONUMENT_DISTRICTS',                  'REQ_CITY_HAS_DISTRICT_HOLY_SITE'),

    ('RS_RIVER_FARM',                                   'REQ_PLOT_HAS_IMPROVEMENT_FARM'),
    ('RS_RIVER_FARM',                                   'REQ_RIVER_PLOT'),
    ('RS_RIVER_PLANTATION',                             'REQ_PLOT_HAS_IMPROVEMENT_PLANTATION'),
    ('RS_RIVER_PLANTATION',                             'REQ_RIVER_PLOT'),
    ('RS_RIVER_LUMBER_MILL',                            'REQ_PLOT_HAS_IMPROVEMENT_LUMBER_MILL'),
    ('RS_RIVER_LUMBER_MILL',                            'REQ_RIVER_PLOT'),
    ('RS_AT_LEAST_4_AMENITIES_AND_HAS_AMPHITHEATER',    'REQ_AT_LEAST_4_AMENITIES'),
    ('RS_AT_LEAST_4_AMENITIES_AND_HAS_AMPHITHEATER',    'REQ_CITY_HAS_BUILDING_AMPHITHEATER');
