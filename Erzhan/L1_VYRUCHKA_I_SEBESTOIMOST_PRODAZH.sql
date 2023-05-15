WITH VIRUCHKA AS (
					SELECT DATEADD(YEAR, -2000,vsp.period) AS DATE,
						kau.organizatsiya as [ORGANIZATSIYA_GUID],
						kau.kontragent as [KONTRAGENT_GUID],
						kau.dogovor as [DOGOVOR_GUID],
						vsp.menedzher as [MENEDZHER_GUID],
						vsp.sklad as [SKLAD_GUID],
						vsp.istochnik_g_f_u_nomenklatury as [NOMENKLATURA_GUID],
						--КлючиАналитикиУчетаНоменклатуры._Fld5323RRef  AS Номенклатура_v2_guid,
						VSP.[valyuta_vzaimoraschetov] AS [VALYUTA_VZAIMORASCHETOV],
						SUM(vsp.kolichestvo) AS KOLICHESTVO,
						SUM([summa_v_valyute_vzaimoraschetov]) AS SUMMA_VYRUCHKI,
						SUM([summa_bez_n_d_s_v_valyute_vzaimoraschetov]) AS [SUMMA_VYRUCHKI_BEZ_NDS],
						SUM(stoimost) AS STOIMOST,
						SUM(stoimost_bez_n_d_s) AS [STOIMOST_BEZ_NDS]
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
						vsp.istochnik_g_f_u_nomenklatury,
						VSP.[valyuta_vzaimoraschetov]
					)

/*** ЭТОТ НУЖЕН ДЛЯ ТОГО ЧТОБЫ СУММА БЫЛО МИНУСОМ КОГДА ЕСТЬ КОЛИЧЕСТВО МИНУС, ДУМАЮ ЭТО ИЗ-ЗА КОРРЕКТИРОВКИ ***/
SELECT 
V.DATE
,V.DOGOVOR_GUID
,V.KONTRAGENT_GUID
,V.MENEDZHER_GUID
,V.NOMENKLATURA_GUID
,V.ORGANIZATSIYA_GUID
,V.SKLAD_GUID
,V.KOLICHESTVO
,V.STOIMOST
,V.STOIMOST_BEZ_NDS
,CASE WHEN V.KOLICHESTVO <0 AND V.SUMMA_VYRUCHKI>0 THEN V.SUMMA_VYRUCHKI*(-1) ELSE V.SUMMA_VYRUCHKI END AS SUMMA_VYRUCHKI
,CASE WHEN V.KOLICHESTVO <0 AND V.SUMMA_VYRUCHKI_BEZ_NDS > 0 THEN V.SUMMA_VYRUCHKI_BEZ_NDS *(-1) ELSE V.SUMMA_VYRUCHKI_BEZ_NDS END AS SUMMA_VYRUCHKI_BEZ_NDS
,V.VALYUTA_VZAIMORASCHETOV

--INTO [L1].[DBO].[VYRUCHKA_I_SEBESTOIMOST_PRODAZH] 
FROM VIRUCHKA V
--WHERE V.DOGOVOR_GUID IN (0x8128000C29EF79CA11E977BA6DBA5C8A,
--0xA22B7085C2A4312A11EA884FE528EA5A)
--AND V.KOLICHESTVO <0 

--ORDER  BY V.KOLICHESTVO