

create table 'Godhood'(
	'GodhoodType' TEXT NOT NULL,
	'ghClass' TEXT NOT NULL,
	'ghParam1' TEXT,
	'ghParam2' INT,
	'ghParam3' INT,	
	'ghParam4' INT,	
	PRIMARY KEY('GodhoodType', 'ghClass', 'ghParam1')
);


create table 'Power'(
	'PowerType' TEXT NOT NULL,
	'pwClass' TEXT NOT NULL,
	'pwParam1' TEXT,
	'pwParam2' INT,
	'pwParam3' INT,
	'pwParam4' INT,
	PRIMARY KEY('PowerType', 'pwClass', 'pwParam1')
);

create table "counter_m" (
'numbers' INTEGER NOT NULL,
PRIMARY KEY(numbers)
);

WITH RECURSIVE
  Indices(i) AS (SELECT 0 UNION ALL SELECT (i + 1) FROM Indices LIMIT 8)
  insert into counter_m(numbers) select i from Indices;

create table 'ThresholdCounter'(
	'Delta' INT NOT NULL,
	'Threshold' INT NOT NULL,
	'MultiNumber' INT,
	PRIMARY KEY('Delta',	'Threshold')
);

insert or ignore into ThresholdCounter(Delta,	Threshold, MultiNumber) select
	a.numbers, b.numbers, ((b.numbers - 1)/a.numbers + 1)
	from counter_m a,	counter_m b;

create table 'PantheonTexts'(
	'PowerType' TEXT NOT NULL,
	'GodhoodType' TEXT NOT NULL,
	'Language' TEXT NOT NULL,
	'Texts' TEXT NOT NULL,
	PRIMARY KEY('GodhoodType', 'PowerType', 'Texts', 'Language')
);

insert or ignore into Godhood(GodhoodType,		ghClass,		ghParam1,		ghParam2,	ghParam3,	ghParam4) values
	('EARTH_GODDESS',					'APPEAL',		'PLACEHOLDER',					NULL,	NULL,	NULL),
--	('GOD_OF_CRAFTS_MAN',				'RESOURCE_COUNT',	'RESOURCECLASS_STRATEGIC',		NULL,	NULL,	NULL),
	('STONE_CIRCLES',					'IMPROVEMENT',	'IMPROVEMENT_QUARRY',			3,	3,	NULL),
	('DESERT_FOLKLORE',					'TERRAIN',		'TERRAIN_DESERT',				2,	2,	NULL),
	('DESERT_FOLKLORE',					'TERRAIN',		'TERRAIN_DESERT_HILLS',			2,	2,	NULL),
	('DESERT_FOLKLORE',					'TERRAIN',		'TERRAIN_DESERT_MOUNTAIN',		2,	2,	NULL),
	--('DESERT_FOLK_LORE',				'FEATURE',		'FEATURE_FLOODPLAINS',			-3,	-3,	NULL),	
	('GOD_OF_THE_SEA',					'IMPROVEMENT',	'IMPROVEMENT_FISHING_BOATS',	3,	3,	NULL),
	('GODDESS_FO_FIRE',					'FEATURE',		'FEATURE_GEOTHERMAL_FISSURE',	2,	2,	NULL),
	('GODDESS_FO_FIRE',					'FEATURE',		'FEATURE_VOLCANIC_SOIL',		2,	2,	NULL),
	('DANCE_OF_THE_AURORA',				'TERRAIN',		'TERRAIN_TUNDRA',				2,	2,	NULL),
	('DANCE_OF_THE_AURORA',				'TERRAIN',		'TERRAIN_TUNDRA_HILLS',			2,	2,	NULL),
	('DANCE_OF_THE_AURORA',				'TERRAIN',		'TERRAIN_TUNDRA_MOUNTAIN',		2,	2,	NULL),
	('GODDESS_OF_FESTIVALS',			'IMPROVEMENT',	'IMPROVEMENT_PLANTATION',		2,	3,	NULL),
	('LADY_OF_THE_REEDS_AND_MARSHES',	'FEATURE',		'FEATURE_MARSH',				2,	2,	NULL),
	('LADY_OF_THE_REEDS_AND_MARSHES',	'FEATURE',		'FEATURE_OASIS',				2,	2,	NULL),
	('LADY_OF_THE_REEDS_AND_MARSHES',	'FEATURE',		'FEATURE_FLOODPLAINS',			2,	2,	NULL),
	('SACRED_PATH',						'FEATURE',		'FEATURE_JUNGLE',				1,	1,	NULL),
	('ORAL_TRADITION',					'FEATURE',		'FEATURE_FOREST',				1,	1,	NULL),
	('GOD_OF_THE_OPEN_SKY',				'IMPROVEMENT',	'IMPROVEMENT_PASTURE',			3,	3,	NULL),
	('RELIGIOUS_IDOLS',					'IMPROVEMENT',	'IMPROVEMENT_MINE',				1,	1,	NULL),
	('GODDESS_OF_THE_HUNT',				'IMPROVEMENT',	'IMPROVEMENT_CAMP',				1,	1,	NULL);


