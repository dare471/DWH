
WITH SALDO_1 AS(/**все данные по салдо на начало периюда**/

SELECT --TOP (1000) [SOURCE_DATABASE]
      CAST([PERIOD] AS DATE) AS[PERIOD] 
      --,[SCHET_DT]
      --,[SCHET_KT]
      ,[ORGANIZACIYA]
	  ,O.NAIMENOVANIE
	  ,[tip_scheta]
	  ,CASE WHEN BSO.naimenovanie IN ('6373, ТОО «Alem Agro Holding» АО "АТФБанк"','3339 в АО "KASPI BANK" business','5534 в АО "KASPI BANK", ТОО «Alem Agro Holding (Алем Агро Холдинг)»'
	  ,'8748 в АО "АЛЬФА-БАНК", ТОО «Alem Agro Holding (АлемАгро Холдинг)»','Holding  KZ719261802194625000 АО "КАЗКОММЕРЦБАНК" (KZT)','Holding KZ5984901KZ001347915 АО «Нурбанк»'
	  ,'АО "ForteBank"'
	  ,'АО "Народный Банк Казахстана", ТОО «Alem Agro Holding (Алем Агро Холдинг)»'
	  ,'БЦК 5290 Alem Agro Holding (АлемАгро Холдинг) (KZT)'
	  ) 
	  THEN '6087 АО "Евразийский Банк", ТОО «Alem Agro Holding (АлемАгро Холдинг)» (KZT)' ELSE BSO.naimenovanie END AS bankovskie_scheta_organizacii
	  ,SUM(CASE WHEN RBX.SCHET_DT in ('1030','1050') THEN RBX.SUMMA ELSE 0 END) 	AS Дт
	,SUM(CASE WHEN RBX.SCHET_KT in('1030','1050') THEN RBX.SUMMA ELSE 0 END)	AS Кт
      --,SUM([SUMMA])[SUMMA]
  FROM [L1].[dbo].[REGISTR_BUHGALTERII_HOZRASCHETNYI] AS RBX
  LEFT JOIN L1.DBO.ORGANIZATSII O
 ON RBX.ORGANIZACIYA=O.GUID
  LEFT JOIN L0.dbo.bankovskie_scheta_organizacii AS BSO
		ON BSO.ssilka=--RBX.subconto_dt_1_guid
				(CASE
    WHEN RBX.subconto_dt_1_type ='БанковскиеСчетаОрганизаций' THEN subconto_dt_1_guid
    WHEN RBX.subconto_dt_2_type ='БанковскиеСчетаОрганизаций' THEN subconto_dt_2_guid
    WHEN RBX.subconto_dt_3_type ='БанковскиеСчетаОрганизаций' THEN subconto_dt_3_guid
    WHEN RBX.subconto_ct_1_type ='БанковскиеСчетаОрганизаций' THEN subconto_ct_1_guid
    WHEN RBX.subconto_ct_2_type ='БанковскиеСчетаОрганизаций' THEN subconto_ct_2_guid
    WHEN RBX.subconto_ct_3_type ='БанковскиеСчетаОрганизаций' THEN subconto_ct_3_guid
  END)


  WHERE 1=1
  AND (RBX.SCHET_DT IN ('1030','1050') OR RBX.SCHET_KT IN ('1030','1050')) 
  AND O.NAIMENOVANIE= 'ТОО «Alem Agro Holding (АлемАгро Холдинг)»'
  
--AND BSO.naimenovanie='Holding KZ5984901KZ001347915 АО «Нурбанк»'
  GROUP BY CAST([PERIOD] AS DATE) 
  --,[SCHET_DT]
  --    ,[SCHET_KT]
      ,[ORGANIZACIYA]
	  ,CASE WHEN BSO.naimenovanie IN ('6373, ТОО «Alem Agro Holding» АО "АТФБанк"'
									,'3339 в АО "KASPI BANK" business','5534 в АО "KASPI BANK", ТОО «Alem Agro Holding (Алем Агро Холдинг)»'
									,'8748 в АО "АЛЬФА-БАНК", ТОО «Alem Agro Holding (АлемАгро Холдинг)»'
									,'Holding  KZ719261802194625000 АО "КАЗКОММЕРЦБАНК" (KZT)'
									,'Holding KZ5984901KZ001347915 АО «Нурбанк»'
									,'АО "ForteBank"'
									,'АО "Народный Банк Казахстана", ТОО «Alem Agro Holding (Алем Агро Холдинг)»'
									,'БЦК 5290 Alem Agro Holding (АлемАгро Холдинг) (KZT)'
									) 
					THEN '6087 АО "Евразийский Банк", ТОО «Alem Agro Holding (АлемАгро Холдинг)» (KZT)' 
	  ELSE BSO.naimenovanie END
	  ,O.NAIMENOVANIE
	  ,[tip_scheta]
--ORDER BY [PERIOD],O.NAIMENOVANIE
)

