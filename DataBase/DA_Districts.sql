
/*
insert or replace into Types(Type, Kind) values
	('DISTRICT_TEST',	'KIND_DISTRICT');

insert or replace into Districts(DistrictType, Name, Description, Cost,
 RequiresPlacement, RequiresPopulation, NoAdjacentCity, Aqueduct, InternalOnly, CaptureRemovesBuildings, CaptureRemovesCityDefenses, PlunderType, 
 PlunderAmount, MilitaryDomain, Appeal, Housing, Entertainment, OnePerCity, Maintenance, AirSlots, CitizenSlots, MaxPerPlayer,
 PrereqTech) values
('DISTRICT_TEST', 'LOC_DISTRICT_TEST_NAME', 'LOC_DISTRICT_TEST_DESCRIPTION', 1,
1, 0, 0, 0, 0, 0, 0, 'YIELD_GOLD',
1, 'NO_DOMAIN', 0, 0, 0, 1, 0, 0, 0, 1,
'TECH_FUTURE_TECH');  

insert or replace into MutuallyExclusiveDistricts(District, MutuallyExclusiveDistrict) values
	('DISTRICT_HOLY_SITE', 'DISTRICT_TEST'),
	('DISTRICT_TEST', 'DISTRICT_HOLY_SITE');  */

update Districts set Description = 'LOC_DA_'||DistrictType||'_DESCRIPTION'
 WHERE DistrictType = 'DISTRICT_HOLY_SITE'				--圣地
	OR DistrictType = 'DISTRICT_CAMPUS'					--学院
	OR DistrictType = 'DISTRICT_ENCAMPMENT'				--军营
	OR DistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
	OR DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
	OR DistrictType = 'DISTRICT_THEATER'				--剧院
	--OR DistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
	--OR DistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
;

UPDATE Districts SET CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 40, Cost = 40 
 WHERE DistrictType = 'DISTRICT_HOLY_SITE'				--圣地
	OR DistrictType = 'DISTRICT_CAMPUS'					--学院
	OR DistrictType = 'DISTRICT_ENCAMPMENT'				--军营
	OR DistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
	OR DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
	OR DistrictType = 'DISTRICT_THEATER'				--剧院
	OR DistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
	OR DistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
;

-- unique districts
UPDATE Districts SET CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 20, Cost = 40 WHERE DistrictType in 
(SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE
	ReplacesDistrictType = 'DISTRICT_HOLY_SITE'					--圣地
	OR ReplacesDistrictType = 'DISTRICT_CAMPUS'					--学院
	OR ReplacesDistrictType = 'DISTRICT_ENCAMPMENT'				--军营
	OR ReplacesDistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
	OR ReplacesDistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
	OR ReplacesDistrictType = 'DISTRICT_THEATER'				--剧院
	OR ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
	OR ReplacesDistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
);

update Districts set CostProgressionModel = 'NO_COST_PROGRESSION', CostProgressionParam1 = 0
 where DistrictType = 'DISTRICT_GOVERNMENT'				--政府区
	or DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER'		--外交区
	or DistrictType = 'DISTRICT_AERODROME'				--空港
	or DistrictType = 'DISTRICT_HARBOR'					--港口
	or DistrictType = 'DISTRICT_AQUEDUCT'				--水渠
	or DistrictType = 'DISTRICT_NEIGHBORHOOD'			--社区
	or DistrictType = 'DISTRICT_CANAL'					--运河
	or DistrictType = 'DISTRICT_DAM'					--大坝
	or DistrictType = 'DISTRICT_THANH'					--城池（越南）
	or DistrictType = 'DISTRICT_PRESERVE'				--保护区
--	or DistrictType = 'DISTRICT_HIPPODROME'				--跑马场(拜占庭)
;

update Districts set Cost = 60 where DistrictType = 'DISTRICT_GOVERNMENT';
update Districts set Cost = 60 where DistrictType = 'DISTRICT_DIPLOMATIC_QUARTER';
update Districts set Cost = 90 where DistrictType = 'DISTRICT_HARBOR';
update Districts set Cost = 90 where DistrictType = 'DISTRICT_AQUEDUCT';
update Districts set Cost = 75 where DistrictType = 'DISTRICT_PRESERVE';
update Districts set CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 0, Cost = 60 where DistrictType in 
(select CivUniqueDistrictType from DistrictReplaces where
	ReplacesDistrictType = 'DISTRICT_AQUEDUCT'
	or ReplacesDistrictType = 'DISTRICT_HARBOR'
	or ReplacesDistrictType = 'DISTRICT_PRESERVE'
	or ReplacesDistrictType = 'DISTRICT_GOVERNMENT'
	or ReplacesDistrictType = 'DISTRICT_DIPLOMATIC_QUARTER'
);

