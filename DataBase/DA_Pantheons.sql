


insert or ignore into Types
	(Type,									Kind)
values
	-- Pantheon
	('BELIEF_ORAL_TRADITION',				'KIND_BELIEF'),
	('BELIEF_GOD_OF_WINE',					'KIND_BELIEF'),
	('BELIEF_GGV',							'KIND_BELIEF'),
	('BELIEF_SHENNONG',						'KIND_BELIEF');


insert or ignore into Beliefs
	(BeliefType,						Name,										Description,											BeliefClassType)
values
	-- Pantheon
	('BELIEF_ORAL_TRADITION',			'LOC_BELIEF_ORAL_TRADITION_NAME',			'LOC_BELIEF_ORAL_TRADITION_DESCRIPTION',				'BELIEF_CLASS_PANTHEON'),
	('BELIEF_GOD_OF_WINE',				'LOC_BELIEF_GOD_OF_WINE_NAME',				'LOC_BELIEF_GOD_OF_WINE_DESCRIPTION',					'BELIEF_CLASS_PANTHEON'),
	('BELIEF_GGV',						'LOC_BELIEF_GGV_NAME',						'LOC_BELIEF_GGV_DESCRIPTION',							'BELIEF_CLASS_PANTHEON'),
	('BELIEF_SHENNONG',					'LOC_BELIEF_SHENNONG_NAME',					'LOC_BELIEF_SHENNONG_DESCRIPTION',						'BELIEF_CLASS_PANTHEON');

--保存并转移万神殿
create table 'Pantheons'(
	'BeliefType' TEXT NOT NULL,
	'Name' TEXT NOT NULL,
	'Description' TEXT NOT NULL,
	PRIMARY KEY('BeliefType')
);

insert into Pantheons(BeliefType,	Name,	Description) select
	BeliefType,	Name,	Description
	from Beliefs where BeliefClassType = 'BELIEF_CLASS_PANTHEON';

--确保万神殿在百科内的显示
insert into CivilopediaPageQueries(SectionId,	PageGroupIdColumn,	TooltipColumn,	SortIndex,
	SQL) values
	('RELIGIONS',	'PageGroupId',	'Tooltip',	10,
	'SELECT BeliefType as PageId, "BELIEF_CLASS_PANTHEON" as PageGroupId, "Belief" as PageLayoutId, Name, null as Tooltip FROM Pantheons');


--select * from Modifiers where ModifierId like '%CITY_PATRON_GODDESS%';
/*
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'FERTILITY_RITES',	GodhoodType||'_FERTILITY_RITES_PLOT_YIELD_FOOD'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');
*/

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

