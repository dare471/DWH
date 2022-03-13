SELECT [ssylka] as [GUID]
      ,[pometka_udaleniya] AS [POMETKA_UDALENIYA]
      ,dateadd(year, -2000, [data]) as [DATA]
      ,[nomer] AS [NOMER]
      ,[proveden] AS [PROVEDEN]
      ,[sotrudnik] AS [FIZICHESKOE_LITSO_GUID]
      ,[organizatsiya] AS [ORGANIZATSIYA_GUID]
      ,[podrazdelenie] AS [PODRAZDELENIE_GUID]
      ,dateadd(year, -2000, [data_nachala]) as [DATA_NACHALA]
      ,dateadd(year, -2000, [data_okonchaniya]) as [DATA_OKONCHANIYA]
      ,[tsel] AS [TSEL]
      ,[dlitelnost_komandirovki_dni] AS [DLITELNOST_KOMANDIROVKI_DNI]
      ,[kommentariy] AS [KOMMENTARIY]
      ,[avtor] AS [AVTOR_GUID]
      ,[summa_dokumenta] AS [SUMMA_DOKUMENTA]
      ,[kategoriya_sotrudnika] AS [KATEGORIYA_SOTRUDNIKA]
      ,[stavka_m_r_p_na_datu_nachala] AS [STAVKA_M_R_P_NA_DATU_NACHALA]
     ,[status_1] AS [STATUS_1]
      ,[na_soglasovanii] AS [NA_SOGLASOVANII]
      ,[otvetstvennyy_1] AS [OTVETSTVENNYY_1]
      ,[rezultat_1] AS [REZULTAT_1] 
      ,[otrabotano] AS [OTRABOTANO]
      ,[otrabotano_avtor] AS [OTRABOTANO_AVTOR]
      ,[otrabotano_data] AS [OTRABOTANO_DATA]
      ,dateadd(year, -2000, [otvetstvennyy_1___data_soglasovaniya]) as [OTVETSTVENNYY_1___DATA_SOGLASOVANIYA]
      ,[otvetstvennyy_1___soglasoval] AS [OTVETSTVENNYY_1___SOGLASOVAL]
      ,[zayavka_na_d_s] AS [ZAYAVKA_NA_D_S]
      ,[komandirovka] AS [KOMANDIROVKA_GUID]
      ,[ispolnitelnoe_proizvodstvo] AS [ISPOLNITELNOE_PROIZVODSTVO]
      ,[otvetstvennyy_2] AS [OTVETSTVENNYY_2]
      ,[otvetstvennyy_2___soglasoval] AS [OTVETSTVENNYY_2___SOGLASOVAL]
      ,[otvetstvennyy_2___data_soglasovaniya] AS [OTVETSTVENNYY_2___DATA_SOGLASOVANIYA]
      ,[rezultat_2] AS [REZULTAT_2]
      ,[sezon] AS [SEZON_GUID]
      ,[dlitelnost_komandirovki_chasy] AS [DLITELNOST_KOMANDIROVKI_CHASY]
      ,[dney_v_puti] AS [DNEY_V_PUTI]
      ,[chasy_v_puti] AS [CHASY_V_PUTI]
      ,[dney_prebyvaniya] AS [DNEY_PREBYVANIYA]
      ,[chasov_prebyvaniya] AS [CHASOV_PREBYVANIYA]
      ,[status] AS [STATUS]
      ,[srochnaya_komandirovka] AS [SROCHNAYA_KOMANDIROVKA]
      ,[biznes_region_sotrudnika] AS [BIZNES_REGION_SOTRUDNIKA]
      ,[est_prozhivanie] AS [EST_PROZHIVANIE]
      ,[nuzhny_bilety] AS [NUZHNY_BILETY]
      ,[summa_sutochnykh] AS [SUMMA_SUTOCHNYKH]
      ,[summa_proezda] AS [SUMMA_PROEZDA]
      ,[summa_prozhivaniya] AS [SUMMA_PROZHIVANIYA]
      ,[summa_predstavitelskikh] AS [SUMMA_PREDSTAVITELSKIKH]
      ,[limit_sutochnykh] AS [LIMIT_SUTOCHNYKH]
      ,[limit_proezda] AS [LIMIT_PROEZDA]
      ,[limit_prozhivaniya] AS [LIMIT_PROZHIVANIYA]
      ,[limit_predstavitelskikh] AS [LIMIT_PREDSTAVITELSKIKH]
      ,[summa_limitov] AS [SUMMA_LIMITOV]
      ,[dney_sutochnykh] AS [DNEY_SUTOCHNYKH]
         ,CAST(GETDATE() AS DATE) A_DATE
