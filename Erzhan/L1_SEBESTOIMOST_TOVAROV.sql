SELECT
	DATEADD(YEAR, -2000,period) AS DATE,
	vid_dvizheniya AS VID_DVIZHENIYA,
	��������������������.organizatsiya AS ORGANIZATSIYA_GUID,
	������.naimenovanie AS SKLAD,
	�������������������������������.nomenklatura AS NOMENKLATURA_GUID,
	������������������������������.kontragent AS KONTRAGENT_GUID,
	CASE vid_dvizheniya
		WHEN 0 THEN SUM(kolichestvo)
		WHEN 1 THEN -SUM(kolichestvo)
	END AS KOLICHESTVO,
	CASE vid_dvizheniya
		WHEN 0 THEN SUM(stoimost + dop_raskhody)
		WHEN 1 THEN -SUM(stoimost + dop_raskhody)
	END AS STOIMOST
	--INTO [L1].[dbo].[SEBESTOIMOST_TOVAROV] 
FROM [L0].[dbo].[sebestoimost_tovarov] AS ��������������������
LEFT JOIN L0.DBO.klyuchi_analitiki_ucheta_nomenklatury AS ������������������������������� ON ��������������������.analitika_ucheta_nomenklatury = �������������������������������.ssylka
LEFT JOIN L0.dbo.sklady AS ������ ON �������������������������������.sklad = ������.ssylka
LEFT JOIN L0.DBO.klyuchi_analitiki_ucheta_po_partneram AS ������������������������������ ON ��������������������.analitika_ucheta_po_partneram = ������������������������������.ssylka
WHERE  ��������������������.aktivnost = 1
GROUP BY 
	DATEADD(YEAR, -2000,period),
	vid_dvizheniya,
	��������������������.organizatsiya,
	������.naimenovanie,
	�������������������������������.nomenklatura,
	������������������������������.kontragent
ORDER BY DATEADD(YEAR, -2000,period)