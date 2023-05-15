/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT S.ssylka AS SEZON_GUID
,PYZ.kolichestvo AS KOLICHESTVO
,PYZ.summa AS SUMMA
,PYZ.nomenklatura AS NOMENKLATURA_GUID
,PYZ.partner AS POSTAVCHIK_GUID
,PZ.otvetstvennyy AS MENEDZHER_GUID
,DATEADD(YEAR,-2000, PYZ.period) AS PERIOD

--INTO [L1].[DBO].[PLAN_ZAKUPOK]

  FROM [L0].[dbo].[plan_zakupok] AS PZ
 LEFT JOIN [L0].[dbo].[plany_zakupok] AS PYZ 
	ON PZ.ssylka=PYZ.plan_zakupok
LEFT JOIN L0.dbo.sezony AS S
	ON PZ.sezon=S.ssylka

	ORDER BY S.naimenovanie DESC