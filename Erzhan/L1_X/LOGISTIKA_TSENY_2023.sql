/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT [KOD_NOMENKLATUR]
      ,[TSENY]
      ,[NAME_NOMENKLATUR]
	  ,ISNULL(N.ssylka,0) AS GUID
---INTO [L1_X].[dbo].[LOGISTIKA_TSENY_2023]    EXCEL KARIM ZHIBERGEN
  FROM [L1_X].[dbo].[TEST_LOGISTIKA_TSENY_2023]
  LEFT JOIN L0.dbo.nomenklatura N 
  ON N.kod=[KOD_NOMENKLATUR]