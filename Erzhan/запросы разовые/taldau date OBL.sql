WITH CROP_ID_DISTINCT AS(
						SELECT 
							MAX([crop_ID]) AS [crop_ID]
							,[crop]
						FROM [L0_X].[dbo].[TALDAU_OBLAST]
						GROUP BY [crop]
					)

,ALL_DATA AS(
SELECT DISTINCT
	[location_ID]
      ,[all_ID]
      ,[categories_ID]
      --,CID.[crop_ID]
      ,[location]
      ,[all]
      ,[categories]
	  ,CASE WHEN CID.[crop]='Культуры масличные' THEN 'Культуры масличные'
			WHEN CID.[crop] IN ('Пшеница','Кукуруза (маис)','Ячмень, рожь и овес','Сорго (джугара), просо и культуры зерновые прочие') THEN 'Культуры зерновые'
			ELSE 'Другие культуры'
		END AS [crop]
	  --,CID.[crop]
      ,[name] AS [YEAR]
      ,[date]
	  ,SUM(CONVERT(NUMERIC(20,2),[value],1))/10000 AS [value]
	  --,SUM(CONVERT(NUMERIC(20,2),[value],1)) OVER (PARTITION BY CASE WHEN CROP='Культуры сезонные')
      --,SUM(CONVERT(NUMERIC(20,2),[value],1))/1000 AS [value]
  FROM CROP_ID_DISTINCT AS CID
  LEFT JOIN [L0_X].[dbo].[TALDAU_OBLAST] AS [TO]
  ON CID.[crop_ID]=[TO].[crop_ID]
  WHERE [all_ID]=808497
  AND [categories_ID]=450122
  AND CID.[crop] IN ('Рис, необрушенный','Овощи и бахчевые, корнеплоды и клубнеплоды','Табак необработанный','Культуры волокнистые прядильные','Культуры сезонные прочие',
  'Пшеница','Кукуруза (маис)','Ячмень, рожь и овес','Сорго (джугара), просо и культуры зерновые прочие','Овощи бобовые зеленые (свежие)','Овощи бобовые сушеные'
  ,'Культуры масличные') 

  GROUP BY [location_ID]
      ,[all_ID]
      ,[categories_ID]
      --,CID.[crop_ID]
      ,[location]
      ,[all]
      ,[categories]
	  ,CASE WHEN CID.[crop]='Культуры масличные' THEN 'Культуры масличные'
			WHEN CID.[crop] IN ('Пшеница','Кукуруза (маис)','Ячмень, рожь и овес','Сорго (джугара), просо и культуры зерновые прочие') THEN 'Культуры зерновые'
			ELSE 'Другие культуры'
		END 
      --,CID.[crop]
	  ,[name]
      ,[date]

  --ORDER BY [location_ID],[name]--,[crop_ID],[crop],[all_ID]
  )


  SELECT 
	--[location_ID]
 --     ,[all_ID]
 --     ,[categories_ID]
      --,CID.[crop_ID]
      [location]
      --,[all]
      --,[categories]
	  ,[YEAR]
      ,[date]
	  ,[Другие культуры]
	  ,[Культуры зерновые]
	  ,[Культуры масличные]
	  --,[crop]
	  --,[value] 
	  --,CASE WHEN [crop]='Другие культуры' THEN [value] END AS'Другие культуры' 
	  --,CASE WHEN [crop]='Культуры зерновые' THEN [value] END AS 'Культуры зерновые'
	  --,CASE WHEN [crop]='Культуры масличные' THEN [value] END AS 'Культуры масличные' 
  FROM ALL_DATA
  PIVOT (SUM([value]) FOR [crop] IN 
	  ([Другие культуры]
	  ,[Культуры зерновые]
	  ,[Культуры масличные])) AS P