
SELECT [ssylka] as [guid]
      ,[naimenovanie]
      ,dateadd(year,-2000,cast([nachalo_perioda] as date)) as [nachalo_perioda] 
      ,dateadd(year,-2000,cast([konets_perioda] as date)) as [konets_perioda] 
  FROM [L0].[dbo].[sezony]

  create table [L1].[DBO].[SEZONY](
	[GUID] [BINARY](16) NOT NULL,
	[NAIMENOVANIE] [NVARCHAR](25) NOT NULL,
	[NACHALO_PERIODA] [DATE] NULL,
	[KONETS_PERIODA] [DATE] NULL
)