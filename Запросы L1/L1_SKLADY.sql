
SELECT [ssylka] as [guid]
      ,[roditel]
      ,[naimenovanie]
      ,[podrazdelenie] as [podrazdelenie_guid]
      ,[biznes_region] as [biznes_region_guid]
      ,[organizatsiya] as [organizatsiya_guid]
	  ,'erp' as source_base
  FROM [L0].[dbo].[sklady]


  create table [L1].[DBO].[SKLADY](
	[GUID] [BINARY](16) NOT NULL,
	[RODITEL] [BINARY](16) NOT NULL,
	[NAIMENOVANIE] [NVARCHAR](80) NULL,
	[PODRAZDELENIE_GUID] [BINARY](16) NULL,
	[BIZNES_REGION_GUID] [BINARY](16) NULL,
	[ORGANIZATSIYA_GUID] [BINARY](16) NULL,
	[SOURCE_BASE] [VARCHAR](5) NULL
) 