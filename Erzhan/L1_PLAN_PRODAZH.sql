
  SELECT
  PP.ssylka AS GUID
  ,CASE WHEN VP.vozmozhnost_rezhima_korrektirovki=0x01 THEN 'Да'
		ELSE 'Нет' 
	END AS VOZMOZHNOST_REZHIMA_KORREKTIROVKI
,DATEADD(YEAR,-2000,PYP.period) AS PERIOD
,SP.description AS STATUS
,PYP.nomenklatura AS NOMENKLATURA_GUID
,PYP.menedzher AS MENEDZHER_GUID
,PP.sezon AS SEZON_GUID
,PYP.KOLICHESTVO AS KOLICHESTVO
,PYP.SUMMA AS SUMMA
,STP.[naimenovanie] AS STSENARII
,PP.podrazdelenie AS PODRAZDELENIE_GUID
,CASE WHEN PP.rezhim_korrektirovki=0x01 THEN 'Да'
		ELSE 'Нет' 
	END AS REZHIM_KORREKTIROVKI
,SKPP.description AS STATUS_KORREKTIROVKI
,VP.naimenovanie AS VIDY_PLANOV 

--INTO L1.dbo.PLAN_PRODAZH

  FROM [L0].[dbo].[plany_prodazh] AS PYP
LEFT JOIN [L0].[dbo].[plan_prodazh] PP
	ON PYP.plan_prodazh=PP.ssylka
LEFT JOIN L0.DBO.vidy_planov AS VP
	ON VP.ssylka=PP.vid_plana
LEFT JOIN L0.DBO.sezony S
	ON PP.sezon=S.ssylka
LEFT JOIN [L0].[dbo].[stsenarii_tovarnogo_planirovaniya] STP
	ON PYP.stsenariy=STP.[ssylka]
LEFT JOIN L0.DBO.statusy_planov AS SP
	ON PYP.status=SP.ssylka
LEFT JOIN L0.DBO.statusy_korrektirovki_plana_prodazh AS SKPP
	ON PP.status_korrektirovki=SKPP.ssylka
WHERE PYP.aktivnost=0x01