/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT PSBU.[ssilka] AS GUID
      ,PSBU.[kod] AS NOMER_SCHETA
	  ,PSBU_2.[kod] AS GRUPPA_SCHETOV
      ,PSBU.[naimenovanie] AS NAIMENOVANIE
      ,CASE PSBU.[vid]
		WHEN 0 THEN 'Активный'
		WHEN 1 THEN 'Пассивный'
		WHEN 2 THEN 'Активный/Пассивный'
	END AS AKTIVNOST
--INTO [L1].[dbo].[PLAN_SCHETOV_BUKHGALTERSKOGO_UCHETA]
  FROM [L0].[dbo].[plan_schetov_bukhgalterskogo_ucheta] AS PSBU
  LEFT JOIN [L0].[dbo].[plan_schetov_bukhgalterskogo_ucheta] AS PSBU_2
	ON PSBU.[roditel]=PSBU_2.[ssilka]