insert or ignore into Power(PowerType,		pwClass,		pwParam1,		pwParam2,	pwParam3,	pwParam4) values
	('DIVINE_SPARK',					'DISTRICT',		'THRESHOLD1',					2,	NULL,	NULL),
	('DIVINE_SPARK',					'DISTRICT',		'THRESHOLD2',					4,	NULL,	NULL),
	('RELIGIOUS_SETTLEMENTS',			'DISTRICT',		'THRESHOLD1',					2,	NULL,	NULL),
	('RELIGIOUS_SETTLEMENTS',			'DISTRICT',		'THRESHOLD2',					4,	NULL,	NULL),
	('GOD_OF_WINE',						'DISTRICT',		'THRESHOLD1',					3,	NULL,	NULL),
	('GOD_OF_WINE',						'DISTRICT',		'THRESHOLD2',					5,	NULL,	NULL),
	('CITY_PATRON_GODDESS',				'CITY',			'THRESHOLD1',					4,	NULL,	NULL),
	('INITIATION_RITES',				'ADJACENCY',	'YIELD_FAITH',					1,	NULL,	NULL),
	('GGV',								'DISTRICT',		'THRESHOLD1',					2,	NULL,	NULL),
	('SHENNONG',						'DISTRICT',		'THRESHOLD1',					2,	NULL,	NULL),

	('GGV',								'YIELD',		'YIELD_CULTURE',				2,	1,		NULL),
	('SHENNONG',						'YIELD',		'YIELD_FOOD',					2,	1,		NULL),
	('FERTILITY_RITES',					'YIELD_COPY',	'YIELD_FAITH',					1,	NULL,	NULL),
	--('AESCULAPIUS',						'UNIT',			'PLACEHOLDER',					1,	NULL,	NULL),
	('MONUMENT_TO_THE_GODS',			'CITY',			'THRESHOLD1',					4,	NULL,	NULL);


