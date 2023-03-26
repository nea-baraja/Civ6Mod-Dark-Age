
insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_DA_CIVIC',                             38,         8,              8,                  'Civics_mn_38'),
    ('ICON_ATLAS_DA_CIVIC',                             42,         8,              8,                  'Civics_mn_42'),
    ('ICON_ATLAS_DA_CIVIC',                             128,        8,              8,                  'Civics_mn_128'),
    ('ICON_ATLAS_DA_CIVIC',                            160,         8,              8,                  'Civics_mn_160');

insert or replace into IconDefinitions
    (Name,                                                          Atlas,                          'Index') values
    ('ICON_CIVIC_NATIVE_LAND',                                      'ICON_ATLAS_DA_CIVIC',           3),
    ('ICON_CIVIC_SORCERY_AND_HERB',                                 'ICON_ATLAS_DA_CIVIC',           4),

    ('ICON_GOVERNMENT_PRIEST_COUNCIL',                              'ICON_ATLAS_GOVERNMENTS',        0),
    ('ICON_GOVERNMENT_CITY_STATE_ALLIANCE',                         'ICON_ATLAS_GOVERNMENTS',        0),
    ('ICON_GOVERNMENT_TRIBE_UNITY',                                 'ICON_ATLAS_GOVERNMENTS',        0),
    ('ICON_GOVERNMENT_PRIEST_COUNCIL_FOW',                          'ICON_ATLAS_GOVERNMENTS_FOW',    0),
    ('ICON_GOVERNMENT_CITY_STATE_ALLIANCE_FOW',                     'ICON_ATLAS_GOVERNMENTS_FOW',    0),
    ('ICON_GOVERNMENT_TRIBE_UNITY_FOW',                             'ICON_ATLAS_GOVERNMENTS_FOW',    0);


