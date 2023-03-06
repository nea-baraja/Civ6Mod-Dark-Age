UPDATE Resources SET SeaFrequency = SeaFrequency + 3 WHERE SeaFrequency <> 0 AND ResourceClassType = 'RESOURCECLASS_BONUS';
UPDATE Resources SET Frequency = Frequency + 2 WHERE Frequency <> 0 AND ResourceClassType = 'RESOURCECLASS_BONUS';
UPDATE Resources SET Frequency = Frequency + 3 WHERE ResourceType in ('RESOURCE_STONE',	'RESOURCE_COPPER');

-- UPDATE Resources SET SeaFrequency = SeaFrequency + 1 WHERE SeaFrequency <> 0 AND ResourceClassType = 'RESOURCECLASS_LUXURY';--bug
UPDATE Resources SET Frequency = Frequency + 1 WHERE Frequency <> 0 AND ResourceClassType = 'RESOURCECLASS_LUXURY';
-- UPDATE Resources SET SeaFrequency = SeaFrequency + 2 WHERE SeaFrequency <> 0 AND ResourceClassType = 'RESOURCECLASS_STRATEGIC';
UPDATE Resources SET Frequency = Frequency + 10 WHERE Frequency <> 0 AND ResourceClassType = 'RESOURCECLASS_STRATEGIC';

DELETE FROM Resource_YieldChanges WHERE ResourceType IN (SELECT ResourceType FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_LUXURY' or ResourceClassType = 'RESOURCECLASS_BONUS');
INSERT OR REPLACE INTO Resource_YieldChanges
(ResourceType,				YieldType,					YieldChange)	VALUES
('RESOURCE_BANANAS',		'YIELD_FOOD',				1),
('RESOURCE_CATTLE',			'YIELD_FOOD',				1),
('RESOURCE_COPPER',			'YIELD_GOLD',				3),
('RESOURCE_CRABS',			'YIELD_GOLD',				3),
('RESOURCE_DEER',			'YIELD_PRODUCTION',			1),
('RESOURCE_FISH',			'YIELD_FOOD',				1),
('RESOURCE_RICE',			'YIELD_FOOD',				1),
('RESOURCE_SHEEP',			'YIELD_FOOD',				1),
('RESOURCE_STONE',			'YIELD_PRODUCTION',			1),
('RESOURCE_WHEAT',			'YIELD_FOOD',				1),
('RESOURCE_MAIZE',			'YIELD_GOLD',				3),

('RESOURCE_TEA',			'YIELD_SCIENCE',			1),
('RESOURCE_TURTLES',		'YIELD_SCIENCE',			1),
('RESOURCE_MERCURY',		'YIELD_SCIENCE',			1),

('RESOURCE_MARBLE',			'YIELD_CULTURE',			1),
('RESOURCE_COFFEE',			'YIELD_CULTURE',			1),
('RESOURCE_SILK',			'YIELD_CULTURE',			1),
('RESOURCE_JADE',			'YIELD_CULTURE',			1),
('RESOURCE_AMBER',			'YIELD_CULTURE',			1),

('RESOURCE_HONEY',			'YIELD_FOOD',				1),
('RESOURCE_CITRUS',			'YIELD_FOOD',				1),
('RESOURCE_WINE',			'YIELD_FOOD',				1),
('RESOURCE_SUGAR',			'YIELD_FOOD',				1),
('RESOURCE_SPICES',			'YIELD_FOOD',				1),
('RESOURCE_SALT',			'YIELD_FOOD',				1),

('RESOURCE_GYPSUM',			'YIELD_PRODUCTION',			1),
('RESOURCE_IVORY',			'YIELD_PRODUCTION',			1),
('RESOURCE_OLIVES',			'YIELD_PRODUCTION',			1),

('RESOURCE_WHALES',			'YIELD_GOLD',				3),
('RESOURCE_COCOA',			'YIELD_GOLD',				3),
('RESOURCE_COTTON',			'YIELD_GOLD',				3),
('RESOURCE_FURS',			'YIELD_GOLD',				3),
('RESOURCE_TRUFFLES',		'YIELD_GOLD',				3),
('RESOURCE_SILVER',			'YIELD_GOLD',				3),
('RESOURCE_DIAMONDS',		'YIELD_GOLD',				3),

('RESOURCE_DYES',			'YIELD_FAITH',				2),
('RESOURCE_INCENSE',		'YIELD_FAITH',				2),
('RESOURCE_TOBACCO',		'YIELD_FAITH',				2),
('RESOURCE_PEARLS',			'YIELD_FAITH',				2);

update Resource_Harvests set Amount = 40 where YieldType = 'YIELD_FOOD';
update Resource_Harvests set Amount = 40 where YieldType = 'YIELD_PRODUCTION';
update Resource_Harvests set Amount = 80 where YieldType = 'YIELD_GOLD';

update Resource_Consumption set ImprovedExtractionRate = 3 where ResourceType in ('RESOURCE_HORSES',	'RESOURCE_IRON');

insert or replace into Resource_Harvests (ResourceType, YieldType, Amount, PrereqTech) select
	ResourceType, 'YIELD_PRODUCTION', 40, PrereqTech from Resources where ResourceClassType = 'RESOURCECLASS_STRATEGIC';

insert or replace into Resource_Harvests (ResourceType, YieldType, Amount, PrereqTech) select
	ResourceType, 'YIELD_GOLD', 80, NULL from Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or replace into Resource_Harvests (ResourceType, YieldType, Amount, PrereqTech) values
	('RESOURCE_ANTIQUITY_SITE',	'YIELD_CULTURE',	40,		NULL),
	('RESOURCE_SHIPWRECK',		'YIELD_CULTURE',	40,		NULL);

update Resource_Harvests set PrereqTech = 'TECH_SAILING' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_FISHING_BOATS');
update Resource_Harvests set PrereqTech = 'TECH_IRRIGATION' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_PLANTATION');
update Resource_Harvests set PrereqTech = 'TECH_MASONRY' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_QUARRY');
update Resource_Harvests set PrereqTech = 'TECH_MINING' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_MINE');
update Resource_Harvests set PrereqTech = 'TECH_ANIMAL_HUSBANDRY' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_PASTURE');
update Resource_Harvests set PrereqTech = 'TECH_ANIMAL_HUSBANDRY' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_CAMP');
update Resource_Harvests set PrereqTech = 'TECH_POTTERY' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_FARM');
update Resource_Harvests set PrereqTech = 'TECH_BRONZE_WORKING' where ResourceType in
	(select ResourceType from Improvement_ValidResources where ImprovementType = 'IMPROVEMENT_LUMBER_MILL');

delete from Resource_Harvests where
	   ResourceType = 'RESOURCE_CLOVES'
	or ResourceType = 'RESOURCE_CINNAMON'
	or ResourceType = 'RESOURCE_TOYS'
	or ResourceType = 'RESOURCE_COSMETICS'
	or ResourceType = 'RESOURCE_PERFUME'
	or ResourceType = 'RESOURCE_JEANS';








