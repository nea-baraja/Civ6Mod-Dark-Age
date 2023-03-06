insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_EVENT_FRAME',                          38,        14,              1,                  'EventFrames');



insert or replace into IconDefinitions
    (Name,                                              Atlas,                                              'Index')
values
    ('ICON_EVENT_GOOD',                             'ICON_ATLAS_EVENT_FRAME',                           7),
    ('ICON_EVENT_BAD',                              'ICON_ATLAS_EVENT_FRAME',                           4);