--create table 'PowerModifiers'(
--	'PowerType' TEXT NOT NULL,
--	'ModifierType' TEXT NOT NULL,

create table 'PantheonModifiers'(
	'PowerType' TEXT NOT NULL,
	'GodhoodType' TEXT NOT NULL,
	'ModifierId' TEXT NOT NULL,
	PRIMARY KEY('GodhoodType', 'PowerType', 'ModifierId')
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
/*
insert or ignore into PantheonModifiers(GodhoodType,	PowerType,	ModifierId) select
	GodhoodType, PowerType,	GodhoodType||'&'||PowerType||'#MOD1'
	from Godhood, Power where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL')
	and pwClass in ('DISTRICT', 'CITY')
	and pwParam1 = 'THRESHOLD1';

insert or ignore into PantheonModifiers(GodhoodType,	PowerType,	ModifierId) select
	GodhoodType, PowerType,	GodhoodType||'&'||PowerType||'#MOD2'
	from Godhood, Power where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL')
	and pwClass in ('DISTRICT', 'CITY')
	and pwParam1 = 'THRESHOLD2';

insert or ignore into RequirementSets(RequirementSetId,	RequirementSetType) select
	GodhoodType||'&THRESHOLD#'||numbers,	'REQUIREMENTSET_TEST_ANY'
	from counter_m, Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL'); 
*/

insert or ignore into Beliefs
	(BeliefType,						Name,										Description,											BeliefClassType) select
	'BELIEF_'||GodhoodType||'_WITH_'||PowerType,	'LOC_BELIEF_'||GodhoodType||'_WITH_'||PowerType||'_NAME',	'LOC_BELIEF_'||GodhoodType||'_WITH_'||PowerType||'_DESCRIPTION',	'BELIEF_CLASS_PANTHEON'
	from Godhood, Power;

insert or ignore into Types
	(Type,									Kind) select
	'BELIEF_'||GodhoodType||'_WITH_'||PowerType,	'KIND_BELIEF'
	from Godhood, Power;

insert or ignore into CivilopediaPageExcludes(SectionId,	PageId)	select
	'RELIGIONS',	'BELIEF_'||GodhoodType||'_WITH_'||PowerType
	from Godhood, Power;


--地貌类别
insert or ignore into Requirements(RequirementId,	RequirementType) select
'REQ_'||GodhoodType||'_TAG_MATCHES',	'REQUIREMENT_PLOT_FEATURE_TAG_MATCHES'
from GodHood where ghClass = 'FEATURE';

insert or ignore into RequirementArguments(RequirementId,	Name, Value) select
	'REQ_'||GodhoodType||'_TAG_MATCHES',	'Tag',	'CLASS_'||GodhoodType
from GodHood where ghClass = 'FEATURE';

insert or ignore into Tags
		(Tag,						Vocabulary) select
		'CLASS_'||GodhoodType,	'FEATURE_CLASS'
		from GodHood where ghClass = 'FEATURE';

insert or ignore into TypeTags
		(Tag,						Type) select
		'CLASS_'||GodhoodType,	ghParam1
		from GodHood where ghClass = 'FEATURE';

--改良类别
insert or ignore into Requirements(RequirementId,	RequirementType) select
'REQ_'||GodhoodType||'_TAG_MATCHES',	'REQUIREMENT_PLOT_IMPROVEMENT_TAG_MATCHES'
from GodHood where ghClass = 'IMPROVEMENT';

insert or ignore into RequirementArguments(RequirementId,	Name, Value) select
	'REQ_'||GodhoodType||'_TAG_MATCHES',	'Tag',	'CLASS_'||GodhoodType
from GodHood where ghClass = 'IMPROVEMENT';

insert or ignore into Tags
		(Tag,						Vocabulary) select
		'CLASS_'||GodhoodType,	'IMPROVEMENT_CLASS'
		from GodHood where ghClass = 'IMPROVEMENT';

insert or ignore into TypeTags
		(Tag,					Type) select
		'CLASS_'||GodhoodType,	ghParam1
		from GodHood where ghClass = 'IMPROVEMENT';

--地形类别
insert or ignore into Requirements(RequirementId,	RequirementType) select
'REQ_'||GodhoodType||'_TAG_MATCHES',	'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES'
from GodHood where ghClass = 'TERRAIN';

insert or ignore into RequirementArguments(RequirementId,	Name, Value) select
	'REQ_'||GodhoodType||'_TAG_MATCHES',	'TerrainClass',	'TERRAIN_CLASS_'||GodhoodType
from GodHood where ghClass = 'TERRAIN';


insert or ignore into TerrainClasses
	(TerrainClassType,		Name) select
	'TERRAIN_CLASS_'||GodhoodType,	'LOC_TERRAIN_CLASS_'||GodhoodType||'_NAME'
from GodHood where ghClass = 'TERRAIN';

insert or ignore into TerrainClass_Terrains
	(TerrainClassType,		TerrainType) select
	'TERRAIN_CLASS_'||GodhoodType,	ghParam1
from GodHood where ghClass = 'TERRAIN';

--阈值计数器
create table 'ThresholdCounter'(
	'Delta' INT NOT NULL,
	'Threshold' INT NOT NULL,
	'MultiNumber' INT,
	PRIMARY KEY('Delta',	'Threshold')
);

insert or ignore into ThresholdCounter(Delta,	Threshold, MultiNumber) select
	a.numbers, b.numbers, ((b.numbers - 1)/a.numbers + 1)
	from counter_m a,	counter_m b;


--一环内某神格的点数达到某阈值
--地形/地貌/改良类  
--阈值req
insert or ignore into Requirements(RequirementId,	RequirementType) select
	'REQ_'||GodhoodType||'_THRESHOLD_'||numbers,	'REQUIREMENT_COLLECTION_COUNT_ATLEAST'
	from GodHood, counter_m where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_'||GodhoodType||'_THRESHOLD_'||numbers,	'CollectionType',	'COLLECTION_ALL_PLOT_YIELDS'
	from GodHood, counter_m where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_'||GodhoodType||'_THRESHOLD_'||numbers,	'Count',	MultiNumber
	from GodHood, counter_m, ThresholdCounter 
	where ghClass in ('FEATURE',	'TERRAIN')
	and Delta = ghParam3 and Threshold = numbers;
--改良 bugfix 当阈值大于1时，需要额外+1阈值才能正常工作  阈值等于1时则不变
insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_'||GodhoodType||'_THRESHOLD_'||numbers,	'Count',	
	case when MultiNumber > 1 then MultiNumber + 1 else MultiNumber end
	from GodHood, counter_m, ThresholdCounter 
	where ghClass = 'IMPROVEMENT'
	and Delta = ghParam3 and Threshold = numbers;



insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_'||GodhoodType||'_THRESHOLD_'||numbers,	'RequirementSetId',	'RS_REQ_'||GodhoodType||'_THRESHOLD'
	from GodHood, counter_m where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

--阈值rs
insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_'||GodhoodType||'_THRESHOLD_'||numbers,		'REQUIREMENTSET_TEST_ALL'
	from GodHood, counter_m where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_THRESHOLD_'||numbers,		'REQ_'||GodhoodType||'_THRESHOLD_'||numbers
	from GodHood join counter_m where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');



insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_REQ_'||GodhoodType||'_THRESHOLD',		'REQUIREMENTSET_TEST_ALL'
	from GodHood, counter_m where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_REQ_'||GodhoodType||'_THRESHOLD',		'REQ_OBJECT_WITHIN_1_TILES'
	from GodHood, counter_m where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_REQ_'||GodhoodType||'_THRESHOLD',		'REQ_'||GodhoodType||'_TAG_MATCHES'
	from GodHood, counter_m where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');	

--大地女神 魅力类
--阈值rs
insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_EARTH_GODDESS_THRESHOLD_'||numbers,	'REQUIREMENTSET_TEST_ALL'
	from counter_m;

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_EARTH_GODDESS_THRESHOLD_'||numbers,	'REQ_EARTH_GODDESS_THRESHOLD_'||numbers
	from counter_m;
--阈值req
insert or ignore into Requirements(RequirementId,	RequirementType) select
	'REQ_EARTH_GODDESS_THRESHOLD_'||numbers,	'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN'
	from counter_m;

insert or ignore into RequirementArguments(RequirementId, Name, Value) select
	'REQ_EARTH_GODDESS_THRESHOLD_'||numbers,	'MinimumAppeal',	numbers * 2
	from counter_m;


--原宗教移民
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'RELIGIOUS_SETTLEMENTS',	GodhoodType||'_RELIGIOUS_SETTLEMENTS_HOUSING1'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_RELIGIOUS_SETTLEMENTS_HOUSING1',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_HOUSING',		'RS_'||GodhoodType||'_THRESHOLD_2'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_RELIGIOUS_SETTLEMENTS_HOUSING1',		'Amount',	1
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');


insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'RELIGIOUS_SETTLEMENTS',	GodhoodType||'_RELIGIOUS_SETTLEMENTS_HOUSING2'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_RELIGIOUS_SETTLEMENTS_HOUSING2',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_HOUSING',		'RS_'||GodhoodType||'_THRESHOLD_4'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_RELIGIOUS_SETTLEMENTS_HOUSING2',		'Amount',	1
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

--原酒神
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'GOD_OF_WINE',	GodhoodType||'_GOD_OF_WINE_AMENITY1'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_GOD_OF_WINE_AMENITY1',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_EXTRA_ENTERTAINMENT',		'RS_'||GodhoodType||'_THRESHOLD_3'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_GOD_OF_WINE_AMENITY1',		'Amount',	1
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');


insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'GOD_OF_WINE',	GodhoodType||'_GOD_OF_WINE_AMENITY2'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_GOD_OF_WINE_AMENITY2',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_EXTRA_ENTERTAINMENT',		'RS_'||GodhoodType||'_THRESHOLD_5'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_GOD_OF_WINE_AMENITY2',		'Amount',	1
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');


--原主神纪念碑
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'MONUMENT_TO_THE_GODS',	GodhoodType||'_MONUMENT_TO_THE_GODS_PRODUCTION_FOR_A_E_WONDERS'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_MONUMENT_TO_THE_GODS_PRODUCTION_FOR_A_E_WONDERS',		'MODIFIER_PLAYER_CITIES_ADJUST_WONDER_ERA_PRODUCTION',		'RS_'||GodhoodType||'_THRESHOLD_4'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_MONUMENT_TO_THE_GODS_PRODUCTION_FOR_A_E_WONDERS',		'Amount',	25
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');
insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_MONUMENT_TO_THE_GODS_PRODUCTION_FOR_A_E_WONDERS',		'EndEra',	'ERA_CLASSICAL'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');
insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_MONUMENT_TO_THE_GODS_PRODUCTION_FOR_A_E_WONDERS',		'IsWonder',	'true'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');
insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_MONUMENT_TO_THE_GODS_PRODUCTION_FOR_A_E_WONDERS',		'StartEra',	'ERA_ANCIENT'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

