
SELECT DISTINCT
	[location_ID]
      ,[all_ID]
      ,[categories_ID]
      --,[crop_ID]
      ,[location]
      ,[all]
      ,[categories]
	  ,[crop]
      ,CASE WHEN [crop]='Культуры сезонные' THEN SUM(CONVERT(NUMERIC(20,2),[value],1)) OVER (PARTITION BY [location],[name],[location_ID],[all_ID],[categories_ID],[date],[crop])/10000 END AS ALL_CROP
	  ,CASE WHEN [crop]='Культуры масличные' THEN SUM(CONVERT(NUMERIC(20,2),[value],1)) OVER (PARTITION BY [location],[name],[location_ID],[all_ID],[categories_ID],[date],[crop])/10000 END AS ALL_CROP
	  ,CASE WHEN [crop] IN ('Пшеница','Кукуруза (маис)','Ячмень, рожь и овес','Сорго (джугара), просо и культуры зерновые прочие') THEN (SUM(CONVERT(NUMERIC(20,2),[value],1)) OVER (PARTITION BY [location],[name],[location_ID],[all_ID],[categories_ID],[date])/10000) END AS ALL_CROP
	  
	  --WHEN [crop]='Культуры масличные' THEN 'Культуры масличные' ELSE 'Зерновые (за исключением риса)' END AS CROP
      ,[name]
      ,[date]
	  --,SUM(CONVERT(NUMERIC(20,2),[value],1)) OVER (PARTITION BY CASE WHEN CROP='Культуры сезонные')
      --,SUM(CONVERT(NUMERIC(20,2),[value],1))/1000 AS [value]
  FROM [L0_X].[dbo].[TALDAU_OBLAST]
  WHERE [all_ID]=808497
  AND [categories_ID]=450122
  AND [crop] IN ('Пшеница','Кукуруза (маис)','Ячмень, рожь и овес','Сорго (джугара), просо и культуры зерновые прочие','Культуры масличные','Культуры сезонные') 
  --OR [crop] ='корнишоны'
  --OR [crop]  IN ('Чили и перцы, зеленые (только рода capsicum)', 'Культуры плодово-овощные прочие','Перцы','Перцы прочие','Овощи')

  --GROUP BY [location_ID]
  --    ,[all_ID]
  --    ,[categories_ID]
  --    --,[crop_ID]
  --    ,[location]
  --    ,[all]
  --    ,[categories]
  -- --   ,CASE 
	 -- --WHEN [crop]='Культуры сезонные' THEN 'Культуры сезонные'
	 -- --WHEN [crop]='Культуры масличные' THEN 'Культуры масличные' ELSE 'Зерновые (за исключением риса)' END 
  --    ,[name]
  --    ,[date]
  ORDER BY [location_ID],[name]--,[crop_ID],[crop],[all_ID]
