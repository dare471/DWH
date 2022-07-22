WITH KADR AS(

SELECT DISTINCT
      KIS.[fizicheskoe_litso]
	  ,CASE WHEN KIS.[period]=MAX(KIS.[period]) OVER (PARTITION BY [fizicheskoe_litso]) THEN MAX(SP.ssylka)OVER(PARTITION BY [fizicheskoe_litso]) END AS STRUKTURA_GUID
	  ,CASE WHEN KIS.[period]=MAX(KIS.[period]) OVER (PARTITION BY [fizicheskoe_litso]) THEN D.ssylka END AS DOLZHNOST
FROM [L0].[dbo].[kadrovaya_istoriya_sotrudnikov] KIS 
LEFT JOIN [L0].[dbo].dolzhnosti D
	ON KIS.dolzhnost=D.ssylka

  left join [L0].dbo.[shtatnoe_raspisanie] shr on kis.dolzhnost_po_shtatnomu_raspisaniyu=shr.ssylka
  left join [L0].dbo.[mesto_pozitsii_shtatnogo_raspisaniya_v_strukture_predpriyatiya] mes on shr.ssylka=mes.[pozitsiya]
  left join [L0].[dbo].[struktura_predpriyatiya] sp  on sp.ssylka=mes.[podrazdelenie]
  --WHERE DOLZHNOST IS NOT NULL
)


SELECT P.[ssylka] as [GUID]
      ,P.[naimenovanie] as [NAIMENOVANIE]
      --,[podrazdelenie] as [podrazdelenie_guid]
      ,P.[fizicheskoe_litso] as [FIZICHESKOE_LITSO_GUID]
	  ,ISNULL(K.STRUKTURA_GUID,0) AS STRUKTURA_PREDPRIYATIYA_GUID
	  ,ISNULL(K.DOLZHNOST,0) AS DOLZHNOST_GUID
	  ,'erp' as [SOURCE_BASE]
--INTO L1.DBO.MENEDZHERY
  FROM [L0].[dbo].[polzovateli] AS P
LEFT JOIN KADR AS K 
	ON P.fizicheskoe_litso=K.fizicheskoe_litso AND DOLZHNOST IS NOT NULL
--WHERE K.DOLZHNOST LIKE '%Технический консультант%'
ORDER BY P.[naimenovanie],P.[ssylka] 