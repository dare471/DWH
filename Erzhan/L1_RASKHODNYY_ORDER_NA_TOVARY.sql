/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT [nomenklatura] AS [NOMENKLATURA_GUID] 
		,DATEADD(YEAR,-2000,RONT.[data])[DATA]
	  ,[naznachenie] AS [NAZNACHENIE_GUID]
	  ,[synonym_rasporyazhenie] AS [SYNONYM_RASPORYAZHENIE]
      ,[rasporyazhenie] AS [RASPORYAZHENIE_GUID]
      --,[seriya] AS [SERIYA_GUID]
      ,[kolichestvo] AS [KOLICHESTVO]
      ,TR.[ssylka] AS [GUID]
	  ,RONT.nomer AS NOMER
	  ,RONT.vsego_mest AS [VSEGO_MEST]
	  ,DATEADD(YEAR,-2000,RONT.[data_otgruzki])[DATA_OTGRUZKI]
	  ,sklad AS SKLAD_OTGRUZKI_GUID
	  ,poluchatel AS POLUCHATEL_GUID
	  ,ISNULL(S.naimenovanie,ISNULL(PAR.naimenovanie,SP.naimenovanie)) AS POLUCHATEL_NAIMENOVANIE
	  ,RONT.synonym_poluchatel AS SYNONYM_POLUCHATEL
	  ,SO.description AS SKLADSKAYA_OPERATSIYA
	  ,SRO.description AS [STATUS]
	  ,P.naimenovanie AS OTVETSTVENNYY
	  ,RONT.[KOMMENTARIY]
--INTO [L1].[DBO].[RASKHODNYY_ORDER_NA_TOVARY] 
FROM [L0].[dbo].[tab_tovary_po_rasporyazheniyam_raskhodnyyordernatovary] TR
LEFT JOIN [L0].[dbo].[raskhodnyy_order_na_tovary] RONT
	ON TR.ssylka=RONT.ssylka
LEFT JOIN [L0].[dbo].[skladskie_operatsii] SO
	ON RONT.skladskaya_operatsiya=SO.ssylka
LEFT JOIN [L0].[dbo].[statusy_raskhodnykh_orderov] SRO
	ON RONT.status=SRO.ssylka
LEFT JOIN L0.DBO.polzovateli P 
	ON RONT.otvetstvennyy=P.ssylka
LEFT JOIN L0.DBO.sklady S 
	ON S.ssylka=RONT.poluchatel
LEFT JOIN L0.DBO.partnery PAR
	ON RONT.poluchatel=PAR.ssylka
LEFT JOIN L0.DBO.struktura_predpriyatiya SP
	ON RONT.poluchatel=SP.ssylka
  --WHERE ssylka=0xA2367085C2A4312A11EB5942BF56F52E