--原城市守护女神
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'CITY_PATRON_GODDESS',	GodhoodType||'_CITY_PATRON_GODDESS_EXTRA_DISTRICT'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_CITY_PATRON_GODDESS_EXTRA_DISTRICT',		'QGG_MODIFIER_PLAYER_CITIES_EXTRA_DISTRICT',		'RS_'||GodhoodType||'_THRESHOLD_4_HAS_1_DISTRICT'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_CITY_PATRON_GODDESS_EXTRA_DISTRICT',		'Amount',	1
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

--城市守护女神rs
    insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_'||GodhoodType||'_THRESHOLD_4_HAS_1_DISTRICT',		'REQUIREMENTSET_TEST_ALL'
	from GodHood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

    insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_THRESHOLD_4_HAS_1_DISTRICT',		'REQ_'||GodhoodType||'_THRESHOLD_4'
	from GodHood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

    insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_THRESHOLD_4_HAS_1_DISTRICT',		'REQ_CITY_HAS_1_DISTRICTS'
	from GodHood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

-- 城市守护女神modifier
insert or ignore into Types (Type, Kind) VALUES 
('QGG_MODIFIER_PLAYER_CITIES_EXTRA_DISTRICT', 'KIND_MODIFIER');

insert or ignore into DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES 
('QGG_MODIFIER_PLAYER_CITIES_EXTRA_DISTRICT', 'COLLECTION_PLAYER_CITIES', 'EFFECT_ADJUST_CITY_EXTRA_DISTRICTS');





