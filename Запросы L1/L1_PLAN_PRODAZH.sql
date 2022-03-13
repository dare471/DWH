/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT pp.[ssylka] as guid
      ,pp.[pometka_udaleniya]
      ,dateadd(year,-2000,[data])[data]
      ,[nomer]
      ,[proveden]
      ,[kommentariy]
      ,[podrazdelenie]as[podrazdelenie_guid]
      ,[status]as[status_guid]
      ,pp.[periodichnost]as[periodichnost_guid]
      ,dateadd(year,-2000,cast(pp.[nachalo_perioda] as date))[nachalo_perioda]
      ,dateadd(year,-2000,cast([okonchanie_perioda] as date)) [okonchanie_perioda]
      ,[menedzher] as [menedzher_guid]
      ,[obnovit_dopolnit]
      ,[izmenit_rezultat_na]
      ,[tochnost_okrugleniya]
      ,[raspredelit_po_rabochim_dnyam]
      ,[stsenariy] as [stsenariy_guid]
      ,vp.naimenovanie [vid_plana]
      ,[summa_dokumenta]
      ,[planirovat_po_summe]
      ,[valyuta] as [valyuta_guid]
      ,[zapolneno_avtomaticheski]
      ,[kross_tablitsa]
      ,[partner] as [partner_guid]
      ,[soglashenie]as [soglashenie_guid]
      ,[sklad]as[sklad_guid]
      ,pp.[grafik_oplaty]as[grafik_oplaty_guid]
      ,[kalendar]as[kalendar_guid]
      ,[dogovor]as[dogovor_guid]
      ,pp.[zapolnyat_plan_oplat]
      ,pp.[zapolnyat_po_formule]
      ,pp.[otrazhaetsya_v_byudzhetirovanii]
      ,pp.[statya_byudzhetov] as [statya_byudzhetov_guid]
      ,[stsenariy_byudzhetirovaniya]as[stsenariy_byudzhetirovaniya_guid]
      ,[otvetstvennyy]as[otvetstvennyy_guid]
      ,[format_magazina]as[format_magazina_guid]
      ,pp.[otrazhaetsya_v_byudzhetirovanii_oplaty]
      ,pp.[statya_byudzhetov_oplat]as[statya_byudzhetov_oplat_guid]
      ,pp.[otrazhaetsya_v_byudzhetirovanii_oplaty_kredit]
      ,pp.[statya_byudzhetov_oplat_kredit]as[statya_byudzhetov_oplat_kredit_guid]
      ,s.naimenovanie [sezon]
      ,[oplata_avans]
      ,[oplata_promezhutochnaya]
      ,[oplata_kredit]
      ,pp.[zameshchayushchiy]
      ,[naznachenie]as[naznachenie_guid]
      ,[organizatsiya_dlya_byudzheta]as[organizatsiya_dlya_byudzheta_guid]
      ,[rezhim_korrektirovki]
      ,[status_korrektirovki]as [status_korrektirovki_guid]
      ,pp.[oblast_dannykh_osnovnye_dannye]
  FROM [L0].[dbo].[plan_prodazh] pp
  left join [L0].dbo.vidy_planov vp on pp.vid_plana=vp.ssylka
  left join [L0].dbo.sezony s on pp.sezon=s.ssylka


  CREATE TABLE [L1].[dbo].[PLAN_PRODAZH](
	[GUID] [BINARY](16) NULL,
	[POMETKA_UDALENIYA] [BINARY](1) NULL,
	[DATA] [DATETIME2](0) NULL,
	[NOMER] [NVARCHAR](11) NULL,
	[PROVEDEN] [BINARY](1) NULL,
	[KOMMENTARIY] [NVARCHAR](MAX) NULL,
	[PODRAZDELENIE_GUID] [BINARY](16) NULL,
	[STATUS_GUID] [BINARY](16) NULL,
	[PERIODICHNOST_GUID] [BINARY](16) NULL,
	[NACHALO_PERIODA] [DATETIME2](0) NULL,
	[OKONCHANIE_PERIODA] [DATETIME2](0) NULL,
	[MENEDZHER_GUID] [BINARY](16) NULL,
	[OBNOVIT_DOPOLNIT] [NUMERIC](1, 0) NULL,
	[IZMENIT_REZULTAT_NA] [NUMERIC](5, 2) NULL,
	[TOCHNOST_OKRUGLENIYA] [NUMERIC](1, 0) NULL,
	[RASPREDELIT_PO_RABOCHIM_DNYAM] [BINARY](1) NULL,
	[STSENARIY_GUID] [BINARY](16) NULL,
	[VID_PLANA] [NVARCHAR](50) NULL,
	[SUMMA_DOKUMENTA] [NUMERIC](15, 2) NULL,
	[PLANIROVAT_PO_SUMME] [BINARY](1) NULL,
	[VALYUTA_GUID] [BINARY](16) NULL,
	[ZAPOLNENO_AVTOMATICHESKI] [BINARY](1) NULL,
	[KROSS_TABLITSA] [BINARY](1) NULL,
	[PARTNER_GUID] [BINARY](16) NULL,
	[SOGLASHENIE_GUID] [BINARY](16) NULL,
	[SKLAD_GUID] [BINARY](16) NULL,
	[GRAFIK_OPLATY_GUID] [BINARY](16) NULL,
	[KALENDAR_GUID] [BINARY](16) NULL,
	[DOGOVOR_GUID] [BINARY](16) NULL,
	[ZAPOLNYAT_PLAN_OPLAT] [BINARY](1) NULL,
	[ZAPOLNYAT_PO_FORMULE] [BINARY](1) NULL,
	[OTRAZHAETSYA_V_BYUDZHETIROVANII] [BINARY](1) NULL,
	[STATYA_BYUDZHETOV_GUID] [BINARY](16) NULL,
	[STSENARIY_BYUDZHETIROVANIYA_GUID] [BINARY](16) NULL,
	[OTVETSTVENNYY_GUID] [BINARY](16) NULL,
	[FORMAT_MAGAZINA_GUID] [BINARY](16) NULL,
	[OTRAZHAETSYA_V_BYUDZHETIROVANII_OPLATY] [BINARY](1) NULL,
	[STATYA_BYUDZHETOV_OPLAT_GUID] [BINARY](16) NULL,
	[OTRAZHAETSYA_V_BYUDZHETIROVANII_OPLATY_KREDIT] [BINARY](1) NULL,
	[STATYA_BYUDZHETOV_OPLAT_KREDIT_GUID] [BINARY](16) NULL,
	[SEZON] [NVARCHAR](25) NULL,
	[OPLATA_AVANS] [NUMERIC](10, 0) NULL,
	[OPLATA_PROMEZHUTOCHNAYA] [NUMERIC](10, 0) NULL,
	[OPLATA_KREDIT] [NUMERIC](10, 0) NULL,
	[ZAMESHCHAYUSHCHIY] [BINARY](1) NULL,
	[NAZNACHENIE_GUID] [BINARY](16) NULL,
	[ORGANIZATSIYA_DLYA_BYUDZHETA_GUID] [BINARY](16) NULL,
	[REZHIM_KORREKTIROVKI] [BINARY](1) NULL,
	[STATUS_KORREKTIROVKI_GUID] [BINARY](16) NULL,
	[OBLAST_DANNYKH_OSNOVNYE_DANNYE] [NUMERIC](7, 0) NULL
)