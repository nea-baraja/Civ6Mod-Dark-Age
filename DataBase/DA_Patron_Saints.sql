create table 'PatronSaints'(
	'Saint' TEXT NOT NULL,
	'Class' TEXT,
	'BuildingType' TEXT,
	'Cost' INT,
	PRIMARY KEY('Saint')
);

insert or replace into PatronSaints(Saint,		Cost) values
	('MOSES',				120),
	('HERCULES',			70);

update PatronSaints set BuildingType = 'BUILDING_SAINT_'||Saint;

insert or replace into Types (Type, Kind) select BuildingType, 'KIND_BUILDING' from PatronSaints;

insert or replace into Buildings (BuildingType,	Name,	Cost,	Description,	PrereqDistrict,	MustPurchase,	PurchaseYield,	MaxWorldInstances)
select BuildingType, 'LOC_'||BuildingType||'_NAME',		Cost, 	'LOC_'||BuildingType||'_DESCRIPTION',	'DISTRICT_CITY_CENTER',	1,	'YIELD_FAITH',	1
from PatronSaints;

insert or replace into Buildings_XP2 (BuildingType, Pillage)
select BuildingType, 0 from PatronSaints;

insert or replace into MutuallyExclusiveBuildings (Building, MutuallyExclusiveBuilding)
select a.BuildingType, b.BuildingType from PatronSaints a, PatronSaints b where a.BuildingType != b.BuildingType;



insert or replace into BuildingModifiers(BuildingType,			ModifierId) values
	('BUILDING_SAINT_MOSES',			'DA_MOSES_FREE_SETTLER'),
	('BUILDING_SAINT_HERCULES',			'DA_HERCULES_FREE_BUILDER');


--insert or replace into Modifiers(ModifierId,		ModifierType,		SubjectRequirementSetId) values
--	()


