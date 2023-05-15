WITH KADR AS(


SELECT [period] AS [PERIOD] /*** СТРУКТУРА ПРЕДПРИЯТИЯНЫ  ШЫҒАРЫП АЛУ ҮШІН ****/
         ,[fizicheskoe_litso] AS [FIZICHESKOE_LITSO_GUID]
         ,sp.ssilka AS [STRUKTURA_PREDPRIYATIYA_GUID]
		 ,kis.dolzhnost AS [DOLZHNOST_GUID]
  FROM [L0].[dbo].[kadrovaya_istoriya_sotrudnikov]kis
  left join [L0].dbo.[shtatnoe_raspisanie] shr 
ON kis.dolzhnost_po_shtatnomu_raspisaniyu=shr.ssylka
  left join [L0].dbo.[mesto_pozitsii_shtatnogo_raspisaniya_v_strukture_predpriyatiya] mes 
ON shr.ssylka=mes.[pozitsiya]
  left join [L0].[dbo].[struktura_predpriyatiya] sp 
ON sp.ssilka=mes.[podrazdelenie]
WHERE KIS.[period]=(
		SELECT MAX(KIS2.[period])
		FROM [L0].[dbo].[kadrovaya_istoriya_sotrudnikov]KIS2
  WHERE KIS2.fizicheskoe_litso=KIS.fizicheskoe_litso
  )
 AND organizatsiya=0x80DE000C29E67B2E11E636A5C3C5D8AE

)
SELECT DISTINCT
  P.[ssylka] as [GUID]
 ,P.[naimenovanie] as [NAIMENOVANIE]
 --,[podrazdelenie] as [podrazdelenie_guid]
 ,P.[fizicheskoe_litso] as [FIZICHESKOE_LITSO_GUID]
 ,CASE WHEN P.[ssylka]=0x92B70025907801D211E3672CA6AC4140 THEN 0xA21F7085C2A4312A11E9F3E8C74A132D 
		WHEN P.[ssylka]=0xA22C7085C2A4312A11EAA0AAA1D378E7 THEN 0xA21F7085C2A4312A11E9F3E8CFC3F143
 ELSE ISNULL(K.[STRUKTURA_PREDPRIYATIYA_GUID],0) END AS STRUKTURA_PREDPRIYATIYA_GUID
 ,ISNULL(K.[DOLZHNOST_GUID],0) AS DOLZHNOST_GUID
 ,P.identifikator_telegram AS TELEGRAM_ID
 ,KIFL_POCHTA.predstavlenie AS ADRES_E_P
 ,'erp' as [SOURCE_BASE]
--INTO L1.DBO.MENEDZHERY
FROM [L0].[dbo].[polzovateli] AS P
  LEFT JOIN KADR AS K 
    ON P.fizicheskoe_litso=K.[FIZICHESKOE_LITSO_GUID] 
      AND [DOLZHNOST_GUID] IS NOT NULL
  LEFT JOIN [L0].[dbo].[tab_kontaktnaya_informatsiya_polzovateli] KIFL_POCHTA 
    ON KIFL_POCHTA.ssylka = P.ssylka
   AND KIFL_POCHTA.tip = 0x82E6D573EE35D0904BF4D326A84A91D2
--WHERE P.[naimenovanie] LIKE '%Абдыкадыров Амангельды%'
ORDER BY P.[naimenovanie],P.[ssylka]

