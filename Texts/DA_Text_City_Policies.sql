-- 
create table 'CityPolicyTexts'(
    'CityPolicy' TEXT NOT NULL,
    'Name' TEXT,
    'EffectText' TEXT,
    'BuildingText' TEXT,
    'EnableProjectText' TEXT,
    'DisableProjectText' TEXT,
    PRIMARY KEY('CityPolicy')
);

insert or replace into CityPolicyTexts
    (CityPolicy)
values
  --城市
    ('EMPTY_TAX'),
    ('MINE_TAX'),
    ('LUXURY_TAX'),
    ('FOOD_TAX'),

--生产
    ('PRODUCTION_FOCUS'),
    ('FOOD_FOCUS'),
    ('EMPTY_FOCUS'),

--沿岸海事
    ('EMPTY_COASTAL_MARITIME'),
    ('COASTAL_FISHING'),
    ('SEA_SALT'),

--粮仓
    ('EMPTY_GRAIN_USE'),
    ('MAKE_WINE'),
    ('WATER_TRANSPORT'),

--石匠坊
    ('EMPTY_MASONRY'),
    ('MARBLE_CITY'),
    ('BRICK_CITY'),
--磨坊动力
    ('WATER_MILL'),
    ('ANIMAL_MILL'),
    ('WIND_MILL'),
    ('EMPTY_MILL'),

--造纸工艺
    ('HEMP_PAPER'),
    ('SILK_PAPER'),
    ('EMPTY_PAPER'),

--图书馆
    ('EMPTY_LIBRARY'),
    ('SCRIPTURE_COLLECTION'),
    ('MANUSCRIPT_COLLECTION'),
    ('LITERATURE_COLLECTION'),
    
--古罗马剧场
    ('EMPTY_PLAYS'),
    ('POLITICAL_SPEECH'),
    ('SACRIFICE'),
    ('DRAMA_ALLOWANCE'),

--神社
    ('EMPTY_SACRIFICE'),
    ('PRAY_FOR_RAIN'),
    ('DIVINE'),
    ('SEA_SACRIFICE'),
    
--竞技场
    ('EMPTY_ARENA'),
    ('OLYMPIC'),
    ('SLAVE_GLADIATUS'),
    --('CHIVALRY'),
    
--兵营
    ('EMPTY_BARRACK'),
    ('BARRACK_FARM'),
    ('BARRACK_WEAPON'),
   
--马厩
    ('EMPTY_STABLED'),
    ('STABLED_CAMP'),
    ('STABLED_TRANSPORT');

update CityPolicyTexts set
    Name                    = 'LOC_CITY_POLICY_' || CityPolicy,
    EffectText              = 'LOC_CITY_POLICY_' || CityPolicy || '_EFFECT',
    BuildingText            = 'LOC_BUILDING_CITY_POLICY_' || CityPolicy,
    EnableProjectText       = 'LOC_PROJECT_CITY_POLICY_ENABLE_' || CityPolicy,
    DisableProjectText      = 'LOC_PROJECT_CITY_POLICY_DISABLE_' || CityPolicy;

insert or replace into EnglishText (Tag, Text) select
    BuildingText || '_NAME',            '{'||Name||'}{LOC_DA_SPACE}{LOC_POLICY_NAME}'
from CityPolicyTexts where CityPolicy NOT LIKE 'EMPTY%';
insert or replace into EnglishText (Tag, Text) select
    BuildingText || '_DESCRIPTION',     '{'||Name||'}{LOC_DA_SPACE}{LOC_CITY_POLICY_NAME}{LOC_DA_SPACE}{LOC_UNDERGOING_TEXT}[NEWLINE]{'||EffectText||'} {LOC_DISABLE_BY_PROJECT}'
from CityPolicyTexts where CityPolicy NOT LIKE 'EMPTY%';

insert or replace into EnglishText (Tag, Text) select
    EnableProjectText || '_NAME',       '{LOC_MODS_ENABLE}{LOC_DA_SPACE}{'||BuildingText||'_NAME}'
from CityPolicyTexts where CityPolicy NOT LIKE 'EMPTY%';
insert or replace into EnglishText (Tag, Text) select
    EnableProjectText || '_SHORT_NAME', '{LOC_MODS_ENABLE}{LOC_DA_SPACE}{'||Name||'}'
