
delete from GoodyHuts where ImprovementType = 'IMPROVEMENT_GOODY_HUT';
delete from GoodyHutSubtypes where GoodyHut like 'GOODYHUT_%';

insert or replace into GoodyHuts(GoodyHutType,	ImprovementType,	Weight, ShowMoment) values
	('GOODYHUT_EVENT',	'IMPROVEMENT_GOODY_HUT',		100,	1),
	('BARB_GOODIES',	'IMPROVEMENT_BARBARIAN_CAMP',	100,	1);


insert or replace into GoodyHutSubtypes(GoodyHut,	SubTypeGoodyHut,	Weight, ModifierID) values
	('GOODYHUT_EVENT',	'GOODYHUT_EVENT',		100,		'DO_NOTHING'),
	('BARB_GOODIES',	'BARB_GOODIES',			100,		'DO_NOTHING');

update Improvements set Goody = 1  where ImprovementType = 'IMPROVEMENT_BARBARIAN_CAMP';
