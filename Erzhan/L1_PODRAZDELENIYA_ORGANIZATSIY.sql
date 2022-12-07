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