SELECT zp.[ssylka] as GUID
		,zp.nomer as NOMER_ZAKAZA
		,dateadd(year,-2000,zp.data) as DATA
		,zp.kontragent as KONTRAGENT_GUID
		,K.naimenovanie AS KONTRAGENT
		,ZP.organizatsiya AS ORGANIZATSIYA
		,zp.menedzher as MENEDZHER_GUID
		,P.naimenovanie AS MENEDZHER
		,zp.dogovor as DOGOVOR_GUID
		,ttz.tsena as TSENA
		,ttz.kolichestvo as KOLICHESTVO
		,ttz.statya_d_d_s as STATYA_DDS_GUID
		,ttz.kommentariy_uslugi as  KOMMENTARIY_USLUGI
		,ttz.nomenklatura as NOMENKLATURA_GUID
		,ttz.analitika_raskhodov_order as ANALITIKA_RASKHODOV_ORDER_GUID
		,ttz.analitika_raskhodov as ANALITIKA_RASKHODOV_GUID
--into L1.dbo.ZAKAZ_POSTAVSHIKU
FROM [L0].[dbo].[tab_tovary_zakazpostavshchiku] ttz
left join [L0].[dbo].[zakaz_postavshchiku] zp on ttz.ssylka=zp.ssylka
LEFT JOIN L0.DBO.polzovateli P 
	ON P.ssylka=ZP.menedzher
LEFT JOIN L0.DBO.kontragenty K 
	ON K.ssylka=ZP.kontragent
  where zp.pometka_udaleniya=0x00


