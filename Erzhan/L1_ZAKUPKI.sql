SELECT dateadd(year,-2000,Z.period)[PERIOD] 
      ,[synonym_registrator] AS [SYNONYM_REGISTRATOR]
      ,[organizatsiya] AS [ORGANIZATSIYA_GUID]
      ,[menedzher] AS [MENEDZHER_GUID]
      ,[sklad] AS [SKLAD_GUID]
      ,[partner] AS [PARTNER_GUID]
      ,[kontragent] AS [KONTRAGENT_GUID]
      ,[dogovor]  AS [DOGOVOR_GUID]
      ,[synonym_zakaz] AS [SYNONYM_ZAKAZ_POSTAVCHIKU]
      ,[zakaz]AS [ZAKAZ_POSTAVCHIKU]
      ,[kolichestvo]  AS [KOLICHESTVO]
      ,summa_v_valyute_dokumenta AS [SUMMA]
      ,[valyuta_vzaimoraschetov] AS [VALYUTA_VZAIMORASCHETOV]
      ,[istochnik_g_f_u_nomenklatury] AS [NOMENKLATURA_GUID]
--INTO L1.DBO.[ZAKUPKI]
  FROM [L0].[dbo].[zakupki] Z

  WHERE 1=1 
