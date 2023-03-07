
insert or replace into Types
	(Type,										Kind)
values
	('GRANT_BUILDING_TO_ALL_CITIES_IGNORE',		'KIND_MODIFIER');

insert or replace into DynamicModifiers
	(ModifierType,							CollectionType,				EffectType)
values
	('GRANT_BUILDING_TO_ALL_CITIES_IGNORE', 'COLLECTION_PLAYER_CITIES', 'EFFECT_GRANT_BUILDING_IN_CITY_IGNORE');
-------------------------------------



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
	PRIMARY KEY('CityPolicy')
);

insert or replace into CityPolicies
(CityPolicy,	            PolicyClass,	  EnableCivicType,			         EnableTechType,		    EnableCost,	DisableCost,	PreDistrict,		PreBuilding) values
--城市
('FOOD_TAX',	            'TAX',			  'CIVIC_EARLY_EMPIRE',		         NULL,			            10,			10,				'DISTRICT_CITY_CENTER',		NULL),
('MINE_TAX',	            'TAX',			  'CIVIC_EARLY_EMPIRE',		         NULL,			            10,			10,				'DISTRICT_CITY_CENTER',		NULL),
('LUXURY_TAX',	            'TAX',			  'CIVIC_EARLY_EMPIRE',		         NULL,			            10,			10,				'DISTRICT_CITY_CENTER',		NULL),
('EMPTY_TAX',	            'TAX',			  'CIVIC_EARLY_EMPIRE',		         NULL,			            10,			10,				'DISTRICT_CITY_CENTER',		NULL),

--生产
('PRODUCTION_FOCUS',	    'FOCUS',		  'CIVIC_STATE_WORKFORCE',		     NULL,			            10,			10,				'DISTRICT_CITY_CENTER',		NULL),
('FOOD_FOCUS',	            'FOCUS',		  'CIVIC_STATE_WORKFORCE',	         NULL,			            10,			10,				'DISTRICT_CITY_CENTER',		NULL),
('EMPTY_FOCUS',	            'FOCUS',		  NULL,	         					 NULL,			            10,			10,				'DISTRICT_CITY_CENTER',		NULL),




--沿岸海事
('COASTAL_FISHING',         'COASTAL_MARITIME',	NULL,		                     'TECH_SAILING',	        30,			10,			    'DISTRICT_CITY_CENTER',		NULL),
('SEA_SALT',	        	'COASTAL_MARITIME',	NULL,		                     'TECH_SAILING',    		30,			10,			    'DISTRICT_CITY_CENTER',		NULL),
('EMPTY_COASTAL_MARITIME',	'COASTAL_MARITIME', NULL,		                     NULL,		    			10,			10,			    'DISTRICT_CITY_CENTER',		NULL),


--粮仓
('MAKE_WINE',           	'GRAIN_USE',	  NULL,		                         'TECH_POTTERY',	        20,			10,			    'DISTRICT_CITY_CENTER',		'BUILDING_GRANARY'),
('WATER_TRANSPORT',	        'GRAIN_USE',	  NULL,		                         'TECH_ENGINEERING',    	20,			10,			    'DISTRICT_CITY_CENTER',		'BUILDING_GRANARY'),
('EMPTY_GRAIN_USE',	        'GRAIN_USE',	  NULL,		                         'TECH_POTTERY',		    10,			10,			    'DISTRICT_CITY_CENTER',		'BUILDING_GRANARY'),

--石工坊
('MARBLE_CITY',           	'MASONRY',	 	  NULL,		                         'TECH_MASONRY',	        20,			10,			    'DISTRICT_CITY_CENTER',		'BUILDING_MASON'),
('BRICK_CITY',	        	'MASONRY',	  	  NULL,		                         'TECH_MASONRY',    		20,			10,			    'DISTRICT_CITY_CENTER',		'BUILDING_MASON'),
('EMPTY_MASONRY',	        'MASONRY',	      NULL,		                         NULL,		    			10,			10,			    'DISTRICT_CITY_CENTER',		'BUILDING_MASON'),

--图书馆
/*
('REVISION_CALENDAR',	    'LIBRARY',		  NULL,		                         'TECH_ASTROLOGY',			10,			10,				'DISTRICT_CAMPUS',	'BUILDING_LIBRARY'),
('HISTORY_BOOKS',	        'LIBRARY',		  'CIVIC_RECORDED_HISTORY',	         NULL,			      	    10,			10,				'DISTRICT_CAMPUS',	'BUILDING_LIBRARY'),
('COLLECT_SCRIPTURES',	    'LIBRARY',		  'CIVIC_THEOLOGY',                  NULL,			      	    10,			10,				'DISTRICT_CAMPUS',	'BUILDING_LIBRARY'),
('EMPTY_LIBRARY',	        'LIBRARY',		  NULL,		                         'TECH_ASTROLOGY',			10,			10,				'DISTRICT_CAMPUS',	'BUILDING_LIBRARY'),
*/
--('LITERATURE_COLLECTION',	'LIBRARY',		  'CIVIC_DRAMA_POETRY',		         NULL,						10,			10,				'DISTRICT_CAMPUS',	'BUILDING_LIBRARY'),
('SCRIPTURE_COLLECTION',	'LIBRARY',		  'CIVIC_THEOLOGY',		         	 NULL,						10,			10,				'DISTRICT_CAMPUS',	'BUILDING_LIBRARY'),
('MANUSCRIPT_COLLECTION',	'LIBRARY',		  NULL,		         				 'TECH_MATHEMATICS',		10,			10,				'DISTRICT_CAMPUS',	'BUILDING_LIBRARY'),
('EMPTY_LIBRARY',			'LIBRARY',		  NULL,		         				 NULL,						10,			10,				'DISTRICT_CAMPUS',	'BUILDING_LIBRARY'),

--磨坊
('WATER_MILL',				'MILL',		  		NULL,		         	 		'TECH_ENGINEERING',			50,			10,				'DISTRICT_CITY_CENTER',	'BUILDING_WATER_MILL'),
('WIND_MILL',				'MILL',		  		NULL,		         	 		'TECH_CONSTRUCTION',		50,			10,				'DISTRICT_CITY_CENTER',	'BUILDING_WATER_MILL'),
('ANIMAL_MILL',				'MILL',		  		NULL,		         	 		'TECH_HORSEBACK_RIDING',	50,			10,				'DISTRICT_CITY_CENTER',	'BUILDING_WATER_MILL'),
('EMPTY_MILL',				'MILL',		  		NULL,		         	 		NULL,						10,			10,				'DISTRICT_CITY_CENTER',	'BUILDING_WATER_MILL'),

--造纸坊
('SILK_PAPER',				'PAPER',		  	NULL,		         	 		'TECH_MATHEMATICS',			50,			10,				'DISTRICT_CITY_CENTER',	'BUILDING_PAPER_MAKER'),
('HEMP_PAPER',				'PAPER',		  	NULL,		         	 		'TECH_MATHEMATICS',			50,			10,				'DISTRICT_CITY_CENTER',	'BUILDING_PAPER_MAKER'),
('EMPTY_PAPER',				'PAPER',		  	NULL,		         	 		NULL,						10,			10,				'DISTRICT_CITY_CENTER',	'BUILDING_PAPER_MAKER'),



--古罗马剧场
('SACRIFICE',	        	'PLAYS',		  'CIVIC_MYSTICISM',		     	 NULL,			            30,			10,				'DISTRICT_THEATER',	'BUILDING_AMPHITHEATER'),
('DRAMA_ALLOWANCE',       	'PLAYS',		  'CIVIC_DRAMA_POETRY',		         NULL,			            30,			10,				'DISTRICT_THEATER',	'BUILDING_AMPHITHEATER'),
('POLITICAL_SPEECH',       	'PLAYS',		  'CIVIC_POLITICAL_PHILOSOPHY',		 NULL,			            30,			10,				'DISTRICT_THEATER',	'BUILDING_AMPHITHEATER'),
('EMPTY_PLAYS',	        	'PLAYS',		  NULL,			     				 NULL,				        10,			10,				'DISTRICT_THEATER',	'BUILDING_AMPHITHEATER'),

--神社
('PRAY_FOR_RAIN',	        'SACRIFICE',		NULL,							 'TECH_IRRIGATION',		    20,			10,				'DISTRICT_HOLY_SITE',	'BUILDING_SHRINE'),
('DIVINE',       			'SACRIFICE',		NULL,		       				 'TECH_ARCHERY',			20,			10,				'DISTRICT_HOLY_SITE',	'BUILDING_SHRINE'),
('SEA_SACRIFICE',	        'SACRIFICE',		NULL,			     			 'TECH_SAILING',			20,			10,				'DISTRICT_HOLY_SITE',	'BUILDING_SHRINE'),
('EMPTY_SACRIFICE',	        'SACRIFICE',		NULL,			     			 NULL,				        10,			10,				'DISTRICT_HOLY_SITE',	'BUILDING_SHRINE'),

