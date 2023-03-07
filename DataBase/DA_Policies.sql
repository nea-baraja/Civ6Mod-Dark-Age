

-- 纪律改为+4蛮子力,城市范围6格内再加4力
update ModifierArguments set Value = 4 where ModifierId = 'DISCIPLINE_BARBARIANCOMBAT' and Name = 'Amount';
-- 君主崇拜 1金1鸽改为2鸽
delete from PolicyModifiers where PolicyType = 'POLICY_GOD_KING' and ModifierId = 'GOD_KING_GOLD';
update ModifierArguments set Value = 2 where ModifierId = 'GOD_KING_FAITH' and Name = 'Amount';
-- 服役建造者加速 50改为30
update ModifierArguments set Value = 30 where ModifierId = 'ILKUM_BUILDERPRODUCTION' and Name = 'Amount';
-- 强迫劳役 奇观加速 15改30
update ModifierArguments set Value = 30 where ModifierId = 'CORVEE_ANCIENTCLASSICALWONDER' and Name = 'Amount';
-- 删除土地调查员
delete from Policies where PolicyType = 'POLICY_LAND_SURVEYORS';
-- 殖民初始开拓者加速改为25
update ModifierArguments set Value = 25 where ModifierId = 'COLONIZATION_SETTLERPRODUCTION' and Name = 'Amount';
-- 魅力领袖改名为出使，影响力点数改3
update ModifierArguments set Value = 3 where ModifierId = 'CHARISMATICLEADER_INFLUENCEPOINTS' and Name = 'Amount';
-- 外交联盟删了
delete from Policies where PolicyType = 'POLICY_DIPLOMATIC_LEAGUE';
-- 楼房删了
delete from Policies where PolicyType = 'POLICY_INSULAE';
-- 司令部删了
delete from Policies where PolicyType = 'POLICY_PRAETORIUM';
-- 骑士阶级改名战略储备，从军事训练改防御战术
update Policies set PrereqCivic = 'CIVIC_DEFENSIVE_TACTICS' where PolicyType = 'POLICY_EQUESTRIAN_ORDERS';
--边防军改效果
delete from PolicyModifiers where PolicyType = 'POLICY_LIMITANEI';

--delete from PolicyModifiers where PolicyType = 'POLICY_INSPIRATION';

update Policies set PrereqCivic = null where PolicyType in ( 'POLICY_GOD_KING', 'POLICY_SURVEY');


insert or replace into PolicyModifiers
	(PolicyType,						ModifierId)
values
	('POLICY_DISCIPLINE',				'DISCIPLINE_EXTRA_BARBARIANCOMBAT'),   --城市范围6格内再加4力
	('POLICY_SURVEY',					'SURVEY_RECONUNIT_HEAL'),   --调查侦察单位+10生命恢复
	('POLICY_CARAVANSARIES',			'CARAVANSARIES_MERCHANT_POINTS'),   --商队旅馆加大商点
	('POLICY_CORVEE',					'CORVEE_SUB_AMENITY'),   --强迫劳役减2宜居度
	('POLICY_COLONIZATION',				'COLONIZATION_SETTLERPRODUCTION_PLUS'),   --殖民在6人口后额外25开拓者加速
	--('POLICY_STRATEGOS',				'STRATEGOS_GREATGENERALPOINTS_PERCENT'),   --将军卡给高相邻军营城市加大将军点百分比
	--('POLICY_INSPIRATION',				'INSPIRATION_GREATSCIENTISTPOINTS_PERCENT'),   --启示给高相邻学院城市加大科点百分比
	--('POLICY_REVELATION',				'REVELATION_GREATPROPHETPOINTS_PERCENT'),   --那啥给高相邻圣地城市加大仙点百分比
	('POLICY_CHARISMATIC_LEADER',		'CHARISMATICLEADER_OPENBORDERS'),	--出使 开城邦边境
	--('POLICY_LITERARY_TRADITION',		'LITERARY_GREATWRITERPOINTS_PERCENT'),	--文学传统那啥，同上
--	('POLICY_EQUESTRIAN_ORDERS',		'EQUESTRIAN_ORDERS_EXTRA_IRON'),	-- 战略储备给收资源税额外加铁
--	('POLICY_EQUESTRIAN_ORDERS',		'EQUESTRIAN_ORDERS_EXTRA_HORSE'),	-- 同上
	('POLICY_LIMITANEI',				'LIMITANEI_UNITS_SPREAD_LOYALTY');	-- 三层套娃，战斗单位给三格内城+2忠诚

insert or replace into Modifiers
	(ModifierId,									ModifierType,											SubjectRequirementSetId)