update Districts set CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1 = 0, Cost = 90 where DistrictType in 
(select CivUniqueDistrictType from DistrictReplaces where ReplacesDistrictType = 'DISTRICT_NEIGHBORHOOD');

update Districts set Cost = 60 where DistrictType = 'DISTRICT_THANH';

update Districts set Cost = 150 where DistrictType = 'DISTRICT_AERODROME';
update Districts set Cost = 200 where DistrictType = 'DISTRICT_CANAL';
update Districts set Cost = 200 where DistrictType = 'DISTRICT_DAM';


insert or replace into District_CitizenGreatPersonPoints
	(DistrictType,						GreatPersonClassType,				PointsPerTurn)
values
	("DISTRICT_CAMPUS",					"GREAT_PERSON_CLASS_SCIENTIST",		1),
	("DISTRICT_COMMERCIAL_HUB",			"GREAT_PERSON_CLASS_MERCHANT",		1),
	("DISTRICT_ENCAMPMENT",				"GREAT_PERSON_CLASS_GENERAL",		1),
	("DISTRICT_HARBOR",					"GREAT_PERSON_CLASS_ADMIRAL",		1),
	("DISTRICT_HOLY_SITE",				"GREAT_PERSON_CLASS_PROPHET",		1),
	("DISTRICT_INDUSTRIAL_ZONE",		"GREAT_PERSON_CLASS_ENGINEER",		1),
	("DISTRICT_THEATER",				"GREAT_PERSON_CLASS_WRITER",		1),
	("DISTRICT_THEATER",				"GREAT_PERSON_CLASS_ARTIST",		1),
	("DISTRICT_THEATER",				"GREAT_PERSON_CLASS_MUSICIAN",		1),
	("DISTRICT_AQUEDUCT",				"GREAT_PERSON_CLASS_ENGINEER",		1);

-- UD support
insert or ignore into District_CitizenGreatPersonPoints (DistrictType, GreatPersonClassType, PointsPerTurn)
select b.CivUniqueDistrictType,	a.GreatPersonClassType,	a.PointsPerTurn
from District_CitizenGreatPersonPoints a, DistrictReplaces b where a.DistrictType = b.ReplacesDistrictType;

update Districts set CitizenSlots = 1 
 where DistrictType = 'DISTRICT_CAMPUS'
 	or DistrictType = 'DISTRICT_COMMERCIAL_HUB'
 	or DistrictType = 'DISTRICT_ENCAMPMENT'
 	or DistrictType = 'DISTRICT_HARBOR'
 	or DistrictType = 'DISTRICT_HOLY_SITE'
 	or DistrictType = 'DISTRICT_INDUSTRIAL_ZONE'
 	or DistrictType = 'DISTRICT_THEATER'
 	or DistrictType = 'DISTRICT_AQUEDUCT';

update Districts set CitizenSlots = 1 where DistrictType in 
(select CivUniqueDistrictType from DistrictReplaces 
 where ReplacesDistrictType = 'DISTRICT_CAMPUS'
 	or ReplacesDistrictType = 'DISTRICT_COMMERCIAL_HUB'
 	or ReplacesDistrictType = 'DISTRICT_ENCAMPMENT'
 	or ReplacesDistrictType = 'DISTRICT_HARBOR'
 	or ReplacesDistrictType = 'DISTRICT_HOLY_SITE'
 	or ReplacesDistrictType = 'DISTRICT_INDUSTRIAL_ZONE'
 	or ReplacesDistrictType = 'DISTRICT_THEATER'
 	or ReplacesDistrictType = 'DISTRICT_AQUEDUCT');