--神圣之光rs
    insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_'||GodhoodType||'_THRESHOLD_2_'||DistrictType,		'REQUIREMENTSET_TEST_ALL'
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

    insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_THRESHOLD_2_'||DistrictType,		'REQ_'||GodhoodType||'_THRESHOLD_2'
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

    insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_THRESHOLD_2_'||DistrictType,		'REQ_PLOT_HAS_'||DistrictType
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

    insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_'||GodhoodType||'_THRESHOLD_4_'||DistrictType,		'REQUIREMENTSET_TEST_ALL'
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

    insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_THRESHOLD_4_'||DistrictType,		'REQ_'||GodhoodType||'_THRESHOLD_4'
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

    insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_THRESHOLD_4_'||DistrictType,		'REQ_PLOT_HAS_'||DistrictType
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

--原神圣之光
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'DIVINE_SPARK',	GodhoodType||'_DIVINE_SPARK_'||DistrictType||'_'||GreatPersonClassType||'_1'
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL') 
	and DistrictType not in (select CivUniqueDistrictType from DistrictReplaces);

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_DIVINE_SPARK_'||DistrictType||'_'||GreatPersonClassType||'_1',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_GREAT_PERSON_POINTS',		'RS_'||GodhoodType||'_THRESHOLD_2_'||DistrictType
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL') 
	and DistrictType not in (select CivUniqueDistrictType from DistrictReplaces);

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_DIVINE_SPARK_'||DistrictType||'_'||GreatPersonClassType||'_1',		'Amount',	1
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL') 
	and DistrictType not in (select CivUniqueDistrictType from DistrictReplaces);
	
insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_DIVINE_SPARK_'||DistrictType||'_'||GreatPersonClassType||'_1',		'GreatPersonClassType',	GreatPersonClassType
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL') 
	and DistrictType not in (select CivUniqueDistrictType from DistrictReplaces);
	

insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'DIVINE_SPARK',	GodhoodType||'_DIVINE_SPARK_'||DistrictType||'_'||GreatPersonClassType||'_2'
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_DIVINE_SPARK_'||DistrictType||'_'||GreatPersonClassType||'_2',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_GREAT_PERSON_POINTS',		'RS_'||GodhoodType||'_THRESHOLD_4_'||DistrictType
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_DIVINE_SPARK_'||DistrictType||'_'||GreatPersonClassType||'_2',		'Amount',	1
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_DIVINE_SPARK_'||DistrictType||'_'||GreatPersonClassType||'_2',		'GreatPersonClassType',	GreatPersonClassType
	from GodHood,  District_GreatPersonPoints where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');




--文曲星神农单元格rs
    insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_'||GodhoodType||'_THRESHOLD_2_PLOT_TAG_MATCHES',		'REQUIREMENTSET_TEST_ALL'
	from GodHood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN') and ghParam2>1;

    insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_THRESHOLD_2_PLOT_TAG_MATCHES',		'REQ_'||GodhoodType||'_TAG_MATCHES'
	from GodHood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN') and ghParam2>1;


--原文曲星单元格产出

insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'GGV',	GodhoodType||'_GGV_PLOT_YIELD_CULTURE'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN')) and ghParam2>1;

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_GGV_PLOT_YIELD_CULTURE',		'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',		'RS_'||GodhoodType||'_THRESHOLD_2_PLOT_TAG_MATCHES'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN')) and ghParam2>1;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select distinct
	GodhoodType||'_GGV_PLOT_YIELD_CULTURE',		'Amount',	1
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN')) and ghParam2>1;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select distinct
	GodhoodType||'_GGV_PLOT_YIELD_CULTURE',		'YieldType',	'YIELD_CULTURE'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN')) and ghParam2>1;

--原文曲星区域产出

insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'GGV',	GodhoodType||'_GGV_DISTRICT_YIELD_CULTURE'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL'));

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_GGV_DISTRICT_YIELD_CULTURE',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',		'RS_'||GodhoodType||'_THRESHOLD_2'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL'));

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_GGV_DISTRICT_YIELD_CULTURE',		'Amount',	1
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL'));

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_GGV_DISTRICT_YIELD_CULTURE',		'YieldType',	'YIELD_CULTURE'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL'));

--文曲星 + 大地女神
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) values
	('EARTH_GODDESS',	'GGV',		'EARTH_GODDESS_GGV_PLOT_YIELD_CULTURE');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) values
	('EARTH_GODDESS_GGV_PLOT_YIELD_CULTURE',	'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',		'RS_EARTH_GODDESS_THRESHOLD_2');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) values
	('EARTH_GODDESS_GGV_PLOT_YIELD_CULTURE',	'Amount',			1),
	('EARTH_GODDESS_GGV_PLOT_YIELD_CULTURE',	'YieldType',		'YIELD_CULTURE');




--原神农单元格产出

insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'SHENNONG',	GodhoodType||'_SHENNONG_PLOT_YIELD_FOOD'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN')) and ghParam2>1;

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_SHENNONG_PLOT_YIELD_FOOD',		'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',		'RS_'||GodhoodType||'_THRESHOLD_2_PLOT_TAG_MATCHES'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN')) and ghParam2>1;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select distinct
	GodhoodType||'_SHENNONG_PLOT_YIELD_FOOD',		'Amount',	1
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN')) and ghParam2>1;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select distinct
	GodhoodType||'_SHENNONG_PLOT_YIELD_FOOD',		'YieldType',	'YIELD_FOOD'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN')) and ghParam2>1;


--原神农区域产出

insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'SHENNONG',	GodhoodType||'_SHENNONG_DISTRICT_YIELD_FOOD'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL'));

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_SHENNONG_DISTRICT_YIELD_FOOD',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',		'RS_'||GodhoodType||'_THRESHOLD_2'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL'));

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_SHENNONG_DISTRICT_YIELD_FOOD',		'Amount',	1
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL'));

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_SHENNONG_DISTRICT_YIELD_FOOD',		'YieldType',	'YIELD_FOOD'
	from GodHood where (ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL'));

--神农 + 大地女神
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) values
	('EARTH_GODDESS',	'SHENNONG',		'EARTH_GODDESS_SHENNONG_PLOT_YIELD_FOOD');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) values
	('EARTH_GODDESS_SHENNONG_PLOT_YIELD_FOOD',	'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',		'RS_EARTH_GODDESS_THRESHOLD_2');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) values
	('EARTH_GODDESS_SHENNONG_PLOT_YIELD_FOOD',	'Amount',			1),
	('EARTH_GODDESS_SHENNONG_PLOT_YIELD_FOOD',	'YieldType',		'YIELD_FOOD');