from CityPolicyTexts where CityPolicy NOT LIKE 'EMPTY%';
insert or replace into EnglishText (Tag, Text) select
    EnableProjectText || '_DESCRIPTION', '{LOC_MODS_ENABLE} {'||BuildingText||'_NAME}[NEWLINE]{'||EffectText||'} {LOC_DISABLE_BY_PROJECT}'
from CityPolicyTexts where CityPolicy NOT LIKE 'EMPTY%';

insert or replace into EnglishText (Tag, Text) select
    DisableProjectText || '_NAME',       '{LOC_MODS_DISABLE}{LOC_DA_SPACE}{'||BuildingText||'_NAME}'
from CityPolicyTexts where CityPolicy NOT LIKE 'EMPTY%';
insert or replace into EnglishText (Tag, Text) select
    DisableProjectText || '_SHORT_NAME', '{LOC_MODS_DISABLE}{LOC_DA_SPACE}{'||Name||'}'
from CityPolicyTexts where CityPolicy NOT LIKE 'EMPTY%';
insert or replace into EnglishText (Tag, Text) select
    DisableProjectText || '_DESCRIPTION', '{LOC_MODS_DISABLE} {'||BuildingText||'_NAME}[NEWLINE]{LOC_CITYPOLICY_BACK_TO_NORMAL}'
from CityPolicyTexts where CityPolicy NOT LIKE 'EMPTY%';



insert or replace into EnglishText (Tag, Text) select
    BuildingText || '_NAME',            '{LOC_EMPTY_POLICY_NAME}{'||Name||'}'
from CityPolicyTexts where CityPolicy LIKE 'EMPTY%';
insert or replace into EnglishText (Tag, Text) select
    BuildingText || '_DESCRIPTION',     '{LOC_EMPTY_POLICY_DESCRIPTION}{'||Name||'}{LOC_DA_SPACE}[NEWLINE]{'||Name||'}{'||EffectText||'} {LOC_ENABLE_BY_PROJECT}'
from CityPolicyTexts where CityPolicy LIKE 'EMPTY%';



