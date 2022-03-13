SELECT [ssylka] AS [GUID]
      ,[pometka_udaleniya] AS [POMETKA_UDALENIYA]
      ,[vladelets] AS [VLADELETS]
      ,[roditel] AS [RODITEL]
      ,[kod] AS [KOD]
      ,[naimenovanie] AS [NAIMENOVANIE]
      ,[rekvizit_dop_uporyadochivaniya] AS [REKVIZIT_DOP_UPORYADOCHIVANIYA]
      ,[rayonnyy_koeffitsient] AS [RAYONNYY_KOEFFITSIENT]
      ,[rayonnyy_koeffitsient_r_f] AS [RAYONNYY_KOEFFITSIENT_R_F]
      ,[obosoblennoe_podrazdelenie] AS [OBOSOBLENNOE_PODRAZDELENIE]
      ,[sformirovano] AS [SFORMIROVANO]
      ,DATEADD(YEAR, -2000, [data_sozdaniya]) AS [DATA_SOZDANIYA]
      ,[rasformirovano] AS [RASFORMIROVANO]
      ,[data_rasformirovaniya] AS [DATA_RASFORMIROVANIYA]
      ,[golovnaya_organizatsiya] AS [GOLOVNAYA_ORGANIZATSIYA]
      ,[registratsiya_v_nalogovom_organe] AS [REGISTRATSIYA_V_NALOGOVOM_ORGANE]
      ,[sootvetstvuet_sudam_zaregistrirovannym_v_rossiyskom_mezhdunarodnom_reestre_sudov] AS [SOOTVETSTVUET_SUDAM_ZAREGISTRIROVANNYM_V_ROSSIYSKOM_MEZHDUNARODNOM_REESTRE_SUDOV]
      ,[rekvizit_dop_uporyadochivaniya_ierarkhicheskogo] AS [REKVIZIT_DOP_UPORYADOCHIVANIYA_IERARKHICHESKOGO]
      ,[udalit_territorialnye_usloviya_p_f_r] AS [UDALIT_TERRITORIALNYE_USLOVIYA_P_F_R]
      ,[grafik_raboty_sotrudnikov] AS [GRAFIK_RABOTY_SOTRUDNIKOV]
      ,[kod_o_k_v_e_d] AS [KOD_O_K_V_E_D]
      ,[naimenovanie_o_k_v_e_d] AS [NAIMENOVANIE_O_K_V_E_D]
      ,[imeet_nomer_territorialnogo_organa_rosstata] AS [IMEET_NOMER_TERRITORIALNOGO_ORGANA_ROSSTATA]
      ,[nomer_territorialnogo_organa_rosstata] AS [NOMER_TERRITORIALNOGO_ORGANA_ROSSTATA]
      ,[protsent_severnoy_nadbavki] AS [PROTSENT_SEVERNOY_NADBAVKI]
      ,[udalit_kolichestvo_dopolnitelnykh_dney_otpuska_v_god] AS [UDALIT_KOLICHESTVO_DOPOLNITELNYKH_DNEY_OTPUSKA_V_GOD]
      ,[kod_organa_f_s_g_s] AS [KOD_ORGANA_F_S_G_S]
      ,[kod_o_k_v_e_d_2] AS [KOD_O_K_V_E_D_2]
      ,[naimenovanie_o_k_v_e_d_2] AS [NAIMENOVANIE_O_K_V_E_D_2]
      ,[oblast_dannykh_osnovnye_dannye] AS [OBLAST_DANNYKH_OSNOVNYE_DANNYE]
         ,CAST(GETDATE() AS DATE) A_DATE
       
  FROM [L0].[dbo].[podrazdeleniya_organizatsiy]


  CREATE TABLE [L1].[dbo].[PODRAZDELENIYA_ORGANIZATSIY](
	[GUID] [binary](16) NULL,
	[POMETKA_UDALENIYA] [binary](1) NULL,
	[VLADELETS] [binary](16) NULL,
	[RODITEL] [binary](16) NULL,
	[KOD] [nvarchar](9) NULL,
	[NAIMENOVANIE] [nvarchar](150) NULL,
	[REKVIZIT_DOP_UPORYADOCHIVANIYA] [numeric](5, 0) NULL,
	[RAYONNYY_KOEFFITSIENT] [numeric](4, 3) NULL,
	[RAYONNYY_KOEFFITSIENT_R_F] [numeric](3, 2) NULL,
	[OBOSOBLENNOE_PODRAZDELENIE] [binary](1) NULL,
	[SFORMIROVANO] [binary](1) NULL,
	[DATA_SOZDANIYA] [datetime2](0) NULL,
	[RASFORMIROVANO] [binary](1) NULL,
	[DATA_RASFORMIROVANIYA] [datetime2](0) NULL,
	[GOLOVNAYA_ORGANIZATSIYA] [binary](16) NULL,
	[REGISTRATSIYA_V_NALOGOVOM_ORGANE] [binary](16) NULL,
	[SOOTVETSTVUET_SUDAM_ZAREGISTRIROVANNYM_V_ROSSIYSKOM_MEZHDUNARODNOM_REESTRE_SUDOV] [binary](1) NULL,
	[REKVIZIT_DOP_UPORYADOCHIVANIYA_IERARKHICHESKOGO] [nvarchar](100) NULL,
	[UDALIT_TERRITORIALNYE_USLOVIYA_P_F_R] [binary](16) NULL,
	[GRAFIK_RABOTY_SOTRUDNIKOV] [binary](16) NULL,
	[KOD_O_K_V_E_D] [nvarchar](8) NULL,
	[NAIMENOVANIE_O_K_V_E_D] [nvarchar](254) NULL,
	[IMEET_NOMER_TERRITORIALNOGO_ORGANA_ROSSTATA] [binary](1) NULL,
	[NOMER_TERRITORIALNOGO_ORGANA_ROSSTATA] [nvarchar](14) NULL,
	[PROTSENT_SEVERNOY_NADBAVKI] [numeric](5, 2) NULL,
	[UDALIT_KOLICHESTVO_DOPOLNITELNYKH_DNEY_OTPUSKA_V_GOD] [numeric](2, 0) NULL,
	[KOD_ORGANA_F_S_G_S] [nvarchar](5) NULL,
	[KOD_O_K_V_E_D_2] [nvarchar](8) NULL,
	[NAIMENOVANIE_O_K_V_E_D_2] [nvarchar](254) NULL,
	[OBLAST_DANNYKH_OSNOVNYE_DANNYE] [numeric](7, 0) NULL,
	[A_DATE] [date] NULL
) 