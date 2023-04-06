SELECT DISTINCT
  CAST(period AS DATE) AS period
 ,n.NAIMENOVANIE AS Номенклатура
 ,md.NAIMENOVANIE AS Менеджер
 ,S.NAIMENOVANIE Сезон
 ,PLN.KOLICHESTVO Количество
 ,PLN.SUMMA Сумма
 ,CONVERT(VARCHAR(25), pln.NOMENKLATURA_GUID, 1) AS Номенклатура_guid
FROM L1.dbo.PLAN_PRODAZH AS pln
LEFT JOIN L1.[dbo].MENEDZHERY AS md
  ON md.[guid] = pln.MENEDZHER_GUID
LEFT JOIN L1.[dbo].NOMENKLATURA AS n
  ON n.GUID= pln.NOMENKLATURA_GUID
LEFT JOIN L1.dbo.SEZONY AS S 
	ON PLN.SEZON_GUID=S.GUID

WHERE PLN.STATUS = 'Утвержден'
AND VIDY_PLANOV='План продаж бюджетный'

SELECT DISTINCT 
  CAST(period AS DATE) AS period
 ,n.description AS Номенклатура
 ,md.description AS Менеджер
 ,Сезон
 ,Количество
 ,Сумма
 ,CONVERT(VARCHAR(25), pln.Номенклатура_guid, 1) AS Номенклатура_guid
FROM AA_DWH.dbo.ПланыПродаж AS pln
LEFT JOIN [AA_DWH].[dbo].[Менеджеры] AS md
  ON md.[guid] = pln.Менеджер_guid
LEFT JOIN [AA_DWH].[dbo].[Номенклатура] AS n
  ON n.[guid_binary] = pln.Номенклатура_guid
WHERE Статус = 'Утвержден'
