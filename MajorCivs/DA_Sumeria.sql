

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_CIVILIZATION_FIRST_CIVILIZATION',	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS'
from counter where numbers > 0 and numbers < 16;

insert or replace into TraitModifiers(TraitType,	ModifierId) select
	'TRAIT_CIVILIZATION_FIRST_CIVILIZATION',	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES'
from counter where numbers > 0 and numbers < 8;


insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS',		'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_PROP_CONQUEST_COUNT_'||numbers
from counter where numbers > 0 and numbers < 16;

insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES',		'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',	'RS_PROP_ALLY_COUNT_'||numbers
from counter where numbers > 0 and numbers < 8;


insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS_MOD',		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_ZIGGURAT'
from counter where numbers > 0 and numbers < 16;

insert or replace into Modifiers(ModifierId,	ModifierType, SubjectRequirementSetId) select
	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES_MOD',		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'RS_PLOT_HAS_IMPROVEMENT_ZIGGURAT'
from counter where numbers > 0 and numbers < 8;


insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS',		'ModifierId',	'ZIGGURAT_SCIENCE_FOR_'||numbers||'_CONQUESTS_MOD'
from counter where numbers > 0 and numbers < 16;

insert or replace into ModifierArguments(ModifierId,	Name,	Value) select
	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES',		'ModifierId',	'ZIGGURAT_CULTURE_FOR_'||numbers||'_ALLIES_MOD'
from counter where numbers > 0 and numbers < 8;