values
	('DISCIPLINE_EXTRA_BARBARIANCOMBAT',			'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',				NULL),
	('DISCIPLINE_EXTRA_BARBARIANCOMBAT_MOD',		'MODIFIER_PLAYER_UNITS_ADJUST_BARBARIAN_COMBAT',		'RS_OBJECT_WITHIN_6_TILES'),
	('SURVEY_RECONUNIT_HEAL',						'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN',			'SURVEY_RECONUNITEXPERIENCE_REQUIREMENTS'),
	('CARAVANSARIES_MERCHANT_POINTS',				'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',			NULL),
	('CORVEE_SUB_AMENITY',							'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY',			NULL),
	('COLONIZATION_SETTLERPRODUCTION_PLUS',			'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION',			'RS_CITY_HAS_6_POPULATION'),   --
	--('STRATEGOS_GREATGENERALPOINTS_PERCENT',		'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT_BONUS',	'RS_DISTRICT_'),   --
	--('INSPIRATION_GREATSCIENTISTPOINTS_PERCENT',	'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT_BONUS',	NULL),--'RS_CITY_HAS_3_ADJACENCY_DISTRICT_CAMPUS'),   --
	--('REVELATION_GREATPROPHETPOINTS_PERCENT',		'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT_BONUS',	'RS_CITY_HAS_3_ADJACENCY_DISTRICT_HOLY_SITE'),  --
	('CHARISMATICLEADER_OPENBORDERS',				'MODIFIER_ADJUST_OPEN_BORDERS_FROM_INFLUENCE',			NUll),
	--('LITERARY_GREATWRITERPOINTS_PERCENT',			'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT_BONUS',	'RS_CITY_HAS_3_ADJACENCY_DISTRICT_THEATER'),  --
	('EQUESTRIAN_ORDERS_EXTRA_IRON',				'MODIFIER_PLAYER_CITIES_ADJUST_EXTRA_ACCUMULATION_SPECIFIC_RESOURCE',	'RS_CITY_HAS_BUILDING_CITY_POLICY_LUXURY_TAX'),
	('EQUESTRIAN_ORDERS_EXTRA_HORSE',				'MODIFIER_PLAYER_CITIES_ADJUST_EXTRA_ACCUMULATION_SPECIFIC_RESOURCE',	'RS_CITY_HAS_BUILDING_CITY_POLICY_LUXURY_TAX'),  
	('LIMITANEI_UNITS_SPREAD_LOYALTY',				'MODIFIER_ALL_UNITS_ATTACH_MODIFIER',					'RS_UNIT_IS_CLASS_MILITARY'),  
	('LIMITANEI_SPREAD_LOYALTY',					'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',				'RS_OBJECT_WITHIN_3_TILES'),  
	('LIMITANEI_LOYALTY_FROM_UNITS',				'MODIFIER_SINGLE_CITY_ADJUST_IDENTITY_PER_TURN',		NULL);

update Modifiers set SubjectStackLimit = 1 where ModifierId = 'DISCIPLINE_EXTRA_BARBARIANCOMBAT_MOD';


insert or replace into ModifierArguments
	(ModifierId,											Name,					Value)
values
	('DISCIPLINE_EXTRA_BARBARIANCOMBAT',					'ModifierId',			'DISCIPLINE_EXTRA_BARBARIANCOMBAT_MOD'),
	('DISCIPLINE_EXTRA_BARBARIANCOMBAT_MOD',				'Amount',				4),		
	('SURVEY_RECONUNIT_HEAL',								'Amount',				5),
	('SURVEY_RECONUNIT_HEAL',								'Type',					'ALL'),	
	('CARAVANSARIES_MERCHANT_POINTS',						'Amount',				2),
	('CARAVANSARIES_MERCHANT_POINTS',						'GreatPersonClassType',	'GREAT_PERSON_CLASS_MERCHANT'),
	('CORVEE_SUB_AMENITY',									'Amount',				-2),
	('COLONIZATION_SETTLERPRODUCTION_PLUS',					'UnitType',				'UNIT_SETTLER'),   
	('COLONIZATION_SETTLERPRODUCTION_PLUS',					'Amount',				'25'),   
	--('STRATEGOS_GREATGENERALPOINTS_PERCENT',				'Amount',				'50'),   
	--('INSPIRATION_GREATSCIENTISTPOINTS_PERCENT',			'Amount',				'50'),   
	--('INSPIRATION_GREATSCIENTISTPOINTS_PERCENT',			'GreatPersonClassType',		'GREAT_PERSON_CLASS_SCIENTIST'),   
	--('REVELATION_GREATPROPHETPOINTS_PERCENT',				'Amount',				'50'),
	('EQUESTRIAN_ORDERS_EXTRA_IRON',						'Amount',				'1'),   
	('EQUESTRIAN_ORDERS_EXTRA_IRON',						'ResourceType',			'RESOURCE_IRON'),   
	('EQUESTRIAN_ORDERS_EXTRA_HORSE',						'Amount',				'1'),
	('EQUESTRIAN_ORDERS_EXTRA_HORSE',						'ResourceType',			'RESOURCE_HORSE'),
	('LIMITANEI_UNITS_SPREAD_LOYALTY',						'ModifierId',			'LIMITANEI_SPREAD_LOYALTY'),
	('LIMITANEI_SPREAD_LOYALTY',							'ModifierId',			'LIMITANEI_LOYALTY_FROM_UNITS'),
	('LIMITANEI_LOYALTY_FROM_UNITS',						'Amount',				'2');

-- 新增政策
insert or replace into Types
	(Type,									Kind)
values
	('POLICY_BLOOD_SACRIFICE',				'KIND_POLICY'), --血祭传统
	('POLICY_LOCAL_MAP',					'KIND_POLICY'), --本地地图
	('POLICY_LAND_MEASURE',					'KIND_POLICY'), --丈量土地

	('POLICY_CAPITAL',						'KIND_POLICY'), --都城
	('POLICY_COASTAL_SURVEY',				'KIND_POLICY'), --沿海调查
	('POLICY_COOPERATIVE_COMBAT',			'KIND_POLICY'),	--协同作战
	('POLICY_TRIBUTE',						'KIND_POLICY'),	--朝贡
	--('POLICY_TRIUMPH',						'KIND_POLICY'),	--凯旋式
	('POLICY_HEDONISM',						'KIND_POLICY'),	--享乐主义
	('POLICY_TRANSLATION',					'KIND_POLICY'),	--翻译
	('POLICY_ARMY_FARM',					'KIND_POLICY');	--军屯