--SELECT 
--A.bankovskie_scheta_organizacii
--,A.NAIMENOVANIE
--,A.PERIOD
--,SUM(A.SALDO) AS SALDO


--FROM 
--,ORTASY AS (
SELECT
SALDO_1.ORGANIZACIYA
,SALDO_1.PERIOD
,NAIMENOVANIE
--,SALDO_1.SCHET_DT
--,SALDO_1.SCHET_KT
--,SALDO_1.SUMMA
,SALDO_1.Дт
,SALDO_1.Кт
,bankovskie_scheta_organizacii
,SUM(Дт) OVER(PARTITION BY bankovskie_scheta_organizacii
					ORDER BY bankovskie_scheta_organizacii,[PERIOD]
					ROWS BETWEEN UNBOUNDED PRECEDING
						AND CURRENT ROW) 
-SUM(Кт) OVER(
			PARTITION BY bankovskie_scheta_organizacii
			ORDER BY bankovskie_scheta_organizacii,[PERIOD]
			ROWS BETWEEN UNBOUNDED PRECEDING
						AND CURRENT ROW) AS SALDO

--,SUM(Дт) OVER(PARTITION BY ORGANIZACIYA--,bankovskie_scheta_organizacii
--					ORDER BY PERIOD,ORGANIZACIYA--,bankovskie_scheta_organizacii
--					ROWS BETWEEN UNBOUNDED PRECEDING
--						AND CURRENT ROW)
---SUM(Кт) OVER(
--			PARTITION BY ORGANIZACIYA--,bankovskie_scheta_organizacii
--			ORDER BY PERIOD,ORGANIZACIYA--,bankovskie_scheta_organizacii
--			ROWS BETWEEN UNBOUNDED PRECEDING
--						AND CURRENT ROW) AS SALDO

FROM SALDO_1


WHERE 1=1
--AND NAIMENOVANIE= 'ТОО «Alem Agro Holding (АлемАгро Холдинг)»'
--AND bankovskie_scheta_organizacii='Holding KZ5984901KZ001347915 АО «Нурбанк»'
--) A

----A.bankovskie_scheta_organizacii
--A.NAIMENOVANIE
--,A.PERIOD

ORDER BY 
--PERIOD,
bankovskie_scheta_organizacii
,[PERIOD]
--)








--SELECT 
--SUM(O.SALDO_V2)AS SALDO
--,O.PERIOD
--,O.NAIMENOVANIE
----,CASE WHEN O.bankovskie_scheta_organizacii NOT IN (' залоговый счет Евразийский KZ2394806KZT22230034'
----,'депозит 0134 в АО "Евразийский Банк", ТОО «Alem Agro Holding (АлемАгро Холдинг)»','5534 в АО "KASPI BANK", ТОО «Alem Agro Holding (Алем Агро Холдинг)»'
----,'8748 в АО "АЛЬФА-БАНК", ТОО «Alem Agro Holding (АлемАгро Холдинг)»') THEN 'KEREK_EMSESTER'
----WHEN O.bankovskie_scheta_organizacii='депозит 0182 в АО "Евразийский Банк", ТОО «Alem Agro Holding (АлемАгро Холдинг)»' THEN 'депозит 0182 в АО "Евразийский Банк", ТОО «Alem Agro Holding (АлемАгро Холдинг)»'
----ELSE 'Расчетный' END
--FROM ORTASY AS O 


--GROUP BY 
--O.[PERIOD]
--,O.NAIMENOVANIE
----,CASE WHEN O.bankovskie_scheta_organizacii NOT IN (' залоговый счет Евразийский KZ2394806KZT22230034'
----,'депозит 0134 в АО "Евразийский Банк", ТОО «Alem Agro Holding (АлемАгро Холдинг)»','5534 в АО "KASPI BANK", ТОО «Alem Agro Holding (Алем Агро Холдинг)»'
----,'8748 в АО "АЛЬФА-БАНК", ТОО «Alem Agro Holding (АлемАгро Холдинг)»') THEN 'KEREK_EMSESTER'
----WHEN O.bankovskie_scheta_organizacii='депозит 0182 в АО "Евразийский Банк", ТОО «Alem Agro Holding (АлемАгро Холдинг)»' THEN 'депозит 0182 в АО "Евразийский Банк", ТОО «Alem Agro Holding (АлемАгро Холдинг)»'
----ELSE 'Расчетный' END



--ORDER BY 
--O.[PERIOD]