--原丰产仪式单元格产出

insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'FERTILITY_RITES',	GodhoodType||'_FERTILITY_RITES_PLOT_YIELD_FOOD'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_FERTILITY_RITES_PLOT_YIELD_FOOD',		'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',		'RS_'||GodhoodType||'_THRESHOLD_PLOT_TAG_MATCHES'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_FERTILITY_RITES_PLOT_YIELD_FOOD',		'Amount',	ghParam2
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_FERTILITY_RITES_PLOT_YIELD_FOOD',		'YieldType',	'YIELD_FAITH'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

--丰产仪式单元格req
insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_'||GodhoodType||'_THRESHOLD_PLOT_TAG_MATCHES',		'REQUIREMENTSET_TEST_ALL'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_THRESHOLD_PLOT_TAG_MATCHES',		'REQ_'||GodhoodType||'_TAG_MATCHES'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN');

--大地女神+丰产仪式
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	'EARTH_GODDESS',	'FERTILITY_RITES',	'EARTH_GODDESS_FERTILITY_RITES_PLOT_YIELD_FOOD_'||numbers
	from counter where numbers > 0 and numbers < 11;

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select  -- rs来自rs.sql
	'EARTH_GODDESS_FERTILITY_RITES_PLOT_YIELD_FOOD_'||numbers,		'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',		'RS_PLOT_APPEAL_AT_LEAST_' || (numbers * 2)
	from counter where numbers > 0 and numbers < 11;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	'EARTH_GODDESS_FERTILITY_RITES_PLOT_YIELD_FOOD_'||numbers,		'Amount',	1
	from counter where numbers > 0 and numbers < 11;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	'EARTH_GODDESS_FERTILITY_RITES_PLOT_YIELD_FOOD_'||numbers,		'YieldType',	'YIELD_FAITH'
	from counter where numbers > 0 and numbers < 11;






-- 改良相邻ModifierType

insert or ignore into Types (Type, Kind) VALUES 
('MODIFIER_PLAYER_CITIES_IMPROVEMENT_ADJACENCY', 'KIND_MODIFIER');

insert or ignore into DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES 
('MODIFIER_PLAYER_CITIES_IMPROVEMENT_ADJACENCY', 'COLLECTION_PLAYER_CITIES', 'EFFECT_IMPROVEMENT_ADJACENCY');


--封禅原启蒙会改良
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'INITIATION_RITES',	GodhoodType||'_INITIATION_RITES_'||ghParam1
	from Godhood where ghClass='IMPROVEMENT';

insert or ignore into Modifiers(ModifierId,	ModifierType) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'MODIFIER_PLAYER_CITIES_IMPROVEMENT_ADJACENCY'	
	from Godhood where ghClass='IMPROVEMENT';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'DistrictType',	'DISTRICT_HOLY_SITE'
	from Godhood where ghClass='IMPROVEMENT';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'YieldType',	'YIELD_FAITH'
	from Godhood where ghClass='IMPROVEMENT';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'Amount',	ghParam3
	from Godhood where ghClass='IMPROVEMENT';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'TilesRequired',	1
	from Godhood where ghClass='IMPROVEMENT';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'Description',	'LOC_INITIATION_RITES'
	from Godhood where ghClass='IMPROVEMENT';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'ImprovementType',	ghParam1
	from Godhood where ghClass='IMPROVEMENT';

--封禅原启蒙会地貌
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'INITIATION_RITES',	GodhoodType||'_INITIATION_RITES_'||ghParam1
	from Godhood where ghClass='FEATURE';

insert or ignore into Modifiers(ModifierId,	ModifierType) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'MODIFIER_PLAYER_CITIES_FEATURE_ADJACENCY'	
	from Godhood where ghClass='FEATURE';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'DistrictType',	'DISTRICT_HOLY_SITE'
	from Godhood where ghClass='FEATURE';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'YieldType',	'YIELD_FAITH'
	from Godhood where ghClass='FEATURE';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'Amount',	ghParam3
	from Godhood where ghClass='FEATURE';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'TilesRequired',	1
	from Godhood where ghClass='FEATURE';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'Description',	'LOC_INITIATION_RITES'
	from Godhood where ghClass='FEATURE';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'FeatureType',	ghParam1
	from Godhood where ghClass='FEATURE';

