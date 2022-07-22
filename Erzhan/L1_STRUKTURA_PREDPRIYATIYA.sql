SELECT sp.[ssylka] as [GUID]
	  ,sp2.ssylka as RODITEL_GUID
	  ,sp3.ssylka as RODITEL2_GUID
      ,sp.[naimenovanie] as [NAIMENOVANIE]
	  ,CASE WHEN sp.[naimenovanie] IN ('ВКО','Павлодар ') THEN 'Восточная дирекция' 
			ELSE sp2.naimenovanie 
	  END as RODITEL
	  ,CASE WHEN sp2.naimenovanie IN ('ВКО','Павлодар ') THEN 'Восточная дирекция' 
			ELSE sp3.naimenovanie 
	  END as RODITEL2
--into [L1].[dbo].[STRUKTURA_PREDPRIYATIYA]
  FROM [L0].[dbo].[struktura_predpriyatiya] sp
  left join [L0].[dbo].[struktura_predpriyatiya] sp2 on sp.roditel=sp2.ssylka
  left join [L0].[dbo].[struktura_predpriyatiya] sp3 on sp2.roditel=sp3.ssylka