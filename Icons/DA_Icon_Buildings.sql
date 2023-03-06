insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_BUILDING_DA',                          256,        8,              8,                  'DA_Buildings_256.dds'),
    ('ICON_ATLAS_BUILDING_DA',                          128,        8,              8,                  'DA_Buildings_128.dds'),
    ('ICON_ATLAS_BUILDING_DA',                          80,         8,              8,                  'DA_Buildings_80.dds'),
    --('ICON_ATLAS_BUILDING_DA',                          64,         8,              8,                  'DA_Buildings_64.dds'),

    ('ICON_ATLAS_BUILDING_DA',                          50,         8,              8,                  'DA_Buildings_50.dds'),
    ('ICON_ATLAS_BUILDING_DA',                          38,         8,              8,                  'DA_Buildings_38.dds'),
    ('ICON_ATLAS_BUILDING_DA',                          32,         8,              8,                  'DA_Buildings_32.dds');




insert or replace into IconDefinitions
    (Name,                                              Atlas,                                              'Index')
values
    ('ICON_BUILDING_MASON',                             'ICON_ATLAS_BUILDING_DA',                           1),
    ('ICON_BUILDING_PAPER_MAKER',                       'ICON_ATLAS_BUILDING_DA',                           3);
