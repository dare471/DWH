SELECT [ssylka] AS [GUID]
      ,[pometka_udaleniya] AS [POMETKA_UDALENIYA]
      ,[roditel] AS [RODITEL]
      ,[naimenovanie] AS [NAIMENOVANIE]
      ,[osnovnoy_menedzher] AS [OSNOVNOY_MENEDZHER]
      ,[geograficheskiy_region] AS [GEOGRAFICHESKIY_REGION]
      ,[sezonnaya_gruppa] AS [SEZONNAYA_GRUPPA]
      ,[kod_regiona] AS [KOD_REGIONA]
      ,[geograficheskaya_zona] AS [GEOGRAFICHESKAYA_ZONA]
      ,[c_r_m___vremya_po_grinvichu___g_m_t] AS [C_R_M___VREMYA_PO_GRINVICHU___G_M_T]
      ,[zona_komandirovki] AS [ZONA_KOMANDIROVKI]
      ,[oblast_dannykh_osnovnye_dannye] AS [OBLAST_DANNYKH_OSNOVNYE_DANNYE]
      ,CAST(GETDATE() AS DATE) A_DATE
  FROM [L0].[dbo].[biznes_regiony]


  CREATE TABLE [L1].[dbo].[BIZNES_REGIONY](
	[GUID] [binary](16) NULL,
	[POMETKA_UDALENIYA] [binary](1) NULL,
	[RODITEL] [binary](16) NULL,
	[NAIMENOVANIE] [nvarchar](100) NULL,
	[OSNOVNOY_MENEDZHER] [binary](16) NULL,
	[GEOGRAFICHESKIY_REGION] [nvarchar](max) NULL,
	[SEZONNAYA_GRUPPA] [binary](16) NULL,
	[KOD_REGIONA] [nvarchar](10) NULL,
	[GEOGRAFICHESKAYA_ZONA] [nvarchar](10) NULL,
	[C_R_M___VREMYA_PO_GRINVICHU___G_M_T] [numeric](2, 0) NULL,
	[ZONA_KOMANDIROVKI] [binary](16) NULL,
	[OBLAST_DANNYKH_OSNOVNYE_DANNYE] [numeric](7, 0) NULL,
	[A_DATE] [date] NULL
)