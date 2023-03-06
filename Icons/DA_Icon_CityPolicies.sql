create table 'CityPolicies'(
    'CityPolicy' TEXT NOT NULL,
    'PolicyClass' TEXT NOT NULL,
    'BuildingType' TEXT,
    'EnableProjectType' TEXT,
    'DisableProjectType' TEXT,
    'EnableCivicType' TEXT,
    'EnableTechType' TEXT,
    'EnableCost' INT NOT NULL,
    'DisableCost' INT NOT NULL,
    'PreDistrict' TEXT,
    'PreBuilding' TEXT,
    'IconIndex' INT,
    'IconAtlas' TEXT,
    'BuildingIcon' TEXT,
    PRIMARY KEY('CityPolicy')
);

insert or replace into CityPolicies
(CityPolicy,                PolicyClass,      EnableCivicType,                   EnableTechType,            EnableCost, DisableCost,    PreDistrict,        PreBuilding) values
--城市
('FOOD_TAX',                'TAX',            'CIVIC_EARLY_EMPIRE',              NULL,                      10,         10,             'DISTRICT_CITY_CENTER',     NULL),
('MINE_TAX',                'TAX',            'CIVIC_EARLY_EMPIRE',              NULL,                      10,         10,             'DISTRICT_CITY_CENTER',     NULL),
('LUXURY_TAX',              'TAX',            'CIVIC_EARLY_EMPIRE',              NULL,                      10,         10,             'DISTRICT_CITY_CENTER',     NULL),
('EMPTY_TAX',               'TAX',            'CIVIC_EARLY_EMPIRE',              NULL,                      10,         10,             'DISTRICT_CITY_CENTER',     NULL),

--生产
('PRODUCTION_FOCUS',        'FOCUS',          'CIVIC_STATE_WORKFORCE',           NULL,                      10,         10,             'DISTRICT_CITY_CENTER',     NULL),
('FOOD_FOCUS',              'FOCUS',          'CIVIC_STATE_WORKFORCE',           NULL,                      10,         10,             'DISTRICT_CITY_CENTER',     NULL),
('EMPTY_FOCUS',             'FOCUS',          NULL,                              NULL,                      10,         10,             'DISTRICT_CITY_CENTER',     NULL),




--沿岸海事
('COASTAL_FISHING',         'COASTAL_MARITIME', NULL,                            'TECH_SAILING',            30,         10,             'DISTRICT_CITY_CENTER',     NULL),
('SEA_SALT',                'COASTAL_MARITIME', NULL,                            'TECH_SAILING',            30,         10,             'DISTRICT_CITY_CENTER',     NULL),
('EMPTY_COASTAL_MARITIME',  'COASTAL_MARITIME', NULL,                            NULL,                      10,         10,             'DISTRICT_CITY_CENTER',     NULL),


--粮仓
('MAKE_WINE',               'GRAIN_USE',      NULL,                              'TECH_POTTERY',            20,         10,             'DISTRICT_CITY_CENTER',     'BUILDING_GRANARY'),
('WATER_TRANSPORT',         'GRAIN_USE',      NULL,                              'TECH_ENGINEERING',        20,         10,             'DISTRICT_CITY_CENTER',     'BUILDING_GRANARY'),
('EMPTY_GRAIN_USE',         'GRAIN_USE',      NULL,                              'TECH_POTTERY',            10,         10,             'DISTRICT_CITY_CENTER',     'BUILDING_GRANARY'),

--石工坊
('MARBLE_CITY',             'MASONRY',        NULL,                              'TECH_MASONRY',            20,         10,             'DISTRICT_CITY_CENTER',     'BUILDING_MASON'),
('BRICK_CITY',              'MASONRY',        NULL,                              'TECH_MASONRY',            20,         10,             'DISTRICT_CITY_CENTER',     'BUILDING_MASON'),
('EMPTY_MASONRY',           'MASONRY',        NULL,                              NULL,                      10,         10,             'DISTRICT_CITY_CENTER',     'BUILDING_MASON'),

