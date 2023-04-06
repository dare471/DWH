/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT DISTINCT
CASE WHEN A.DIREKSYA='Головной офис' AND A.NAIMENOVANIE!='Кемелов Эдиль' THEN NULL
	WHEN A.DIREKSYA='Павлодар' AND A.NAIMENOVANIE IN ('Абдыкадыров Амангельды Акбатырович','Макенов Марат Анатольевич') THEN NULL
	WHEN A.DIREKSYA='ВКО'	AND A.NAIMENOVANIE='Дробышев Дмитрий' THEN NULL
	WHEN A.DIREKSYA='Северная дирекция' AND A.NAIMENOVANIE='Павлов Денис Сергеевич' THEN NULL
	WHEN A.DIREKSYA IN('ВКО','Павлодар') THEN 'Восточная дирекция'
	ELSE A.DIREKSYA END AS DIREKSYA
,CASE WHEN A.DIREKSYA='Головной офис' AND A.NAIMENOVANIE!='Кемелов Эдиль' THEN NULL
	WHEN A.DIREKSYA='Павлодар' AND A.NAIMENOVANIE IN ('Абдыкадыров Амангельды Акбатырович','Макенов Марат Анатольевич') THEN NULL
	WHEN A.DIREKSYA='ВКО'	AND A.NAIMENOVANIE='Дробышев Дмитрий' THEN NULL
	WHEN A.DIREKSYA='Северная дирекция' AND A.NAIMENOVANIE='Павлов Денис Сергеевич' THEN NULL

	ELSE A.NAIMENOVANIE END AS DIREKSYA

FROM (
		SELECT DISTINCT
		FL.NAIMENOVANIE
		--,SP.naimenovanie AS SP
		--,SP1.naimenovanie AS SP1
		--,SP2.naimenovanie AS SP2
		--,ISNULL(SP2.naimenovanie,ISNULL(SP1.naimenovanie,SP.naimenovanie))
		,ISNULL(SP2.naimenovanie,ISNULL(SP1.naimenovanie,SP.naimenovanie)) DIREKSYA--='Головной офис' THEN SP.naimenovanie ELSE ISNULL(SP2.naimenovanie,ISNULL(SP1.naimenovanie,SP.naimenovanie)) END AS DIREKSYA
		  FROM [L0].[dbo].[struktura_predpriyatiya] AS SP
		  LEFT JOIN [L0].[dbo].[struktura_predpriyatiya] AS SP1
		  ON SP.roditel=SP1.ssylka
		  LEFT JOIN [L0].[dbo].[struktura_predpriyatiya] AS SP2
		  ON SP1.roditel=SP2.ssylka
		  LEFT JOIN L1.DBO.FIZICHESKIE_LITSA AS FL
		  ON SP.tekushchiy_rukovoditel=FL.GUID
		WHERE ISNULL(SP2.naimenovanie,ISNULL(SP1.naimenovanie,SP.naimenovanie)) IN ('ВКО','Павлодар','Центральная дирекция','Северная дирекция','Западная дирекция','Южная дирекция','Головной офис')
		AND FL.NAIMENOVANIE IS NOT NULL

		--ORDER BY FL.NAIMENOVANIE

	) A

	WHERE DIREKSYA IS NOT NULL