--竞技场
('OLYMPIC',	           	    'ARENA',		  'CIVIC_MYSTICISM',		         NULL,			     	    10,			10,				'DISTRICT_ENTERTAINMENT_COMPLEX',	'BUILDING_ARENA'),
('SLAVE_GLADIATUS',    	    'ARENA',		  'CIVIC_GAMES_RECREATION',	         NULL,			     	    10,			10,				'DISTRICT_ENTERTAINMENT_COMPLEX',	'BUILDING_ARENA'),
--('CHIVALRY',      	   	    'ARENA',		  'CIVIC_MERCENARIES',               NULL,			      	    10,			10,				'DISTRICT_ENTERTAINMENT_COMPLEX',	'BUILDING_ARENA'),
('EMPTY_ARENA',     	    'ARENA',		  'CIVIC_MYSTICISM',			     NULL,				  	    10,			10,				'DISTRICT_ENTERTAINMENT_COMPLEX',	'BUILDING_ARENA'),

--兵营
('BARRACK_FARM',	        'BARRACK',		  NULL,		                         'TECH_IRON_WORKING',		10,			10,				'DISTRICT_ENCAMPMENT',	'BUILDING_BARRACKS'),
('BARRACK_WEAPON',	        'BARRACK',		  NULL,		                         'TECH_IRON_WORKING',		10,			10,				'DISTRICT_ENCAMPMENT',	'BUILDING_BARRACKS'),
('EMPTY_BARRACK',	        'BARRACK',		  NULL,		                         'TECH_IRON_WORKING',		10,			10,				'DISTRICT_ENCAMPMENT',	'BUILDING_BARRACKS'),

--马厩
('STABLED_CAMP',    	    'STABLED',		  NULL,		                         'TECH_HORSEBACK_RIDING',	10,			10,				'DISTRICT_ENCAMPMENT',	'BUILDING_STABLE'),
('STABLED_TRANSPORT',    	'STABLED',		  NULL,		                         'TECH_HORSEBACK_RIDING',	10,			10,				'DISTRICT_ENCAMPMENT',	'BUILDING_STABLE'),
('EMPTY_STABLED',	        'STABLED',		  NULL,		                         'TECH_HORSEBACK_RIDING',	10,			10,				'DISTRICT_ENCAMPMENT',	'BUILDING_STABLE');


--根据表格生成城市政策的建筑/开启项目/关闭项目
update CityPolicies set
	BuildingType 			= 'BUILDING_CITY_POLICY_' || CityPolicy,
	EnableProjectType 		= 'PROJECT_CITY_POLICY_ENABLE_' || CityPolicy,
	DisableProjectType 		= 'PROJECT_CITY_POLICY_DISABLE_' || CityPolicy;

insert or replace into Types (Type, Kind) select BuildingType, 'KIND_BUILDING' from CityPolicies;
insert or replace into Types (Type, Kind) select EnableProjectType, 'KIND_PROJECT' from CityPolicies where CityPolicy NOT LIKE 'EMPTY%';
insert or replace into Types (Type, Kind) select DisableProjectType, 'KIND_PROJECT' from CityPolicies where CityPolicy NOT LIKE 'EMPTY%';

insert or replace into Buildings (BuildingType,	Name,	Cost,	Description,	PrereqDistrict,	MustPurchase)
select BuildingType, 'LOC_'||BuildingType||'_NAME',		1, 		'LOC_'||BuildingType||'_DESCRIPTION',	PreDistrict,	1
from CityPolicies;

insert or replace into Buildings_XP2 (BuildingType, Pillage)
select BuildingType, 0 from CityPolicies;

update Buildings set Maintenance = 6 where BuildingType = 'BUILDING_CITY_POLICY_REVISION_CALENDAR';
update Buildings set Maintenance = 6 where BuildingType = 'BUILDING_CITY_POLICY_HISTORY_BOOKS';
update Buildings set Maintenance = 6 where BuildingType = 'BUILDING_CITY_POLICY_COLLECT_SCRIPTURES';
update Buildings set Maintenance = 2 where BuildingType = 'BUILDING_CITY_POLICY_PRAY_FOR_RAIN';
update Buildings set Maintenance = 2 where BuildingType = 'BUILDING_CITY_POLICY_SEA_SACRIFICE';
update Buildings set Maintenance = 2 where BuildingType = 'BUILDING_CITY_POLICY_DIVINE';

--送空税务政策到每座4人口城
insert or replace into TraitModifiers
	(TraitType,					ModifierId)
SELECT  'TRAIT_LEADER_MAJOR_CIV',	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER' 
FROM CityPolicies WHERE CityPolicy IS 'EMPTY_TAX';

insert or replace into TraitModifiers
	(TraitType,					ModifierId)
SELECT  'MINOR_CIV_DEFAULT_TRAIT',	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER' 
FROM CityPolicies WHERE CityPolicy IS 'EMPTY_TAX';

insert or replace into Modifiers
	(ModifierId,								ModifierType,		SubjectRequirementSetId)
select
	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER', 'GRANT_BUILDING_TO_ALL_CITIES_IGNORE',	'RS_CITY_HAS_4_POPULATION'
	FROM CityPolicies WHERE CityPolicy IS 'EMPTY_TAX';

insert or replace into ModifierArguments
	(ModifierId,								Name,			Value)
select
	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER', 'BuildingType', BuildingType
FROM CityPolicies WHERE CityPolicy IS 'EMPTY_TAX';

--送空建筑政策到每座城
insert or replace into BuildingModifiers(BuildingType,		ModifierId)
select PreBuilding,		'DA_'||PreBuilding||'_EMPTY_POLICY' 
from CityPolicies where CityPolicy like 'EMPTY%' and PreBuilding is not null;

insert or replace into Modifiers(ModifierId,	ModifierType)
	select 'DA_'||PreBuilding||'_EMPTY_POLICY',		'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE'
from CityPolicies where CityPolicy like 'EMPTY%' and PreBuilding is not null;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'DA_'||PreBuilding||'_EMPTY_POLICY',		'BuildingType',		'BUILDING_CITY_POLICY_' || CityPolicy
from CityPolicies where CityPolicy like 'EMPTY%' and PreBuilding is not null;

insert or replace into BuildingModifiers(BuildingType,		ModifierId)
select CivUniqueBuildingType,		'DA_'||PreBuilding||'_EMPTY_POLICY' 
from CityPolicies, BuildingReplaces where CityPolicy like 'EMPTY%' and PreBuilding = ReplacesBuildingType;


--送空沿岸海事政策到每座城
insert or replace into TraitModifiers
	(TraitType,					ModifierId)
SELECT  'TRAIT_LEADER_MAJOR_CIV',	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER' 
FROM CityPolicies WHERE CityPolicy IS 'EMPTY_COASTAL_MARITIME';

insert or replace into TraitModifiers
	(TraitType,					ModifierId)
SELECT  'MINOR_CIV_DEFAULT_TRAIT',	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER' 
FROM CityPolicies WHERE CityPolicy IS 'EMPTY_COASTAL_MARITIME';

insert or replace into Modifiers
	(ModifierId,								ModifierType,			SubjectRequirementSetId)
select
	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER', 'GRANT_BUILDING_TO_ALL_CITIES_IGNORE',		'RS_PLOT_ADJACENT_TERRAIN_COAST'
	FROM CityPolicies WHERE CityPolicy IS 'EMPTY_COASTAL_MARITIME';

insert or replace into ModifierArguments
	(ModifierId,								Name,			Value)
select
	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER', 'BuildingType', BuildingType
FROM CityPolicies WHERE CityPolicy IS 'EMPTY_COASTAL_MARITIME';


--送空生产政策到每座有建筑城
insert or replace into TraitModifiers
	(TraitType,					ModifierId)
SELECT  'TRAIT_LEADER_MAJOR_CIV',	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER' 
FROM CityPolicies WHERE CityPolicy IS 'EMPTY_FOCUS';

insert or replace into TraitModifiers
	(TraitType,					ModifierId)
SELECT  'MINOR_CIV_DEFAULT_TRAIT',	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER' 
FROM CityPolicies WHERE CityPolicy IS 'EMPTY_FOCUS';

