

update Technologies set Description = 'LOC_'||TechnologyType||'_DESCRIPTION' where TechnologyType in
	('TECH_ARCHERY',	'TECH_HORSEBACK_RIDING');


