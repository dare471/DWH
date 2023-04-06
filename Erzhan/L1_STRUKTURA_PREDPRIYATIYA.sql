SELECT sp.[ssilka] as [GUID]
	  ,sp2.[ssilka] as RODITEL_GUID
	  ,sp3.ssilka as RODITEL2_GUID
	  ,sp.[naimenovanie] as [NAIMENOVANIE]
	  ,sp2.[naimenovanie] as RODITEL
	  ,sp3.[naimenovanie] as RODITEL2
	  ,sp4.[naimenovanie] as RODITEL3
	  ,sp5.[naimenovanie] as RODITEL4
	  ,sp6.[naimenovanie] as RODITEL5
	  --,CASE WHEN sp2.naimenovanie='ТОО «Alem Agro Holding (АлемАгро Холдинг)»' THEN NULL ELSE sp2.naimenovanie END as RODITEL
	  --,CASE WHEN sp3.naimenovanie='ТОО «Alem Agro Holding (АлемАгро Холдинг)»' THEN NULL ELSE sp3.naimenovanie END as RODITEL1
	  --,CASE WHEN sp4.naimenovanie='ТОО «Alem Agro Holding (АлемАгро Холдинг)»' THEN NULL ELSE sp4.naimenovanie END  AS RODITEL2
	  ,ISNULL(CASE WHEN sp.eto_direkciya=1 THEN sp.naimenovanie
				  WHEN sp2.eto_direkciya=1 THEN sp2.naimenovanie
				  WHEN sp3.eto_direkciya=1 THEN sp3.naimenovanie
				  WHEN sp4.eto_direkciya=1 THEN sp4.naimenovanie 
				  WHEN sp5.eto_direkciya=1 THEN sp5.naimenovanie
				  WHEN sp6.eto_direkciya=1 THEN sp6.naimenovanie	
			END, CASE WHEN SP2.naimenovanie NOT IN ('Головной офис','Управление цепью поставок','ТОО «Alem Agro Holding (АлемАгро Холдинг)»','Департамент продаж') THEN sp3.naimenovanie ELSE sp.naimenovanie END ) AS DIREKSYA
	  ,ISNULL(CASE WHEN sp.eto_direkciya=1 THEN sp.ssilka
				  WHEN sp2.eto_direkciya=1 THEN sp2.ssilka
				  WHEN sp3.eto_direkciya=1 THEN sp3.ssilka
				  WHEN sp4.eto_direkciya=1 THEN sp4.ssilka
				  WHEN sp5.eto_direkciya=1 THEN sp5.ssilka
			END, CASE WHEN SP2.naimenovanie NOT IN ('Головной офис','Управление цепью поставок','ТОО «Alem Agro Holding (АлемАгро Холдинг)»') THEN sp3.ssilka ELSE sp2.ssilka END ) AS DIREKSYA_GUID
	  ,SP.[tekushchii_rukovoditel] AS TEKUSHCHIY_RUKOVODITEL
	  ,SP.eto_direkciya AS ETO_DIREKCIYA
--INTO [L1].[dbo].[STRUKTURA_PREDPRIYATIYA]
  FROM [L0].[dbo].[struktura_predpriyatiya] sp
  LEFT JOIN [L0].[dbo].[struktura_predpriyatiya] sp2 on sp.roditel=sp2.[ssilka]
  LEFT JOIN [L0].[dbo].[struktura_predpriyatiya] sp3 on sp2.roditel=sp3.[ssilka]
  LEFT JOIN [L0].[dbo].[struktura_predpriyatiya] sp4 on sp3.roditel=sp4.[ssilka]
  LEFT JOIN [L0].[dbo].[struktura_predpriyatiya] sp5 on sp4.roditel=sp5.[ssilka]
  LEFT JOIN [L0].[dbo].[struktura_predpriyatiya] sp6 on sp5.roditel=sp6.[ssilka]
  WHERE SP.pometka_udaleniya=0
 -- ORDER BY SP.naimenovanie