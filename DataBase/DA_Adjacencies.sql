delete from District_Adjacencies
      --学院
   where YieldChangeId = 'Mountains_Science1'
      or YieldChangeId = 'Mountains_Science2'
      or YieldChangeId = 'Mountains_Science3'
      or YieldChangeId = 'Mountains_Science4'
      or YieldChangeId = 'Mountains_Science5'
      or YieldChangeId = 'Jungle_Science'
      or YieldChangeId = 'District_Science'
      or YieldChangeId = 'GBR_Science'
      or YieldChangeId = 'Reef_Science'
      or YieldChangeId = 'Government_Science'
      or YieldChangeId = 'Geothermal_Science'
      --圣地
      or YieldChangeId = 'NaturalWonder_Faith'
      or YieldChangeId = 'Mountain_Faith1'
      or YieldChangeId = 'Mountain_Faith2'
      or YieldChangeId = 'Mountain_Faith3'
      or YieldChangeId = 'Mountain_Faith4'
      or YieldChangeId = 'Mountain_Faith5'
      or YieldChangeId = 'Forest_Faith'
      or YieldChangeId = 'District_Faith'
      or YieldChangeId = 'Government_Faith'
      --商业港口共享
    --  or YieldChangeId = 'District_Gold'
    --  or YieldChangeId = 'Government_Gold'

      or (YieldChangeId = 'District_Gold' and DistrictType = 'DISTRICT_COMMERCIAL_HUB')
      or (YieldChangeId = 'Government_Gold' and DistrictType = 'DISTRICT_COMMERCIAL_HUB')
      --商业中心
      or YieldChangeId = 'River_Gold'
      or YieldChangeId = 'Harbor_Gold'
      or YieldChangeId = 'RoyalDock_Gold'
      or YieldChangeId = 'Cothon_Gold'
      --港口
    --  or YieldChangeId = 'SeaResource_Gold'
    --  or YieldChangeId = 'Harbor_City_Gold'
      --剧院广场
      or YieldChangeId = 'Wonder_Culture'
      or YieldChangeId = 'District_Culture'
      or YieldChangeId = 'Government_Culture'
      or YieldChangeId = 'EntertainmentComplex_Culture'
      or YieldChangeId = 'WaterPark_Culture'
      or YieldChangeId = 'StreetCarnival_Culture'
      or YieldChangeId = 'Copacabana_Culture'
      or YieldChangeId = 'Hippodrome_Culture'
      --工业区
      --or YieldChangeId = 'Mine_Production'
      --or YieldChangeId = 'Quarry_Production'
      --or YieldChangeId = 'District_Production'
      --or YieldChangeId = 'Government_Production'
      --or YieldChangeId = 'Minel_HalfProduction'
      --or YieldChangeId = 'LumberMill_HalfProduction'
      --or YieldChangeId = 'Aqueduct_Production'
      --or YieldChangeId = 'Bath_Production'
      --or YieldChangeId = 'Canal_Production'
      --or YieldChangeId = 'Dam_Production'
      --or YieldChangeId = 'Strategic_Production'
      --书院_朝鲜
      --or YieldChangeId = 'BaseDistrict_Science'
      --or YieldChangeId = 'NegativeDistrict_Science'
      --天文台_玛雅
      --or YieldChangeId = 'Plantation_Science'
      --or YieldChangeId = 'Farm_Science'
      --曼丁哥市场_马里
      --or YieldChangeId = 'Holy_Site_Gold'
      --or YieldChangeId = 'Lavra_Gold'
      --皇家海军船坞_英国
      --or YieldChangeId = 'RoyalDock_City_Gold'
      --卫城_希腊
      --or YieldChangeId = 'District_Culture_Standard'
      --or YieldChangeId = 'District_Culture_City_Center'
      --商业同业工会_德国
      --or YieldChangeId = 'Commerical_Hub_Production'
      --or YieldChangeId = 'Resource_Production'
      --奥皮杜姆_高卢
      --or YieldChangeId = 'Quarry_Production2'
      --or YieldChangeId = 'Strategic_Production2'
      --城池_越南
      --or YieldChangeId = 'District_Culture_Major'
      --拉夫拉修道院_俄罗斯
      --伊坎达_祖鲁
      --浴场_罗马
      --姆班赞_刚果
      --街头狂欢节_巴西
      --跑马场_拜占庭
      --科帕卡瓦纳_巴西
      --U型港_迦太基
      --棉花堡
      or YieldChangeId = 'Pamukkale_Culture'
      or YieldChangeId = 'Pamukkale_Faith'
      or YieldChangeId = 'Pamukkale_Gold'
      or YieldChangeId = 'Pamukkale_Science';