--图书馆
/*
('REVISION_CALENDAR',       'LIBRARY',        NULL,                              'TECH_ASTROLOGY',          10,         10,             'DISTRICT_CAMPUS',  'BUILDING_LIBRARY'),
('HISTORY_BOOKS',           'LIBRARY',        'CIVIC_RECORDED_HISTORY',          NULL,                      10,         10,             'DISTRICT_CAMPUS',  'BUILDING_LIBRARY'),
('COLLECT_SCRIPTURES',      'LIBRARY',        'CIVIC_THEOLOGY',                  NULL,                      10,         10,             'DISTRICT_CAMPUS',  'BUILDING_LIBRARY'),
('EMPTY_LIBRARY',           'LIBRARY',        NULL,                              'TECH_ASTROLOGY',          10,         10,             'DISTRICT_CAMPUS',  'BUILDING_LIBRARY'),
*/
--('LITERATURE_COLLECTION', 'LIBRARY',        'CIVIC_DRAMA_POETRY',              NULL,                      10,         10,             'DISTRICT_CAMPUS',  'BUILDING_LIBRARY'),
('SCRIPTURE_COLLECTION',    'LIBRARY',        'CIVIC_THEOLOGY',                  NULL,                      10,         10,             'DISTRICT_CAMPUS',  'BUILDING_LIBRARY'),
('MANUSCRIPT_COLLECTION',   'LIBRARY',        NULL,                              'TECH_MATHEMATICS',        10,         10,             'DISTRICT_CAMPUS',  'BUILDING_LIBRARY'),
('EMPTY_LIBRARY',           'LIBRARY',        NULL,                              NULL,                      10,         10,             'DISTRICT_CAMPUS',  'BUILDING_LIBRARY'),

--磨坊
('WATER_MILL',              'MILL',             NULL,                           'TECH_ENGINEERING',         25,         10,             'DISTRICT_CITY_CENTER', 'BUILDING_WATER_MILL'),
('WIND_MILL',               'MILL',             NULL,                           'TECH_CONSTRUCTION',        25,         10,             'DISTRICT_CITY_CENTER', 'BUILDING_WATER_MILL'),
('ANIMAL_MILL',             'MILL',             NULL,                           'TECH_HORSEBACK_RIDING',    25,         10,             'DISTRICT_CITY_CENTER', 'BUILDING_WATER_MILL'),
('EMPTY_MILL',              'MILL',             NULL,                           NULL,                       10,         10,             'DISTRICT_CITY_CENTER', 'BUILDING_WATER_MILL'),

--造纸坊
('SILK_PAPER',              'PAPER',            NULL,                           'TECH_MATHEMATICS',         50,         10,             'DISTRICT_CITY_CENTER', 'BUILDING_PAPER_MAKER'),
('HEMP_PAPER',              'PAPER',            NULL,                           'TECH_MATHEMATICS',         50,         10,             'DISTRICT_CITY_CENTER', 'BUILDING_PAPER_MAKER'),
('EMPTY_PAPER',             'PAPER',            NULL,                           NULL,                       10,         10,             'DISTRICT_CITY_CENTER', 'BUILDING_PAPER_MAKER'),



--古罗马剧场
('SACRIFICE',               'PLAYS',          'CIVIC_MYSTICISM',                 NULL,                      30,         10,             'DISTRICT_THEATER', 'BUILDING_AMPHITHEATER'),
('DRAMA_ALLOWANCE',         'PLAYS',          'CIVIC_DRAMA_POETRY',              NULL,                      30,         10,             'DISTRICT_THEATER', 'BUILDING_AMPHITHEATER'),
('POLITICAL_SPEECH',        'PLAYS',          'CIVIC_POLITICAL_PHILOSOPHY',      NULL,                      30,         10,             'DISTRICT_THEATER', 'BUILDING_AMPHITHEATER'),
('EMPTY_PLAYS',             'PLAYS',          NULL,                              NULL,                      10,         10,             'DISTRICT_THEATER', 'BUILDING_AMPHITHEATER'),

--神社
('PRAY_FOR_RAIN',           'SACRIFICE',        NULL,                            'TECH_IRRIGATION',         20,         10,             'DISTRICT_HOLY_SITE',   'BUILDING_SHRINE'),
('DIVINE',                  'SACRIFICE',        NULL,                            'TECH_ARCHERY',            20,         10,             'DISTRICT_HOLY_SITE',   'BUILDING_SHRINE'),
('SEA_SACRIFICE',           'SACRIFICE',        NULL,                            'TECH_SAILING',            20,         10,             'DISTRICT_HOLY_SITE',   'BUILDING_SHRINE'),
('EMPTY_SACRIFICE',         'SACRIFICE',        NULL,                            NULL,                      10,         10,             'DISTRICT_HOLY_SITE',   'BUILDING_SHRINE'),