insert or ignore into LocalizedText    (Language,      Tag,                                                             Text) values
	('zh_Hans_CN',		'LOC_BELIEF_GGV_NAME',						'文曲星'),
	('zh_Hans_CN',		'LOC_BELIEF_SHENNONG_NAME',					'神农'),
	('zh_Hans_CN',		'LOC_BELIEF_GOD_OF_WINE_NAME',				'酒神'),

	('zh_Hans_CN',		'LOC_STONE_CIRCLES_POINTS',					'采石场'),
	('zh_Hans_CN',		'LOC_DESERT_FOLKLORE_POINTS',				'沙漠，沙漠丘陵或沙漠山脉'),
	('zh_Hans_CN',		'LOC_GOD_OF_THE_SEA_POINTS',				'渔船'),
	('zh_Hans_CN',		'LOC_GODDESS_FO_FIRE_POINTS',				'地热裂缝或火山土'),
	('zh_Hans_CN',		'LOC_DANCE_OF_THE_AURORA_POINTS',			'冻土，冻土丘陵或冻土山脉'),
	('zh_Hans_CN',		'LOC_GODDESS_OF_FESTIVALS_POINTS',			'种植园'),
	('zh_Hans_CN',		'LOC_LADY_OF_THE_REEDS_AND_MARSHES_POINTS',	'沼泽，绿洲或沙漠泛滥平原'),
	('zh_Hans_CN',		'LOC_SACRED_PATH_POINTS',					'雨林'),
	('zh_Hans_CN',		'LOC_ORAL_TRADITION_POINTS',				'森林'),
	('zh_Hans_CN',		'LOC_GOD_OF_THE_OPEN_SKY_POINTS',			'牧场'),
	('zh_Hans_CN',		'LOC_RELIGIOUS_IDOLS_POINTS',				'矿山'),
	('zh_Hans_CN',		'LOC_GODDESS_OF_THE_HUNT_POINTS',			'营地'),

	--('zh_Hans_CN',		'LOC_INITIATION_RITES_DIS_EFFECT',			''),
	('zh_Hans_CN',		'LOC_SHENNONG_DIS_EFFECT',					'+1 [ICON_FOOD] 食物'),
	('zh_Hans_CN',		'LOC_GGV_DIS_EFFECT',						'+1 [ICON_CULTURE] 文化值'),
	('zh_Hans_CN',		'LOC_DIVINE_SPARK_DIS_EFFECT',				'+1 [ICON_GreatPerson] 对应伟人点数'),
	('zh_Hans_CN',		'LOC_RELIGIOUS_SETTLEMENTS_DIS_EFFECT',		'+1 [ICON_Housing] 住房'),
	('zh_Hans_CN',		'LOC_GOD_OF_WINE_DIS_EFFECT',				'+1 [ICON_Amenities] 宜居度'),
	('zh_Hans_CN',		'LOC_CITY_PATRON_GODDESS_DIS_EFFECT',		'在拥有一个专业区域后，可以无视人口限制额外建造一个专业区域'),
	('zh_Hans_CN',		'LOC_MONUMENT_TO_THE_GODS_DIS_EFFECT',		'建造远古和古典奇观时+25%建造速度');



--三类+区域
insert or ignore into PantheonTexts    (Language,      GodhoodType,	PowerType,		Texts) select
			'zh_Hans_CN',		GodhoodType,	PowerType,		'一格范围内拥有至少拥有'||MultiNumber||'个'||'{LOC_'||GodhoodType||'_POINTS}的区域{LOC_'||PowerType||'_DIS_EFFECT}。'
	from Godhood, Power, ThresholdCounter where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN') and pwClass = 'DISTRICT'
	and pwParam1 in ('THRESHOLD1', 'THRESHOLD2') and ghParam3 = Delta and pwParam2 = Threshold;
--三类+城市
insert or ignore into PantheonTexts    (Language,      GodhoodType,	PowerType,		Texts) select
			'zh_Hans_CN',		GodhoodType,	PowerType,	'市中心一格范围内拥有至少拥有'||MultiNumber||'个'||'{LOC_'||GodhoodType||'_POINTS}的城市{LOC_'||PowerType||'_DIS_EFFECT}。'
	from Godhood, Power, ThresholdCounter where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN') and pwClass = 'CITY'
	and pwParam1 in ('THRESHOLD1', 'THRESHOLD2') and ghParam3 = Delta and pwParam2 = Threshold;
--三类+封禅
insert or ignore into PantheonTexts    (Language,      GodhoodType,	PowerType,		Texts) select
			'zh_Hans_CN',		GodhoodType,	'INITIATION_RITES',	'圣地一格范围内的每个{LOC_'||GodhoodType||'_POINTS}均为圣地+'||ghParam3||' [ICON_FAITH] 信仰值相邻加成。'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');
