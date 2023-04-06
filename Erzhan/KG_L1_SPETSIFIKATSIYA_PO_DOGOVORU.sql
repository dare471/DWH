WITH SrezPoslednikh AS (
SELECT 

A.dogovor
,A.nomenklatura
,A.nomer_stroki_t_ch
,A.srok_postavki
,MAX(period) AS period
 FROM [L0_kg].[dbo].[spetsifikatsiya_po_dogovoru] A
 GROUP BY 
A.dogovor
,A.nomenklatura
,A.nomer_stroki_t_ch
,A.srok_postavki
)




SELECT SP.[dogovor] AS [DOGOVOR_GUID]
      ,DATEADD(YEAR,-2000,SP.[period]) AS [PERIOD]
      ,SP.[nomenklatura] AS [NOMENKLATURA_GUID]
	  ,VKN.naimenovanie AS [VIDY_KULTUR]
	  ,SPD.kolichestvo AS [KOLICHESTVO]
	  ,cast(spd.summa / spd.kolichestvo as numeric(10,2)) as [TSENA]
	  ,SPD.summa AS [SUMMA]
      ,CAST(0 AS NUMERIC(15,2)) AS [TSENA_SO_SKIDKOY]
      ,[TSENA_PO_PRAYS_LISTU] AS [TSENA_PO_PRAYS_LISTU]
	  ,CAST(0 AS NUMERIC(15,2)) AS [TSENA_MIN]
      ,CAST(0 AS NUMERIC(15,2)) AS[SUMMA_SO_SKIDKOY]
      ,DATEADD(YEAR,-2000,SP.[srok_postavki]) AS [DATA_OTGRUZKI]
	  ,DK.sklad AS [SKLAD_OTGRUZKI_GUID]
	  ,'' AS [SKLAD_OTGRUZKI]
--INTO [L1].[dbo].[KG_SPETSIFIKATSIYA_PO_DOGOVORU]
  FROM SrezPoslednikh AS SP
LEFT JOIN [L0_kg].[dbo].[spetsifikatsiya_po_dogovoru] SPD
	ON SP.dogovor=SPD.dogovor
	AND SP.nomenklatura=SPD.nomenklatura
	AND SP.period=SPD.period
	AND SP.nomer_stroki_t_ch=SPD.nomer_stroki_t_ch
	AND SP.srok_postavki=SPD.srok_postavki
LEFT JOIN [L0].[dbo].vidy_kultur_nomenklatury vkn on spd.vidy_kultury=vkn.ssylka
LEFT JOIN L0_kg.dbo.dogovory_kontragentov AS DK
	ON SP.dogovor=DK.ssylka
WHERE 1=1
AND kolichestvo<>0