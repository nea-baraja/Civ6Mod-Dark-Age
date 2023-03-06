insert into IconTextureAtlases
    (Name,                                              IconSize,   IconsPerRow,    IconsPerColumn,     Filename)
values
    ('ICON_ATLAS_PANTHEON_DA',                          256,        8,              8,                  'DA_Pantheons256'),
    ('ICON_ATLAS_PANTHEON_DA',                          64,         8,              8,                  'DA_Pantheons64'),   
    ('ICON_ATLAS_PANTHEON_DA',                          50,         8,              8,                  'DA_Pantheons50'),
    ('ICON_ATLAS_PANTHEON_DA',                          32,         8,              8,                  'DA_Pantheons32');




insert or replace into IconDefinitions
    (Name,                                              Atlas,                                              'Index')
values
    ('ICON_BELIEF_GOD_OF_WINE',                         'ICON_ATLAS_PANTHEON_DA',                           0),
    ('ICON_BELIEF_GGV',                                 'ICON_ATLAS_PANTHEON_DA',                           2),
    ('ICON_BELIEF_SHENNONG',                            'ICON_ATLAS_PANTHEON_DA',                           6);