--三类+丰产仪式
insert or ignore into PantheonTexts    (Language,      GodhoodType,	PowerType,		Texts) select
			'zh_Hans_CN',		GodhoodType,	'FERTILITY_RITES',	'{LOC_'||GodhoodType||'_POINTS}所在单元格+'||ghParam3||' [ICON_FAITH] 信仰值。'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');
--三类+神农/文曲星
insert or ignore into PantheonTexts    (Language,      GodhoodType,	PowerType,		Texts) select
			'zh_Hans_CN',		GodhoodType,	PowerType,	'{LOC_'||GodhoodType||'_POINTS}所在单元格'||'{LOC_'||PowerType||'_DIS_EFFECT}。'
	from Godhood, Power where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN') and pwClass = 'YIELD'
	 and ghParam3 >= pwParam2;


--大地女神+区域
insert or ignore into PantheonTexts    (Language,      GodhoodType,	PowerType,		Texts) select
			'zh_Hans_CN',		'EARTH_GODDESS',	PowerType,	'魅力值至少为'||(pwParam2 * 2)||'的区域'||'{LOC_'||PowerType||'_DIS_EFFECT}。'
	from  Power where  pwClass = 'DISTRICT'
	and pwParam1 in ('THRESHOLD1', 'THRESHOLD2');
--大地女神+城市
insert or ignore into PantheonTexts    (Language,      GodhoodType,	PowerType,		Texts) select
			'zh_Hans_CN',		'EARTH_GODDESS',	PowerType,		'市中心魅力值至少为'||(pwParam2 * 2)||'的城市{LOC_'||PowerType||'_DIS_EFFECT}。'
	from  Power where  pwClass = 'CITY'
	and pwParam1 in ('THRESHOLD1', 'THRESHOLD2');
--大地女神+封禅/丰产仪式
insert or ignore into PantheonTexts    (Language,      GodhoodType,	PowerType,		Texts) values
			('zh_Hans_CN',		'EARTH_GODDESS',	'INITIATION_RITES',		'圣地所在单元格的每有2点魅力值就为该圣地提供+1 [ICON_FAITH] 信仰值相邻加成。'),
			('zh_Hans_CN',		'EARTH_GODDESS',	'FERTILITY_RITES',		'单元格每有2点魅力值就+1 [ICON_FAITH] 信仰值。');
--大地女神+神农/文曲星
insert or ignore into PantheonTexts    (Language,      GodhoodType,	PowerType,		Texts) select
			'zh_Hans_CN',		'EARTH_GODDESS',	PowerType,	'魅力值至少为'||(pwParam2 * 2)||'的单元格{LOC_'||PowerType||'_DIS_EFFECT}。'
	from  Power where  pwClass = 'YIELD';



insert or ignore into LocalizedText    (Language,      Tag,                                                             Text) select
	'zh_Hans_CN',			'LOC_BELIEF_'||GodhoodType||'_WITH_'||PowerType||'_NAME',	'{LOC_BELIEF_'||GodhoodType||'_NAME}+{LOC_BELIEF_'||PowerType||'_NAME}'
	from Godhood, Power;

insert into LocalizedText(Language,	Tag,	Text) select
	Language,	'LOC_BELIEF_'||GodhoodType||'_WITH_'||PowerType||'_DESCRIPTION',	group_concat(Texts)
	from PantheonTexts group by  GodhoodType, Language, PowerType;


--insert or ignore into EnglishText	 (      Tag,                                                             Text) values
--	('LOC_ORAL_TRADITION_DIVINE_SPARK_THRESHOLD1',	'一格范围内拥有至少拥有'||3||'ge'||'{LOC_DANCE_OF_THE_AURORA_POINTS}的区域');




