/****** Naidi pasxalku :)  ******/
SELECT k.[ssylka] as [guid]
	  ,p.ssylka as [guid_partner]
      ,k.[naimenovanie]
      ,[i_n_n] as [IIN_BIN]
	  ,CAST(p.vkhodit_v_gruppu_kompaniy_alem_agro AS bit) AS vkhodit_v_gruppu_kompaniy_alem_agro
	  ,'erp' AS source_base,
	  kik.predstavlenie AS fakt_adres_kontragenta
	,p.kod
	,CASE p.klient
		WHEN 0x01 THEN 'Да' 
		ELSE 'Нет'
	END  AS isClient,
	CASE p.postavshchik 
		WHEN 0x01 THEN 'Да' 
		ELSE 'Нет'
	END  AS isProvider,
	CASE p.konkurent
		WHEN 0x01 THEN 'Да' 
		ELSE 'Нет'
	END   AS isComp,
	CASE p.diler
		WHEN 0x01 THEN 'Да' 
		ELSE 'Нет'
	END   AS isDiller,
    k.kato AS kato,
	br.naimenovanie AS biznes_regiony,
	polz.naimenovanie AS osnovnoy_menedzher

  FROM [L0].[dbo].[kontragenty] k
  left join [L0].[dbo].[partnery] p on k.partner=p.ssylka
  left join [L0].dbo.[tab_kontaktnaya_informatsiya_kontragenty] kik on k.ssylka=kik.ssylka and kik.vid = 0x80DE000C29E67B2E11E628A23AABB795
  left join [L0].[dbo].biznes_regiony br on p.biznes_region=br.ssylka
  left join [L0].[dbo].polzovateli polz on p.osnovnoy_menedzher=polz.ssylka
UNION ALL
SELECT
	fl.ssylka AS [guid],
	fl.ssylka AS [guid_partner],
	fl.naimenovanie as naimenovanie,
	fl.i_n_n AS [IIN_BIN],
	CAST(0 AS bit),
	'' AS source_base,
	'' AS fakt_adres_kontragenta,
	'' AS kod,
	'' AS isClient,
	'' AS isProvider,
	'' AS isComp,
	'' AS isDiller,
    '' AS kato,
	'' AS biznes_regiony,
	'' AS osnovnoy_menedzher
FROM [L0].dbo.fizicheskie_litsa fl