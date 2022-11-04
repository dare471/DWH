SELECT  dateadd(year,-2000,[period])[PERIOD]
      ,[synonym_registrator] as SYNONYM_REGISTRATOR
	  ,dogovor.ssylka as DOGOVOR_GUID
      ,[type_registrator] as TYPE_REGISTRATOR
      ,[registrator] AS REGISTRATOR
      ,[nomer_stroki] AS NOMER_STROKI
      ,[aktivnost] AS AKTIVNOST
      ,[analitika_ucheta_po_partneram] AS ANALITIKA_UCHETA_PO_PARTNERAM
      ,[synonym_zakaz_klienta] AS SYNONYM_ZAKAZ_KLIENTA
      ,[type_zakaz_klienta] AS TYPE_ZAKAZ_KLIENTA
      ,rsk.[zakaz_klienta] AS ZAKAZ_KLIENTA_GUID
      ,[valyuta] AS VALYUTA_GUID
      ,rsk.[summa] AS [SUMMA]
      ,[k_oplate] AS [K_OPLATE]
      ,[oplachivaetsya] AS OPLACHIVAETSYA
      ,[k_otgruzke] AS K_OTGRUZKE
      ,[otgruzhaetsya] AS OTGRUZHAETSYA
      ,rsk.[khozyaystvennaya_operatsiya] AS KHOZYAYSTVENNAYA_OPERATSIYA
      ,rsk.[forma_oplaty] AS FORMA_OPLATY
      ,[schet_na_oplatu] AS SCHET_NA_OPLATU
      ,[synonym_prodazha_po_zakazu] AS SYNONYM_PRODAZHA_PO_ZAKAZU
      ,[type_prodazha_po_zakazu] AS TYPE_PRODAZHA_PO_ZAKAZU
      ,[prodazha_po_zakazu]  AS PRODAZHA_PO_ZAKAZU
      ,dateadd(year,-2000,[data_registratora]) AS [DATA_REGISTRATORA]
      ,dateadd(year,-2000,[data_platezha]) AS [DATA_PLATEZHA]
      ,[summa_regl] AS [SUMMA_REGL]
      ,[summa_upr] AS [SUMMA_UPR]
      ,[isklyuchat_pri_kontrole] AS ISKLYUCHAT_PRI_KONTROLE
      ,rsk.[dopustimaya_summa_zadolzhennosti] AS DOPUSTIMAYA_SUMMA_ZADOLZHENNOSTI
      ,[zalog_za_taru] AS ZALOG_ZA_TARU
      ,rsk.[statya_dvizheniya_denezhnykh_sredstv] AS STATYA_DVIZHENIYA_DENEZHNYKH_SREDSTV
      ,[synonym_raschetnyy_dokument] AS SYNONYM_RASCHETNYY_DOKUMENT
      ,[type_raschetnyy_dokument] AS TYPE_RASCHETNYY_DOKUMENT
      ,[raschetnyy_dokument] AS RASCHETNYY_DOKUMENT
	  ,analitika.organizatsiya as ORGANIZATSIYA_GUID
--into [L1].[dbo].[RASCHETY_S_KLIENTAMI]
  FROM [L0].[dbo].[raschety_s_klientami] rsk
  	 LEFT JOIN [L0].dbo.klyuchi_analitiki_ucheta_po_partneram AS analitika ON rsk.analitika_ucheta_po_partneram = analitika.ssylka 
	 LEFT JOIN [L0].dbo.dogovory_kontragentov AS dogovor ON analitika.dogovor = dogovor.ssylka
