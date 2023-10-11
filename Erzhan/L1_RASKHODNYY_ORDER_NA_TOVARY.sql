/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT  TOT.[nomenklatura] AS [NOMENKLATURA_GUID] 
		,DATEADD(YEAR,-2000,RONT.[data])[DATA]
	  --,TR.[naznachenie] AS [NAZNACHENIE_GUID]
	  --,[synonym_rasporyazhenie] AS [SYNONYM_RASPORYAZHENIE]
   --   ,[rasporyazhenie] AS [RASPORYAZHENIE_GUID]
      ,TOT.[seriya] AS [SERIYA_GUID]
      ,TOT.[kolichestvo] AS [KOLICHESTVO]
      ,TOT.[ssylka] AS [GUID]
	  ,RONT.nomer AS NOMER
	  ,RONT.vsego_mest AS [VSEGO_MEST]
	  ,DATEADD(YEAR,-2000,RONT.[data_otgruzki])[DATA_OTGRUZKI]
	  ,RONT.sklad AS SKLAD_OTGRUZKI_GUID
	  ,poluchatel AS POLUCHATEL_GUID
	  ,ISNULL(S.naimenovanie,ISNULL(PAR.naimenovanie,SP.naimenovanie)) AS POLUCHATEL_NAIMENOVANIE
	  ,RONT.synonym_poluchatel AS SYNONYM_POLUCHATEL
	  ,SO.description AS SKLADSKAYA_OPERATSIYA
	  ,SRO.description AS [STATUS]
	  ,P.naimenovanie AS OTVETSTVENNYY
	  --,ZK.dogovor AS DOGOVOR_GUID
	  ,RONT.[KOMMENTARIY]
--INTO [L1].[DBO].[RASKHODNYY_ORDER_NA_TOVARY] 
FROM [L0].[dbo].[tab_otgruzhaemye_tovary_raskhodnyyordernatovary] AS TOT
LEFT JOIN [L0].[dbo].[raskhodnyy_order_na_tovary] RONT
	ON TOT.ssylka=RONT.ssylka
--LEFT JOIN L0.dbo.[tab_tovary_po_rasporyazheniyam_raskhodnyyordernatovary] AS TTP
--	ON RONT.ssylka=TTP.ssylka
--LEFT JOIN L0.dbo.zakaz_klienta AS ZK
--	ON TTP.[rasporyazhenie]=ZK.ssylka
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
	ON RONT.poluchatel=SP.ssilka
LEFT JOIN L1.DBO.NOMENKLATURA AS N
	ON N.GUID=TOT.nomenklatura
WHERE 1=1
AND RONT.pometka_udaleniya=0
--AND RONT.nomer='00-00007755'
--RONT.ssylka=0xAF9AD4F5EF10792511EDFA31C8476D99