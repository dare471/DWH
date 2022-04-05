SELECT ОтчетKompra.ssylka as [GUID],
	DATEADD(YEAR, -2000, [data]) AS [DATA],
	[NOMER] AS [NOMER],
	[subekt_proverki] AS [SUBEKT_PROVERKI_GUID],
	[i_i_n___b_i_n] AS [IIN_BIN],
	CASE [sostoyanie]
		WHEN 0x9C4BFF7B5DD7BE864DC0C31916DDE31B THEN 'Отчет получен' 
		WHEN 0x87CA7FE2E340B96B465BF974D731E129 THEN 'Отчет не получен' 
		ELSE 'В обработке'
	END AS [SOSTOYANIE],
	DATEADD(YEAR, -2000, [data_zaprosa]) AS [DATA_ZAPROSA],
	DATEADD(YEAR, -2000, [data_otveta]) AS [DATA_OTVETA],
	[avtor] AS [AVTOR_GUID],
	[kolichestvo_popytok_polucheniya] AS [KOLICHESTVO_POPYTOK_POLUCHENIYA],
	DATEADD(YEAR, -2000, [data_sleduyushchego_zaprosa]) AS [DATA_SLEDUYUSHCHEGO_ZAPROSA],
	CASE [tip_proverki] 
		WHEN 0xA8E51060959E378B4F61223EC09E63E2 THEN 'Ручной запуск' 
		WHEN 0xB85C3A25E80EA9334B16002D92A9F6E2 THEN 'Новый клиент'
		ELSE 'Ежемесячная проверка' 
	END AS [TIP_PROVERKI],
	CASE [prevyshen_limit]
		WHEN 0x01 THEN 'Да'
		ELSE 'Нет'
	END  AS [PREVYSHEN_LIMIT]
	,[PROTSENT_DOSTUPNOSTI_ISTOCHNIKOV]
--into [L1].[dbo].[OTCHET_KOMPRA]
FROM [L0].[dbo].[otchet_kompra] AS ОтчетKompra
order by [data],nomer