FROM [L0].[dbo].[zayavka_na_komandirovku]


CREATE TABLE [L1].[dbo].[ZAYAVKA_NA_KOMANDIROVKU](
	[GUID] [binary](16) NULL,
	[POMETKA_UDALENIYA] [binary](1) NULL,
	[DATA] [datetime2](0) NULL,
	[NOMER] [nvarchar](9) NULL,
	[PROVEDEN] [binary](1) NULL,
	[FIZICHESKOE_LITSO_GUID] [binary](16) NULL,
	[ORGANIZATSIYA_GUID] [binary](16) NULL,
	[PODRAZDELENIE_GUID] [binary](16) NULL,
	[DATA_NACHALA] [datetime2](0) NULL,
	[DATA_OKONCHANIYA] [datetime2](0) NULL,
	[TSEL] [nvarchar](max) NULL,
	[DLITELNOST_KOMANDIROVKI_DNI] [numeric](3, 0) NULL,
	[KOMMENTARIY] [nvarchar](max) NULL,
	[AVTOR_GUID] [binary](16) NULL,
	[SUMMA_DOKUMENTA] [numeric](10, 2) NULL,
	[KATEGORIYA_SOTRUDNIKA] [binary](16) NULL,
	[STAVKA_M_R_P_NA_DATU_NACHALA] [numeric](10, 2) NULL,
	[STATUS_1] [binary](16) NULL,
	[NA_SOGLASOVANII] [binary](1) NULL,
	[OTVETSTVENNYY_1] [binary](16) NULL,
	[REZULTAT_1] [binary](16) NULL,
	[OTRABOTANO] [binary](1) NULL,
	[OTRABOTANO_AVTOR] [binary](16) NULL,
	[OTRABOTANO_DATA] [datetime2](0) NULL,
	[OTVETSTVENNYY_1___DATA_SOGLASOVANIYA] [datetime2](0) NULL,
	[OTVETSTVENNYY_1___SOGLASOVAL] [binary](16) NULL,
	[ZAYAVKA_NA_D_S] [binary](16) NULL,
	[KOMANDIROVKA_GUID] [binary](16) NULL,
	[ISPOLNITELNOE_PROIZVODSTVO] [binary](16) NULL,
	[OTVETSTVENNYY_2] [binary](16) NULL,
	[OTVETSTVENNYY_2___SOGLASOVAL] [binary](16) NULL,
	[OTVETSTVENNYY_2___DATA_SOGLASOVANIYA] [datetime2](0) NULL,
	[REZULTAT_2] [binary](16) NULL,
	[SEZON_GUID] [binary](16) NULL,
	[DLITELNOST_KOMANDIROVKI_CHASY] [numeric](4, 2) NULL,
	[DNEY_V_PUTI] [numeric](3, 0) NULL,
	[CHASY_V_PUTI] [numeric](4, 2) NULL,
	[DNEY_PREBYVANIYA] [numeric](3, 0) NULL,
	[CHASOV_PREBYVANIYA] [numeric](4, 2) NULL,
	[STATUS] [binary](16) NULL,
	[SROCHNAYA_KOMANDIROVKA] [binary](1) NULL,
	[BIZNES_REGION_SOTRUDNIKA] [binary](16) NULL,
	[EST_PROZHIVANIE] [binary](1) NULL,
	[NUZHNY_BILETY] [binary](1) NULL,
	[SUMMA_SUTOCHNYKH] [numeric](10, 2) NULL,
	[SUMMA_PROEZDA] [numeric](10, 2) NULL,
	[SUMMA_PROZHIVANIYA] [numeric](10, 2) NULL,
	[SUMMA_PREDSTAVITELSKIKH] [numeric](10, 2) NULL,
	[LIMIT_SUTOCHNYKH] [numeric](10, 2) NULL,
	[LIMIT_PROEZDA] [numeric](10, 2) NULL,
	[LIMIT_PROZHIVANIYA] [numeric](10, 2) NULL,
	[LIMIT_PREDSTAVITELSKIKH] [numeric](10, 2) NULL,
	[SUMMA_LIMITOV] [numeric](10, 2) NULL,
	[DNEY_SUTOCHNYKH] [numeric](10, 2) NULL,
	[A_DATE] [date] NULL
)