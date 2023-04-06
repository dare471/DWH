SELECT
	DATEADD(YEAR, -2000,period) AS DATE,
	vid_dvizheniya AS VID_DVIZHENIYA,
	—ебестоимость“оваров.organizatsiya AS ORGANIZATSIYA_GUID,
	—клады.naimenovanie AS SKLAD,
	 лючијналитики”четаЌоменклатуры.nomenklatura AS NOMENKLATURA_GUID,
	 лючијналитики”четаѕоѕартнерам.kontragent AS KONTRAGENT_GUID,
	CASE vid_dvizheniya
		WHEN 0 THEN SUM(kolichestvo)
		WHEN 1 THEN -SUM(kolichestvo)
	END AS KOLICHESTVO,
	CASE vid_dvizheniya
		WHEN 0 THEN SUM(stoimost + dop_raskhody)
		WHEN 1 THEN -SUM(stoimost + dop_raskhody)
	END AS STOIMOST
	--INTO [L1].[dbo].[SEBESTOIMOST_TOVAROV] 
FROM [L0].[dbo].[sebestoimost_tovarov] AS —ебестоимость“оваров
LEFT JOIN L0.DBO.klyuchi_analitiki_ucheta_nomenklatury AS  лючијналитики”четаЌоменклатуры ON —ебестоимость“оваров.analitika_ucheta_nomenklatury =  лючијналитики”четаЌоменклатуры.ssylka
LEFT JOIN L0.dbo.sklady AS —клады ON  лючијналитики”четаЌоменклатуры.sklad = —клады.ssylka
LEFT JOIN L0.DBO.klyuchi_analitiki_ucheta_po_partneram AS  лючијналитики”четаѕоѕартнерам ON —ебестоимость“оваров.analitika_ucheta_po_partneram =  лючијналитики”четаѕоѕартнерам.ssylka
WHERE  —ебестоимость“оваров.aktivnost = 1
GROUP BY 
	DATEADD(YEAR, -2000,period),
	vid_dvizheniya,
	—ебестоимость“оваров.organizatsiya,
	—клады.naimenovanie,
	 лючијналитики”четаЌоменклатуры.nomenklatura,
	 лючијналитики”четаѕоѕартнерам.kontragent
ORDER BY DATEADD(YEAR, -2000,period)