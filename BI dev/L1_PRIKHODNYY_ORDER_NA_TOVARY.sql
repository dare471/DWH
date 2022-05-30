/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT  pot.rasporyazhenie as ZAKAZ_POSTAVSHCHIKU_GUID
	  ,pot.nomer AS NOMER
	  ,pot.sklad AS SKLAD_GUID
	  ,ZP.dogovor AS  DOGOVOR_GUID
      ,DATEADD(YEAR,-2000,POT.[data])[DATA]
      ,[synonym_rasporyazhenie] AS [SYNONYM_RASPORYAZHENIE]
	  ,[otpravitel] AS [OTPRAVITEL_GUID]
      ,[nomenklatura] AS [NOMENKLATURA_GUID]
      ,[kolichestvo] AS[KOLICHESTVO]
      ,[seriya] AS [SERIYA_GUID]
      ,ttp.[ssylka] AS GUID
--INTO  [L1].[DBO].[PRIKHODNYY_ORDER_NA_TOVARY] 
FROM [L0].[dbo].[tab_tovary_prikhodnyyordernatovary]  ttp
left join [L0].[dbo].[prikhodnyy_order_na_tovary] pot 
	on ttp.ssylka=pot.ssylka
LEFT JOIN [L0].[dbo].zakaz_postavshchiku ZP 
	ON POT.rasporyazhenie=ZP.ssylka
where pot.pometka_udaleniya=0x00