--封禅原启蒙会地形
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'INITIATION_RITES',	GodhoodType||'_INITIATION_RITES_'||ghParam1
	from Godhood where ghClass='TERRAIN';

insert or ignore into Modifiers(ModifierId,	ModifierType) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY'		
	from Godhood where ghClass='TERRAIN';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'DistrictType',	'DISTRICT_HOLY_SITE'
	from Godhood where ghClass='TERRAIN';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'YieldType',	'YIELD_FAITH'
	from Godhood where ghClass='TERRAIN';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'Amount',	ghParam3
	from Godhood where ghClass='TERRAIN';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'TilesRequired',	1
	from Godhood where ghClass='TERRAIN';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'Description',	'LOC_INITIATION_RITES'
	from Godhood where ghClass='TERRAIN';

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_'||ghParam1,		'TerrainType',	ghParam1
	from Godhood where ghClass='TERRAIN';

--封禅 + 大地女神
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	'EARTH_GODDESS',	'INITIATION_RITES',	'EARTH_GODDESS_INITIATION_RITES_'||numbers
	from counter where numbers > 0 and numbers < 10;

insert or ignore into Modifiers(ModifierId,	ModifierType) select
	'EARTH_GODDESS_INITIATION_RITES_'||numbers,		'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_BASED_ON_APPEAL'		
	from counter where numbers > 0 and numbers < 10;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	'EARTH_GODDESS_INITIATION_RITES_'||numbers,		'YieldType',	'YIELD_FAITH'
	from counter where numbers > 0 and numbers < 10;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	'EARTH_GODDESS_INITIATION_RITES_'||numbers,		'Description',	'LOC_INITIATION_RITES'
	from counter where numbers > 0 and numbers < 10;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	'EARTH_GODDESS_INITIATION_RITES_'||numbers,		'DistrictType',	'DISTRICT_HOLY_SITE'
	from counter where numbers > 0 and numbers < 10;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	'EARTH_GODDESS_INITIATION_RITES_'||numbers,		'RequiredAppeal',	numbers * 2
	from counter where numbers > 0 and numbers < 10;

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	'EARTH_GODDESS_INITIATION_RITES_'||numbers,		'YieldChange',	1
	from counter where numbers > 0 and numbers < 10;

-- 封禅原启蒙会ModifierType

insert or ignore into Types (Type, Kind) VALUES 
('MODIFIER_PLAYER_DISTRICTS_ADJUST_BASE_YIELD_CHANGE', 'KIND_MODIFIER');

insert or ignore into DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES 
('MODIFIER_PLAYER_DISTRICTS_ADJUST_BASE_YIELD_CHANGE', 'COLLECTION_PLAYER_DISTRICTS', 'EFFECT_ADJUST_DISTRICT_BASE_YIELD_CHANGE');

--封禅原启蒙会建立于地貌--哼哼啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊--
--和地形
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'INITIATION_RITES',	GodhoodType||'_INITIATION_RITES_BONUS'
	from Godhood where ghClass in ('FEATURE',	'TERRAIN');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_INITIATION_RITES_BONUS',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',		'RS_'||GodhoodType||'_INITIATION_RITES_BONUS_'||ghParam1
	from Godhood where ghClass in ('FEATURE',	'TERRAIN');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_BONUS',		'YieldType',	'YIELD_FAITH'
	from Godhood where ghClass in ('FEATURE',	'TERRAIN');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_INITIATION_RITES_BONUS',		'Amount',	ghParam2
	from Godhood where ghClass in ('FEATURE',	'TERRAIN');

--封禅原启蒙会rs
    insert or ignore into RequirementSets(RequirementSetId, RequirementSetType) select
	'RS_'||GodhoodType||'_INITIATION_RITES_BONUS_'||ghParam1,		'REQUIREMENTSET_TEST_ALL'
	from Godhood where ghClass in ('FEATURE',	'TERRAIN');

    insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_INITIATION_RITES_BONUS_'||ghParam1,		'REQ_PLOT_HAS_DISTRICT_HOLY_SITE'
	from Godhood where ghClass in ('FEATURE',	'TERRAIN');

	insert or ignore into RequirementSetRequirements(RequirementSetId, RequirementId) select
	'RS_'||GodhoodType||'_INITIATION_RITES_BONUS_'||ghParam1,		'REQ_'||GodhoodType||'_TAG_MATCHES'
	from Godhood where ghClass in ('FEATURE',	'TERRAIN');

