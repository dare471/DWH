SELECT DATEADD(YEAR, -2000,vsp.period) AS date,
	kau.organizatsiya as [organizatsiya_guid],
	kau.kontragent as [kontragent_guid],
	kau.dogovor as [dogovor_guid],
	vsp.menedzher as [menedzher_guid],
	vsp.sklad as [sklad_guid],
	vsp.istochnik_g_f_u_nomenklatury as [nomenklatura_guid],
	--КлючиАналитикиУчетаНоменклатуры._Fld5323RRef  AS Номенклатура_v2_guid,
	SUM(vsp.kolichestvo) AS kolichestvo,
	SUM(summa_vyruchki) AS summa_vyruchki,
	SUM(summa_vyruchki_bez_n_d_s) AS [summa_vyruchki_bez_NDS],
	SUM(stoimost) AS stoimost,
	SUM(stoimost_bez_n_d_s) AS [stoimost_bez_NDS]
  FROM [L0].[dbo].[vyruchka_i_sebestoimost_prodazh] vsp
  LEFT JOIN L0.dbo.klyuchi_analitiki_ucheta_po_partneram AS kau ON vsp.analitika_ucheta_po_partneram=kau.ssylka
  left join [L0].[dbo].[dogovory_kontragentov] dk on vsp.dogovor=dk.ssylka
--LEFT JOIN _Reference197 AS КлючиАналитикиУчетаНоменклатуры ON ВыручкаИСебестоимостьПродаж._Fld41921RRef = КлючиАналитикиУчетаНоменклатуры._idrref
where dk.status=0xA92F27FC8D2DBD51466ED7D8981B86F1 and dk.pometka_udaleniya=0x00
GROUP BY
	DATEADD(YEAR, -2000,vsp.period),
	kau.organizatsiya,
	kau.kontragent,
	kau.dogovor,
	vsp.menedzher,
	vsp.sklad,
	vsp.istochnik_g_f_u_nomenklatury