insert or replace into District_Adjacencies
    (DistrictType,            YieldChangeId)
  VALUES
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_MOUNTAINS1_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_MOUNTAINS2_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_MOUNTAINS3_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_MOUNTAINS4_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_MOUNTAINS5_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_OASIS_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_VOLCANO_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_VOLCANIC_SOIL_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_MARSH_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_REEF_SCIENCE'),
    ('DISTRICT_CAMPUS',             'DA_CAMPUS_GEOTHERMAL_FISSURE_SCIENCE'),
    ('DISTRICT_THEATER',            'DA_THEATER_GOVERNMENT_CULTURE'),
    ('DISTRICT_THEATER',            'DA_THEATER_DISTRICT_CULTURE'),
    ('DISTRICT_THEATER',            'DA_THEATER_WONDER_CULTURE'),
    ('DISTRICT_COMMERCIAL_HUB',     'DA_COMMERCIAL_HUB_BONUS_GOLD'),
    ('DISTRICT_COMMERCIAL_HUB',     'DA_COMMERCIAL_HUB_LUXURY_GOLD'),
    ('DISTRICT_COMMERCIAL_HUB',     'DA_COMMERCIAL_HUB_CAMP_GOLD'),
    ('DISTRICT_COMMERCIAL_HUB',     'DA_COMMERCIAL_HUB_PLANTATION_GOLD'),
    ('DISTRICT_COMMERCIAL_HUB',     'DA_COMMERCIAL_HUB_HARBOR_GOLD'),
    ('DISTRICT_COMMERCIAL_HUB',     'DA_COMMERCIAL_HUB_DISTRICT_GOLD'),
    ('DISTRICT_HOLY_SITE',          'DA_HOLY_SITE_MOUNTAINS_FAITH1'),
    ('DISTRICT_HOLY_SITE',          'DA_HOLY_SITE_MOUNTAINS_FAITH2'),
    ('DISTRICT_HOLY_SITE',          'DA_HOLY_SITE_MOUNTAINS_FAITH3'),
    ('DISTRICT_HOLY_SITE',          'DA_HOLY_SITE_MOUNTAINS_FAITH4'),
    ('DISTRICT_HOLY_SITE',          'DA_HOLY_SITE_MOUNTAINS_FAITH5'),
    ('DISTRICT_HOLY_SITE',          'DA_HOLY_SITE_NATURAL_WONDER_FAITH');
    

--YIELD_FOOD食物，YIELD_PRODUCTION生产力，YIELD_SCIENCE科技值，YIELD_CULTURE文化值，YIELD_FAITH信仰值，YIELD_GOLD金币 


--相邻任意区域
insert or replace into Adjacency_YieldChanges
    (ID,                      Description,                      YieldType,YieldChange,TilesRequired,OtherDistrictAdjacent)
  VALUES
    ('DA_THEATER_DISTRICT_CULTURE','LOC_DA_THEATER_DISTRICT_CULTURE_DESCRIPTION','YIELD_CULTURE','1','1','1'),
    ('DA_COMMERCIAL_HUB_DISTRICT_GOLD','LOC_DA_COMMERCIAL_HUB_DISTRICT_GOLD_DESCRIPTION','YIELD_GOLD','1','1','1');


--相邻海洋资源
--insert or replace into Adjacency_YieldChanges
    --(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentSeaResource)
  --VALUES
    --('','','','','','');


