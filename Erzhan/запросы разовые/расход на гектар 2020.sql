/****  ****/

WITH CATO_CUSTOMER AS(
SELECT DISTINCT

	  C.cato_Id AS CATO
	  ,C.name AS CATO_OBL
      ,[applicantIn]
      ,[applicantCatoCode]
  FROM [AA_DWH_X].[dbo].[subsidies_03] AS S
LEFT JOIN L1_X.DBO.cato AS C 
	ON LEFT(S.applicantCatoCode,2)+'0000000'=C.cato_Id
  )

,ESF_PRICE AS(
SELECT 
	  CATO
      ,[productCode]
	  ,CATO_OBL
      ,SUM([PriceWithTax])/SUM([Quantity])UNIT_PRICE
FROM [AA_DWH_X].[dbo].[esf]
LEFT JOIN CATO_CUSTOMER AS CC
	ON ESF.CustomerIIN=CC.applicantIn
WHERE 1=1
	AND CATO IS NOT NULL 
	AND productCode!=0

GROUP BY CATO
,CATO_OBL
,[productCode]
)

,PRODUCT_QUANTITI AS(

SELECT 
flNameCode
      ,SUM(SD.[quantityFact])[quantityFact]
	  ,S.productCode
	  ,CC.CATO
	  ,CC.CATO_OBL
	  ,s.[group]
  FROM [AA_DWH_X].[dbo].[subsidiesDetails] SD
LEFT JOIN CATO_CUSTOMER CC 
	ON SD.applicantIn=CC.applicantIn
LEFT JOIN AA_DWH_X.DBO.subsidies_03 S
	ON SD.appCode=S.appCode
WHERE 1=1
	AND CATO IS NOT NULL 
	AND status IN ('Заявка оплачена','Сформирован платеж','Не оплачена казначейством')
	GROUP BY flNameCode
	  ,s.[group]
	  ,CC.CATO
	  ,CC.CATO_OBL
	  ,S.productCode
	--ORDER BY CC.CATO,S.productCode
)


,SUMMA_RASXOD AS (
SELECT 
	PQ.CATO
	,PQ.flNameCode
	,SUM(PQ.quantityFact*EP.UNIT_PRICE) RASXOD
FROM PRODUCT_QUANTITI AS PQ 
LEFT JOIN ESF_PRICE AS EP 
	ON PQ.CATO=EP.CATO
	AND PQ.productCode=EP.productCode
WHERE PQ.[group] NOT IN ('Удобрения','Семена')
GROUP BY PQ.CATO
	,PQ.flNameCode
--ORDER BY PQ.flNameCode,PQ.productCode,PQ.CATO
)


, MAX_AREA AS(
SELECT
   CC.CATO_OBL
  ,CC.CATO
  ,SD.[flName]
  ,SD.[flNameCode]
  ,MAX(SD.[flAreaUsing]) AS Max_flAreaUsing
  ,SD.cadNumField
FROM [AA_DWH_X].[dbo].[subsidiesDetails] SD
  LEFT JOIN AA_DWH_X.dbo.subsidies_03 SUB
    ON SUB.appCode = SD.appCode
  LEFT JOIN CATO_CUSTOMER CC
    ON CC.applicantIn = SD.applicantIn
WHERE 1=1
  AND CC.CATO_OBL IS NOT NULL
GROUP BY 
   SD.cadNumField
  ,SD.flName
  ,SD.flNameCode
  ,CC.CATO
  ,CC.CATO_OBL
--ORDER BY 
--   SD.[cadNumField]
)
SELECT 
DISTINCT

   MA.CATO_OBL AS Область
  ,MA.flName AS Культура
  ,CAST(SUM(MA.Max_flAreaUsing) OVER (PARTITION BY MA.CATO_OBL,MA.CATO,MA.flName,MA.flNameCode) AS NUMERIC(16,2))AS Площадь
  ,CAST(ROUND(RASXOD,2)AS NUMERIC(16,2)) AS Сумма
  ,CAST(ROUND(RASXOD / SUM(MA.Max_flAreaUsing) OVER (PARTITION BY MA.CATO_OBL,MA.CATO,MA.flName,MA.flNameCode),2) AS NUMERIC(16,2)) AS РАСХОД_НА_ГЕКТАР
FROM MAX_AREA AS MA
LEFT JOIN SUMMA_RASXOD AS SR
	ON MA.CATO=SR.CATO
	AND MA.flNameCode=SR.flNameCode