insert or replace into Modifiers
	(ModifierId,								ModifierType,			SubjectRequirementSetId)
select
	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER', 'GRANT_BUILDING_TO_ALL_CITIES_IGNORE',		'RS_CITY_HAS_BUILDING'
	FROM CityPolicies WHERE CityPolicy IS 'EMPTY_FOCUS';

insert or replace into ModifierArguments
	(ModifierId,								Name,			Value)
select
	'TRAIT_GRANT_'||CityPolicy||'_MODIFIER', 'BuildingType', BuildingType
FROM CityPolicies WHERE CityPolicy IS 'EMPTY_FOCUS';





--项目定义
insert or replace into Projects
	(ProjectType, Name, ShortName, Description, Cost, PrereqCivic, PrereqTech, AdvisorType, PrereqDistrict)
select
	EnableProjectType,
	'LOC_'||EnableProjectType||'_NAME',
	'LOC_'||EnableProjectType||'_SHORT_NAME',
	'LOC_'||EnableProjectType||'_DESCRIPTION',
	EnableCost,
	EnableCivicType,
	EnableTechType,
	'ADVISOR_GENERIC',
	PreDistrict
from CityPolicies where CityPolicy NOT LIKE 'EMPTY%';

insert or replace into Projects
	(ProjectType, Name, ShortName, Description, Cost, PrereqCivic, PrereqTech, AdvisorType)
select
	DisableProjectType,
	'LOC_'||DisableProjectType||'_NAME',
	'LOC_'||DisableProjectType||'_SHORT_NAME',
	'LOC_'||DisableProjectType||'_DESCRIPTION',
	DisableCost,
	NULL,
	NULL,
	'ADVISOR_GENERIC'
from CityPolicies where CityPolicy NOT LIKE 'EMPTY%';

--ENABLE PROJECTS
insert or replace into Project_BuildingCosts
	(ProjectType,			ConsumedBuildingType)
select
	EnableProjectType,		'BUILDING_CITY_POLICY_EMPTY_' || PolicyClass
from CityPolicies where CityPolicy NOT LIKE 'EMPTY%';
insert or replace into Projects_XP2
	(ProjectType,			RequiredBuilding,				CreateBuilding)
select
	EnableProjectType,		'BUILDING_CITY_POLICY_EMPTY_' || PolicyClass,			BuildingType
from CityPolicies where CityPolicy NOT LIKE 'EMPTY%';

--DISABLE PROJECTS
insert or replace into Projects_XP2
	(ProjectType,			RequiredBuilding,				CreateBuilding)
select
	DisableProjectType,		BuildingType,					'BUILDING_CITY_POLICY_EMPTY_' || PolicyClass
from CityPolicies where CityPolicy NOT LIKE 'EMPTY%';
insert or replace into Project_BuildingCosts
	(ProjectType,			ConsumedBuildingType)
select
	DisableProjectType,		BuildingType
from CityPolicies where CityPolicy NOT LIKE 'EMPTY%';

insert or replace into MutuallyExclusiveBuildings (Building, MutuallyExclusiveBuilding)
select a.BuildingType, b.BuildingType from CityPolicies a, CityPolicies b where a.BuildingType != b.BuildingType and a.PolicyClass = b.PolicyClass;

--在百科中屏蔽取消项目
insert or replace into CivilopediaPageExcludes(SectionId,	PageId)	select
'WONDERS',	DisableProjectType from CityPolicies where CityPolicy not like 'EMPTY%';





--城市政策效果
insert or replace into BuildingModifiers 
	(BuildingType,								                ModifierId)
values 
--城市
	('BUILDING_CITY_POLICY_FOOD_TAX',		                	'DA_FOOD_TAX_GOLD'),
	('BUILDING_CITY_POLICY_FOOD_TAX',		                	'DA_FOOD_TAX_FOOD'),
	('BUILDING_CITY_POLICY_FOOD_TAX',		                	'DA_FOOD_TAX_EXTRA_GOLD'),

	('BUILDING_CITY_POLICY_MINE_TAX',		                	'DA_MINE_TAX_GOLD'),
	('BUILDING_CITY_POLICY_MINE_TAX',		                	'DA_MINE_TAX_PRODUCTION'),
	('BUILDING_CITY_POLICY_MINE_TAX',		                	'DA_MINE_TAX_EXTRA_GOLD'),

	('BUILDING_CITY_POLICY_LUXURY_TAX',		                	'DA_LUXURY_TAX_RESOURCE_AMENITY'),
	('BUILDING_CITY_POLICY_LUXURY_TAX',		                	'DA_LUXURY_TAX_RESOURCE_STRATEGIC'),


--生产
	('BUILDING_CITY_POLICY_PRODUCTION_FOCUS',		            'DA_PRODUCTION_FOCUS_POP_PRODUCTION'),
	('BUILDING_CITY_POLICY_PRODUCTION_FOCUS',		            'DA_PRODUCTION_FOCUS_POP_COST_FOOD'),
	('BUILDING_CITY_POLICY_PRODUCTION_FOCUS',		            'DA_PRODUCTION_FOCUS_LOW_GROWTH'),

	('BUILDING_CITY_POLICY_FOOD_FOCUS',		            		'DA_FOOD_FOCUS_POP_FOOD'),
	('BUILDING_CITY_POLICY_FOOD_FOCUS',		            		'DA_FOOD_FOCUS_POP_COST_PRODUCTION'),
	('BUILDING_CITY_POLICY_FOOD_FOCUS',		            		'DA_FOOD_FOCUS_LOW_UNIT_BUILD'),


--沿岸海事
	--('BUILDING_CITY_POLICY_COASTAL_FISHING',		            'DA_COASTAL_FISHING_FOOD'),
	('BUILDING_CITY_POLICY_SEA_SALT',		                	'DA_SEA_SALT_GOLD'),

--粮仓  --能力重做
	/*('BUILDING_CITY_POLICY_MAKE_WINE',		                	'DA_MAKE_WINE_LESS_FOOD_DEBUFF'),
	('BUILDING_CITY_POLICY_MAKE_WINE',		                	'DA_MAKE_WINE_GOLD'), --条件集我不知道是否成功   --e-应该没问题
	('BUILDING_CITY_POLICY_MAKE_WINE',		                	'DA_MAKE_WINE_GOLD_AMENITIES'), --同上	
	
	('BUILDING_CITY_POLICY_WATER_TRANSPORT',		        	'DA_WATER_TRANSPORT_FOOD_BUFF'), --同样是条件集
	('BUILDING_CITY_POLICY_WATER_TRANSPORT',		        	'DA_WATER_TRANSPORT_GOLD_DEBUFF'),
	('BUILDING_CITY_POLICY_WATER_TRANSPORT',		        	'DA_WATER_TRANSPORT_FOOD_DEBUFF'),
	('BUILDING_CITY_POLICY_WATER_TRANSPORT',			        'DA_WATER_TRANSPORT_LESS_GOLD_DEBUFF'),*/

	('BUILDING_CITY_POLICY_MAKE_WINE',		                	'DA_MAKE_WINE_AMENITIES'),	
	('BUILDING_CITY_POLICY_MAKE_WINE',		                	'DA_MAKE_WINE_COST_FOOD'),	

	('BUILDING_CITY_POLICY_WATER_TRANSPORT',		        	'DA_WATER_TRANSPORT_SUPPLY_FOOD'),
	('BUILDING_CITY_POLICY_WATER_TRANSPORT',		        	'DA_WATER_TRANSPORT_COST_FOOD'),

--石工坊
	('BUILDING_CITY_POLICY_MARBLE_CITY',		                'DA_MARBLE_CITY_AMENITIES'),	
	('BUILDING_CITY_POLICY_MARBLE_CITY',		                'DA_MARBLE_CITY_COST_PRODUCTION'),	

	('BUILDING_CITY_POLICY_BRICK_CITY',		                	'DA_BRICK_CITY_HOUSING'),	
	('BUILDING_CITY_POLICY_BRICK_CITY',		                	'DA_BRICK_CITY_COST_PRODUCTION'),	

--磨坊
	('BUILDING_CITY_POLICY_WATER_MILL',		                	'DA_WATER_MILL_DISTRICT_PRODUCTION'),	
	('BUILDING_CITY_POLICY_WATER_MILL',		                	'DA_WATER_MILL_DISTRICT_FOOD'),	
	('BUILDING_CITY_POLICY_WIND_MILL',		                	'DA_WIND_MILL_DISTRICT_PRODUCTION'),	
	('BUILDING_CITY_POLICY_WIND_MILL',		                	'DA_WIND_MILL_DISTRICT_FOOD'),	
	('BUILDING_CITY_POLICY_ANIMAL_MILL',		                'DA_ANIMAL_MILL_DISTRICT_PRODUCTION'),		
	('BUILDING_CITY_POLICY_ANIMAL_MILL',		                'DA_ANIMAL_MILL_DISTRICT_FOOD'),		


