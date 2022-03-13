
  SELECT zp.[ssylka] as [GUID]
		,zp.nomer as [NOMER_ZAKAZA]
		,dateadd(year,-2000,zp.data)DATA
		,zp.kontragent as KONTRAGENT_GUID
		,zp.menedzher as MENEDZHER_GUID
		,ttz.tsena as [TSENA]
		,ttz.kolichestvo as [KOLICHESTVO]
		,ttz.statya_d_d_s as STATYA_DDS_GUID
		,ttz.kommentariy_uslugi as KOMMENTARIY_USLUGI
		,ttz.nomenklatura as NOMENKLATURA_GUID
		,ttz.analitika_raskhodov_order as ANALITIKA_RASKHODOV_ORDER_GUID
		,ttz.analitika_raskhodov as ANALITIKA_RASKHODOV_GUID
		--into [L1].dbo.[ZAKAZ_POSTAVSHCHIKU]
  FROM [L0].[dbo].[tab_tovary_zakazpostavshchiku] ttz
  left join [L0].[dbo].[zakaz_postavshchiku] zp on ttz.ssylka=zp.ssylka
  where zp.pometka_udaleniya=0x00

  CREATE TABLE [L1].[DBO].[ZAKAZ_POSTAVSHIKU](
	[GUID] [BINARY](16) NULL,
	[NOMER_ZAKAZA] [NCHAR](11) NULL,
	[DATA] [DATETIME2](0) NULL,
	[KONTRAGENT_GUID] [BINARY](16) NULL,
	[MENEDZHER_GUID] [BINARY](16) NULL,
	[TSENA] [NUMERIC](15, 2) NULL,
	[KOLICHESTVO] [NUMERIC](15, 3) NULL,
	[STATYA_DDS_GUID] [BINARY](16) NULL,
	[KOMMENTARIY_USLUGI] [NVARCHAR](250) NULL,
	[NOMENKLATURA_GUID] [BINARY](16) NULL,
	[ANALITIKA_RASKHODOV_ORDER_GUID] [BINARY](16) NULL,
	[ANALITIKA_RASKHODOV_GUID] [BINARY](16) NULL
)