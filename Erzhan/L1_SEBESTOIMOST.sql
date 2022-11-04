/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT DISTINCT DATEADD(YEAR,-2000,ST.[period]) AS [period]
      ,ST.[synonym_registrator]
	  ,DK.ssylka AS DOGOVOR_GUID
	  ,N.naimenovanie
	  ,N.ssylka NOMENKLATURA_GUID
      ,ST.[organizatsiya] AS ORGANIZATSIYA_GUID
      ,SUM(ST.[kolichestvo]) AS KOLICHESTVO
      ,SUM([stoimost]) AS SUMMA
      ,SUM([stoimost_bez_n_d_s]) AS SUMMA_NDS
      ,SUM([stoimost_zabalansovaya]) AS SUMMA_ZABALANSOVAYA
      ,SUM([dop_raskhody]) AS DOP_RASKHODY
      ,SUM([dop_raskhody_bez_n_d_s]) AS DOP_RASKHODY_NDS
      ,SUM([trudozatraty]) AS TRUDOZATRATY
      ,SUM([stoimost_regl]) AS STOIMOST_REGL
--INTO [L1].[dbo].[SEBESTOIMOST_TOVAROV] 
  FROM [L0].[dbo].[sebestoimost_tovarov] ST
  LEFT JOIN L0.DBO.klyuchi_analitiki_ucheta_nomenklatury KAUN
	ON ST.analitika_ucheta_nomenklatury=KAUN.ssylka
LEFT JOIN L0.DBO.nomenklatura N 
	ON KAUN.nomenklatura=N.ssylka
LEFT JOIN [L0].[dbo].[klyuchi_analitiki_ucheta_po_partneram] PKAU
	ON ST.analitika_ucheta_po_partneram=PKAU.ssylka
LEFT JOIN L0.DBO.dogovory_kontragentov DK
	ON PKAU.dogovor=DK.ssylka
LEFT JOIN L0.DBO.spetsifikatsiya_po_dogovoru SPD
	ON DK.ssylka=SPD.dogovor 
	AND N.ssylka=SPD.nomenklatura
  WHERE 1=1
  AND ST.[kolichestvo] > 0
  AND ST.synonym_registrator='Возврат товаров поставщику'
  --AND DK.ssylka=0xA23A7085C2A4312A11EB78C6A8DD1A49
  --AND analitika_ucheta_po_partneram=0x811F000C29EF79CA11E934DC54139880
  GROUP BY DATEADD(YEAR,-2000,ST.[period])
      ,ST.[synonym_registrator]
	  ,DK.ssylka 
	  ,N.naimenovanie
	  ,N.ssylka 
	  ,ST.[organizatsiya]
  ORDER BY DK.ssylka