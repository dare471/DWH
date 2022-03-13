/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT  dateadd(year,-2000,[period])[period]
      ,[synonym_registrator]
	  ,dogovor.ssylka as dogovor_guid
      ,[type_registrator]
      ,[registrator]
      ,[nomer_stroki]
      ,[aktivnost]
      ,[analitika_ucheta_po_partneram]
      ,[synonym_zakaz_klienta]
      ,[type_zakaz_klienta]
      ,rsk.[zakaz_klienta]
      ,[valyuta]
      ,rsk.[summa]
      ,[k_oplate]
      ,[oplachivaetsya]
      ,[k_otgruzke]
      ,[otgruzhaetsya]
      ,rsk.[khozyaystvennaya_operatsiya]
      ,rsk.[forma_oplaty]
      ,[schet_na_oplatu]
      ,[synonym_prodazha_po_zakazu]
      ,[type_prodazha_po_zakazu]
      ,[prodazha_po_zakazu]
      ,dateadd(year,-2000,[data_registratora])[data_registratora]
      ,dateadd(year,-2000,[data_platezha])[data_platezha]
      ,[summa_regl]
      ,[summa_upr]
      ,[isklyuchat_pri_kontrole]
      ,rsk.[dopustimaya_summa_zadolzhennosti]
      ,[zalog_za_taru]
      ,rsk.[statya_dvizheniya_denezhnykh_sredstv]
      ,[synonym_raschetnyy_dokument]
      ,[type_raschetnyy_dokument]
      ,[raschetnyy_dokument]
  FROM [L0].[dbo].[raschety_s_klientami] rsk
  	 LEFT JOIN [L0].dbo.klyuchi_analitiki_ucheta_po_partneram AS analitika ON rsk.analitika_ucheta_po_partneram = analitika.ssylka 
	 LEFT JOIN [L0].dbo.dogovory_kontragentov AS dogovor ON analitika.dogovor = dogovor.ssylka
	 --WHERE [synonym_registrator] <> 'Корректировка реализации' AND [synonym_registrator] <> 'Реализация товаров и услуг'-- AND dogovor.ssylka=0xA22E7085C2A4312A11EAC0304F1CBAB0
		--order by dogovor.ssylka,[synonym_zakaz_klienta],[period]





CREATE TABLE [L1].[DBO].[RASCHETY_S_KLIENTAMI](
	[PERIOD] [DATETIME2](0) NULL,
	[SYNONYM_REGISTRATOR] [VARCHAR](255) NULL,
	[DOGOVOR_GUID] [BINARY](16) NULL,
	[TYPE_REGISTRATOR] [BINARY](4) NULL,
	[REGISTRATOR] [BINARY](16) NULL,
	[NOMER_STROKI] [NUMERIC](9, 0) NULL,
	[AKTIVNOST] [BINARY](1) NULL,
	[ANALITIKA_UCHETA_PO_PARTNERAM] [BINARY](16) NULL,
	[SYNONYM_ZAKAZ_KLIENTA] [VARCHAR](255) NULL,
	[TYPE_ZAKAZ_KLIENTA] [BINARY](4) NULL,
	[ZAKAZ_KLIENTA] [BINARY](16) NULL,
	[VALYUTA] [BINARY](16) NULL,
	[SUMMA] [NUMERIC](15, 2) NULL,
	[K_OPLATE] [NUMERIC](15, 2) NULL,
	[OPLACHIVAETSYA] [NUMERIC](15, 2) NULL,
	[K_OTGRUZKE] [NUMERIC](15, 2) NULL,
	[OTGRUZHAETSYA] [NUMERIC](15, 2) NULL,
	[KHOZYAYSTVENNAYA_OPERATSIYA] [BINARY](16) NULL,
	[FORMA_OPLATY] [BINARY](16) NULL,
	[SCHET_NA_OPLATU] [BINARY](16) NULL,
	[SYNONYM_PRODAZHA_PO_ZAKAZU] [VARCHAR](255) NULL,
	[TYPE_PRODAZHA_PO_ZAKAZU] [BINARY](4) NULL,
	[PRODAZHA_PO_ZAKAZU] [BINARY](16) NULL,
	[DATA_REGISTRATORA] [DATETIME2](0) NULL,
	[DATA_PLATEZHA] [DATETIME2](0) NULL,
	[SUMMA_REGL] [NUMERIC](15, 2) NULL,
	[SUMMA_UPR] [NUMERIC](15, 2) NULL,
	[ISKLYUCHAT_PRI_KONTROLE] [BINARY](1) NULL,
	[DOPUSTIMAYA_SUMMA_ZADOLZHENNOSTI] [NUMERIC](15, 2) NULL,
	[ZALOG_ZA_TARU] [NUMERIC](15, 2) NULL,
	[STATYA_DVIZHENIYA_DENEZHNYKH_SREDSTV] [BINARY](16) NULL,
	[SYNONYM_RASCHETNYY_DOKUMENT] [VARCHAR](255) NULL,
	[TYPE_RASCHETNYY_DOKUMENT] [BINARY](4) NULL,
	[RASCHETNYY_DOKUMENT] [BINARY](16) NULL
)