--相邻地形
insert or replace into Adjacency_YieldChanges
    (ID,                          Description,                     YieldType,  YieldChange,TilesRequired,AdjacentTerrain)
  VALUES
    ('DA_CAMPUS_MOUNTAINS1_SCIENCE','LOC_DA_CAMPUS_MOUNTAINS1_SCIENCE_DESCRIPTION','YIELD_SCIENCE','1','1','TERRAIN_GRASS_MOUNTAIN'),
    ('DA_CAMPUS_MOUNTAINS2_SCIENCE','LOC_DA_CAMPUS_MOUNTAINS2_SCIENCE_DESCRIPTION','YIELD_SCIENCE','1','1','TERRAIN_PLAINS_MOUNTAIN'),
    ('DA_CAMPUS_MOUNTAINS3_SCIENCE','LOC_DA_CAMPUS_MOUNTAINS3_SCIENCE_DESCRIPTION','YIELD_SCIENCE','1','1','TERRAIN_DESERT_MOUNTAIN'),
    ('DA_CAMPUS_MOUNTAINS4_SCIENCE','LOC_DA_CAMPUS_MOUNTAINS4_SCIENCE_DESCRIPTION','YIELD_SCIENCE','1','1','TERRAIN_TUNDRA_MOUNTAIN'),
    ('DA_CAMPUS_MOUNTAINS5_SCIENCE','LOC_DA_CAMPUS_MOUNTAINS5_SCIENCE_DESCRIPTION','YIELD_SCIENCE','1','1','TERRAIN_SNOW_MOUNTAIN'),
    ('DA_HOLY_SITE_MOUNTAINS_FAITH1','LOC_DA_HOLY_SITE_MOUNTAINS1_FAITH_DESCRIPTION','YIELD_FAITH','1','1','TERRAIN_GRASS_MOUNTAIN'),
    ('DA_HOLY_SITE_MOUNTAINS_FAITH2','LOC_DA_HOLY_SITE_MOUNTAINS2_FAITH_DESCRIPTION','YIELD_FAITH','1','1','TERRAIN_PLAINS_MOUNTAIN'),
    ('DA_HOLY_SITE_MOUNTAINS_FAITH3','LOC_DA_HOLY_SITE_MOUNTAINS3_FAITH_DESCRIPTION','YIELD_FAITH','1','1','TERRAIN_DESERT_MOUNTAIN'),
    ('DA_HOLY_SITE_MOUNTAINS_FAITH4','LOC_DA_HOLY_SITE_MOUNTAINS4_FAITH_DESCRIPTION','YIELD_FAITH','1','1','TERRAIN_TUNDRA_MOUNTAIN'),
    ('DA_HOLY_SITE_MOUNTAINS_FAITH5','LOC_DA_HOLY_SITE_MOUNTAINS5_FAITH_DESCRIPTION','YIELD_FAITH','1','1','TERRAIN_SNOW_MOUNTAIN');



--相邻指定地貌（包括自然奇观）
insert or replace into Adjacency_YieldChanges
    (ID,                     Description,                     YieldType,YieldChange,TilesRequired,AdjacentFeature)
  VALUES
    ('DA_CAMPUS_OASIS_SCIENCE','LOC_DA_CAMPUS_OASIS_SCIENCE_DESCRIPTION','YIELD_SCIENCE','3','1','FEATURE_OASIS'),
    ('DA_CAMPUS_VOLCANO_SCIENCE','LOC_DA_CAMPUS_VOLCANO_SCIENCE_DESCRIPTION','YIELD_SCIENCE','2','1','FEATURE_VOLCANO'),
    ('DA_CAMPUS_VOLCANIC_SOIL_SCIENCE','LOC_DA_CAMPUS_VOLCANIC_SOIL_SCIENCE_DESCRIPTION','YIELD_SCIENCE','1','1','FEATURE_VOLCANIC_SOIL'),
    ('DA_CAMPUS_MARSH_SCIENCE','LOC_DA_CAMPUS_MARSH_SCIENCE_DESCRIPTION','YIELD_SCIENCE','1','2','FEATURE_MARSH'),
    ('DA_CAMPUS_REEF_SCIENCE','LOC_DA_CAMPUS_REEF_SCIENCE_DESCRIPTION','YIELD_SCIENCE','3','1','FEATURE_REEF'),
    ('DA_CAMPUS_GEOTHERMAL_FISSURE_SCIENCE','LOC_DA_CAMPUS_GEOTHERMAL_FISSURE_SCIENCE_DESCRIPTION','YIELD_SCIENCE','2','1','FEATURE_GEOTHERMAL_FISSURE');


