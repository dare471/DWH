/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT DATEADD(YEAR, -2000,vsp.period) AS date,
	kau.organizatsiya as [organizatsiya_guid],
	kau.kontragent as [kontragent_guid],
	kau.dogovor as [dogovor_guid],
	menedzher as [menedzher_guid],
	sklad as [sklad_guid],
	vsp.istochnik_g_f_u_nomenklatury as [nomenklatura_guid],
	--КлючиАналитикиУчетаНоменклатуры._Fld5323RRef  AS Номенклатура_v2_guid,
	SUM(vsp.kolichestvo) AS kolichestvo,
	SUM(summa_vyruchki) AS summa_vyruchki,
	SUM(summa_vyruchki_bez_n_d_s) AS [summa_vyruchki_bez_NDS],
	SUM(stoimost) AS stoimost,
	SUM(stoimost_bez_n_d_s) AS [stoimost_bez_NDS]
  FROM [L0].[dbo].[vyruchka_i_sebestoimost_prodazh] vsp
  LEFT JOIN L0.dbo.klyuchi_analitiki_ucheta_po_partneram AS kau ON vsp.analitika_ucheta_po_partneram=kau.ssylka
--LEFT JOIN _Reference197 AS КлючиАналитикиУчетаНоменклатуры ON ВыручкаИСебестоимостьПродаж._Fld41921RRef = КлючиАналитикиУчетаНоменклатуры._idrref
GROUP BY
	DATEADD(YEAR, -2000,vsp.period),
	kau.organizatsiya,
	kau.kontragent,
	kau.dogovor,
	menedzher,
	sklad,
	vsp.istochnik_g_f_u_nomenklatury


	CREATE TABLE [L1].[DBO].[VYRUCHKA_I_SEBESTOIMOST_PRODAZH](
	[DATE] [DATETIME2](0) NULL,
	[ORGANIZATSIYA_GUID] [BINARY](16) NULL,
	[KONTRAGENT_GUID] [BINARY](16) NULL,
	[DOGOVOR_GUID] [BINARY](16) NULL,
	[MENEDZHER_GUID] [BINARY](16) NOT NULL,
	[SKLAD_GUID] [BINARY](16) NOT NULL,
	[NOMENKLATURA_GUID] [BINARY](16) NOT NULL,
	[KOLICHESTVO] [NUMERIC](38, 3) NULL,
	[SUMMA_VYRUCHKI] [NUMERIC](38, 2) NULL,
	[SUMMA_VYRUCHKI_BEZ_NDS] [NUMERIC](38, 2) NULL,
	[STOIMOST] [NUMERIC](38, 2) NULL,
	[STOIMOST_BEZ_NDS] [NUMERIC](38, 2) NULL
)