--造纸坊
	('BUILDING_CITY_POLICY_SILK_PAPER',		                	'DA_SILK_PAPER_CAMPUS_ADJACENCY'),	
	('BUILDING_CITY_POLICY_SILK_PAPER',		                	'DA_SILK_PAPER_COMMERCIAL_HUB_ADJACENCY'),	
	('BUILDING_CITY_POLICY_SILK_PAPER',		                	'DA_SILK_PAPER_THERTER_ADJACENCY'),	
	('BUILDING_CITY_POLICY_SILK_PAPER',		                	'DA_SILK_PAPER_HOLY_SITE_ADJACENCY'),	

	('BUILDING_CITY_POLICY_HEMP_PAPER',		                	'DA_HEMP_PAPER_POP_SCIENCE'),	
	('BUILDING_CITY_POLICY_HEMP_PAPER',		                	'DA_HEMP_PAPER_POP_CULTURE'),	





--图书馆

--古罗马剧场
	('BUILDING_CITY_POLICY_SACRIFICE',		        			'DA_SACRIFICE_AMPHITHEATER_MIRROR_FAITH'), 
	('BUILDING_CITY_POLICY_DRAMA_ALLOWANCE',		        	'DA_DRAMA_ALLOWANCE_AMPHITHEATER_MIRROR_TOURISM'), 
	--('BUILDING_CITY_POLICY_POLITICAL_SPEECH',					'DA_POLITICAL_SPEECH_AMPHITHEATER_MIRROR_IDENTITY_SPREAD'),
--政治演说在下面

--神社
	('BUILDING_CITY_POLICY_PRAY_FOR_RAIN',			            'DA_PRAY_FOR_RAIN_NO_WATER_FAITH'),
	--('BUILDING_CITY_POLICY_DIVINE',			            		'DA_DIVINE_DISTRICT_FAITH'),
	('BUILDING_CITY_POLICY_SEA_SACRIFICE',			            'DA_SEA_SACRIFICE_NEAR_COAST_FAITH');


--竞技场
--每点宜居度给城市产出，我没想明白怎么写  --写在下面了
	
--兵营 --由单位能力和lua联合实现

--马厩

--畜力磨坊
--insert or replace into TraitModifiers(TraitType,	ModifierId) values
--	('TRAIT_LEADER_MAJOR_CIV',		'DA_ANIMAL_MILL_DISTRICT_PRODUCTION');

--竞技场
insert or replace into TraitModifiers(TraitType,	ModifierId) values
	('TRAIT_LEADER_MAJOR_CIV',		'DA_DIVINE_DISTRICT_FAITH_MOD'),
	('TRAIT_LEADER_MAJOR_CIV',		'DA_SEA_SALT_GOLD_MOD'),
	('TRAIT_LEADER_MAJOR_CIV',		'DA_COASTAL_FISHING_FOOD_MOD');

insert or replace into TraitModifiers(TraitType,	ModifierId)
	select 'TRAIT_LEADER_MAJOR_CIV',		'DA_OLYMPIC_FAITH_FROM_AMENITY_'||(numbers * 2)
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into TraitModifiers(TraitType,	ModifierId)
	select 'TRAIT_LEADER_MAJOR_CIV',	'DA_OLYMPIC_GOLD_FROM_AMENITY_'||(numbers * 2)
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into TraitModifiers(TraitType,	ModifierId)
	select 'TRAIT_LEADER_MAJOR_CIV',	'DA_OLYMPIC_PRODUCTION_FROM_AMENITY_'||(numbers * 2)
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into TraitModifiers(TraitType,	ModifierId)
	select 'TRAIT_LEADER_MAJOR_CIV',	'DA_SLAVE_GLADIATUS_SCIENCE_FROM_AMENITY_'||(numbers * 2)
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into TraitModifiers(TraitType,	ModifierId)
	select 'TRAIT_LEADER_MAJOR_CIV',	'DA_SLAVE_GLADIATUS_CULTURE_FROM_AMENITY_'||(numbers * 2)
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into TraitModifiers(TraitType,	ModifierId)
	select 'TRAIT_LEADER_MAJOR_CIV',	'DA_SLAVE_GLADIATUS_LOYALTY_FROM_AMENITY_'||(numbers * 2)
    from counter where numbers >= -5 and numbers <= -1;

--剧场 政治演说
insert or replace into BuildingModifiers(BuildingType,		ModifierId) select
	'BUILDING_CITY_POLICY_POLITICAL_SPEECH',		'DA_POLITICAL_SPEECH_IDENTITY_SPREAD_'||numbers
	from counter where numbers >= 1 and numbers <= 20;




insert or replace into Modifiers
	(ModifierId,														ModifierType,												SubjectRequirementSetId)
