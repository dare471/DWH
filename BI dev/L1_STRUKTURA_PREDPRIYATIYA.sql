SELECT sp.[ssylka] as [GUID]
	  ,sp2.ssylka as RODITEL_GUID
	  ,sp3.ssylka as RODITEL2_GUID
      ,sp.[naimenovanie] as [NAIMENOVANIE]
	  ,sp2.naimenovanie as RODITEL
	  ,sp3.naimenovanie as RODITEL2
--into [L1].[dbo].[STRUKTURA_PREDPRIYATIYA]
  FROM [L0].[dbo].[struktura_predpriyatiya] sp
  left join [L0].[dbo].[struktura_predpriyatiya] sp2 on sp.roditel=sp2.ssylka
  left join [L0].[dbo].[struktura_predpriyatiya] sp3 on sp2.roditel=sp3.ssylka