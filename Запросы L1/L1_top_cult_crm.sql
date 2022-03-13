WITH [subsidies_03] ([provider]
     ,flName,[usageArea]
     ,rn
     ,cato) 
  AS(SELECT * FROM(SELECT
    case when s.[providerIn]='150140002752' then s.[provider] else 'otherProvider' end [provider]
   ,flName
   ,SUM([usageArea]) AS [usageArea]
   ,ROW_NUMBER () over (partition by case when [providerIn]='150140002752' then [provider] else 'otherProvider' end,[lvl1] order by SUM([usageArea]) DESC) rn
   ,[lvl1] as cato
   
  FROM [AA_DWH_X].[dbo].[subsidies_03] s
  left join [AA_DWH_X].[dbo].[subsidiesDetails] sd on s.appCode=sd.appCode
  left join [AA_DWH_X].[dbo].[cato] c on s.[applicantCatoCode]=c.cato_Id
    group by case when s.[providerIn]='150140002752' then s.[provider] else 'otherProvider' end
    ,flName
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
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=1 THEN flName
      WHEN S3.[provider]!='ALEM AGRO' AND rn=1 THEN flName
      END CULT1_NAME
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=1 THEN s3.[usageArea]
      WHEN S3.[provider]!='ALEM AGRO' AND rn=1 THEN s3.[usageArea]
      END CULT1_Area
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=2 THEN flName
      WHEN S3.[provider]!='ALEM AGRO' AND rn=2 THEN flName
      END CULT2_NAME
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=2 THEN s3.[usageArea]
      WHEN S3.[provider]!='ALEM AGRO' AND rn=2 THEN s3.[usageArea]
      END CULT2_Area
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=3 THEN flName
      WHEN S3.[provider]!='ALEM AGRO' AND rn=3 THEN flName
      END CULT3_NAME
      ,CASE WHEN S3.[provider]='ALEM AGRO' AND rn=3 THEN s3.[usageArea]
      WHEN S3.[provider]!='ALEM AGRO' AND rn=3 THEN s3.[usageArea]
      END CULT3_Area
    FROM [subsidies_03] S3
	LEFT JOIN [subsidies_032] AS S2 ON S3.provider=S2.provider
    
    ) 


select c.provider
   ,c.cato
   ,c.usageArea
   ,c.COUNT_CLIENT
   ,cc.cato_Id
   ,CULT1_NAME
   ,sum(c.CULT1_Area) AS CULT1_Area
      ,c2.CULT2_NAME
   ,sum(c2.CULT2_Area) AS CULT2_Area
  ,c3.CULT3_NAME
  ,sum(c3.CULT3_Area) AS CULT3_Area
  ,CAST(GETDATE() AS DATE) AS A_DATE
  --into L1.dbo.TOP_CULT_CRM
from culturArea c

left join (select c.provider,c.cato
  ,isnull(c.CULT1_NAME,isnull(c.CULT2_NAME,c.CULT3_NAME))CULT2_NAME,sum(c.CULT2_Area)CULT2_Area
  from culturArea c
  where CULT2_NAME is not null
  group by c.cato,c.provider,c.CULT1_NAME,c.CULT2_NAME
  ,c.CULT3_NAME)c2 on c.provider=c2.provider and c.cato=c2.cato

left join (select c.provider,c.cato
  ,isnull(c.CULT1_NAME,isnull(c.CULT2_NAME,c.CULT3_NAME))CULT3_NAME,sum(c.CULT3_Area)CULT3_Area
  from culturArea c
  where CULT3_NAME is not null
  group by c.provider,c.cato,c.CULT1_NAME,c.CULT2_NAME
  ,c.CULT3_NAME)c3 on c.provider=c3.provider and c.cato=c3.cato

left join [AA_DWH_X].[dbo].[cato] cc on c.cato =cc.lvl1

where CULT1_NAME is not null
  and (cc.lvl2 = 00 OR c.cato = 0)
group by c.provider,c.cato
  ,cc.cato_Id
  ,c.CULT1_NAME
  ,c2.CULT2_NAME
  ,c2.CULT2_Area
  ,c3.CULT3_NAME
  ,c3.CULT3_Area
  ,c.cato
  ,c.usageArea
  ,c.COUNT_CLIENT