delete from TraitModifiers where TraitType = 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE';

create table "China_Dynasties"(
'CivilizationType' TEXT,
'TraitType' TEXT NOT NULL,
'ModifierId' TEXT NOT NULL,
PRIMARY KEY('TraitType','ModifierId')
);


insert or replace into China_Dynasties (TraitType,	ModifierId)
		select TraitType,	ModifierId
	from TraitModifiers;

update China_Dynasties set 
	CivilizationType = (select CivilizationTraits.CivilizationType
	from CivilizationTraits 
	where China_Dynasties.TraitType = CivilizationTraits.TraitType);

delete from China_Dynasties where CivilizationType is null;


insert or replace into TraitModifiers (TraitType,	ModifierId)
	select 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE',		'CHINA_ATTACH_'||ModifierId
	from China_Dynasties;

insert or replace into Modifiers(ModifierId,  	ModifierType, 		SubjectRequirementSetId)
	select 'CHINA_ATTACH_'||ModifierId,	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',		'DYNASTY_'||CivilizationType
	from China_Dynasties;

insert or replace into ModifierArguments(ModifierId,	Name,	Value)
	select 'CHINA_ATTACH_'||ModifierId,	'ModifierId',	ModifierId
	from China_Dynasties;

insert or replace into Requirements (RequirementId, RequirementType)
select 'REQ_DYNASTY_'||CivilizationType, 'REQUIREMENT_PLOT_PROPERTY_MATCHES'
	from China_Dynasties;

insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_DYNASTY_'||CivilizationType, 'PropertyName', 'CD_'||CivilizationType
	from China_Dynasties;
insert or replace into RequirementArguments (RequirementId, Name, Value)
select 'REQ_DYNASTY_'||CivilizationType, 'PropertyMinimum', 1
	from China_Dynasties;

insert or ignore into RequirementSets
    (RequirementSetId,                                  RequirementSetType)
select	'DYNASTY_'||CivilizationType,					'REQUIREMENTSET_TEST_ALL'
	from China_Dynasties;
                                   
insert or ignore into RequirementSetRequirements
    (RequirementSetId,                                  RequirementId)
select	'DYNASTY_'||CivilizationType,				'REQ_DYNASTY_'||CivilizationType  
	from China_Dynasties;
