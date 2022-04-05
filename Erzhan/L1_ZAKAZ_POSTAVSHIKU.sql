SELECT zp.[ssylka] as guid
		,zp.nomer as nomer_zakaza
		,dateadd(year,-2000,zp.data)data
		,zp.kontragent as kontragent_guid
		,zp.menedzher as menedzher_guid
		,ttz.tsena
		,ttz.kolichestvo
		,ttz.statya_d_d_s as statya_DDS_guid
		,ttz.kommentariy_uslugi
		,ttz.nomenklatura as nomenklatura_guid
		,ttz.analitika_raskhodov_order as analitika_raskhodov_order_guid
		,ttz.analitika_raskhodov as analitika_raskhodov_guid
  FROM [L0].[dbo].[tab_tovary_zakazpostavshchiku] ttz
  left join [L0].[dbo].[zakaz_postavshchiku] zp on ttz.ssylka=zp.ssylka
  where zp.pometka_udaleniya=0x00