DELETE FROM District_CitizenYieldChanges 
WHERE DistrictType IN ('DISTRICT_CAMPUS', 'DISTRICT_COMMERCIAL_HUB', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR', 'DISTRICT_HOLY_SITE', 'DISTRICT_THEATER', 'DISTRICT_INDUSTRIAL_ZONE');

insert or replace into District_CitizenYieldChanges
	(DistrictType,				YieldType,			YieldChange)
values
	('DISTRICT_CAMPUS',			'YIELD_SCIENCE',	2),
	('DISTRICT_COMMERCIAL_HUB',	'YIELD_GOLD',		6),
	('DISTRICT_ENCAMPMENT',		'YIELD_FOOD',		1),
	('DISTRICT_ENCAMPMENT',		'YIELD_PRODUCTION', 1),
	('DISTRICT_HARBOR',			'YIELD_GOLD',		3),
	('DISTRICT_HARBOR',			'YIELD_FOOD',		1),
	('DISTRICT_HOLY_SITE',		'YIELD_FAITH',		4),
	('DISTRICT_THEATER',		'YIELD_CULTURE',	2),
	('DISTRICT_INDUSTRIAL_ZONE','YIELD_PRODUCTION', 2),
	('DISTRICT_AQUEDUCT',		'YIELD_FOOD', 		2),
	('DISTRICT_AQUEDUCT',		'YIELD_PRODUCTION', 2);

-- 删除区域自带伟人点。可能要给AI加回来
--update District_GreatPersonPoints set PointsPerTurn = 0 where DistrictType IN ('DISTRICT_CAMPUS', 'DISTRICT_COMMERCIAL_HUB', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR', 'DISTRICT_HOLY_SITE', 'DISTRICT_THEATER', 'DISTRICT_INDUSTRIAL_ZONE');
--update District_GreatPersonPoints set PointsPerTurn = 0 where 
--	DistrictType in (select CivUniqueDistrictType from DistrictReplaces where ReplacesDistrictType IN ('DISTRICT_CAMPUS', 'DISTRICT_COMMERCIAL_HUB', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR', 'DISTRICT_HOLY_SITE', 'DISTRICT_THEATER', 'DISTRICT_INDUSTRIAL_ZONE'));

update Districts set RequiresPopulation = 0 where DistrictType = 'DISTRICT_GOVERNMENT'
	or DistrictType in (select CivUniqueDistrictType from DistrictReplaces where ReplacesDistrictType = 'DISTRICT_GOVERNMENT');


--delete from District_Adjacencies where DistrictType IN ('DISTRICT_CAMPUS', 'DISTRICT_COMMERCIAL_HUB', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR', 'DISTRICT_HOLY_SITE', 'DISTRICT_THEATER', 'DISTRICT_INDUSTRIAL_ZONE');
/*
insert or replace into District_Adjacencies
	(DistrictType,					YieldChangeId)
select
	'DISTRICT_THEATER',				DistrictType || '_Theater_Culture'
from Districts where DistrictType IN ('DISTRICT_CAMPUS', 'DISTRICT_COMMERCIAL_HUB', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR', 'DISTRICT_HOLY_SITE', 'DISTRICT_THEATER', 'DISTRICT_INDUSTRIAL_ZONE');
insert or replace into District_Adjacencies
	(DistrictType,					YieldChangeId)
select
	'DISTRICT_THEATER',				DistrictType || '_Theater_Culture'
from Districts where DistrictType IN ('DISTRICT_CAMPUS', 'DISTRICT_COMMERCIAL_HUB', 'DISTRICT_ENCAMPMENT', 'DISTRICT_HARBOR', 'DISTRICT_HOLY_SITE', 'DISTRICT_THEATER', 'DISTRICT_INDUSTRIAL_ZONE');

*/

insert or replace into DistrictModifiers(DistrictType,				ModifierId) values
	--('DISTRICT_CAMPUS',						'CAMPUS_ADD_MINE_SCIENCE'),
	--('DISTRICT_CAMPUS',						'CAMPUS_ADD_FARM_SCIENCE'),	
	--('DISTRICT_THEATER',					'THEATER_ADD_QUARRY_CULTURE'),
	--('DISTRICT_THEATER',					'THEATER_ADD_PLANTATION_CULTURE'),
	('DISTRICT_ENCAMPMENT',					'ENCAMPMENT_ADD_PASTURE_PRODUCTION'),
	('DISTRICT_ENCAMPMENT',					'ENCAMPMENT_ADD_QUARRY_PRODUCTION'),
	--('DISTRICT_ENCAMPMENT',					'ENCAMPMENT_ADD_MINE_PRODUCTION'),
	('DISTRICT_COMMERCIAL_HUB',				'COMMERCIAL_HUB_ADD_PLANTATION_GOLD'),
	('DISTRICT_COMMERCIAL_HUB',				'COMMERCIAL_HUB_ADD_PASTURE_GOLD'),
	('DISTRICT_HARBOR',						'HARBOR_ADD_FISHING_BOATS_FOOD');
	--('DISTRICT_ENTERTAINMENT_COMPLEX',		'ENTERTAINMENT_COMPLEX_ADD_CAMP_CULTURE'),
	--('DISTRICT_ENTERTAINMENT_COMPLEX',		'ENTERTAINMENT_COMPLEX_ADD_PASTURE_CULTURE');

insert or replace into Modifiers(ModifierId,		ModifierType,									SubjectRequirementSetId) values
	('CAMPUS_ADD_MINE_SCIENCE',						'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_MINE'),
	('CAMPUS_ADD_FARM_SCIENCE',						'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_FARM'),
	('THEATER_ADD_QUARRY_CULTURE',					'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_QUARRY'),
	('THEATER_ADD_PLANTATION_CULTURE',				'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_PLANTATION'),
	('ENCAMPMENT_ADD_PASTURE_PRODUCTION',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_PASTURE'),
	('ENCAMPMENT_ADD_QUARRY_PRODUCTION',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_QUARRY'),
	('COMMERCIAL_HUB_ADD_PLANTATION_GOLD',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_PLANTATION'),
	('COMMERCIAL_HUB_ADD_PASTURE_GOLD',				'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_PASTURE'),
	('HARBOR_ADD_FISHING_BOATS_FOOD',				'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_FISHING_BOATS'),
	('ENTERTAINMENT_COMPLEX_ADD_CAMP_CULTURE',		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_CAMP'),
	('ENTERTAINMENT_COMPLEX_ADD_PASTURE_CULTURE',	'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_PASTURE');

insert or replace into ModifierArguments(ModifierId,			Name,			Value) values
	('CAMPUS_ADD_MINE_SCIENCE',							'YieldType',			'YIELD_SCIENCE'),
	('CAMPUS_ADD_MINE_SCIENCE',							'Amount',				1),
	('CAMPUS_ADD_FARM_SCIENCE',							'YieldType',			'YIELD_SCIENCE'),
	('CAMPUS_ADD_FARM_SCIENCE',							'Amount',				1),
	('THEATER_ADD_QUARRY_CULTURE',						'YieldType',			'YIELD_CULTURE'),
	('THEATER_ADD_QUARRY_CULTURE',						'Amount',				1),
	('THEATER_ADD_PLANTATION_CULTURE',					'YieldType',			'YIELD_CULTURE'),
	('THEATER_ADD_PLANTATION_CULTURE',					'Amount',				1),
	('ENCAMPMENT_ADD_PASTURE_PRODUCTION',				'YieldType',			'YIELD_PRODUCTION'),
	('ENCAMPMENT_ADD_PASTURE_PRODUCTION',				'Amount',				1),
	('ENCAMPMENT_ADD_QUARRY_PRODUCTION',				'YieldType',			'YIELD_PRODUCTION'),
	('ENCAMPMENT_ADD_QUARRY_PRODUCTION',				'Amount',				1),
	('COMMERCIAL_HUB_ADD_PLANTATION_GOLD',				'YieldType',			'YIELD_GOLD'),
	('COMMERCIAL_HUB_ADD_PLANTATION_GOLD',				'Amount',				3),
	('COMMERCIAL_HUB_ADD_PASTURE_GOLD',					'YieldType',			'YIELD_GOLD'),
	('COMMERCIAL_HUB_ADD_PASTURE_GOLD',					'Amount',				3),
	('HARBOR_ADD_FISHING_BOATS_FOOD',					'YieldType',			'YIELD_FOOD'),
	('HARBOR_ADD_FISHING_BOATS_FOOD',					'Amount',				2),
	('ENTERTAINMENT_COMPLEX_ADD_CAMP_CULTURE',			'YieldType',			'YIELD_CULTURE'),
	('ENTERTAINMENT_COMPLEX_ADD_CAMP_CULTURE',			'Amount',				1),
	('ENTERTAINMENT_COMPLEX_ADD_PASTURE_CULTURE',		'YieldType',			'YIELD_CULTURE'),
	('ENTERTAINMENT_COMPLEX_ADD_PASTURE_CULTURE',		'Amount',				1);

insert or replace into DistrictModifiers(DistrictType,	ModifierId) select
	'DISTRICT_CITY_CENTER',		DistrictType||'_'||numbers||'_WORKER_CONSUME_AMENITY'
	from counter, Districts where numbers >= 1 and numbers <= 8	and DistrictType not in ('DISTRICT_CITY_CENTER');

insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	DistrictType||'_'||numbers||'_WORKER_CONSUME_AMENITY',	'MODIFIER_CITY_DISTRICTS_ADJUST_DISTRICT_AMENITY',	'RS_'||DistrictType||'_HAS_'||numbers||'_WORKERS'
	from counter, Districts where numbers >= 1 and numbers <= 8	and DistrictType not in ('DISTRICT_CITY_CENTER');

insert or replace into ModifierArguments(ModifierId,	Name, Value) select
	DistrictType||'_'||numbers||'_WORKER_CONSUME_AMENITY',	'Amount',	-1
	from counter, Districts where numbers >= 1 and numbers <= 8	and DistrictType not in ('DISTRICT_CITY_CENTER');