--------------------------------------------------------------------------------
-- Language: en_US
/*
insert or replace into EnglishText
    (Tag,                                                             Text)
values
    ("LOC_CITY_POLICY_NAME",                                          "City Policy"),
    ("LOC_HUD_CITY_CITY_POLICIES",                                    "City Policies"),
    ("LOC_HUD_CITY_NO_CITY_POLICIES",                                 "No City Policies exist."),
    ("LOC_BUILDING_CITY_POLICY_EMPTY_NAME",                           "No City Policy"),
    ("LOC_BUILDING_CITY_POLICY_EMPTY_DESCRIPTION",                    "No City Policy."),

    ("LOC_DA_SPACE",                                                  " "),
    ("LOC_UNDERGOING_TEXT",                                           "undergoing"),
    ("LOC_DISABLE_BY_PROJECT",                                        "This policy can be disabled by a project."),
    ("LOC_CITYPOLICY_BACK_TO_NORMAL",                                 "Restore the original yields."),

    ("LOC_CITY_POLICY_FOOD_TAX",                                         "Conscripting Labor"),
    ("LOC_CITY_POLICY_FOOD_TAX_EFFECT",                                  "Each [ICON_Citizen] Citizen provides 1.5 extra [ICON_Production] Production, but consume extra 1 [ICON_Food] Food. The city growth rate decreased by 75% and suffer -1 [ICON_Amenities] Amenity."),
    ("LOC_CITY_POLICY_MINE_TAX",                              "Cash Crops"),
    ("LOC_CITY_POLICY_MINE_TAX_EFFECT",                       "Each Farm provides extra 2 [ICON_GOLD] Gold, but -1 [ICON_Food] Food."),
    ("LOC_CITY_POLICY_LABOR_TAX",                                "Daily Goods"),
    ("LOC_CITY_POLICY_LABOR_TAX_EFFECT",                         "Each Mine or Quarry provides extra 2 [ICON_GOLD] Gold, but -1 [ICON_PRODUCTION] Production."),
    ("LOC_CITY_POLICY_LUXURY_TAX",                              "Almanac Revision"),
    ("LOC_CITY_POLICY_LUXURY_TAX_EFFECT",                       "Aqueduct Project. Need maintenance cost of 6 [ICON_GOLD] Gold.  In this City: the improvement yields of Plantations and Farms over resource are replaced with +1 [ICON_Production] Production and +1 [ICON_SCIENCE] Science. After Calendar is researched, provides +2 [ICON_Production] Production."),
    ("LOC_CITY_POLICY_DIPLOMATIC_MEETING",                            "Diplomatic Meeting"),
    ("LOC_CITY_POLICY_DIPLOMATIC_MEETING_EFFECT",                     "Diplomatic Quarter Project. Each turn, Diplomatic Quarter and each of its building consumes 2 [ICON_Favor] Favor, and provides 5 influence points."),
    ("LOC_CITY_POLICY_JIMI",                                          "JIMI"),
    ("LOC_CITY_POLICY_JIMI_EFFECT",                                   "Encampment Project. Consumes 1 [ICON_RESOURCE_HORSES] Horses and 1 [ICON_RESOURCE_IRON] Iron per turn, and provides 2 influence points."),
    ("LOC_CITY_POLICY_FREIGHT",                                       "Freight"),
    ("LOC_CITY_POLICY_FREIGHT_EFFECT",                                "Commercial Hub Project. Each turn, consumes 3 [ICON_RESOURCE_HORSES] Horses, provides 2 [ICON_FOOD] Food and 3 [ICON_PRODUCTION] Production."),
    ("LOC_CITY_POLICY_THEOLOGICAL_SEMINAR",                           "Theological Seminar"),
    ("LOC_CITY_POLICY_THEOLOGICAL_SEMINAR_EFFECT",                    "Holy Site Project. Consumes 3 [ICON_FAITH] Faith per turn, provides 1 [ICON_CULTURE] Culture and 1 [ICON_SCIENCE] Science. Religious spread from adjacent city pressure is 50% weaker."),
    ("LOC_CITY_POLICY_FORGING_IRON",                                  "Forging Iron"), -- Tool Production
    ("LOC_CITY_POLICY_FORGING_IRON_EFFECT",                           "Industrial Zone Project. Each turn, consumes 3 [ICON_RESOURCE_IRON] Iron, provides 5 [ICON_PRODUCTION] Production.");

    -- ("LOC_CITY_POLICY_DACAOGU",                                       "Pillage Preparing"),
    -- ("LOC_CITY_POLICY_DACAOGU_EFFECT",                                "Each trained light cavalry unit of Mediveal or eralier era in this city gains the ability that can pillage tiles using only 1 [ICON_Movement] Movement. Each [ICON_Citizen] Citizen consumes extra 1 [ICON_FOOD] Food. -100% Growth Rate and -1 [ICON_Amenities] Amenity to this city. If the city has at least 3 [ICON_Citizen] Citizens, receives another unit of the same kind when a light cavalry unit of Mediveal or eralier era being trained in this city, at the cost of one [ICON_Citizen] Citizen. This policy can be disabled by a project.");
*/
--------------------------------------------------------------------------------
-- Language: zh_Hans_CN
insert or replace into LocalizedText
    (Language,      Tag,                                                             Text)
values
    ("zh_Hans_CN",  "LOC_CITY_POLICY_NAME",                                          "城市政策"),
    ("zh_Hans_CN",  "LOC_EMPTY_POLICY_NAME",                                         "无"),
    ("zh_Hans_CN",  "LOC_EMPTY_POLICY_DESCRIPTION",                                  "无"),
    ("zh_Hans_CN",  "LOC_HUD_CITY_CITY_POLICIES",                                    "城市政策"),
    ("zh_Hans_CN",  "LOC_HUD_CITY_NO_CITY_POLICIES",                                 "尚未开启城市政策"),
    ("zh_Hans_CN",  "LOC_BUILDING_CITY_POLICY_EMPTY_NAME",                           "无城市政策"),
    ("zh_Hans_CN",  "LOC_BUILDING_CITY_POLICY_EMPTY_DESCRIPTION",                    "无城市政策。"),

    ("zh_Hans_CN",  "LOC_DA_SPACE",                                                  ""),
    ("zh_Hans_CN",  "LOC_UNDERGOING_TEXT",                                           "已启用"),
    ("zh_Hans_CN",  "LOC_DISABLE_BY_PROJECT",                                        "该政策可通过项目关闭。"),
    ("zh_Hans_CN",  "LOC_ENABLE_BY_PROJECT",                                         "通过完成对应科技或市政，解锁相应城市政策。"),
    ("zh_Hans_CN",  "LOC_CITYPOLICY_BACK_TO_NORMAL",                                 "产出恢复正常。"),
    
