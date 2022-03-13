/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT distinct oe.[ssylka] AS [guid]
	,oe.NAIMENOVANIE
      ,oe2.naimenovanie as [RODITEL]
	  ,oe.NAIMENOVANIE_POLNOE
	  ,oe.INVENTARNYY_NOMER
	  ,oe.GOS_NOMER
	  ,oe.id__wialon as ID_WIALON
	  ,oe.name__wialon as NAME_WIALON
	  --into [L1].[dbo].[OBEKTY_EKSPLUATATSII]
  FROM [L0].[dbo].[OBEKTY_EKSPLUATATSII] oe
  left join [L0].[dbo].[obekty_ekspluatatsii]  oe2 on oe.roditel=oe2.ssylka
  where oe.[pometka_udaleniya]=0x00


  CREATE TABLE [L1].[DBO].[OBEKTY_EKSPLUATATSII](
	[GUID] [BINARY](16) NULL,
	[NAIMENOVANIE] [NVARCHAR](100) NULL,
	[RODITEL] [NVARCHAR](100) NULL,
	[NAIMENOVANIE_POLNOE] [NVARCHAR](1000) NULL,
	[INVENTARNYY_NOMER] [NVARCHAR](15) NULL,
	[GOS_NOMER] [NVARCHAR](20) NULL,
	[ID_WIALON] [NUMERIC](15, 0) NULL,
	[NAME_WIALON] [NVARCHAR](30) NULL
) 