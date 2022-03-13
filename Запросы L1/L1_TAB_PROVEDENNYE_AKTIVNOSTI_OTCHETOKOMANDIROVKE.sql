SELECT [ssylka] AS [GUID] 
         ,[nomer_stroki] AS [NOMER_STROKI]
      ,[biznes_region_prebyvaniya_1] AS [BIZNES_REGION_PREBYVANIYA_1]
      ,[biznes_region_prebyvaniya_2] AS [BIZNES_REGION_PREBYVANIYA_2]
      ,DATEADD(YEAR, -2000, [data_sobytiya]) AS [DATA_SOBYTIYA]
      ,[sobytie] AS [SOBYTIE]
      ,[kontragent_1] AS [KONTRAGENT_1]
      ,[synonym_kontragent_2] AS [SYNONYM_KONTRAGENT_2]
      ,[type_kontragent_2] AS [TYPE_KONTRAGENT_2]
      ,[kontragent_2] AS [KONTRAGENT_2]
      ,[predmet_sobytiya] AS [PREDMET_SOBYTIYA]
      ,[rezultat] AS [REZULTAT]
      ,[nelzya_udalyat] AS [NELZYA_UDALYAT]
      ,[oblast_dannykh_osnovnye_dannye] AS [OBLAST_DANNYKH_OSNOVNYE_DANNYE]
         ,CAST(GETDATE() AS DATE) A_DATE
  FROM [L0].[dbo].[tab_provedennye_aktivnosti_otchetokomandirovke]



  CREATE TABLE [L1].[dbo].[TAB_PROVEDENNYE_AKTIVNOSTI_OTCHETOKOMANDIROVKE](
	[GUID] [binary](16) NULL,
	[NOMER_STROKI] [numeric](5, 0) NULL,
	[BIZNES_REGION_PREBYVANIYA_1] [nvarchar](30) NULL,
	[BIZNES_REGION_PREBYVANIYA_2] [binary](16) NULL,
	[DATA_SOBYTIYA] [datetime2](0) NULL,
	[SOBYTIE] [binary](16) NULL,
	[KONTRAGENT_1] [nvarchar](30) NULL,
	[SYNONYM_KONTRAGENT_2] [varchar](255) NULL,
	[TYPE_KONTRAGENT_2] [binary](4) NULL,
	[KONTRAGENT_2] [binary](16) NULL,
	[PREDMET_SOBYTIYA] [nvarchar](max) NULL,
	[REZULTAT] [nvarchar](max) NULL,
	[NELZYA_UDALYAT] [binary](1) NULL,
	[OBLAST_DANNYKH_OSNOVNYE_DANNYE] [numeric](7, 0) NULL,
	[A_DATE] [date] NULL
)