/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT DISTINCT
	  [dogovor]
	  --,DK.NOMER
	  --,tpr.nomenklatura
	  ,TOT.[nomenklatura]
	  ,TOT.seriya
	  ,sum(TOT.[kolichestvo])[kolichestvo]
--into L1.dbo.DOGOVOR_SERIY
FROM [L0].[dbo].[zakaz_klienta] ZK
LEFT JOIN [L0].[dbo].[tab_tovary_po_rasporyazheniyam_raskhodnyyordernatovary] TPR
	ON ZK.ssylka=TPR.rasporyazhenie
LEFT JOIN [L0].[dbo].[tab_otgruzhaemye_tovary_raskhodnyyordernatovary]TOT 
	ON TPR.ssylka=TOT.ssylka AND TPR.nomenklatura=TOT.nomenklatura
LEFT JOIN L1.DBO.DOGOVORY_KONTRAGENTOV DK 
	ON ZK.dogovor=DK.GUID
	group by [dogovor]
	  ,TOT.[nomenklatura]
	  ,TOT.seriya
	  ,tpr.nomenklatura