--竞技场
('OLYMPIC',                 'ARENA',          'CIVIC_MYSTICISM',                 NULL,                      10,         10,             'DISTRICT_ENTERTAINMENT_COMPLEX',   'BUILDING_ARENA'),
('SLAVE_GLADIATUS',         'ARENA',          'CIVIC_GAMES_RECREATION',          NULL,                      10,         10,             'DISTRICT_ENTERTAINMENT_COMPLEX',   'BUILDING_ARENA'),
--('CHIVALRY',                  'ARENA',          'CIVIC_MERCENARIES',               NULL,                      10,         10,             'DISTRICT_ENTERTAINMENT_COMPLEX',   'BUILDING_ARENA'),
('EMPTY_ARENA',             'ARENA',          'CIVIC_MYSTICISM',                 NULL,                      10,         10,             'DISTRICT_ENTERTAINMENT_COMPLEX',   'BUILDING_ARENA'),

--兵营
('BARRACK_FARM',            'BARRACK',        NULL,                              'TECH_IRON_WORKING',       10,         10,             'DISTRICT_ENCAMPMENT',  'BUILDING_BARRACKS'),
('BARRACK_WEAPON',          'BARRACK',        NULL,                              'TECH_IRON_WORKING',       10,         10,             'DISTRICT_ENCAMPMENT',  'BUILDING_BARRACKS'),
('EMPTY_BARRACK',           'BARRACK',        NULL,                              'TECH_IRON_WORKING',       10,         10,             'DISTRICT_ENCAMPMENT',  'BUILDING_BARRACKS'),

--马厩
('STABLED_CAMP',            'STABLED',        NULL,                              'TECH_HORSEBACK_RIDING',   10,         10,             'DISTRICT_ENCAMPMENT',  'BUILDING_STABLE'),
('STABLED_TRANSPORT',       'STABLED',        NULL,                              'TECH_HORSEBACK_RIDING',   10,         10,             'DISTRICT_ENCAMPMENT',  'BUILDING_STABLE'),
('EMPTY_STABLED',           'STABLED',        NULL,                              'TECH_HORSEBACK_RIDING',   10,         10,             'DISTRICT_ENCAMPMENT',  'BUILDING_STABLE');

/*
update CityPolicies set BuildingIcon = 'ICON_'||PreBuilding where PreBuilding != null;
update CityPolicies set IconIndex = (select `Index` from  IconDefinitions where IconDefinitions.Name = CityPolicies.BuildingIcon),
    IconAtlas = (select Atlas from  IconDefinitions where IconDefinitions.Name = CityPolicies.BuildingIcon);


insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         IconIndex
from CityPolicies where IconAtlas = 'ICON_ATLAS_BUILDINGS';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY_DA',      IconIndex
from CityPolicies where IconAtlas = 'ICON_ATLAS_BUILDING_DA';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         IconIndex
from CityPolicies where IconAtlas = 'ICON_ATLAS_BUILDINGS';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY_DA',      IconIndex
from CityPolicies where IconAtlas = 'ICON_ATLAS_BUILDING_DA';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         IconIndex
from CityPolicies where IconAtlas = 'ICON_ATLAS_BUILDINGS';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY_DA',      IconIndex
from CityPolicies where IconAtlas = 'ICON_ATLAS_BUILDING_DA';

*/


insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_CITY_POLICY',                       256,        8,              8,                  'CityPolicies_256'),
    ('ICON_ATLAS_CITY_POLICY',                       128,        8,              8,                  'CityPolicies_128'),
    ('ICON_ATLAS_CITY_POLICY',                       80,         8,              8,                  'CityPolicies_80'),
    ('ICON_ATLAS_CITY_POLICY',                       50,         8,              8,                  'CityPolicies_50'),
    ('ICON_ATLAS_CITY_POLICY',                       38,         8,              8,                  'CityPolicies_38'),
    ('ICON_ATLAS_CITY_POLICY',                       32,         8,              8,                  'CityPolicies_32');


insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_CITY_POLICY_DA',                       256,        8,              8,                  'CityPolicies_DA_256'),
    ('ICON_ATLAS_CITY_POLICY_DA',                       128,        8,              8,                  'CityPolicies_DA_128'),
    ('ICON_ATLAS_CITY_POLICY_DA',                       80,         8,              8,                  'CityPolicies_DA_80'),
    ('ICON_ATLAS_CITY_POLICY_DA',                       50,         8,              8,                  'CityPolicies_DA_50'),
    ('ICON_ATLAS_CITY_POLICY_DA',                       38,         8,              8,                  'CityPolicies_DA_38'),
    ('ICON_ATLAS_CITY_POLICY_DA',                       32,         8,              8,                  'CityPolicies_DA_32');


insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_CITY_POLICY_FONT',                       256,       11,              3,                  'font_citypolicy_256'),
    ('ICON_ATLAS_CITY_POLICY_FONT',                       128,        11,              3,                  'font_citypolicy_128'),
    ('ICON_ATLAS_CITY_POLICY_FONT',                       80,         11,              3,                  'font_citypolicy_80'),
    ('ICON_ATLAS_CITY_POLICY_FONT',                       50,         11,              3,                  'font_citypolicy_50'),
    ('ICON_ATLAS_CITY_POLICY_FONT',                       38,         11,              3,                  'font_citypolicy_38'),
    ('ICON_ATLAS_CITY_POLICY_FONT',                       32,         11,              3,                  'font_citypolicy_32');





insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         1
from CityPolicies where PolicyClass = 'TAX';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        1
from CityPolicies where PolicyClass = 'TAX';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        1
from CityPolicies where PolicyClass = 'TAX';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         0
from CityPolicies where PolicyClass = 'FOCUS';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        0
from CityPolicies where PolicyClass = 'FOCUS';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        0
from CityPolicies where PolicyClass = 'FOCUS';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_TECH',         3
from CityPolicies where PolicyClass = 'COASTAL_MARITIME';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_TECH',        3
from CityPolicies where PolicyClass = 'COASTAL_MARITIME';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_TECH',        3
from CityPolicies where PolicyClass = 'COASTAL_MARITIME';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         3
from CityPolicies where PreBuilding = 'BUILDING_GRANARY';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        3
from CityPolicies where PreBuilding = 'BUILDING_GRANARY';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        3
from CityPolicies where PreBuilding = 'BUILDING_GRANARY';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY_DA',      1
from CityPolicies where PreBuilding = 'BUILDING_MASON';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY_DA',     1
from CityPolicies where PreBuilding = 'BUILDING_MASON';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY_DA',     1
from CityPolicies where PreBuilding = 'BUILDING_MASON';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',      7
from CityPolicies where PreBuilding = 'BUILDING_WATER_MILL';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',     7
from CityPolicies where PreBuilding = 'BUILDING_WATER_MILL';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',     7
from CityPolicies where PreBuilding = 'BUILDING_WATER_MILL';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY_DA',      3
from CityPolicies where PreBuilding = 'BUILDING_PAPER_MAKER';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY_DA',     3
from CityPolicies where PreBuilding = 'BUILDING_PAPER_MAKER';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY_DA',     3
from CityPolicies where PreBuilding = 'BUILDING_PAPER_MAKER';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         4
from CityPolicies where PreBuilding = 'BUILDING_LIBRARY';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        4
from CityPolicies where PreBuilding = 'BUILDING_LIBRARY';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        4
from CityPolicies where PreBuilding = 'BUILDING_LIBRARY';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         16
from CityPolicies where PreBuilding = 'BUILDING_AMPHITHEATER';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        16
from CityPolicies where PreBuilding = 'BUILDING_AMPHITHEATER';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        16
from CityPolicies where PreBuilding = 'BUILDING_AMPHITHEATER';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         5
from CityPolicies where PreBuilding = 'BUILDING_SHRINE';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        5
from CityPolicies where PreBuilding = 'BUILDING_SHRINE';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        5
from CityPolicies where PreBuilding = 'BUILDING_SHRINE';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         8
from CityPolicies where PreBuilding = 'BUILDING_ARENA';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        8
from CityPolicies where PreBuilding = 'BUILDING_ARENA';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        8
from CityPolicies where PreBuilding = 'BUILDING_ARENA';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         2
from CityPolicies where PreBuilding = 'BUILDING_BARRACKS';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        2
from CityPolicies where PreBuilding = 'BUILDING_BARRACKS';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        2
from CityPolicies where PreBuilding = 'BUILDING_BARRACKS';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_ENABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',         13
from CityPolicies where PreBuilding = 'BUILDING_STABLE';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_CITY_POLICY_DISABLE_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        13
from CityPolicies where PreBuilding = 'BUILDING_STABLE';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_CITY_POLICY_'||CityPolicy,                     'ICON_ATLAS_CITY_POLICY',        13
from CityPolicies where PreBuilding = 'BUILDING_STABLE';


