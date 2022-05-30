SELECT  
	  DATEADD(YEAR, -2000, dst.period) AS [PERIOD], --_Period 
	  dst.registrator AS [REGISTRATOR_GUID],        --Регистратор_guid, 
	  dst.seriya AS [SERIYA_GUID],                       --Серия_guid, 
	  serii_nomenklatury.naimenovanie AS [SERIYA], --Серия, 
	  dst.nomenklatura AS [NOMENKLATURA_GUID],      --Номенклатура_guid 
	  dst.dokument AS [DOKUMENT_GUID],              --Документ_guid 
	  --dst.type_dokument as [TYPE_DOCUMENT],         --_Fld42543_RTRef 
	  dst.synonym_dokument as [DOKUMENT_DVIZHENIYA], --ДокументДвижения, 
	  dst.skladskaya_operatsiya as [SKLADSKIE_OPERATSII_GUID], 
	  skladskie_operatsii.description as [SKLADSKIE_OPERATSII], 
	  dst.poluchatel AS [SKLAD_GUID], --Склад_guid, 
	  sklady.naimenovanie AS [SKLAD], 
	  dst.kolichestvo AS [KOLICHESTVO], --Количество, 
	  tovary_realizatsii.tsena AS [TSENA_REALIZATSII], 
	  tovary_priobretenie.tsena AS [TSENA_PRIOBRETENIE], 
	  serii_nomenklatury.koeffitsient_posevnykh_edinits AS [VES_1PE_V_KG],
	  poluchatel as [POLUCHATEL_GUID]
--into [L1].dbo.[DVIZHENIYA_SERIY_TOVAROV]
FROM [L0].[dbo].[dvizheniya_seriy_tovarov] AS dst 
	LEFT JOIN [L0].[dbo].[serii_nomenklatury] AS serii_nomenklatury ON dst.seriya = serii_nomenklatury.ssylka 
	LEFT JOIN [L0].[dbo].[sklady] as sklady ON dst.poluchatel = sklady.ssylka 
	LEFT JOIN [L0].[dbo].[tab_tovary_priobretenietovarovuslug] AS tovary_priobretenie  
		ON dst.dokument = tovary_priobretenie.ssylka  
		AND dst.nomenklatura = tovary_priobretenie.nomenklatura 
	LEFT JOIN [L0].[dbo].[tab_tovary_realizatsiyatovarovuslug] AS tovary_realizatsii  
		ON dst.dokument = tovary_realizatsii.ssylka  
		AND dst.nomenklatura = tovary_realizatsii.nomenklatura 
	LEFT JOIN [L0].[dbo].[skladskie_operatsii] as skladskie_operatsii  
		ON dst.skladskaya_operatsiya=skladskie_operatsii.ssylka  
ORDER BY DATEADD(YEAR, -2000, dst.period)