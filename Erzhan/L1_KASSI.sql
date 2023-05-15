/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT [kassi].[ssilka] AS GUID
      ,[vladelec] AS ORGANIZATSIYA_GUID
	  ,organizatsii.naimenovanie AS ORGANIZATSIYA
      ,[kassi].[naimenovanie] AS [NAIMENOVANIE]

--INTO [L1].[dbo].[KASSI]

  FROM [L0].[dbo].[kassi]
  LEFT JOIN [L0].[dbo].organizatsii
 ON [kassi].[vladelec]=organizatsii.ssylka