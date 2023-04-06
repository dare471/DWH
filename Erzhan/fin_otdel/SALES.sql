WITH DOGOVOR AS (
SELECT
  dog.guid
 ,dog.NAIMENOVANIE AS Договор
 ,dog.DOGOVOR_VNUTRI_GRUPPY
 ,dog.DATA
 ,dog.SOGLASOVAN
 ,k.NAIMENOVANIE AS Контрагент
 ,m.NAIMENOVANIE AS Менеджер
 --,br.NAIMENOVANIE AS БизнесРегион
 ,sez.NAIMENOVANIE AS Сезон
 ,dog.SUMMA
 
-- INTO #dogovor

FROM L1.dbo.DOGOVORY_KONTRAGENTOV AS dog
LEFT JOIN L1.[dbo].MENEDZHERY AS m
  ON m.[guid] = dog.MENEDZHER_GUID
LEFT JOIN L1.[dbo].KONTRAGENTY AS k
  ON k.[guid] = dog.KONTRAGENT_GUID
LEFT JOIN L1.dbo.SEZONY AS sez
  ON sez.guid = dog.SEZON_GUID
--LEFT JOIN L1.dbo.БизнесРегионы AS br
--  ON br.guid = dog.БизнесРегион_guid
)

SELECT
  CAST([Date] AS DATE) AS Дата
 ,CASE --создаётся связь для декады в планах
    WHEN DAY([Date]) BETWEEN 1 AND 9 THEN DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 1)
    WHEN DAY([Date]) BETWEEN 10 AND 19 THEN DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 11)
    WHEN DAY([Date]) BETWEEN 20 AND 31 THEN DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 21)
  END AS Декада
 ,o.NAIMENOVANIE AS Организация
 ,dog.Договор
 --,dog.ДоговорВнутриГруппы
 ,dog.DATA AS Дата_договора
 ,dog.Контрагент
 ,dog.Менеджер AS Менеджер
 --,dog.БизнесРегион
 ,dog.Сезон
 ,s.NAIMENOVANIE AS Склад
 ,n.NAIMENOVANIE AS Номенклатура
-- ,n.ГруппаУр1
-- ,n.ГруппаУр2
-- ,n.КатегорияНоменклатуры AS Категория
-- ,n.Производитель
 ,prod.KOLICHESTVO
 ,prod.SUMMA_VYRUCHKI
 ,prod.SUMMA_VYRUCHKI_BEZ_NDS
 ,prod.STOIMOST
 ,prod.STOIMOST_BEZ_NDS
 ,prod.SUMMA_VYRUCHKI - prod.STOIMOST AS [Валовая прибыль]
 ,prod.SUMMA_VYRUCHKI_BEZ_NDS - prod.STOIMOST_BEZ_NDS AS [Валовая прибыль (без НДС)]
 ,CONVERT(VARCHAR(50), prod.NOMENKLATURA_GUID, 1) AS Номенклатура_guid
FROM L1.[dbo].VYRUCHKA_I_SEBESTOIMOST_PRODAZH AS prod
LEFT JOIN dogovor AS dog
  ON dog.guid = prod.DOGOVOR_GUID
LEFT JOIN L1.[dbo].NOMENKLATURA AS n
  ON n.GUID= prod.NOMENKLATURA_GUID
LEFT JOIN L1.[dbo].ORGANIZATSII AS o
  ON o.[guid] = prod.ORGANIZATSIYA_GUID
LEFT JOIN L1.[dbo].SKLADY AS s
  ON s.[guid] = prod.SKLAD_GUID
WHERE dog.DOGOVOR_VNUTRI_GRUPPY = 0
--WHERE dog.Контрагент NOT IN (
--'Alem Agro Trade" ТОО'
--, 'LLC Alem Agro KG (ОсОО Алем Агро Кей Джи)'
--, 'TOO "KazAgroSystems"'
--, 'ТОО "Alem Agro Holding (Алем Агро Холдинг)"'
--, 'ТОО «Алем-Агро LTD»'
--, 'ТОО "IrriTech Systems"'
--, 'ТОО "Alem Agro Trade"'
--, 'ТОО "KazAgroSystems"'
--, 'ТОО "Алем-Агро LTD"'
--, 'ТОО «Alem Agro Holding (Алем Агро Холдинг)»'
--)

--DROP TABLE #dogovor