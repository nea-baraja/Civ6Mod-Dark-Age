create table 'DistrictCitizenYields'(
	'Id' TEXT NOT NULL,
	'YieldType'	TEXT,
	'BuildingType' TEXT,
	'Amount'	INT,
	'DistrictType'	TEXT,
	'CitizenSlots'	INT,
	PRIMARY KEY('Id','DistrictType')	
);

insert or replace into DistrictCitizenYields
(Id,						YieldType,			Amount,		    DistrictType,			CitizenSlots) select
'OLIGARCHY_FOOD_COST',		'YIELD_FOOD',		-2,				DistrictType,			0
from Districts where DistrictType = 'DISTRICT_HOLY_SITE'				--圣地
	or DistrictType = 'DISTRICT_CAMPUS'					--学院
	or DistrictType = 'DISTRICT_ENCAMPMENT'				--军营
	or DistrictType = 'DISTRICT_COMMERCIAL_HUB'			--商业
	or DistrictType = 'DISTRICT_ENTERTAINMENT_COMPLEX'	--娱乐
	or DistrictType = 'DISTRICT_THEATER'				--剧院
	or DistrictType = 'DISTRICT_INDUSTRIAL_ZONE'		--工业
	or DistrictType = 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX' --水上娱乐
	or DistrictType = 'DISTRICT_HARBOR' --港口
;





update DistrictCitizenYields set BuildingType = 'BUILDING_CTZY_'||Id||'_IN_'||DistrictType;

--百科不显示虚拟建筑
insert or replace into CivilopediaPageExcludes(SectionId,	PageId)	select
'BUILDINGS',	BuildingType from DistrictCitizenYields;




insert or replace into Types (Type, Kind) 
	select BuildingType,	'KIND_BUILDING' from DistrictCitizenYields;

insert or replace into Buildings (BuildingType,	Name,	Cost,	Description,	PrereqDistrict,	MustPurchase,	CitizenSlots)
select BuildingType, 'LOC_CTZY_'||Id||'_NAME',		1, 		'LOC_CTZY_'||Id||'_DESCRIPTION',	DistrictType,	1,	CitizenSlots
from DistrictCitizenYields;

insert or replace into Buildings_XP2 (BuildingType, Pillage)
select BuildingType, 0 from DistrictCitizenYields;

insert or replace into Building_CitizenYieldChanges(BuildingType,		YieldType,		YieldChange)
select BuildingType,	YieldType,		Amount from DistrictCitizenYields;

