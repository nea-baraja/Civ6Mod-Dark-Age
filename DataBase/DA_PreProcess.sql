create table "counter" (
'numbers' INTEGER NOT NULL,
PRIMARY KEY(numbers)
);

WITH RECURSIVE
  Indices(i) AS (SELECT -50 UNION ALL SELECT (i + 1) FROM Indices LIMIT 100)
  insert into counter(numbers) select i from Indices;

create table "counter_m" (
'numbers' INTEGER NOT NULL,
PRIMARY KEY(numbers)
);

WITH RECURSIVE
  Indices(i) AS (SELECT 0 UNION ALL SELECT (i + 1) FROM Indices LIMIT 8)
  insert into counter_m(numbers) select i from Indices;

create table "GreatpeopleYields"(
'GreatPersonClassType' TEXT NOT NULL,
'YieldType' TEXT NOT NULL,
'Amount' INTEGER NOT NULL,
PRIMARY KEY(GreatPersonClassType, YieldType)
);

insert or replace into GreatpeopleYields(GreatPersonClassType,  YieldType,  Amount) values
  ('GREAT_PERSON_CLASS_GENERAL',          'YIELD_PRODUCTION',         1),
  ('GREAT_PERSON_CLASS_ADMIRAL',          'YIELD_FOOD',               1),
  ('GREAT_PERSON_CLASS_ENGINEER',         'YIELD_PRODUCTION',         1),
  ('GREAT_PERSON_CLASS_MERCHANT',         'YIELD_GOLD',               3),
  ('GREAT_PERSON_CLASS_PROPHET',          'YIELD_FAITH',              2),
  ('GREAT_PERSON_CLASS_SCIENTIST',        'YIELD_SCIENCE',            1),
  ('GREAT_PERSON_CLASS_WRITER',           'YIELD_CULTURE',            1),
  ('GREAT_PERSON_CLASS_ARTIST',           'YIELD_CULTURE',            1),
  ('GREAT_PERSON_CLASS_MUSICIAN',         'YIELD_CULTURE',            1),
  ('GREAT_PERSON_CLASS_WRITER',           'YIELD_CULTURE',            1);

create table "ConfigValues" (
'ConfigId' TEXT NOT NULL,
'ConfigVal' INT NOT NULL,
PRIMARY KEY(ConfigId)
);

insert or replace into ConfigValues(ConfigId,   ConfigVal) values
  ('CONFIG_BELIEF',         0),
  ('CONFIG_GOODY_EVENT',    0);
 




