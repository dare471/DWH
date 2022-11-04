WITH OBL AS (
SELECT AO.[ID]
      --,[TEXT] + ' ' + [VNAIM] AS NAME_OBL
      ,[KLKOD]
      ,AO.[KATO] AS [KATO_OBL]
	  ,AOG.GEOMETRY_RINGS AS GEOMETRY_RINGS_OBL
  FROM [L0_X].[dbo].[AISGZK_OBLAST] AS AO
  LEFT JOIN [L0_X].[dbo].[AISGZK_OBLAST_GEO] AOG
	ON CASE WHEN AO.[KATO]='750000000' THEN '190000000'
			WHEN AO.[KATO]='710000000' THEN '110000000'
			WHEN AO.[KATO]='790000000' THEN '510000000'
			WHEN AO.[KATO]='610000000' THEN '510000000'
		else AO.[KATO] 
		end = AOG.[KATO]
),
RAION AS (
SELECT [ID]
      --,[TEXT] AS NAME_RAION
      ,REPLACE([KLKOD],'|','')[KLKOD]
      --,[VNAIM]
      --,[NAIMPRE]
      ,[KATO] AS [KATO_RAION]
      --,[TYPE]
      --,[ICONCCLS]
      --,[EXPANDED]
      --,[LEAF]
      ,[OBL_KLKOD]
      --,[LAYERS_ID]
	  ,ARG.geometry_rings AS GEOMETRY_RINGS_RAION
	  --,ARG.[spatialReference.latestWkid]
	  --,ARG.[spatialReference.wkid]
  FROM [L0_X].[dbo].[AISGZK_RAION] AS AR
LEFT JOIN [L0_X].[dbo].AISGZK_RAION_GEO AS ARG
	ON REPLACE([KLKOD],'|','')=ARG.RAION_KLKOD
)


SELECT top(30)
	  GEOMETRY_RINGS_OBL
	  ,CO.name AS OBL
	  ,ARG.GEOMETRY_RINGS_RAION
      ,CR.name AS RAION
	  ,[value] AS KADASTR
	  --,LEFT(AKP.value,5)
      ,isnull([attributes_Shape_Length],[attributes_SHAPE_Length_UP]) as [attributes_Shape_Length]
      ,isnull([attributes_Shape_Area],[attributes_SHAPE_Area_UP]) as [attributes_Shape_Area]
      ,AKP.[geometry_rings] AS GEOMETRY_RINGS_KADASTR
      ,[geometry_spatialReference_wkid]
      ,[geometry_spatialReference_latestWkid]
	  ,AKBI.bin AS IIN_BIN
	  ,AKBI.nameLast+' '+AKBI.nameFirst+' '+AKBI.nameMiddle AS FIO
	  ,AKBI.srok
	  
  FROM [L0_X].[dbo].[AISGZK_KADASTR_POLYGON] AS AKP
LEFT JOIN RAION AS ARG
	ON LEFT(AKP.value,5)=ARG.[KLKOD]
LEFT JOIN OBL 
	ON OBL.KLKOD=ARG.[OBL_KLKOD]
LEFT JOIN L1_X.dbo.CATO AS CO
	ON CO.cato_Id=OBL.KATO_OBL
LEFT JOIN L1_X.dbo.CATO AS CR 
	ON CR.cato_Id=ARG.KATO_RAION
LEFT JOIN [L0_X].[dbo].AISGZK_KADASTR_BIN_INFORMATSYA_2 AS AKBI
	ON AKBI.kadastr=AKP.value
LEFT JOIN [L0_X].[dbo].
WHERE 1=1
--AND [value]='01278012100'