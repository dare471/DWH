WITH KADR AS(

SELECT DISTINCT
  KIS.[fizicheskoe_litso]
 ,CASE 
    WHEN KIS.[period] = MAX(KIS.[period]) OVER (PARTITION BY [fizicheskoe_litso]) 
      THEN MAX(SP.ssylka)OVER(PARTITION BY [fizicheskoe_litso]) 
     END AS STRUKTURA_GUID
 ,CASE 
    WHEN KIS.[period] = MAX(KIS.[period]) OVER (PARTITION BY [fizicheskoe_litso]) 
      THEN D.ssylka 
     END AS DOLZHNOST
FROM [L0].[dbo].[kadrovaya_istoriya_sotrudnikov] KIS 
  LEFT JOIN [L0].[dbo].dolzhnosti D
    ON KIS.dolzhnost = D.ssylka
  LEFT JOIN [L0].dbo.[shtatnoe_raspisanie] shr 
    ON kis.dolzhnost_po_shtatnomu_raspisaniyu=shr.ssylka
  LEFT JOIN [L0].dbo.[mesto_pozitsii_shtatnogo_raspisaniya_v_strukture_predpriyatiya] mes 
    ON shr.ssylka=mes.[pozitsiya]
  LEFT JOIN [L0].[dbo].[struktura_predpriyatiya] sp  
    ON sp.ssylka=mes.[podrazdelenie]
  --WHERE DOLZHNOST IS NOT NULL
)
SELECT 
  P.[ssylka] as [GUID]
 ,P.[naimenovanie] as [NAIMENOVANIE]
 --,[podrazdelenie] as [podrazdelenie_guid]
 ,P.[fizicheskoe_litso] as [FIZICHESKOE_LITSO_GUID]
 ,ISNULL(K.STRUKTURA_GUID,0) AS STRUKTURA_PREDPRIYATIYA_GUID
 ,ISNULL(K.DOLZHNOST,0) AS DOLZHNOST_GUID
 ,P.identifikator_telegram AS TELEGRAM_ID
 ,KIFL_POCHTA.predstavlenie AS ADRES_E_P
 ,'erp' as [SOURCE_BASE]
--INTO L1.DBO.MENEDZHERY
FROM [L0].[dbo].[polzovateli] AS P
  LEFT JOIN KADR AS K 
    ON P.fizicheskoe_litso=K.fizicheskoe_litso 
      AND DOLZHNOST IS NOT NULL
  LEFT JOIN [L0].[dbo].[tab_kontaktnaya_informatsiya_polzovateli] KIFL_POCHTA 
    ON KIFL_POCHTA.ssylka = P.ssylka
   AND KIFL_POCHTA.tip = 0x82E6D573EE35D0904BF4D326A84A91D2
--WHERE P.[naimenovanie] LIKE '%вороб%'
ORDER BY P.[naimenovanie],P.[ssylka]