--




--愈合之神

/*
insert or ignore into PantheonModifiers(GodhoodType,	PowerType, ModifierId) select
	GodhoodType,	'AESCULAPIUS',	GodhoodType||'_AESCULAPIUS_HEAL'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	GodhoodType||'_AESCULAPIUS_HEAL',		'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN',		'RS_'||GodhoodType||'_AESCULAPIUS_HEAL'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_AESCULAPIUS_HEAL',		'Amount',	30
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');

insert or ignore into ModifierArguments(ModifierId,	Name,	Value) select
	GodhoodType||'_AESCULAPIUS_HEAL',		'Type',	'ALL'
	from Godhood where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN', 'APPEAL');
*/







--测试
insert or ignore into TraitModifiers(TraitType, ModifierId) values
	('TRAIT_LEADER_MAJOR_CIV',		'STONE_CIRCLES_RELIGIOUS_SETTLEMENTS_HOUSING2'),
		('TRAIT_LEADER_MAJOR_CIV',		'STONE_CIRCLES_RELIGIOUS_SETTLEMENTS_HOUSING1'),

	('TRAIT_LEADER_MAJOR_CIV',		'TEST_PANTHEON2');

insert or ignore into Modifiers(ModifierId, ModifierType,	SubjectRequirementSetId) values
	('TEST_PANTHEON1',				'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_CHANGE',		'RS_GODDESS_OF_THE_HUNT_THRESHOLD_4'),
	--('TEST_PANTHEON3',				'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_CHANGE',		'RS_DESERT_FOLK_LORE_THRESHOLD_4'),
	('TEST_PANTHEON2',				'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_CHANGE',		'RS_SACRED_PATH_THRESHOLD_3');

insert or ignore into ModifierArguments(ModifierId, Name, Value) values
	('TEST_PANTHEON1',				'YieldType',		'YIELD_CULTURE'),
	('TEST_PANTHEON1',				'Amount',			100),	
	--('TEST_PANTHEON3',				'YieldType',		'YIELD_FAITH'),
	--('TEST_PANTHEON3',				'Amount',			100),
	('TEST_PANTHEON2',				'YieldType',		'YIELD_SCIENCE'),
	('TEST_PANTHEON2',				'Amount',			100);


/*
--文本
create table 'PantheonTexts'(
	'PowerType' TEXT NOT NULL,
	'GodhoodType' TEXT NOT NULL,
	'Language' TEXT NOT NULL,
	'Texts' TEXT NOT NULL,
	PRIMARY KEY('GodhoodType', 'PowerType', 'Texts')
);

insert or replace into PantheonTexts	 (Language,      GodhoodType,      PowerType,                                                       Texts) select
	'zh_Hans_CN',		GodhoodType,	PowerType,			'LOC_'||GodhoodType||'_'||PowerType||'_'||pwParam1
	from Godhood, Power, ThresholdCounter where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN') and pwClass in ('DISTRICT', 'CITY')
	and pwParam1 in ('THRESHOLD1', 'THRESHOLD2') and ghParam3 = Delta and pwParam2 = Threshold;

insert or replace into PantheonTexts	 (Language,      GodhoodType,      PowerType,                                                       Texts) select
	'zh_Hans_CN',		GodhoodType,	PowerType,			'LOC_'||GodhoodType||'_'||PowerType||'_'||pwParam1
	from Godhood, Power where ghClass in ('IMPROVEMENT',	'FEATURE',	'TERRAIN') and pwClass = 'YIELD'
	 and ghParam3 >= pwParam2;

insert or replace into PantheonTexts	 (Language,      GodhoodType,      PowerType,                                                       Texts) select
	'zh_Hans_CN',		GodhoodType,	PowerType,			'LOC_'||GodhoodType||'_'||PowerType||'_'||pwParam1
	from Godhood, Power where ghClass = 'APPEAL' and pwClass in ('DISTRICT', 'CITY', 'YIELD');

*/