insert or replace into Policies
	(PolicyType,							Name,											Description,											PrereqCivic,								PrereqTech,					GovernmentSlotType)
values	
	('POLICY_BLOOD_SACRIFICE',				'LOC_POLICY_BLOOD_SACRIFICE_NAME',				'LOC_POLICY_BLOOD_SACRIFICE_DESCRIPTION',				'CIVIC_NATIVE_LAND',						null,						'SLOT_MILITARY'),
	('POLICY_LOCAL_MAP',					'LOC_POLICY_LOCAL_MAP_NAME',					'LOC_POLICY_LOCAL_MAP_DESCRIPTION',						'CIVIC_NATIVE_LAND',						null,						'SLOT_MILITARY'),
    ('POLICY_LAND_MEASURE',           		'LOC_POLICY_LAND_MEASURE_NAME',           		'LOC_POLICY_LAND_MEASURE_DESCRIPTION',            		'CIVIC_CRAFTSMANSHIP',               		null,                       'SLOT_ECONOMIC'),
 

	('POLICY_CAPITAL',						'LOC_POLICY_CAPITAL_NAME',						'LOC_POLICY_CAPITAL_DESCRIPTION',						'CIVIC_CRAFTSMANSHIP',						null,						'SLOT_ECONOMIC'),
	('POLICY_COOPERATIVE_COMBAT',			'LOC_POLICY_COOPERATIVE_COMBAT_NAME',			'LOC_POLICY_COOPERATIVE_COMBAT_DESCRIPTION',			'CIVIC_MILITARY_TRADITION',					null,						'SLOT_MILITARY'),
    ('POLICY_TRIBUTE',           			'LOC_POLICY_TRIBUTE_NAME',           			'LOC_POLICY_TRIBUTE_DESCRIPTION',            			'CIVIC_POLITICAL_PHILOSOPHY',               null,                       'SLOT_DIPLOMATIC'),
    --('POLICY_TRIUMPH',           			'LOC_POLICY_TRIUMPH_NAME',           			'LOC_POLICY_TRIUMPH_DESCRIPTION',            			'CIVIC_GAMES_RECREATION',                 	null,                       'SLOT_MILITARY'),
    ('POLICY_HEDONISM',           			'LOC_POLICY_HEDONISM_NAME',           			'LOC_POLICY_HEDONISM_DESCRIPTION',            			'CIVIC_GAMES_RECREATION',                   null,                       'SLOT_ECONOMIC'),
    ('POLICY_COASTAL_SURVEY',           	'LOC_POLICY_COASTAL_SURVEY_NAME',           	'LOC_POLICY_COASTAL_SURVEY_DESCRIPTION',            	'CIVIC_FOREIGN_TRADE',                 		null,                       'SLOT_MILITARY'),
    ('POLICY_TRANSLATION',           		'LOC_POLICY_TRANSLATION_NAME',           		'LOC_POLICY_TRANSLATION_DESCRIPTION',            		'CIVIC_DRAMA_POETRY',                 		null,                       'SLOT_DIPLOMATIC'),
    ('POLICY_ARMY_FARM',           			'LOC_POLICY_ARMY_FARM_NAME',           			'LOC_POLICY_ARMY_FARM_DESCRIPTION',            			'CIVIC_MILITARY_TRAINING',                 	null,                       'SLOT_MILITARY');

insert or replace into PolicyModifiers
	(PolicyType,						ModifierId)
values
	('POLICY_BLOOD_SACRIFICE',			'BLOOD_SACRIFICE_COMBAT_FAITH'),
	--('POLICY_LOCAL_MAP',				'LOCAL_MAP_ADD_MOVEMENT'),
	('POLICY_LOCAL_MAP',				'LOCAL_MAP_IGNORE_TERRAIN'),
	('POLICY_LAND_MEASURE',				'LAND_MEASURE_FOOD'),


	('POLICY_CAPITAL',					'P_CAPITAL_DISTRICT_PRODUCTION'),   --首都 区域加速25
	('POLICY_CAPITAL',					'P_CAPITAL_FIRST_DISTRICT_PRODUCTION'),   --首都 第一个区域再加速25
	('POLICY_COOPERATIVE_COMBAT',		'COOPERATIVE_COMBAT_FLANKING'),   --协同作战 夹击50加成
	('POLICY_COOPERATIVE_COMBAT',		'COOPERATIVE_COMBAT_SUPPORT'),   --协同作战 支援50加成
	('POLICY_TRIBUTE',					'TRIBUTE_SCIENCEPERTRIBUTARY'),
	('POLICY_TRIBUTE',					'TRIBUTE_CULTUREPERTRIBUTARY'),
	--('POLICY_TRIUMPH',					'TRIUMPH_OWNER_ENTERTAINING_CITY_AMENITY'),
	--('POLICY_TRIUMPH',					'TRIUMPH_NOT_OWNER_CITY_LESS_AMENITY'),
	('POLICY_HEDONISM',					'HEDONISM_ENTERTAINMENT_PRODUCTION'),
	('POLICY_HEDONISM',					'HEDONISM_ENTERTAINMENT_BUILDING_PRODUCTION'),
	('POLICY_HEDONISM',					'HEDONISM_ENTERTAINMENT_PRODUCTION_EXTRA'),
	('POLICY_HEDONISM',					'HEDONISM_ENTERTAINMENT_BUILDING_PRODUCTION_EXTRA'),
	('POLICY_TRANSLATION',				'TRANSLATION_CAMPUS_TOURISM_ADJACENCY'),
	('POLICY_TRANSLATION',				'TRANSLATION_THEATER_TOURISM_ADJACENCY'),
	('POLICY_TRANSLATION',				'TRANSLATION_CAMPUS_TRADE_ROUTE_SCIENCE_TO_OTHERS'),
	('POLICY_TRANSLATION',				'TRANSLATION_THEATER_TRADE_ROUTE_CULTURE_TO_OTHERS'),
	('POLICY_ARMY_FARM',				'ARMY_FARM_ENCAMPMENT_ADJACENCY_FOOD_DOUBLE'),
	('POLICY_ARMY_FARM',				'ARMY_FARM_ENCAMPMENT_ADJACENCY_PRODUCTION_DOUBLE');


