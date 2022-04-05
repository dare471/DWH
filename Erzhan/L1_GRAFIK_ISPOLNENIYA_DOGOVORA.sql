SELECT DATEADD(YEAR, -2000,gid.period) AS period,
		gid.dogovor AS dogovor_guid,
		dk.nomer AS nomer_dogovora,
		--gid.[synonym_registrator],
		CASE dk.tip_dogovora
		WHEN 0xA3389E59ECB123F5411A3ED37167043E THEN 'С покупателем / заказчиком'
		WHEN 0x8B4A2312CE4B533D4A75139DDFDB8623 THEN 'Импорт'
		WHEN 0x8CA38FB9F79383F2423DF86B12E91F6D THEN 'Ввоз из ЕАЭС'
		WHEN 0xB4AB7CA032D09A4C4CC873A7230CD346 THEN 'С поставщиком / исполнителем'
		END AS tip_dogovora,
		CASE dk.status
		WHEN 0xA92F27FC8D2DBD51466ED7D8981B86F1 THEN 'Действует'
		WHEN 0xA2EA1532A615D3884BDCF62760B790DE THEN 'Отменен'
		WHEN 0xB272C13AAE12525743C0BFD226B5DC0E THEN 'Закрыт'
		WHEN 0x82D1CD037C7784B2447E1C9C3915309E THEN 'Ожидается согласование'
		ELSE 'Пусто' 
		END AS [status],
		DATEADD(YEAR, -2000,cast(gid.data_po_grafiku as date)) AS data_po_grafiku,
		gid.protsent_oplaty AS protsent_oplaty,
		gid.summa_oplaty AS summa_oplaty,
		'erp' AS source_base
  FROM [L0].[dbo].[grafik_ispolneniya_dogovora]gid
  left join [L0].[dbo].[grafik_ispolneniya_dogovora] gid2 on gid.dogovor=gid2.dogovor
  left join [L0].dbo.dogovory_kontragentov dk on dk.ssylka=gid.dogovor

  WHERE gid.period = (SELECT MAX(period) FROM [L0].[dbo].[grafik_ispolneniya_dogovora]i WHERE i.dogovor = gid.dogovor)
--AND ДоговораКонтрагентов._Fld4139RRef = 0xA3389E59ECB123F5411A3ED37167043E 
AND gid.summa_oplaty<> 0  
GROUP BY
		DATEADD(YEAR, -2000,gid.Period),
		gid.dogovor,
		dk.nomer,
		--gid.[synonym_registrator],
		CASE dk.tip_dogovora
		WHEN 0xA3389E59ECB123F5411A3ED37167043E THEN 'С покупателем / заказчиком'
		WHEN 0x8B4A2312CE4B533D4A75139DDFDB8623 THEN 'Импорт'
		WHEN 0x8CA38FB9F79383F2423DF86B12E91F6D THEN 'Ввоз из ЕАЭС'
		WHEN 0xB4AB7CA032D09A4C4CC873A7230CD346 THEN 'С поставщиком / исполнителем'
		END,
		CASE dk.status
		WHEN 0xA92F27FC8D2DBD51466ED7D8981B86F1 THEN 'Действует'
		WHEN 0xA2EA1532A615D3884BDCF62760B790DE THEN 'Отменен'
		WHEN 0xB272C13AAE12525743C0BFD226B5DC0E THEN 'Закрыт'
		WHEN 0x82D1CD037C7784B2447E1C9C3915309E THEN 'Ожидается согласование'
		ELSE 'Пусто' 
		END,
		DATEADD(YEAR, -2000,cast(gid.data_po_grafiku as date)),
		gid.protsent_oplaty,
		gid.summa_oplaty
ORDER BY DATEADD(YEAR, -2000,cast(gid.data_po_grafiku as date))