--税收
    ("zh_Hans_CN",  "LOC_CITY_POLICY_FOOD_TAX",                                      "粮税"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_FOOD_TAX_EFFECT",                               "城市拥有至少4 [ICON_CITIZEN] 人口后解锁。每个改良资源的农场、牧场、营地、种植园和渔船+2 [ICON_GOLD] 金币，但额外减少1 [ICON_Food] 食物。完成科技“骑马”后额外+2 [ICON_GOLD] 金币。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_MINE_TAX",                                      "矿税"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_MINE_TAX_EFFECT",                               "城市拥有至少4 [ICON_CITIZEN] 人口后解锁。每个改良资源的矿山、采石场、伐木场+3 [ICON_GOLD] 金币，但额外减少1 [ICON_PRODUCTION] 生产力。完成科技“炼铁术”后额外+1 [ICON_GOLD] 金币。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_LUXURY_TAX",                                    "资源税"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_LUXURY_TAX_EFFECT",                             "城市拥有至少4 [ICON_CITIZEN] 人口后解锁。若城市拥有商业中心，每个改良的奢侈品资源额外为城市提供1 [ICON_Amenities] 宜居度。若城市拥有军营，每个改良的战略资源额外为城市提供1对应的资源储备速度。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_TAX",                                     "税务政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_TAX_EFFECT",                              "包括粮税、矿税、资源税。"),
 
 --生产
    ("zh_Hans_CN",  "LOC_CITY_POLICY_FOOD_FOCUS",                                    "督农制"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_FOOD_FOCUS_EFFECT",                             "城市建造一个建筑后解锁。城市中每位 [ICON_CITIZEN] 公民减少1 [ICON_FOOD] 食物消耗，但额外消耗1 [ICON_PRODUCTION] 生产力。单位建造速度-50%。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_PRODUCTION_FOCUS",                              "劳役制"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_PRODUCTION_FOCUS_EFFECT",                       "城市建造一个建筑后解锁。城市中每位 [ICON_CITIZEN] 公民提供1 [ICON_PRODUCTION] 生产力，但额外增加1 [ICON_FOOD] 食物消耗。人口增长速度-50%。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_FOCUS",                                   "生产政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_FOCUS_EFFECT",                            "包括督农制和劳役制。"),
 



--沿岸海事
    ("zh_Hans_CN",  "LOC_CITY_POLICY_COASTAL_FISHING",                              "沿岸捕捞"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_COASTAL_FISHING_EFFECT",                       "市中心每相邻一个海岸单元格就+1 [ICON_Food] 食物。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SEA_SALT",                                     "晒盐"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SEA_SALT_EFFECT",                              "市中心每相邻一个海岸单元格就+3 [ICON_GOLD] 金币。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_COASTAL_MARITIME",                       "沿岸海事政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_COASTAL_MARITIME_EFFECT",                "包括沿岸捕捞和晒盐。"),
    ("zh_Hans_CN",  "LOC_COASTAL_FISHING_FOOD",                                     "+{1_num} [ICON_Food] 食物来自相邻海岸单元格。"),
    ("zh_Hans_CN",  "LOC_SEA_SALT_GOLD",                                            "+{1_num} [ICON_GOLD] 金币来自相邻海岸单元格。"),

   

--粮仓    
    ("zh_Hans_CN",  "LOC_CITY_POLICY_MAKE_WINE",                                     "酿酒"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_MAKE_WINE_EFFECT",                              "城市每个区域-2 [ICON_Food] 食物，并+1 [ICON_Amenities] 宜居度。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_WATER_TRANSPORT",                               "漕运"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_WATER_TRANSPORT_EFFECT",                        "城市每个区域-2 [ICON_Food] 食物，并为通往本城的国内商路+1 [ICON_Food] 食物"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_GRAIN_USE",                               "余粮政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_GRAIN_USE_EFFECT",                        "包括酿酒和漕运。"),

--石匠坊
    ("zh_Hans_CN",  "LOC_CITY_POLICY_MARBLE_CITY",                                   "大理石城市"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_MARBLE_CITY_EFFECT",                            "城市每个区域-2 [ICON_PRODUCTION] 生产力，并+1[ICON_Amenities] 宜居度。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_BRICK_CITY",                                    "泥砖城市"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_BRICK_CITY_EFFECT",                             "城市每个区域-1 [ICON_PRODUCTION] 生产力，并+1 [ICON_Housing] 住房。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_MASONRY",                                 "石工政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_MASONRY_EFFECT",                          "包括大理石城市和泥砖城市。"),

--磨坊
    ("zh_Hans_CN",  "LOC_CITY_POLICY_WATER_MILL",                                   "水力磨坊"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_WATER_MILL_EFFECT",                            "城市每个河流边的区域+1 [ICON_PRODUCTION] 生产力和+1 [ICON_Food] 食物。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_WIND_MILL",                                    "风车磨坊"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_WIND_MILL_EFFECT",                             "城市每个海岸与岸边的区域+1 [ICON_PRODUCTION] 生产力和+1 [ICON_Food] 食物。"),   
    ("zh_Hans_CN",  "LOC_CITY_POLICY_ANIMAL_MILL",                                  "畜力磨坊"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_ANIMAL_MILL_EFFECT",                           "城市每个区域+1 [ICON_PRODUCTION] 生产力和+1 [ICON_Food] 食物，城市每有2个区域就每回合消耗1 [ICON_RESOURCE_HORSES] 马，向上取整。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_MILL",                                   "磨坊动力"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_MILL_EFFECT",                            "包括水力磨坊，风车磨坊和畜力磨坊"),

--造纸坊
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SILK_PAPER",                                   "丝绢制纸"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SILK_PAPER_EFFECT",                            "为城市中的学院，剧院广场，商业中心和圣地提供一份对应的基础相邻加成。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_HEMP_PAPER",                                   "麻皮制纸"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_HEMP_PAPER_EFFECT",                            "城市中每位公民额外提供+0.3 [ICON_SCIENCE] 科技值和+0.3 [ICON_CULTURE] 文化值。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_PAPER",                                  "制纸工艺"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_PAPER_EFFECT",                           "包括丝绢制纸和麻皮制纸。"),


--图书馆
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SCRIPTURE_COLLECTION",                          "经文收藏"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SCRIPTURE_COLLECTION_EFFECT",                   "城市每购买一次宗教单位就+2 [ICON_Faith] 信仰值。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_MANUSCRIPT_COLLECTION",                         "手稿收藏"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_MANUSCRIPT_COLLECTION_EFFECT",                  "伟人在本城首次激活时，+1对应产出。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_LITERATURE_COLLECTION",                         "文学收藏"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_LITERATURE_COLLECTION_EFFECT",                  "阿巴阿巴阿巴"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_LIBRARY",                                 "藏书政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_LIBRARY_EFFECT",                          "包括经文收藏、手稿收藏。"),
        
--古罗马剧场
    ("zh_Hans_CN",  "LOC_CITY_POLICY_DRAMA_ALLOWANCE",                               "戏剧津贴"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_DRAMA_ALLOWANCE_EFFECT",                        "剧院广场的相邻加成也会提供等量的 [ICON_TOURISM] 旅游业绩。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SACRIFICE",                                     "祭祀"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SACRIFICE_EFFECT",                              "剧院广场的相邻加成也会提供等量的 [ICON_FAITH] 信仰值。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_POLITICAL_SPEECH",                              "政治演说"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_POLITICAL_SPEECH_EFFECT",                       "剧院广场的相邻加成也会为四环内的城市提供等量的 [ICON_PressureUp] 忠诚度。"),
 
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_PLAYS",                                   "剧场政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_PLAYS_EFFECT",                            "包括戏剧津贴，祭祀和政治演说。"),
    
--神社
    ("zh_Hans_CN",  "LOC_CITY_POLICY_PRAY_FOR_RAIN",                                 "祈雨"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_PRAY_FOR_RAIN_EFFECT",                          "需要2 [ICON_GOLD] 金币的维护费。城市的无水单元格+1 [ICON_Faith] 信仰。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_DIVINE",                                        "占卜"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_DIVINE_EFFECT",                                 "需要2 [ICON_GOLD] 金币的维护费。城市的区域+1 [ICON_Faith] 信仰。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SEA_SACRIFICE",                                 "海祭"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SEA_SACRIFICE_EFFECT",                          "需要2 [ICON_GOLD] 金币的维护费。城市的沿岸陆地和海岸+1 [ICON_Faith] 信仰。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_SACRIFICE",                               "祭祀政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_SACRIFICE_EFFECT",                        "包括祈雨，占卜和海祭。"),
   

--竞技场
    ("zh_Hans_CN",  "LOC_CITY_POLICY_OLYMPIC",                                       "奥林匹克"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_OLYMPIC_EFFECT",                                "高宜居度不再降低[ICON_PRODUCTION] 生产力和 [ICON_GOLD] 金币产出。 [ICON_Amenities] 宜居度也会为 [ICON_Faith] 信仰值提供产出加成。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SLAVE_GLADIATUS",                               "奴隶角斗"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_SLAVE_GLADIATUS_EFFECT",                        "低宜居度不再降低[ICON_SCIENCE] 科技值和 [ICON_Culture] 文化值产出。低 [ICON_Amenities] 宜居度产生的 [ICON_PressureDown] 忠诚度减益翻倍。"),
    --("zh_Hans_CN",  "LOC_CITY_POLICY_CHIVALRY",                                      "骑士竞技"),
    --("zh_Hans_CN",  "LOC_CITY_POLICY_CHIVALRY_EFFECT",                               "每点 [ICON_Amenities] 宜居度为建造单位+2 [ICON_PRODUCTION] 生产力，若有军营则再+1 [ICON_PRODUCTION] 生产力"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_ARENA",                                   "竞技场演出项目"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_ARENA_EFFECT",                            "包括奥林匹克和奴隶角斗。"),
    
--兵营
    ("zh_Hans_CN",  "LOC_CITY_POLICY_BARRACK_FARM",                                 "屯田"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_BARRACK_FARM_EFFECT",                          "生产近战，远程，抗骑兵单位时额外消耗10 [ICON_RESOURCE_IRON] 铁，使其获得特性“屯田”：为1格范围内的农场和种植园加1 [ICON_FOOD] 食物，自身+12 [ICON_GOLD] 维护费（军营和堡垒上免除），进行战斗后失去该特性。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_BARRACK_WEAPON",                               "铁制兵器"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_BARRACK_WEAPON_EFFECT",                        "生产战斗单位时额外消耗10 [ICON_RESOURCE_IRON] 铁，使其获得+3 [ICON_Strength] 战斗力。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_BARRACK",                                "兵营政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_BARRACK_EFFECT",                         "包括屯田和铁制兵器。"),     
--马厩
    ("zh_Hans_CN",  "LOC_CITY_POLICY_STABLED_CAMP",                                  "围猎"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_STABLED_CAMP_EFFECT",                           "生产轻骑兵和重骑兵单位时额外消耗10 [ICON_RESOURCE_HORSES] 马，使其获得特性“围猎”：为1格范围内的营地和牧场加1 [ICON_FOOD] 食物，自身+12 [ICON_GOLD] 维护费（军营和堡垒上免除），进行战斗后失去该特性。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_STABLED_TRANSPORT",                             "马匹运输"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_STABLED_TRANSPORT_EFFECT",                      "生产陆地单位时额外消耗10 [ICON_RESOURCE_HORSES] 马，使其获得+1 [ICON_MOVEMENT] 移动力。"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_STABLED",                                 "马厩政策"),
    ("zh_Hans_CN",  "LOC_CITY_POLICY_EMPTY_STABLED_EFFECT",                          "包括围猎和马匹运输。");