insert or replace into Modifiers
	(ModifierId,									ModifierType,												SubjectRequirementSetId)
values
	('BLOOD_SACRIFICE_COMBAT_FAITH',				'MODIFIER_PLAYER_UNITS_ADJUST_POST_COMBAT_YIELD',			NULL),
	('LOCAL_MAP_ADD_MOVEMENT',						'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',					NULL),
	('LOCAL_MAP_ADD_MOVEMENT_MOD',					'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT',					'RS_OBJECT_WITHIN_6_TILES'),
	('LOCAL_MAP_IGNORE_TERRAIN',					'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',					NULL),
	('LOCAL_MAP_IGNORE_TERRAIN_MOD',				'MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_TERRAIN',				'RS_OBJECT_WITHIN_5_TILES'),
	('LAND_MEASURE_FOOD',							'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE',			NULL),


	('P_CAPITAL_DISTRICT_PRODUCTION',				'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION_MODIFIER',	'RS_CITY_HAS_BUILDING_PALACE'),
	('P_CAPITAL_FIRST_DISTRICT_PRODUCTION',			'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION_MODIFIER',	'RS_CITY_HAS_BUILDING_PALACE_AND_FIRST_DISTRICT'),
	('COOPERATIVE_COMBAT_FLANKING',					'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',						NULL),
	('COOPERATIVE_COMBAT_SUPPORT',					'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',						NULL),
	('TRIBUTE_SCIENCEPERTRIBUTARY',					'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE_PER_TRIBUTARY',		null),
	('TRIBUTE_CULTUREPERTRIBUTARY',					'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE_PER_TRIBUTARY',		null),
	--('TRIUMPH_OWNER_ENTERTAINING_CITY_AMENITY',		'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY',				'RS_CITY_ORIGINAL_OWNER_AND_ENTERTAINING'),
	--('TRIUMPH_NOT_OWNER_CITY_LESS_AMENITY',			'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY',				'RS_CITY_NOT_ORIGINAL_OWNER'),
	('HEDONISM_ENTERTAINMENT_PRODUCTION',			'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',		null),
	('HEDONISM_ENTERTAINMENT_BUILDING_PRODUCTION',	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION',		null),
	('HEDONISM_ENTERTAINMENT_PRODUCTION_EXTRA',		'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION',		'RS_AT_LEAST_4_AMENITIES'),
	('HEDONISM_ENTERTAINMENT_BUILDING_PRODUCTION_EXTRA','MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION',	'RS_AT_LEAST_4_AMENITIES'),
	('TRANSLATION_CAMPUS_TOURISM_ADJACENCY',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_TOURISM_ADJACENCY_YIELD_MOFIFIER',	'RS_DISTRICT_IS_CAMPUS'),
	('TRANSLATION_THEATER_TOURISM_ADJACENCY',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_TOURISM_ADJACENCY_YIELD_MOFIFIER',	'RS_DISTRICT_IS_THEATER'),
	('TRANSLATION_CAMPUS_TRADE_ROUTE_SCIENCE_TO_OTHERS',	'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS',	'RS_CITY_HAS_DISTRICT_CAMPUS'),
	('TRANSLATION_THEATER_TRADE_ROUTE_CULTURE_TO_OTHERS',	'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS',	'RS_CITY_HAS_DISTRICT_THEATER'),
	('ARMY_FARM_ENCAMPMENT_ADJACENCY_FOOD_DOUBLE',			'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',				'RS_DISTRICT_IS_ENCAMPMENT'),
	('ARMY_FARM_ENCAMPMENT_ADJACENCY_PRODUCTION_DOUBLE',	'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',				'RS_DISTRICT_IS_ENCAMPMENT');

update Modifiers set SubjectStackLimit = 1 where ModifierId = 'LOCAL_MAP_ADD_MOVEMENT_MOD' or ModifierId = 'LOCAL_MAP_IGNORE_TERRAIN_MOD';



insert or replace into ModifierArguments
	(ModifierId,											Name,					Value)
values
	('BLOOD_SACRIFICE_COMBAT_FAITH',						'PercentDefeatedStrength',	50),
	('BLOOD_SACRIFICE_COMBAT_FAITH',						'YieldType',				'YIELD_FAITH'),
	('LOCAL_MAP_ADD_MOVEMENT',								'ModifierId',				'LOCAL_MAP_ADD_MOVEMENT_MOD'),
	('LOCAL_MAP_ADD_MOVEMENT_MOD',							'Amount',					1),
	('LOCAL_MAP_IGNORE_TERRAIN',							'ModifierId',				'LOCAL_MAP_IGNORE_TERRAIN_MOD'),
	('LOCAL_MAP_IGNORE_TERRAIN_MOD',						'Type',						'ALL'),
	('LOCAL_MAP_IGNORE_TERRAIN_MOD',						'Ignore',					1),
	('LAND_MEASURE_FOOD',									'Amount',					1),
	('LAND_MEASURE_FOOD',									'YieldType',				'YIELD_FOOD'),



	('P_CAPITAL_DISTRICT_PRODUCTION',						'Amount',				25),
	('P_CAPITAL_FIRST_DISTRICT_PRODUCTION',					'Amount',				25),
	('COOPERATIVE_COMBAT_FLANKING',							'AbilityType',			'ABILITY_COOPERATIVE_FLANKING'),
	('COOPERATIVE_COMBAT_SUPPORT',							'AbilityType',			'ABILITY_COOPERATIVE_SUPPORT'),
	('TRIBUTE_SCIENCEPERTRIBUTARY',							'YieldType',			'YIELD_SCIENCE'),
	('TRIBUTE_SCIENCEPERTRIBUTARY',							'Amount',				1),
	('TRIBUTE_CULTUREPERTRIBUTARY',							'YieldType',			'YIELD_CULTURE'),
	('TRIBUTE_CULTUREPERTRIBUTARY',							'Amount',				1),
	--('TRIUMPH_OWNER_ENTERTAINING_CITY_AMENITY',				'Amount',				2),
	--('TRIUMPH_NOT_OWNER_CITY_LESS_AMENITY',					'Amount',				-2),
	('HEDONISM_ENTERTAINMENT_PRODUCTION',	 				'DistrictType',			'DISTRICT_ENTERTAINMENT_COMPLEX'),
	('HEDONISM_ENTERTAINMENT_PRODUCTION',	  				'Amount',				25),
	('HEDONISM_ENTERTAINMENT_BUILDING_PRODUCTION',	 		'DistrictType',			'DISTRICT_ENTERTAINMENT_COMPLEX'),
	('HEDONISM_ENTERTAINMENT_BUILDING_PRODUCTION',	  		'Amount',				25),
	('HEDONISM_ENTERTAINMENT_PRODUCTION_EXTRA',	 			'DistrictType',			'DISTRICT_ENTERTAINMENT_COMPLEX'),
	('HEDONISM_ENTERTAINMENT_PRODUCTION_EXTRA',	  			'Amount',				25),
	('HEDONISM_ENTERTAINMENT_BUILDING_PRODUCTION_EXTRA',	'DistrictType',			'DISTRICT_ENTERTAINMENT_COMPLEX'),
	('HEDONISM_ENTERTAINMENT_BUILDING_PRODUCTION_EXTRA',	'Amount',				25),
	('TRANSLATION_CAMPUS_TOURISM_ADJACENCY',				'YieldType',			'YIELD_SCIENCE'),
	('TRANSLATION_CAMPUS_TOURISM_ADJACENCY',				'Amount',				100),
	('TRANSLATION_THEATER_TOURISM_ADJACENCY',				'YieldType',			'YIELD_CULTURE'),
	('TRANSLATION_THEATER_TOURISM_ADJACENCY',				'Amount',				100),
	('TRANSLATION_CAMPUS_TRADE_ROUTE_SCIENCE_TO_OTHERS',	'YieldType',			'YIELD_SCIENCE'),
	('TRANSLATION_CAMPUS_TRADE_ROUTE_SCIENCE_TO_OTHERS',	'Amount',				1),
	('TRANSLATION_THEATER_TRADE_ROUTE_CULTURE_TO_OTHERS',	'YieldType',			'YIELD_CULTURE'),
	('TRANSLATION_THEATER_TRADE_ROUTE_CULTURE_TO_OTHERS',	'Amount',				1),
	('ARMY_FARM_ENCAMPMENT_ADJACENCY_FOOD_DOUBLE',			'YieldType',			'YIELD_FOOD'),
	('ARMY_FARM_ENCAMPMENT_ADJACENCY_FOOD_DOUBLE',			'Amount',				100),
	('ARMY_FARM_ENCAMPMENT_ADJACENCY_PRODUCTION_DOUBLE',	'YieldType',			'YIELD_PRODUCTION'),
	('ARMY_FARM_ENCAMPMENT_ADJACENCY_PRODUCTION_DOUBLE',	'Amount',				100);

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
values	('RS_DISTRICT_IS_CAMPUS',						'REQUIREMENTSET_TEST_ALL'),
		('RS_DISTRICT_IS_ENCAMPMENT',					'REQUIREMENTSET_TEST_ALL'),
		('RS_DISTRICT_IS_THEATER',						'REQUIREMENTSET_TEST_ALL'),
		('RS_CITY_HAS_BUILDING_PALACE_AND_FIRST_DISTRICT',	'REQUIREMENTSET_TEST_ALL');


insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
values	('RS_DISTRICT_IS_CAMPUS',						'REQUIRES_DISTRICT_IS_CAMPUS'), 
		('RS_DISTRICT_IS_ENCAMPMENT',					'REQUIRES_DISTRICT_IS_ENCAMPMENT'),  
		('RS_DISTRICT_IS_THEATER',						'REQUIRES_DISTRICT_IS_THEATER'),         
		('RS_CITY_HAS_BUILDING_PALACE_AND_FIRST_DISTRICT',	'REQ_CITY_HAS_BUILDING_PALACE'),        
		('RS_CITY_HAS_BUILDING_PALACE_AND_FIRST_DISTRICT',	'REQ_CITY_HAS_0_DISTRICTS');         

--伟人点卡框架，有一定相邻的区域，专家增加产出伟人点
create table 'PolicyGreatPersonPoints'(
	'PolicyType' TEXT NOT null,
	'GreatPersonClassType' TEXT NOT null,
	'Amount' INTEGER NOT null DEFAULT 0,
	'DistrictType' TEXT NOT null,
	'YieldType' TEXT NOT null,
	'Adjacency' INTEGER NOT null DEFAULT 0,
	PRIMARY KEY('PolicyType', 'GreatPersonClassType','YieldType')
);

insert or replace into PolicyGreatPersonPoints (PolicyType,	GreatPersonClassType,	Amount,	DistrictType,	YieldType	,Adjacency) values
	('POLICY_STRATEGOS',			'GREAT_PERSON_CLASS_GENERAL',	2,	'DISTRICT_ENCAMPMENT',	'YIELD_PRODUCTION',	2),
	('POLICY_STRATEGOS',			'GREAT_PERSON_CLASS_GENERAL',	2,	'DISTRICT_ENCAMPMENT',	'YIELD_FOOD',		2),
	('POLICY_INSPIRATION',			'GREAT_PERSON_CLASS_SCIENTIST',	2,	'DISTRICT_CAMPUS',		'YIELD_SCIENCE',	4),
	('POLICY_REVELATION',			'GREAT_PERSON_CLASS_PROPHET',	2,	'DISTRICT_HOLY_SITE',	'YIELD_FAITH',		4),
	('POLICY_LITERARY_TRADITION',	'GREAT_PERSON_CLASS_WRITER',	2,	'DISTRICT_THEATER',		'YIELD_CULTURE',	4);

insert or replace into PolicyModifiers(PolicyType,	ModifierId) select
	PolicyType,	PolicyType||'_ADD_'||GreatPersonClassType||'_'||numbers||'_WORKER_'||YieldType
	from PolicyGreatPersonPoints,counter  where numbers>=1 and numbers<=6;

insert or replace into Modifiers(ModifierId,	ModifierType,	SubjectRequirementSetId) select
	PolicyType||'_ADD_'||GreatPersonClassType||'_'||numbers||'_WORKER_'||YieldType,	'MODIFIER_PLAYER_DISTRICTS_ADJUST_GREAT_PERSON_POINTS',	'RS_'||Amount||'_ADJACENCY_'||DistrictType||'_'||numbers||'_WORKERS_'||YieldType
	from PolicyGreatPersonPoints,counter  where numbers>=1 and numbers<=6;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	PolicyType||'_ADD_'||GreatPersonClassType||'_'||numbers||'_WORKER_'||YieldType,	'Amount',	Amount
	from PolicyGreatPersonPoints,counter  where numbers>=1 and numbers<=6;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	PolicyType||'_ADD_'||GreatPersonClassType||'_'||numbers||'_WORKER_'||YieldType,	'GreatPersonClassType',	GreatPersonClassType
	from PolicyGreatPersonPoints,counter  where numbers>=1 and numbers<=6;

insert or replace into RequirementSets(RequirementSetId,	RequirementSetType) select
	'RS_'||Amount||'_ADJACENCY_'||DistrictType||'_'||numbers||'_WORKERS_'||YieldType,	'REQUIREMENTSET_TEST_ALL'	
	from PolicyGreatPersonPoints,counter  where numbers>=1 and numbers<=6;

insert or replace into RequirementSetRequirements(RequirementSetId,	RequirementId) select
	'RS_'||Amount||'_ADJACENCY_'||DistrictType||'_'||numbers||'_WORKERS_'||YieldType,	'REQ_IS_'||Adjacency||'_ADJACENCY_'||YieldType||'_'||DistrictType||'_FIX'
	from PolicyGreatPersonPoints,counter  where numbers>=1 and numbers<=6;

insert or replace into RequirementSetRequirements(RequirementSetId,	RequirementId) select
	'RS_'||Amount||'_ADJACENCY_'||DistrictType||'_'||numbers||'_WORKERS_'||YieldType,	'REQ_PLOT_HAS_'||numbers||'_WORKERS'
	from PolicyGreatPersonPoints,counter  where numbers>=1 and numbers<=6;


-- 从hd copy的单位生产力加成卡框架

delete from Policies where PolicyType = 'POLICY_MANEUVER';
delete from Policies where PolicyType = 'POLICY_CHIVALRY';

delete from PolicyModifiers where
	PolicyType = 'POLICY_AGOGE' or
	PolicyType = 'POLICY_FEUDAL_CONTRACT' or
	PolicyType = 'POLICY_GRANDE_ARMEE' or
	PolicyType = 'POLICY_MILITARY_FIRST' or
	PolicyType = 'POLICY_MARITIME_INDUSTRIES' or
	PolicyType = 'POLICY_PRESS_GANGS' or
	PolicyType = 'POLICY_INTERNATIONAL_WATERS';

create table 'PolicyUnitProductionValidEras'(
	'PolicyType' TEXT NOT null,
	'EraType' TEXT NOT null,
	'SpeedUpAmount' INTEGER NOT null DEFAULT 0,
	'SpeedUpPerTier' INTEGER NOT null DEFAULT 0,
	PRIMARY KEY('PolicyType', 'EraType'),
	FOREIGN KEY('PolicyType') REFERENCES Policies('PolicyType') ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY('EraType') REFERENCES Eras('EraType') ON DELETE CASCADE ON UPDATE CASCADE);

create table 'PolicyUnitProductionValidClasses'(
	'PolicyType' TEXT NOT null,
	'PromotionClassType' TEXT NOT null,
	'UnitDomain' TEXT,
	PRIMARY KEY('PolicyType', 'PromotionClassType'),
	FOREIGN KEY('PolicyType') REFERENCES Policies('PolicyType') ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY('PromotionClassType') REFERENCES UnitPromotionClasses('PromotionClassType') ON DELETE CASCADE ON UPDATE CASCADE);

insert or replace into PolicyUnitProductionValidEras
	(PolicyType,					EraType 			)
values
	('POLICY_AGOGE',				'ERA_ANCIENT' 		),
	('POLICY_AGOGE',				'ERA_CLASSICAL' 	),
	('POLICY_FEUDAL_CONTRACT',		'ERA_ANCIENT' 		),
	('POLICY_FEUDAL_CONTRACT',		'ERA_CLASSICAL' 	),
	('POLICY_FEUDAL_CONTRACT',		'ERA_MEDIEVAL' 		),
	('POLICY_FEUDAL_CONTRACT',		'ERA_RENAISSANCE' 	),
	('POLICY_GRANDE_ARMEE',			'ERA_ANCIENT' 		),
	('POLICY_GRANDE_ARMEE',			'ERA_CLASSICAL' 	),
	('POLICY_GRANDE_ARMEE',			'ERA_MEDIEVAL' 		),
	('POLICY_GRANDE_ARMEE',			'ERA_RENAISSANCE' 	),
	('POLICY_GRANDE_ARMEE',			'ERA_INDUSTRIAL' 	),
	('POLICY_GRANDE_ARMEE',			'ERA_MODERN' 		),
	('POLICY_MILITARY_FIRST',		'ERA_ANCIENT' 		),
	('POLICY_MILITARY_FIRST',		'ERA_CLASSICAL' 	),
	('POLICY_MILITARY_FIRST',		'ERA_MEDIEVAL' 		),
	('POLICY_MILITARY_FIRST',		'ERA_RENAISSANCE' 	),
	('POLICY_MILITARY_FIRST',		'ERA_INDUSTRIAL' 	),
	('POLICY_MILITARY_FIRST',		'ERA_MODERN' 		),
	('POLICY_MILITARY_FIRST',		'ERA_ATOMIC' 		),
	('POLICY_MILITARY_FIRST',		'ERA_INFORMATION' 	),
	('POLICY_MARITIME_INDUSTRIES',	'ERA_ANCIENT' 		),
	('POLICY_MARITIME_INDUSTRIES',	'ERA_CLASSICAL' 	),
	('POLICY_PRESS_GANGS',			'ERA_ANCIENT' 		),
	('POLICY_PRESS_GANGS',			'ERA_CLASSICAL' 	),
	('POLICY_PRESS_GANGS',			'ERA_MEDIEVAL' 		),
	('POLICY_PRESS_GANGS',			'ERA_RENAISSANCE' 	),
	('POLICY_PRESS_GANGS',			'ERA_INDUSTRIAL' 	),
	('POLICY_INTERNATIONAL_WATERS',	'ERA_ANCIENT' 		),
	('POLICY_INTERNATIONAL_WATERS',	'ERA_CLASSICAL' 	),
	('POLICY_INTERNATIONAL_WATERS',	'ERA_MEDIEVAL' 		),
	('POLICY_INTERNATIONAL_WATERS',	'ERA_RENAISSANCE' 	),
	('POLICY_INTERNATIONAL_WATERS',	'ERA_INDUSTRIAL' 	),
	('POLICY_INTERNATIONAL_WATERS',	'ERA_MODERN' 		),
	('POLICY_INTERNATIONAL_WATERS',	'ERA_ATOMIC' 		),
	('POLICY_INTERNATIONAL_WATERS',	'ERA_INFORMATION' 	);

-- Land
update PolicyUnitProductionValidEras set SpeedUpAmount = 25, SpeedUpPerTier = 25 where
	PolicyType = 'POLICY_AGOGE' or PolicyType = 'POLICY_FEUDAL_CONTRACT' or PolicyType = 'POLICY_GRANDE_ARMEE' or PolicyType = 'POLICY_MILITARY_FIRST';

-- Sea
update PolicyUnitProductionValidEras set SpeedUpAmount = 50, SpeedUpPerTier = 50 where
	PolicyType = 'POLICY_MARITIME_INDUSTRIES' or PolicyType = 'POLICY_PRESS_GANGS' or PolicyType = 'POLICY_INTERNATIONAL_WATERS';

insert or replace into PolicyUnitProductionValidClasses	(PolicyType,	PromotionClassType,	UnitDomain)
select a.PolicyType, b.PromotionClassType,	'Land' from Policies a CROSS JOIN UnitPromotionClasses b where (
	a.PolicyType = 'POLICY_AGOGE' or
	a.PolicyType = 'POLICY_FEUDAL_CONTRACT' or
	a.PolicyType = 'POLICY_GRANDE_ARMEE' or
	a.PolicyType = 'POLICY_MILITARY_FIRST' ) and (
	b.PromotionClassType = 'PROMOTION_CLASS_RECON' or
	b.PromotionClassType = 'PROMOTION_CLASS_MELEE' or
	b.PromotionClassType = 'PROMOTION_CLASS_RANGED' or
	b.PromotionClassType = 'PROMOTION_CLASS_SIEGE' or
	b.PromotionClassType = 'PROMOTION_CLASS_ANTI_CAVALRY' or
	b.PromotionClassType = 'PROMOTION_CLASS_LIGHT_CAVALRY' or
	b.PromotionClassType = 'PROMOTION_CLASS_HEAVY_CAVALRY');

insert or replace into PolicyUnitProductionValidClasses (PolicyType,	PromotionClassType,	UnitDomain)
select a.PolicyType, b.PromotionClassType,	'Sea' from Policies a CROSS JOIN UnitPromotionClasses b where (
	a.PolicyType = 'POLICY_MARITIME_INDUSTRIES' or
	a.PolicyType = 'POLICY_PRESS_GANGS' or
	a.PolicyType = 'POLICY_INTERNATIONAL_WATERS' ) and (
	b.PromotionClassType = 'PROMOTION_CLASS_NAVAL_MELEE' or
	b.PromotionClassType = 'PROMOTION_CLASS_NAVAL_RANGED' or
	b.PromotionClassType = 'PROMOTION_CLASS_NAVAL_RAIDER');




insert or replace into PolicyModifiers (PolicyType, ModifierId) select
    a.PolicyType,   'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType;

insert or replace into Modifiers (ModifierId,   ModifierType) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION',  'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType;

insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION',  'EraType',  a.EraType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType;
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION',  'UnitPromotionClass',   b.PromotionClassType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType;
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION',  'Amount',   a.SpeedUpAmount
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType;

-- Tier1, land
insert or replace into PolicyModifiers (PolicyType, ModifierId) select
    a.PolicyType,   'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER1'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

insert or replace into Modifiers (ModifierId,   ModifierType,   SubjectRequirementSetId) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER1',
    'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION',    'RS_CITY_HAS_DISTRICT_ENCAMPMENT'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER1',   'EraType',  a.EraType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER1',   'UnitPromotionClass',   b.PromotionClassType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER1',   'Amount',   a.SpeedUpPerTier
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

-- Tier2, land
insert or replace into PolicyModifiers (PolicyType, ModifierId) select
    a.PolicyType,   'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER2'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

insert or replace into Modifiers (ModifierId,   ModifierType,   SubjectRequirementSetId) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER2',
    'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION',    'RS_CITY_HAS_ENCAMPMENT_TIER1'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER2',   'EraType',  a.EraType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER2',   'UnitPromotionClass',   b.PromotionClassType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER2',   'Amount',   a.SpeedUpPerTier
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

-- Tier3, land
insert or replace into PolicyModifiers (PolicyType, ModifierId) select
    a.PolicyType,   'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER3'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

insert or replace into Modifiers (ModifierId,   ModifierType,   SubjectRequirementSetId) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER3',
    'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION',    'RS_CITY_HAS_BUILDING_ARMORY'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER3',   'EraType',  a.EraType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER3',   'UnitPromotionClass',   b.PromotionClassType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER3',   'Amount',   a.SpeedUpPerTier
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';


-- Tier4, land
insert or replace into PolicyModifiers (PolicyType, ModifierId) select
    a.PolicyType,   'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER4'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

insert or replace into Modifiers (ModifierId,   ModifierType,   SubjectRequirementSetId) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER4',
    'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION',    'RS_CITY_HAS_BUILDING_MILITARY_ACADEMY'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';

insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER4',   'EraType',  a.EraType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER4',   'UnitPromotionClass',   b.PromotionClassType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_LAND_TIER4',   'Amount',   a.SpeedUpPerTier
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Land';


-- Tier1, sea
insert or replace into PolicyModifiers (PolicyType, ModifierId) select
    a.PolicyType,   'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER1'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

insert or replace into Modifiers (ModifierId,   ModifierType,   SubjectRequirementSetId) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER1',
    'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION',    'RS_CITY_HAS_DISTRICT_HARBOR'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER1',    'EraType',  a.EraType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER1',    'UnitPromotionClass',   b.PromotionClassType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER1',    'Amount',   a.SpeedUpPerTier
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

-- Tier2, SEA
insert or replace into PolicyModifiers (PolicyType, ModifierId) select
    a.PolicyType,   'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER2'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

insert or replace into Modifiers (ModifierId,   ModifierType,   SubjectRequirementSetId) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER2',
    'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION',    'RS_CITY_HAS_BUILDING_LIGHTHOUSE'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER2',    'EraType',  a.EraType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER2',    'UnitPromotionClass',   b.PromotionClassType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER2',    'Amount',   a.SpeedUpPerTier
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

-- Tier3, sea
insert or replace into PolicyModifiers (PolicyType, ModifierId) select
    a.PolicyType,   'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER3'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

insert or replace into Modifiers (ModifierId,   ModifierType,   SubjectRequirementSetId) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER3',
    'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION',    'RS_CITY_HAS_BUILDING_SEAPORT'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER3',    'EraType',  a.EraType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER3',    'UnitPromotionClass',   b.PromotionClassType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER3',    'Amount',   a.SpeedUpPerTier
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';


-- Tier4, sea
insert or replace into PolicyModifiers (PolicyType, ModifierId) select
    a.PolicyType,   'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER4'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

insert or replace into Modifiers (ModifierId,   ModifierType,   SubjectRequirementSetId) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER4',
    'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION',    'RS_CITY_HAS_BUILDING_SHIPYARD'
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';

insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER4',    'EraType',  a.EraType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER4',    'UnitPromotionClass',   b.PromotionClassType
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';
insert or replace into ModifierArguments (ModifierId,   Name,   Value) select
    'HD_' || a.PolicyType || '_' || a.EraType || '_' || b.PromotionClassType || '_PRODUCTION_SEA_TIER4',    'Amount',   a.SpeedUpPerTier
from PolicyUnitProductionValidEras a CROSS JOIN PolicyUnitProductionValidClasses b where a.PolicyType = b.PolicyType and b.UnitDomain = 'Sea';
