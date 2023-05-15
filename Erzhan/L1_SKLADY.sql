
SELECT S.[ssylka] as [GUID]
      ,[RODITEL] AS [RODITEL]
      ,[naimenovanie] AS [NAIMENOVANIE]
      ,[podrazdelenie] as [PODRAZDELENIE_GUID]
      ,[biznes_region] as [BIZNES_REGION_GUID]
      ,[organizatsiya] as [ORGANIZATSIYA_GUID]
	  ,TKIS.predstavlenie AS ADRES_SKLADA
	  ,'erp' as [SOURCE_BASE]
--INTO [L1].[dbo].[SKLADY]
  FROM [L0].[dbo].[sklady] AS S
  LEFT JOIN L0.DBO.tab_kontaktnaya_informatsiya_sklady AS TKIS 
	ON S.ssylka=TKIS.ssylka AND TKIS.predstavlenie <> 'm-zhos@mail.ru почта +7(777)761-42-09 Жолдасбек'