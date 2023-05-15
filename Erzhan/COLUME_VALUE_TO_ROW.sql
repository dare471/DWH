WITH KOD AS (SELECT [NAME]
   ,CARG.ID
   ,CAOG.[KATO]
      ,[POPULATION_AREA]
      ,[POPULATION_CITY]
      ,[POPULATION_VILLAGE]
      ,CAOG.[GEOMETRY_RINGS]
      ,CAOG.[KLKOD]
 FROM [CRM_DWH].[dbo].[CRM_AISGZK_OBLAST_GEO] AS CAOG
  LEFT JOIN [CRM_DWH].[dbo].[CRM_AISGZK_RAION_GEO] AS CARG 
	ON CAOG.[KLKOD]=LEFT(CARG.KLKOD,2)
 )

 select K2.[NAME], 
        (select stuff([list],1,1,'') as stuff_list
		from (SELECT ',' + cast(ID as varchar(255)) as [text()]
				FROM KOD K
				WHERE K.[NAME]=K2.[NAME]
				for xml path('')
			 ) sub_query([list]) 
			 ) as RAION_list

   ,K2.[KATO]
      ,[POPULATION_AREA]
      ,[POPULATION_CITY]
      ,[POPULATION_VILLAGE]
      ,K2.[GEOMETRY_RINGS]
      ,K2.[KLKOD]
from  KOD K2
group by [NAME]   
		,K2.[KATO]
      ,[POPULATION_AREA]
      ,[POPULATION_CITY]
      ,[POPULATION_VILLAGE]
      ,K2.[GEOMETRY_RINGS]
      ,K2.[KLKOD]
order by [NAME]