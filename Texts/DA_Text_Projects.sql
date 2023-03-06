create table 'StrategicProjectTexts'(
    'Id' TEXT NOT NULL,
    'ResourceType' TEXT,
    'Name' TEXT,
    'EffectText' TEXT,
    'BuildingText' TEXT,
    'ProjectText' TEXT,
    PRIMARY KEY('Id')
);

insert or replace into StrategicProjectTexts(Id,    ResourceType) values
    ('SET_IRON_OFFICER',        'RESOURCE_IRON'),
    ('FORGE_WEAPON',            'RESOURCE_IRON'),
    ('IRON_FARM_TOOL',          'RESOURCE_IRON'),
    ('ANIMAL_POWER',            'RESOURCE_HORSES'),
    ('CARRIAGE_TRANSPORT',      'RESOURCE_HORSES');


update StrategicProjectTexts set
    Name                    = 'LOC_STG_' || Id,
    EffectText              = 'LOC_STG_' || Id || '_EFFECT',
    BuildingText            = 'LOC_BUILDING_STG_' || Id,
    ProjectText             = 'LOC_PROJECT_STG_' || Id;


insert or replace into EnglishText (Tag, Text) select
    BuildingText || '_NAME',            '{'||Name||'}{LOC_DA_SPACE}{LOC_STG_NAME}'
from StrategicProjectTexts;
insert or replace into EnglishText (Tag, Text) select
    BuildingText || '_DESCRIPTION',     '{'||Name||'}{LOC_DA_SPACE}{LOC_STG_NAME}{LOC_DA_SPACE}{LOC_UNDERGOING_TEXT}[NEWLINE]{'||EffectText||'} {LOC_STG_'||ResourceType||'_COST}'
from StrategicProjectTexts;

insert or replace into EnglishText (Tag, Text) select
    ProjectText || '_NAME',       '{LOC_MODS_ENABLE}{LOC_DA_SPACE}{'||BuildingText||'_NAME}'
from StrategicProjectTexts;
insert or replace into EnglishText (Tag, Text) select
    ProjectText || '_SHORT_NAME', '{LOC_MODS_ENABLE}{LOC_DA_SPACE}{'||Name||'}'
from StrategicProjectTexts;
insert or replace into EnglishText (Tag, Text) select
    ProjectText || '_DESCRIPTION', '{LOC_MODS_ENABLE} {'||BuildingText||'_NAME}[NEWLINE]{'||EffectText||'} {LOC_STG_'||ResourceType||'_COST}'
from StrategicProjectTexts;



insert or replace into LocalizedText
    (Language,      Tag,                                                             Text)
values
    ("zh_Hans_CN",  "LOC_STG_NAME",                                                 "战略项目"),
    ("zh_Hans_CN",  "LOC_DA_SPACE",                                                 ""),
    ("zh_Hans_CN",  "LOC_UNDERGOING_TEXT",                                          "已启用"),

    ("zh_Hans_CN",  "LOC_STG_RESOURCE_IRON_COST",                                   "当 [ICON_RESOURCE_IRON] 铁资源不足时，3 [ICON_PRODUCTION] 生产力可兑换1 [ICON_RESOURCE_IRON] 铁。当城市拥有改良的铁资源或拥有兵营时兑换所需的 [ICON_PRODUCTION] 生产力都会-1。"),
    ("zh_Hans_CN",  "LOC_STG_RESOURCE_HORSES_COST",                                 "当 [ICON_RESOURCE_HORSES] 马资源不足时，3 [ICON_FOOD] 食物可兑换1 [ICON_RESOURCE_HORSES] 马。当城市拥有改良的马资源或拥有马厩时兑换所需的 [ICON_FOOD] 食物都会-1。"),

    ("zh_Hans_CN",  "LOC_STG_SET_IRON_OFFICER",                                     "设立铁官"),
    ("zh_Hans_CN",  "LOC_STG_SET_IRON_OFFICER_EFFECT",                              "城市可以无视人口需求再建造一个专业区域。此项目需要3点 [ICON_RESOURCE_IRON] 铁资源进行维护。"),

    ("zh_Hans_CN",  "LOC_STG_FORGE_WEAPON",                                         "金戈铁马"),
    ("zh_Hans_CN",  "LOC_STG_FORGE_WEAPON_EFFECT",                                  "城市生产的军事单位+3战斗力。此项目需要2点 [ICON_RESOURCE_IRON] 铁资源进行维护。"),

    ("zh_Hans_CN",  "LOC_STG_IRON_FARM_TOOL",                                       "铸剑为犁"),
    ("zh_Hans_CN",  "LOC_STG_IRON_FARM_TOOL_EFFECT",                                "人口消耗的 [ICON_Food] 食物-0.5。此项目需要2点 [ICON_RESOURCE_IRON] 铁资源进行维护。"),

    ("zh_Hans_CN",  "LOC_STG_ANIMAL_POWER",                                         "牛马劳力"),
    ("zh_Hans_CN",  "LOC_STG_ANIMAL_POWER_EFFECT",                                  "为有基础产出的建筑+1 [ICON_PRODUCTION] 生产力。此项目需要2点 [ICON_RESOURCE_HORSES] 马资源进行维护。"),

    ("zh_Hans_CN",  "LOC_STG_CARRIAGE_TRANSPORT",                                   "快马加鞭"),
    ("zh_Hans_CN",  "LOC_STG_CARRIAGE_TRANSPORT_EFFECT",                            "城市生产的陆地单位+1 [ICON_MOVEMENT] 移动速度。此项目需要2点 [ICON_RESOURCE_HORSES] 马资源进行维护。");


insert or replace into LocalizedText
    (Language,      Tag,                                                             Text)
values
    ("zh_Hans_CN",  "LOC_ABILITY_BARRACK_FARM_DESCRIPTION",                          "屯田 为1格范围内的农场和种植园加1 [ICON_FOOD] 食物，自身+12 [ICON_GOLD] 维护费（军营和堡垒上免除），进行战斗后失去该特性。"),
    ("zh_Hans_CN",  "LOC_ABILITY_STABLED_CAMP_DESCRIPTION",                          "围猎 为1格范围内的营地和牧场加1 [ICON_FOOD] 食物，自身+12 [ICON_GOLD] 维护费（军营和堡垒上免除），进行战斗后失去该特性。"),
    ("zh_Hans_CN",  "LOC_ABILITY_FORGE_WEAPON_STRENGTH_DESCRIPTION",                 "铁制兵器 +3 [ICON_Strength] 战斗力"),
    ("zh_Hans_CN",  "LOC_ABILITY_CARRIAGE_TRANSPORT_MOVEMENT_DESCRIPTION",           "马匹运输 +1 [ICON_MOVEMENT] 移动力"),

    ("zh_Hans_CN",  "LOC_FORGE_WEAPON_STRENGTH_MODIFIER_PREVIEW_TEXT",               "来自 铁制兵器");

