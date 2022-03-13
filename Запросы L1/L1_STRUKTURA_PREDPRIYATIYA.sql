SELECT sp.[ssylka] as [guid]
      ,sp.[naimenovanie]
	  ,sp2.naimenovanie roditel
	  ,sp3.naimenovanie roditel2
  FROM [L0].[dbo].[struktura_predpriyatiya] sp
  left join [L0].[dbo].[struktura_predpriyatiya] sp2 on sp.roditel=sp2.ssylka
  left join [L0].[dbo].[struktura_predpriyatiya] sp3 on sp2.roditel=sp3.ssylka


  CREATE TABLE [L1].[DBO].[STRUKTURA_PREDPRIYATIYA](
	[GUID] [BINARY](16) NOT NULL,
	[RODITEL] [NVARCHAR](50) NULL,
	[RODITEL2] [NVARCHAR](50) NULL,
	[NAIMENOVANIE] [NVARCHAR](50) NULL
)