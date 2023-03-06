create table 'StrategicProjects'(
	'Id' TEXT NOT NULL,
	'ProjectType'	TEXT,
	'BuildingType'	TEXT,
	'EnableCivicType' TEXT,
	'EnableTechType' TEXT,
	'Cost' INT NOT NULL,
	'PreDistrict' TEXT,
	'ResourceType'	TEXT,
	'Amount' INT,
	'Maintenance' INT,
	PRIMARY KEY('Id')
);


--填写战略项目信息
insert or replace into StrategicProjects
(Id,					EnableCivicType,			EnableTechType,		    	Cost,		PreDistrict,				ResourceType,		Amount,		Maintenance) values
('SET_IRON_OFFICER',	NULL,						'TECH_IRON_WORKING',		20,			'DISTRICT_CITY_CENTER',		'RESOURCE_IRON',	20,			3),
('FORGE_WEAPON',		NULL,						'TECH_IRON_WORKING',		20,			'DISTRICT_CITY_CENTER',		'RESOURCE_IRON',	10,			2),
('IRON_FARM_TOOL',		NULL,						'TECH_IRON_WORKING',		20,			'DISTRICT_CITY_CENTER',		'RESOURCE_IRON',	10,			2),
('ANIMAL_POWER',		NULL,						'TECH_HORSEBACK_RIDING',	20,			'DISTRICT_CITY_CENTER',		'RESOURCE_HORSES',	10,			2),
('CARRIAGE_TRANSPORT',	NULL,						'TECH_HORSEBACK_RIDING',	20,			'DISTRICT_CITY_CENTER',		'RESOURCE_HORSES',	10,			2);



insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_STG_'||Id,                     					'ICON_ATLAS_RESOURCES',         43
from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_PROJECT_STG_'||Id,                     					'ICON_ATLAS_RESOURCES',         42
from StrategicProjects where ResourceType = 'RESOURCE_HORSES';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_STG_'||Id,                     					'ICON_ATLAS_RESOURCES',         43
from StrategicProjects where ResourceType = 'RESOURCE_IRON';

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index')
select
    'ICON_BUILDING_STG_'||Id,                     					'ICON_ATLAS_RESOURCES',         42
from StrategicProjects where ResourceType = 'RESOURCE_HORSES';