--相邻河流
--insert or replace into Adjacency_YieldChanges
    --(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentRiver)
  --VALUES
    --('','','','','','');


--相邻任意人造奇观
insert or replace into Adjacency_YieldChanges
    (ID,Description,YieldType,YieldChange,TilesRequired,AdjacentWonder)
  VALUES
    ('DA_THEATER_WONDER_CULTURE','LOC_DA_THEATER_WONDER_CULTURE_DESCRIPTION','YIELD_CULTURE','3','1','1');


--相邻任意自然奇观
insert or replace into Adjacency_YieldChanges
    (ID,Description,YieldType,YieldChange,TilesRequired,AdjacentNaturalWonder)
  VALUES
    ('DA_HOLY_SITE_NATURAL_WONDER_FAITH','LOC_DA_HOLY_SITE_NATURAL_WONDER_FAITH_DESCRIPTION','YIELD_FAITH','2','1','1');


--相邻指定改良设施
insert or replace into Adjacency_YieldChanges
    (ID,Description,YieldType,YieldChange,TilesRequired,AdjacentImprovement)
  VALUES
    ('DA_COMMERCIAL_HUB_CAMP_GOLD','LOC_DA_COMMERCIAL_HUB_CAMP_GOLD_DESCRIPTION','YIELD_GOLD','1','1','IMPROVEMENT_CAMP'),
    ('DA_COMMERCIAL_HUB_PLANTATION_GOLD','LOC_DA_COMMERCIAL_HUB_PLANTATION_GOLD_DESCRIPTION','YIELD_GOLD','1','1','IMPROVEMENT_PLANTATION');


--相邻指定区域
insert or replace into Adjacency_YieldChanges
    (ID,Description,YieldType,YieldChange,TilesRequired,AdjacentDistrict)
  VALUES
    ('DA_THEATER_GOVERNMENT_CULTURE','LOC_DA_THEATER_GOVERNMENT_CULTURE_DESCRIPTION','YIELD_CULTURE','2','1','DISTRICT_GOVERNMENT'),
    ('DA_COMMERCIAL_HUB_HARBOR_GOLD','LOC_DA_COMMERCIAL_HUB_HARBOR_GOLD_DESCRIPTION','YIELD_GOLD','1','1','DISTRICT_HARBOR');


--相邻任意资源
--insert or replace into Adjacency_YieldChanges
    --(ID,Description,YieldType,YieldChange,TilesRequired,AdjacentResource)
  --VALUES
    --('','','','','','');


--相邻指定类型的资源
--RESOURCECLASS_BONUS加成资源，RESOURCECLASS_LUXURY奢侈资源，RESOURCECLASS_STRATEGIC战略资源（RESOURCECLASS_ARTIFACT文物资源，
insert or replace into Adjacency_YieldChanges
    (ID,Description,YieldType,YieldChange,TilesRequired,AdjacentResourceClass)
  VALUES
    ('DA_COMMERCIAL_HUB_BONUS_GOLD','LOC_DA_COMMERCIAL_HUB_BONUS_GOLD_DESCRIPTION','YIELD_GOLD','1','1','RESOURCECLASS_BONUS'),
    ('DA_COMMERCIAL_HUB_LUXURY_GOLD','LOC_DA_COMMERCIAL_HUB_LUXURY_GOLD_DESCRIPTION','YIELD_GOLD','1','1','RESOURCECLASS_LUXURY');


--无需相邻直接获得
--insert or replace into Adjacency_YieldChanges
    --(ID,Description,YieldType,YieldChange,TilesRequired,Self)
  --VALUES
    --('','','','','','');



