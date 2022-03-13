SELECT [ssylka] AS [GUID]
      ,[pometka_udaleniya] AS [POMETKA_UDALENIYA]
      ,DATEADD(YEAR, -2000, [data]) AS [DATA]
      ,[nomer] AS [NOMER]
      ,[proveden] AS [PROVEDEN]
      ,[avtor] AS [AVTOR_GUID]
      ,[dokument_osnovanie] AS [DOKUMENT_OSNOVANIE]
      ,[sotrudnik] AS [FIZICHESKOE_LITSO_GUID]
      ,[organizatsiya] AS [ORGANIZATSIYA_GUID]
      ,[podrazdelenie] AS [PODRAZDELENIE_GUID]
      ,[oblast_dannykh_osnovnye_dannye] AS [OBLAST_DANNYKH_OSNOVNYE_DANNYE]   
         ,CAST(GETDATE() AS DATE) A_DATE
FROM [L0].[dbo].[otchet_o_komandirovke]

CREATE TABLE [L1].[dbo].[OTCHET_O_KOMANDIROVKE](
	[GUID] [binary](16) NULL,
	[POMETKA_UDALENIYA] [binary](1) NULL,
	[DATA] [datetime2](0) NULL,
	[NOMER] [nvarchar](9) NULL,
	[PROVEDEN] [binary](1) NULL,
	[AVTOR_GUID] [binary](16) NULL,
	[DOKUMENT_OSNOVANIE] [binary](16) NULL,
	[FIZICHESKOE_LITSO_GUID] [binary](16) NULL,
	[ORGANIZATSIYA_GUID] [binary](16) NULL,
	[PODRAZDELENIE_GUID] [binary](16) NULL,
	[OBLAST_DANNYKH_OSNOVNYE_DANNYE] [numeric](7, 0) NULL,
	[A_DATE] [date] NULL
)