values
--城市
	('DA_FOOD_TAX_GOLD',												'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'RS_PLOT_HAS_FOOD_IMPROVEMENTS_R'),
	('DA_FOOD_TAX_FOOD',												'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'RS_PLOT_HAS_FOOD_IMPROVEMENTS_R'),
	('DA_FOOD_TAX_EXTRA_GOLD',											'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'RS_PLOT_HAS_FOOD_IMPROVEMENTS_R_HORSEBACK_RIDING'),

	('DA_MINE_TAX_GOLD',												'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'RS_PLOT_HAS_MINE_IMPROVEMENTS_R'),
	('DA_MINE_TAX_PRODUCTION',											'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'RS_PLOT_HAS_MINE_IMPROVEMENTS_R'),
	('DA_MINE_TAX_EXTRA_GOLD',											'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'RS_PLOT_HAS_MINE_IMPROVEMENTS_R_IRON_WORKING'),

	('DA_LUXURY_TAX_RESOURCE_AMENITY',									'MODIFIER_SINGLE_CITY_ADJUST_EXTRA_AMENITY_FOR_LUXURY_DIVERSITY',	'RS_CITY_HAS_DISTRICT_COMMERCIAL_HUB'),
	('DA_LUXURY_TAX_RESOURCE_STRATEGIC',								'MODIFIER_SINGLE_CITY_ADJUST_EXTRA_ACCUMULATION',					'RS_CITY_HAS_DISTRICT_ENCAMPMENT'),

--生产
	('DA_PRODUCTION_FOCUS_POP_PRODUCTION',								'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
	('DA_PRODUCTION_FOCUS_POP_COST_FOOD',								'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
	('DA_PRODUCTION_FOCUS_LOW_GROWTH',									'MODIFIER_SINGLE_CITY_ADJUST_CITY_GROWTH',					NULL),

	('DA_FOOD_FOCUS_POP_FOOD',											'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
	('DA_FOOD_FOCUS_POP_COST_PRODUCTION',								'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
	('DA_FOOD_FOCUS_LOW_UNIT_BUILD',									'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PRODUCTION_MODIFIER',		NULL),


--沿岸海事
	--('DA_COASTAL_FISHING_FOOD',											'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',					'RS_CITY_HAS_BUILDING_CITY_POLICY_COASTAL_FISHING'),
	('DA_COASTAL_FISHING_FOOD_MOD',										'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',					'RS_CITY_HAS_BUILDING_CITY_POLICY_COASTAL_FISHING'),
	
	--('DA_SEA_SALT_GOLD',												'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',				NULL),	--'RS_CITY_HAS_BUILDING_CITY_POLICY_SEA_SALT'),
	('DA_SEA_SALT_GOLD_MOD',											'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY',					'RS_CITY_HAS_BUILDING_CITY_POLICY_SEA_SALT'),
	


--粮仓
    /*('DA_MAKE_WINE_LESS_FOOD_DEBUFF',                             	 	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',          NULL),
    ('DA_MAKE_WINE_GOLD',                                         	 	'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',              'RS_PLOT_HAS_MAKE_WINE_IMPROVEMENT'), --我在条件集写了一个新的分类，不知道是否正确
    ('DA_MAKE_WINE_GOLD_AMENITIES',                                		'MODIFIER_CITY_OWNER_ATTACH_MODIFIER',              		'RS_AT_LEAST_4_AMENITIES'), --上面分类不正确的话，这条应该也不能正确使用
    ('DA_MAKE_WINE_GOLD_AMENITIES_MOD',                                	'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',              'RS_PLOT_HAS_MAKE_WINE_IMPROVEMENT'), --上面分类不正确的话，这条应该也不能正确使用
   
    ('DA_WATER_TRANSPORT_FOOD_BUFF',                                     'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',          'RS_CITY_HAS_TRANSPORT'),
    ('DA_WATER_TRANSPORT_GOLD_DEBUFF',                                   'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',            	NULL),
 --我在ModifierType写了个新的，修改单个城市资源产出
    ('DA_WATER_TRANSPORT_FOOD_DEBUFF',                                   'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',           	 	NULL),
    ('DA_WATER_TRANSPORT_LESS_GOLD_DEBUFF',                              'MODIFIER_SINGLE_CITY_ADJUST_YIELD_CHANGE',            	'RS_CITY_HAS_DISTRICT_COMMERCIAL_HUB'),
    */
    ('DA_MAKE_WINE_AMENITIES',                                    		'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_AMENITY',          'RS_NOT_WONDER'),
    ('DA_MAKE_WINE_COST_FOOD',                                    		'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',            	'RS_NOT_WONDER'),

    ('DA_WATER_TRANSPORT_SUPPLY_FOOD',                                  'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',           		'RS_NOT_WONDER'),
    ('DA_WATER_TRANSPORT_SUPPLY_FOOD_MOD',                              'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS',  'RS_NOT_WONDER'),

    ('DA_WATER_TRANSPORT_COST_FOOD',                                  	'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',           	'RS_NOT_WONDER'),

--石工坊
    ('DA_MARBLE_CITY_AMENITIES',                                  		'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_AMENITY',          'RS_NOT_WONDER'),
    ('DA_MARBLE_CITY_COST_PRODUCTION',                                  'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',           	'RS_NOT_WONDER'),

    ('DA_BRICK_CITY_HOUSING',                                  			'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_HOUSING',          'RS_NOT_WONDER'),
    ('DA_BRICK_CITY_COST_PRODUCTION',                                  	'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',           	'RS_NOT_WONDER'),

--磨坊
    ('DA_WATER_MILL_DISTRICT_PRODUCTION',                               'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',          	'RS_RIVER_DISTRICT'),
    ('DA_WATER_MILL_DISTRICT_FOOD',                               		'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',          	'RS_RIVER_DISTRICT'),
    ('DA_WIND_MILL_DISTRICT_PRODUCTION',                                'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',           	'RS_NEAR_COAST_DISTRICT'),
    ('DA_WIND_MILL_DISTRICT_FOOD',                                		'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',           	'RS_NEAR_COAST_DISTRICT'),
    ('DA_ANIMAL_MILL_DISTRICT_PRODUCTION',                              'MODIFIER_CITY_OWNER_ATTACH_MODIFIER',           			'RS_ENOUGH_RESOURCE_HORSES'),
    ('DA_ANIMAL_MILL_DISTRICT_FOOD',                              		'MODIFIER_CITY_OWNER_ATTACH_MODIFIER',           			'RS_ENOUGH_RESOURCE_HORSES'),
    ('DA_ANIMAL_MILL_DISTRICT_PRODUCTION_MOD',                          'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',           	'RS_NOT_WONDER'),
    ('DA_ANIMAL_MILL_DISTRICT_FOOD_MOD',                          		'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',           	'RS_NOT_WONDER'),

--造纸坊
    ('DA_SILK_PAPER_CAMPUS_ADJACENCY',                               	'MODIFIER_CITY_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',         'RS_PLOT_HAS_DISTRICT_CAMPUS'),
    ('DA_SILK_PAPER_COMMERCIAL_HUB_ADJACENCY',                          'MODIFIER_CITY_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',         'RS_PLOT_HAS_DISTRICT_COMMERCIAL_HUB'),
    ('DA_SILK_PAPER_HOLY_SITE_ADJACENCY',                               'MODIFIER_CITY_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',         'RS_PLOT_HAS_DISTRICT_HOLY_SITE'),
    ('DA_SILK_PAPER_THERTER_ADJACENCY',                               	'MODIFIER_CITY_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',         'RS_PLOT_HAS_DISTRICT_THEATER'),

	('DA_HEMP_PAPER_POP_CULTURE',                                  		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',    NULL),
	('DA_HEMP_PAPER_POP_SCIENCE',                                  		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',    NULL),


--图书馆
	('DA_SCRIPTURE_COLLECTION_FAITH',                                  	'MODIFIER_BUILDING_YIELD_CHANGE',          					NULL),

--古罗马剧场
	('DA_SACRIFICE_AMPHITHEATER_MIRROR_FAITH',                          'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',            NULL),
	('DA_DRAMA_ALLOWANCE_AMPHITHEATER_MIRROR_TOURISM',                  'MODIFIER_PLAYER_DISTRICT_ADJUST_TOURISM_ADJACENCY_YIELD_MOFIFIER',            NULL),
	--('DA_POLITICAL_SPEECH_AMPHITHEATER_MIRROR_IDENTITY_SPREAD',         'MODIFIER_PLAYER_DISTRICT_ADJUST_TOURISM_ADJACENCY_YIELD_MOFIFIER',            NULL),

--神社
    ('DA_PRAY_FOR_RAIN_NO_WATER_FAITH',                                 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',            'RS_NO_WATER'),
    ('DA_SEA_SACRIFICE_NEAR_COAST_FAITH',                               'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',            'RS_NEAR_COAST'),
--    ('DA_DIVINE_DISTRICT_FAITH',                               			'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',            	  NULL),
    ('DA_DIVINE_DISTRICT_FAITH_MOD',                               		'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',     'RS_CITY_HAS_BUILDING_CITY_POLICY_DIVINE');

--竞技场   --批量写在下面了

--兵营

--马厩

update Modifiers set Permanent = 1 where ModifierId = 'DA_SCRIPTURE_COLLECTION_FAITH';



--竞技场   

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_OLYMPIC_FAITH_FROM_AMENITY_'||(numbers * 2),	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_OLYMPIC_GOLD_FROM_AMENITY_'||(numbers * 2),	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_AT_LEAST_'||(numbers * 2)||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_OLYMPIC_PRODUCTION_FROM_AMENITY_'||(numbers * 2),	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_AT_LEAST_'||(numbers * 2 )||'_AMENITIES'
    from counter where numbers >= 1 and numbers <= 5;


insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_SLAVE_GLADIATUS_SCIENCE_FROM_AMENITY_'||(numbers * 2),	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_SLAVE_GLADIATUS_CULTURE_FROM_AMENITY_'||(numbers * 2),	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_SLAVE_GLADIATUS_LOYALTY_FROM_AMENITY_'||(numbers * 2),	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_AT_MOST_'||(numbers * 2 + 1 )||'_AMENITIES'
    from counter where numbers >= -5 and numbers <= -1;




insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_OLYMPIC_FAITH_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',	'RS_CITY_HAS_BUILDING_CITY_POLICY_OLYMPIC'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_OLYMPIC_GOLD_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',	'RS_CITY_HAS_BUILDING_CITY_POLICY_OLYMPIC'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_OLYMPIC_PRODUCTION_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',	'RS_CITY_HAS_BUILDING_CITY_POLICY_OLYMPIC'
    from counter where numbers >= 1 and numbers <= 5;



insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_SLAVE_GLADIATUS_SCIENCE_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',	'RS_CITY_HAS_BUILDING_CITY_POLICY_SLAVE_GLADIATUS'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_SLAVE_GLADIATUS_CULTURE_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',	'RS_CITY_HAS_BUILDING_CITY_POLICY_SLAVE_GLADIATUS'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId)
	select 'DA_SLAVE_GLADIATUS_LOYALTY_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'MODIFIER_SINGLE_CITY_ADJUST_IDENTITY_PER_TURN',	'RS_CITY_HAS_BUILDING_CITY_POLICY_SLAVE_GLADIATUS'
    from counter where numbers >= -5 and numbers <= -1;



--图书馆 手稿收藏
insert or replace into Modifiers(ModifierId,	ModifierType, Permanent)
	select 'DA_MANUSCRIPT_COLLECTION_'||GreatPersonClassType,	'MODIFIER_BUILDING_YIELD_CHANGE', 1
	from GreatpeopleYields;

insert or replace into ModifierArguments(ModifierId,		Name,	Value)
	select 'DA_MANUSCRIPT_COLLECTION_'||GreatPersonClassType,	'YieldType',	YieldType
	from GreatpeopleYields;

insert or replace into ModifierArguments(ModifierId,		Name,	Value)
	select 'DA_MANUSCRIPT_COLLECTION_'||GreatPersonClassType,	'Amount',	Amount
	from GreatpeopleYields;
	
insert or replace into ModifierArguments(ModifierId,		Name,	Value)
	select 'DA_MANUSCRIPT_COLLECTION_'||GreatPersonClassType,	'BuildingType',	'BUILDING_CITY_POLICY_MANUSCRIPT_COLLECTION'
	from GreatpeopleYields;

--剧场 政治演说
--insert or replace into 

insert or replace into Modifiers(ModifierId,	ModifierType,		SubjectRequirementSetId,	OwnerRequirementSetId)
	select 'DA_POLITICAL_SPEECH_IDENTITY_SPREAD_'||numbers,	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_OBJECT_WITHIN_4_TILES',	'RS_IS_'||numbers||'_ADJACENCY_DISTRICT_THEATER_FIX'
    from counter where numbers >= 1 and numbers <= 20;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectStackLimit)
	select 'DA_POLITICAL_SPEECH_IDENTITY_SPREAD_'||numbers||'_MOD',	'MODIFIER_SINGLE_CITY_ADJUST_IDENTITY_PER_TURN',	1
    from counter where numbers >= 1 and numbers <= 20;


insert or ignore into RequirementSets
	(RequirementSetId,								      		RequirementSetType)
values
--城市
	('RS_PLOT_HAS_FOOD_IMPROVEMENTS_R',       		      		'REQUIREMENTSET_TEST_ALL'),
	('RS_PLOT_HAS_FOOD_IMPROVEMENTS_R_HORSEBACK_RIDING',        'REQUIREMENTSET_TEST_ALL'),
	('RS_PLOT_HAS_MINE_IMPROVEMENTS_R',       		      		'REQUIREMENTSET_TEST_ALL'),
	('RS_PLOT_HAS_MINE_IMPROVEMENTS_R_IRON_WORKING',      		'REQUIREMENTSET_TEST_ALL'),
	('RS_CITY_HAS_DISTRICT_COMMERCIAL_HUB',			      		'REQUIREMENTSET_TEST_ALL'),

--粮仓
/*	('RS_PLOT_HAS_MAKE_WINE_IMPROVEMENT',       		      	'REQUIREMENTSET_TEST_ANY'),
	('RS_PLOT_HAS_MAKE_WINE_IMPROVEMENT_AMENITIES',			    'REQUIREMENTSET_TEST_ALL'),

	('RS_CITY_HAS_TRANSPORT',       		      	            'REQUIREMENTSET_TEST_ALL'),
*/


	('RS_CITY_NO_7_POP_AND_WITHIN_5_TILES',			    		'REQUIREMENTSET_TEST_ALL'),

--图书馆
	--('RS_CITY_HAS_DISTRICT_HOLY_SITE',			      		    'REQUIREMENTSET_TEST_ALL'),  --e不需要，条件文件已经定义了
	('RS_CITY_HAS_PALACE_OR_DISTRICT_GOVERNMENT',       		    'REQUIREMENTSET_TEST_ALL'),

--古罗马剧场

--竞技场

--兵营
	('RS_CITY_HAS_IMPROVED_IRON_OR_DISTRICT_INDUSTRIAL_ZONE',   'REQUIREMENTSET_TEST_ANY'),
	
--马厩
	('RS_CITY_HAS_IMPROVED_HORSE_OR_DISTRICT_ENTERTAINMENT_COMPLEX', 'REQUIREMENTSET_TEST_ANY');



	
insert or ignore into RequirementSetRequirements
	(RequirementSetId,								 		RequirementId)
values
--城市
	('RS_PLOT_HAS_FOOD_IMPROVEMENTS_R',       		 		'REQ_PLOT_HAS_FOOD_IMPROVEMENT'),
	('RS_PLOT_HAS_FOOD_IMPROVEMENTS_R',       		 		'REQ_PLOT_HAS_RESOURCE'),

	('RS_PLOT_HAS_FOOD_IMPROVEMENTS_R_HORSEBACK_RIDING',    'REQ_PLOT_HAS_FOOD_IMPROVEMENT'),
	('RS_PLOT_HAS_FOOD_IMPROVEMENTS_R_HORSEBACK_RIDING',    'REQ_PLAYER_HAS_TECH_HORSEBACK_RIDING'),
	('RS_PLOT_HAS_FOOD_IMPROVEMENTS_R_HORSEBACK_RIDING',    'REQ_PLOT_HAS_RESOURCE'),

	('RS_PLOT_HAS_MINE_IMPROVEMENTS_R',       		 		'REQ_PLOT_HAS_MINE_IMPROVEMENT'),
	('RS_PLOT_HAS_MINE_IMPROVEMENTS_R',       		 		'REQ_PLOT_HAS_RESOURCE'),

	('RS_PLOT_HAS_MINE_IMPROVEMENTS_R_IRON_WORKING', 		'REQ_PLOT_HAS_MINE_IMPROVEMENT'),
	('RS_PLOT_HAS_MINE_IMPROVEMENTS_R_IRON_WORKING', 		'REQ_PLAYER_HAS_TECH_IRON_WORKING'),
	('RS_PLOT_HAS_MINE_IMPROVEMENTS_R_IRON_WORKING', 		'REQ_PLOT_HAS_RESOURCE'),

	('RS_CITY_HAS_DISTRICT_COMMERCIAL_HUB',		    		'REQ_CITY_HAS_DISTRICT_COMMERCIAL_HUB'),

--粮仓
	/*('RS_PLOT_HAS_MAKE_WINE_IMPROVEMENT',       	 		'REQ_PLOT_HAS_MAKE_WINE_IMPROVEMENT'),
	('RS_PLOT_HAS_MAKE_WINE_IMPROVEMENT_AMENITIES',       	'REQ_PLOT_HAS_MAKE_WINE_IMPROVEMENT'),
	('RS_PLOT_HAS_MAKE_WINE_IMPROVEMENT_AMENITIES',       	'REQ_AT_LEAST_4_AMENITIES'),	
	
	('RS_CITY_HAS_TRANSPORT',               	    	  	'REQ_CITY_NO_7_POPULATION'),  --没看见条件反向，先写个7人口，反向了就是7人口以下的城市才触发
	('RS_CITY_HAS_TRANSPORT',                  	  	     	'REQ_CITY_HAS_BUILDING_CITY_POLICY_WATER_TRANSPORT'),  --报错，没有这个建筑，奇怪了  --e。现在补在下面了
*/
	('RS_CITY_NO_7_POP_AND_WITHIN_5_TILES',		   			'REQ_CITY_NO_7_POPULATION'),
	('RS_CITY_NO_7_POP_AND_WITHIN_5_TILES',		   			'REQ_OBJECT_WITHIN_5_TILES'),

--图书馆
	--('RS_CITY_HAS_DISTRICT_HOLY_SITE',		    		  	'REQ_CITY_HAS_DISTRICT_HOLY_SITE'),
	('RS_CITY_HAS_PALACE_OR_DISTRICT_GOVERNMENT',		   	'REQ_CITY_HAS_BUILDING_PALACE'),
	('RS_CITY_HAS_PALACE_OR_DISTRICT_GOVERNMENT',		    'REQ_CITY_HAS_DISTRICT_GOVERNMENT'),	
--古罗马剧场

--神社



--竞技场

--兵营 REQ_CITY_HAS_IMPROVED_
	('RS_CITY_HAS_IMPROVED_IRON_OR_DISTRICT_INDUSTRIAL_ZONE','REQ_CITY_HAS_DISTRICT_INDUSTRIAL_ZONE'),
	('RS_CITY_HAS_IMPROVED_IRON_OR_DISTRICT_INDUSTRIAL_ZONE','REQ_CITY_HAS_IMPROVED_RESOURCE_IRON'),

    --('RS_CITY_HAS_IMPROVEMENTS_IRON',               	    'REQUIREMENT_PLOT_RESOURCE_TAG_MATCHES');  没看到条件集有城市有某一资源，我就不乱加了

--马厩


	('RS_CITY_HAS_IMPROVED_HORSE_OR_DISTRICT_ENTERTAINMENT_COMPLEX',          'REQ_CITY_HAS_DISTRICT_ENTERTAINMENT_COMPLEX'),
	('RS_CITY_HAS_IMPROVED_HORSE_OR_DISTRICT_ENTERTAINMENT_COMPLEX',          'REQ_CITY_HAS_IMPROVED_RESOURCE_HORSES');


    --('RS_CITY_HAS_IMPROVEMENTS_HORSES',               	    'REQUIREMENT_PLOT_RESOURCE_TAG_MATCHES');  没看到条件集有城市有某一资源，我就不乱加了
/*
--是否有某城市政策	REQ/RS
insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_CITY_HAS_'||BuildingType, 'REQUIREMENT_CITY_HAS_BUILDING'
from CityPolicies;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_CITY_HAS_'||BuildingType, 'BuildingType', BuildingType
from CityPolicies;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'RS_CITY_HAS_'||BuildingType,				'REQUIREMENTSET_TEST_ALL'
from CityPolicies;                                

insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'RS_CITY_HAS_'||BuildingType,				'REQ_CITY_HAS_'||BuildingType
from CityPolicies;
*/
	
insert or replace into ModifierArguments
	(ModifierId,													Name,						Value)
values
--城市
	('DA_FOOD_TAX_GOLD',											'YieldType',				'YIELD_GOLD'),
	('DA_FOOD_TAX_GOLD',											'Amount',					'2'),
	('DA_FOOD_TAX_FOOD',											'YieldType',				'YIELD_FOOD'),
	('DA_FOOD_TAX_FOOD',											'Amount',					'-1'),
	('DA_FOOD_TAX_EXTRA_GOLD',										'YieldType',				'YIELD_GOLD'),
	('DA_FOOD_TAX_EXTRA_GOLD',										'Amount',					'2'),

	('DA_MINE_TAX_GOLD',											'YieldType',				'YIELD_GOLD'),
	('DA_MINE_TAX_GOLD',											'Amount',					'3'),
	('DA_MINE_TAX_PRODUCTION',										'YieldType',				'YIELD_PRODUCTION'),
	('DA_MINE_TAX_PRODUCTION',										'Amount',					'-1'),
	('DA_MINE_TAX_EXTRA_GOLD',										'YieldType',				'YIELD_GOLD'),
	('DA_MINE_TAX_EXTRA_GOLD',										'Amount',					'1'),

	('DA_LUXURY_TAX_RESOURCE_AMENITY',								'Amount',					'1'),
	('DA_LUXURY_TAX_RESOURCE_STRATEGIC',							'Amount',					'1'),

--生产 
	('DA_PRODUCTION_FOCUS_POP_PRODUCTION',										'YieldType',				'YIELD_PRODUCTION'),
	('DA_PRODUCTION_FOCUS_POP_PRODUCTION',										'Amount',					'1'),
	('DA_PRODUCTION_FOCUS_POP_COST_FOOD',										'YieldType',				'YIELD_FOOD'),
	('DA_PRODUCTION_FOCUS_POP_COST_FOOD',										'Amount',					'-1'),
	('DA_PRODUCTION_FOCUS_LOW_GROWTH',											'Amount',					'-50'),

	('DA_FOOD_FOCUS_POP_FOOD',													'YieldType',				'YIELD_FOOD'),
	('DA_FOOD_FOCUS_POP_FOOD',													'Amount',					'1'),
	('DA_FOOD_FOCUS_POP_COST_PRODUCTION',										'YieldType',				'YIELD_PRODUCTION'),
	('DA_FOOD_FOCUS_POP_COST_PRODUCTION',										'Amount',					'-1'),
	('DA_FOOD_FOCUS_LOW_UNIT_BUILD',											'Amount',					'-50'),


--沿海海事
    ('DA_COASTAL_FISHING_FOOD_MOD',                 'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('DA_COASTAL_FISHING_FOOD_MOD',                 'Amount',                   1),
    ('DA_COASTAL_FISHING_FOOD_MOD',                 'TerrainType',              'TERRAIN_COAST'),
    ('DA_COASTAL_FISHING_FOOD_MOD',                 'YieldType',                'YIELD_FOOD'),
    ('DA_COASTAL_FISHING_FOOD_MOD',                 'Description',              'LOC_COASTAL_FISHING_FOOD'),
    ('DA_COASTAL_FISHING_FOOD_MOD',                 'TilesRequired',            1),
   -- ('DA_COASTAL_FISHING_FOOD',             'ModifierId',            	'DA_COASTAL_FISHING_FOOD_MOD'),

    ('DA_SEA_SALT_GOLD_MOD',                 'DistrictType',             'DISTRICT_CITY_CENTER'),
    ('DA_SEA_SALT_GOLD_MOD',                 'Amount',                   3),
    ('DA_SEA_SALT_GOLD_MOD',                 'TerrainType',              'TERRAIN_COAST'),
    ('DA_SEA_SALT_GOLD_MOD',                 'YieldType',                'YIELD_GOLD'),
    ('DA_SEA_SALT_GOLD_MOD',                 'Description',              'LOC_SEA_SALT_GOLD'),
    ('DA_SEA_SALT_GOLD_MOD',                 'TilesRequired',            1),
   -- ('DA_SEA_SALT_GOLD',             'ModifierId',               'DA_SEA_SALT_GOLD_MOD'),

--粮仓
	/*('DA_MAKE_WINE_LESS_FOOD_DEBUFF',								'YieldType',				'YIELD_FOOD'),
	('DA_MAKE_WINE_LESS_FOOD_DEBUFF',								'Amount',					'-10'),
	('DA_MAKE_WINE_GOLD',											'YieldType',				'YIELD_GOLD'),
	('DA_MAKE_WINE_GOLD',											'Amount',					'2'),
	('DA_MAKE_WINE_GOLD_AMENITIES',									'ModifierId',				'DA_MAKE_WINE_GOLD_AMENITIES_MOD'),
	('DA_MAKE_WINE_GOLD_AMENITIES_MOD',								'YieldType',				'YIELD_GOLD'),
	('DA_MAKE_WINE_GOLD_AMENITIES_MOD',								'Amount',					'2'),

	('DA_WATER_TRANSPORT_FOOD_BUFF',						    		'YieldType',		'YIELD_FOOD'),
	('DA_WATER_TRANSPORT_FOOD_BUFF',						    		'Amount',			'2'),
	('DA_WATER_TRANSPORT_GOLD_DEBUFF',									'YieldType',			'YIELD_GOLD'),
	('DA_WATER_TRANSPORT_GOLD_DEBUFF',									'Amount',				'-4'),
	('DA_WATER_TRANSPORT_FOOD_DEBUFF',									'YieldType',			'YIELD_FOOD'),
	('DA_WATER_TRANSPORT_FOOD_DEBUFF',									'Amount',				'-4'),
	('DA_WATER_TRANSPORT_LESS_GOLD_DEBUFF',								'YieldType',			'YIELD_GOLD'),
	('DA_WATER_TRANSPORT_LESS_GOLD_DEBUFF',								'Amount',				'4'),
*/
	('DA_MAKE_WINE_COST_FOOD',										'YieldType',				'YIELD_FOOD'),
	('DA_MAKE_WINE_COST_FOOD',										'Amount',					-2),
	('DA_MAKE_WINE_AMENITIES',										'Amount',					'1'),

	('DA_WATER_TRANSPORT_COST_FOOD',								'YieldType',				'YIELD_FOOD'),
	('DA_WATER_TRANSPORT_COST_FOOD',								'Amount',					-2),
	('DA_WATER_TRANSPORT_SUPPLY_FOOD',								'ModifierId',				'DA_WATER_TRANSPORT_SUPPLY_FOOD_MOD'),
	('DA_WATER_TRANSPORT_SUPPLY_FOOD_MOD',							'Amount',					1),
	('DA_WATER_TRANSPORT_SUPPLY_FOOD_MOD',							'YieldType',				'YIELD_FOOD'),
	('DA_WATER_TRANSPORT_SUPPLY_FOOD_MOD',							'Domestic',					1),
--石工坊
	('DA_MARBLE_CITY_AMENITIES',									'Amount',					'1'),
	('DA_MARBLE_CITY_COST_PRODUCTION',								'YieldType',				'YIELD_PRODUCTION'),
	('DA_MARBLE_CITY_COST_PRODUCTION',								'Amount',					-2),

	('DA_BRICK_CITY_HOUSING',										'Amount',					'1'),
	('DA_BRICK_CITY_COST_PRODUCTION',								'YieldType',				'YIELD_PRODUCTION'),
	('DA_BRICK_CITY_COST_PRODUCTION',								'Amount',					-1),

--磨坊
	('DA_WATER_MILL_DISTRICT_PRODUCTION',							'YieldType',				'YIELD_PRODUCTION'),
	('DA_WATER_MILL_DISTRICT_PRODUCTION',							'Amount',					1),
	('DA_WATER_MILL_DISTRICT_FOOD',									'YieldType',				'YIELD_FOOD'),
	('DA_WATER_MILL_DISTRICT_FOOD',									'Amount',					1),

	('DA_WATER_MILL_DISTRICT_PRODUCTION',							'YieldType',				'YIELD_PRODUCTION'),
	('DA_WATER_MILL_DISTRICT_PRODUCTION',							'Amount',					1),
	('DA_WATER_MILL_DISTRICT_FOOD',									'YieldType',				'YIELD_FOOD'),
	('DA_WATER_MILL_DISTRICT_FOOD',									'Amount',					1),


	('DA_WIND_MILL_DISTRICT_PRODUCTION',							'YieldType',				'YIELD_PRODUCTION'),
	('DA_WIND_MILL_DISTRICT_PRODUCTION',							'Amount',					1),
	('DA_WIND_MILL_DISTRICT_FOOD',									'YieldType',				'YIELD_FOOD'),
	('DA_WIND_MILL_DISTRICT_FOOD',									'Amount',					1),

	('DA_ANIMAL_MILL_DISTRICT_PRODUCTION',							'ModifierId',				'DA_ANIMAL_MILL_DISTRICT_PRODUCTION_MOD'),
	('DA_ANIMAL_MILL_DISTRICT_PRODUCTION_MOD',						'YieldType',				'YIELD_PRODUCTION'),
	('DA_ANIMAL_MILL_DISTRICT_PRODUCTION_MOD',						'Amount',					1),
	('DA_ANIMAL_MILL_DISTRICT_FOOD',								'ModifierId',				'DA_ANIMAL_MILL_DISTRICT_FOOD_MOD'),
	('DA_ANIMAL_MILL_DISTRICT_FOOD_MOD',							'YieldType',				'YIELD_FOOD'),
	('DA_ANIMAL_MILL_DISTRICT_FOOD_MOD',							'Amount',					1),

--造纸坊
	('DA_SILK_PAPER_CAMPUS_ADJACENCY',								'YieldType',				'YIELD_SCIENCE'),
	('DA_SILK_PAPER_CAMPUS_ADJACENCY',								'Amount',					'1'),
	('DA_SILK_PAPER_COMMERCIAL_HUB_ADJACENCY',						'YieldType',				'YIELD_GOLD'),
	('DA_SILK_PAPER_COMMERCIAL_HUB_ADJACENCY',						'Amount',					'1'),
	('DA_SILK_PAPER_HOLY_SITE_ADJACENCY',							'YieldType',				'YIELD_FAITH'),
	('DA_SILK_PAPER_HOLY_SITE_ADJACENCY',							'Amount',					'1'),
	('DA_SILK_PAPER_THERTER_ADJACENCY',								'YieldType',				'YIELD_CULTURE'),
	('DA_SILK_PAPER_THERTER_ADJACENCY',								'Amount',					'1'),

	('DA_HEMP_PAPER_POP_CULTURE',									'YieldType',				'YIELD_CULTURE'),
	('DA_HEMP_PAPER_POP_CULTURE',									'Amount',					'0.3'),
	('DA_HEMP_PAPER_POP_SCIENCE',									'YieldType',				'YIELD_SCIENCE'),
	('DA_HEMP_PAPER_POP_SCIENCE',									'Amount',					'0.3'),

--图书馆
	('DA_SCRIPTURE_COLLECTION_FAITH',						    		'YieldType',			'YIELD_FAITH'),
	('DA_SCRIPTURE_COLLECTION_FAITH',						    		'Amount',				'2'),
	('DA_SCRIPTURE_COLLECTION_FAITH',						    		'BuildingType',			'BUILDING_CITY_POLICY_SCRIPTURE_COLLECTION'),

	
--古罗马剧场
	('DA_SACRIFICE_AMPHITHEATER_MIRROR_FAITH',							'YieldTypeToGrant',		'YIELD_FAITH'),
	('DA_SACRIFICE_AMPHITHEATER_MIRROR_FAITH',							'YieldTypeToMirror',	'YIELD_CULTURE'),
	('DA_DRAMA_ALLOWANCE_AMPHITHEATER_MIRROR_TOURISM',					'Amount',				100),
	('DA_DRAMA_ALLOWANCE_AMPHITHEATER_MIRROR_TOURISM',					'YieldType',			'YIELD_CULTURE'),


--神社
	('DA_PRAY_FOR_RAIN_NO_WATER_FAITH', 								'YieldType', 	'YIELD_FAITH'),
	('DA_PRAY_FOR_RAIN_NO_WATER_FAITH', 								'Amount', 		'1'),
	('DA_SEA_SACRIFICE_NEAR_COAST_FAITH', 								'YieldType', 	'YIELD_FAITH'),
	('DA_SEA_SACRIFICE_NEAR_COAST_FAITH', 								'Amount', 		'1'),
--	('DA_DIVINE_DISTRICT_FAITH', 										'ModifierId', 	'DA_DIVINE_DISTRICT_FAITH_MOD'),
	('DA_DIVINE_DISTRICT_FAITH_MOD', 									'YieldType', 	'YIELD_FAITH'),
	('DA_DIVINE_DISTRICT_FAITH_MOD', 									'Amount', 		'1');



--竞技场


--兵营


--马厩

--竞技场

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_OLYMPIC_FAITH_FROM_AMENITY_'||(numbers * 2),	'ModifierId',	'DA_OLYMPIC_FAITH_FROM_AMENITY_'||(numbers * 2)||'_MOD'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_OLYMPIC_GOLD_FROM_AMENITY_'||(numbers * 2),	'ModifierId',	'DA_OLYMPIC_GOLD_FROM_AMENITY_'||(numbers * 2)||'_MOD'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_OLYMPIC_PRODUCTION_FROM_AMENITY_'||(numbers * 2),	'ModifierId',	'DA_OLYMPIC_PRODUCTION_FROM_AMENITY_'||(numbers * 2)||'_MOD'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_SLAVE_GLADIATUS_SCIENCE_FROM_AMENITY_'||(numbers * 2),	'ModifierId',	'DA_SLAVE_GLADIATUS_SCIENCE_FROM_AMENITY_'||(numbers * 2)||'_MOD'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_SLAVE_GLADIATUS_CULTURE_FROM_AMENITY_'||(numbers * 2),	'ModifierId',	'DA_SLAVE_GLADIATUS_CULTURE_FROM_AMENITY_'||(numbers * 2)||'_MOD'
    from counter where numbers >= -5 and numbers <= -1;
    
insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_SLAVE_GLADIATUS_LOYALTY_FROM_AMENITY_'||(numbers * 2),	'ModifierId',	'DA_SLAVE_GLADIATUS_LOYALTY_FROM_AMENITY_'||(numbers * 2)||'_MOD'
    from counter where numbers >= -5 and numbers <= -1;





insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_OLYMPIC_FAITH_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'YieldType',	'YIELD_FAITH'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_OLYMPIC_FAITH_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'Amount',	6
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_OLYMPIC_GOLD_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'YieldType',	'YIELD_GOLD'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_OLYMPIC_GOLD_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'Amount',	6
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_OLYMPIC_PRODUCTION_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'YieldType',	'YIELD_PRODUCTION'
    from counter where numbers >= 1 and numbers <= 5;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_OLYMPIC_PRODUCTION_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'Amount',	6
    from counter where numbers >= 1 and numbers <= 5;



insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_SLAVE_GLADIATUS_SCIENCE_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'YieldType',	'YIELD_SCIENCE'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_SLAVE_GLADIATUS_SCIENCE_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'Amount',	6
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_SLAVE_GLADIATUS_CULTURE_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'YieldType',	'YIELD_CULTURE'
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_SLAVE_GLADIATUS_CULTURE_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'Amount',	6
    from counter where numbers >= -5 and numbers <= -1;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_SLAVE_GLADIATUS_LOYALTY_FROM_AMENITY_'||(numbers * 2)||'_MOD',	'Amount',	-4
    from counter where numbers >= -5 and numbers <= -1;

--剧场 政治演说


insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_POLITICAL_SPEECH_IDENTITY_SPREAD_'||numbers,	'ModifierId',	'DA_POLITICAL_SPEECH_IDENTITY_SPREAD_'||numbers||'_MOD'
    from counter where numbers >= 1 and numbers <= 20;

insert or replace into ModifierArguments(ModifierId,			Name,						Value)
	select 'DA_POLITICAL_SPEECH_IDENTITY_SPREAD_'||numbers||'_MOD',		'Amount',					1
    from counter where numbers >= 1 and numbers <= 20;






