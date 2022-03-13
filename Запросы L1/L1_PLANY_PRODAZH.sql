/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT dateadd(year,-2000,cast([period]as date))as[PERIOD]
      ,[synonym_registrator] as [SYNONYM_REGISTRATOR]
      ,[type_registrator] as [TYPE_REGISTRATOR]
      ,[registrator] as [REGISTRATOR]
      ,[nomer_stroki] as [NOMER_STROKI]
      ,[aktivnost] as [AKTIVNOST]
      ,[stsenariy] as [STSENARIY]
      ,[status] as [STATUS]
      ,[nomenklatura] as [NOMENKLATURA]
      ,[podrazdelenie] as [PODRAZDELENIE]
      ,[plan_prodazh] as [PLAN_PRODAZH]
      ,[menedzher] as [MENEDZHER]
      ,[kolichestvo] as [KOLICHESTVO]
      ,[summa] as [SUMMA]
  FROM [L0].[dbo].[plany_prodazh]


  CREATE TABLE [L1].[dbo].[PLANY_PRODAZH](
	[PERIOD] [datetime2](0) NULL,
	[SYNONYM_REGISTRATOR] [varchar](255) NULL,
	[TYPE_REGISTRATOR] [binary](4) NULL,
	[REGISTRATOR] [binary](16) NULL,
	[NOMER_STROKI] [numeric](9, 0) NULL,
	[AKTIVNOST] [binary](1) NULL,
	[STSENARIY] [binary](16) NULL,
	[STATUS] [binary](16) NULL,
	[NOMENKLATURA] [binary](16) NULL,
	[PODRAZDELENIE] [binary](16) NULL,
	[PLAN_PRODAZH] [binary](16) NULL,
	[MENEDZHER] [binary](16) NULL,
	[KOLICHESTVO] [numeric](15, 3) NULL,
	[SUMMA] [numeric](15, 2) NULL,
) 