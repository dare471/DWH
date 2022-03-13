WITH [subsidies_03] ([provider]
     ,product,[usageArea]
     ,rn
     ,cato) 
  AS(SELECT * FROM(SELECT
    case when s.[providerIn]='150140002752' then s.[provider] else 'otherProvider' end [provider]
   ,product
   ,SUM([usageArea]) AS [usageArea]
   ,ROW_NUMBER () over (partition by case when [providerIn]='150140002752' then [provider] else 'otherProvider' end,[lvl1] order by SUM([usageArea]) DESC) rn
   ,[lvl1] as cato
   
  FROM [AA_DWH_X].[dbo].[subsidies_03] s
  left join [AA_DWH_X].[dbo].[subsidiesDetails] sd on s.appCode=sd.appCode
  left join [AA_DWH_X].[dbo].[cato] c on s.[applicantCatoCode]=c.cato_Id
    group by case when s.[providerIn]='150140002752' then s.[provider] else 'otherProvider' end
    ,product
    ,[lvl1]
    )XZ WHERE rn IN (1,2,3)
  ) , 
  [subsidies_032]([provider],[usageArea],[COUNT_CLIENT],cato)AS(
		SELECT 
			case when [providerIn]='150140002752' then [provider] else  'otherProvider' end [provider]
			,SUM([usageArea]) AS [usageArea]
			,COUNT(S.[applicantIn]) as [COUNT_CLIENT]
		   ,'110000000' as cato
		FROM [AA_DWH_X].[dbo].[subsidies_03] s
		left join [AA_DWH_X].[dbo].[subsidiesDetails] sd on s.appCode=sd.appCode
			where [applicantCatoCode] like '11%'
			group by case when [providerIn]='150140002752' then [provider] else  'otherProvider' end
		),

 culturArea AS (
    SELECT S3.[provider]
      ,isnull(S3.cato,0) cato
	  ,S2.usageArea
	  ,S2.[COUNT_CLIENT]
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=1 THEN product
      WHEN S3.[provider]!='ALEM AGRO' AND rn=1 THEN product
      END PRODUCT_1_NAME
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=1 THEN s3.[usageArea]
      WHEN S3.[provider]!='ALEM AGRO' AND rn=1 THEN s3.[usageArea]
      END PRODUCT_1_Area
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=2 THEN product
      WHEN S3.[provider]!='ALEM AGRO' AND rn=2 THEN product
      END PRODUCT_2_NAME
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=2 THEN s3.[usageArea]
      WHEN S3.[provider]!='ALEM AGRO' AND rn=2 THEN s3.[usageArea]
      END PRODUCT_2_Area
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=3 THEN product
      WHEN S3.[provider]!='ALEM AGRO' AND rn=3 THEN product
      END PRODUCT_3_NAME
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=3 THEN s3.[usageArea]
      WHEN S3.[provider]!='ALEM AGRO' AND rn=3 THEN s3.[usageArea]
      END PRODUCT_3_Area
    FROM [subsidies_03] S3
	LEFT JOIN [subsidies_032] AS S2 ON S3.provider=S2.provider
    
    ) 


select c.provider
   ,c.usageArea
   ,c.COUNT_CLIENT
   ,isnull(cc.cato_Id,0)cato_Id
   ,PRODUCT_1_NAME
   ,c.PRODUCT_1_Area
   ,c2.PRODUCT_2_NAME
   ,c2.PRODUCT_2_Area
  ,c3.PRODUCT_3_NAME
  ,c3.PRODUCT_3_Area
  ,CAST(GETDATE() AS DATE) AS A_DATE
  --into L1.dbo.TOP_PROD_CRM
from culturArea c

left join (select c.provider,c.cato
  ,isnull(c.PRODUCT_1_NAME,isnull(c.PRODUCT_2_NAME,c.PRODUCT_3_NAME))PRODUCT_2_NAME,sum(c.PRODUCT_2_Area)PRODUCT_2_Area
  from culturArea c
  where PRODUCT_2_NAME is not null
  group by c.cato,c.provider,c.PRODUCT_1_NAME,c.PRODUCT_2_NAME
  ,c.PRODUCT_3_NAME)c2 on c.provider=c2.provider and c.cato=c2.cato

left join (select c.provider,c.cato
  ,isnull(c.PRODUCT_1_NAME,isnull(c.PRODUCT_2_NAME,c.PRODUCT_3_NAME))PRODUCT_3_NAME,sum(c.PRODUCT_3_Area)PRODUCT_3_Area
  from culturArea c
  where PRODUCT_3_NAME is not null
  group by c.provider,c.cato,c.PRODUCT_1_NAME,c.PRODUCT_2_NAME
  ,c.PRODUCT_3_NAME)c3 on c.provider=c3.provider and c.cato=c3.cato

left join [AA_DWH_X].[dbo].[cato] cc on c.cato =cc.lvl1

where PRODUCT_1_NAME is not null
  and (cc.lvl2 = 00 OR c.cato = 0)
group by c.provider,c.cato
  ,cc.cato_Id
  ,c.PRODUCT_1_NAME
  ,c.PRODUCT_1_Area
  ,c2.PRODUCT_2_NAME
  ,c2.PRODUCT_2_Area
  ,c3.PRODUCT_3_NAME
  ,c3.PRODUCT_3_Area
  ,c.cato
  ,c.usageArea
  ,c.COUNT_CLIENT
  ORDER BY cato_Id




  CREATE TABLE [L1].[DBO].[TOP_PROD_CRM](
	[PROVIDER] [NVARCHAR](250) NULL,
	[USAGEAREA] [NUMERIC](38, 4) NULL,
	[COUNT_CLIENT] [INT] NULL,
	[CATO_ID] [VARCHAR](50) NOT NULL,
	[PRODUCT_1_NAME] [NVARCHAR](345) NULL,
	[PRODUCT_1_AREA] [NUMERIC](38, 4) NULL,
	[PRODUCT_2_NAME] [NVARCHAR](345) NULL,
	[PRODUCT_2_AREA] [NUMERIC](38, 4) NULL,
	[PRODUCT_3_NAME] [NVARCHAR](345) NULL,
	[PRODUCT_3_AREA] [NUMERIC](38, 4) NULL,
	[A_DATE] [DATE] NULL
)