SELECT 
	_Fld44831RRef AS [NOMENKLATURA_GUID],
	_Fld44834RRef AS [SKLAD_GUID],
	_Fld44836RRef AS SERIYA_GUID,
	DATEADD(YEAR, -2000,СерииНоменклатуры.data_proizvodstva) AS DATA_PROIZVODSTVA,
	DATEADD(YEAR, -2000,СерииНоменклатуры.goden_do) AS GODEN_DO,
	CASE
		WHEN DATEADD(YEAR, -2000,СерииНоменклатуры.goden_do) < SYSDATETIME() THEN 'НеГоден'
		WHEN DATEADD(YEAR, -2000,СерииНоменклатуры.goden_do) > SYSDATETIME() THEN 'Годен'  
		END AS STATUS_GODNOSTI,
	CASE 
	WHEN DATEDIFF (dayofyear , SYSDATETIME() , DATEADD(YEAR, -2000,СерииНоменклатуры.goden_do) ) < 0 THEN 0
	ELSE DATEDIFF (dayofyear , SYSDATETIME() , DATEADD(YEAR, -2000,СерииНоменклатуры.goden_do) )
		END AS DNEY_DO_ISTECHENIYA_SROKA_GODNOSTI,
	SUM(_Fld44837) AS KOLICHESTVO,
	SUM(_Fld44838) AS K_OTGRUZKE,
	'erp' AS SOURCE_BASE
	---INTO [L1].[dbo].TOVARY_NA_SKLADAKH_OSTATKI_PO_SROKAM_GODNOSTI
FROM [L0].dbo.[itogi_tovary_na_skladakh] as ТоварыНаСкладахОстатки
LEFT JOIN [L0].[dbo].nomenklatura AS Номенклатура ON ТоварыНаСкладахОстатки._Fld44831RRef = Номенклатура.ssylka
LEFT JOIN [L0].[dbo].sklady AS Склады ON ТоварыНаСкладахОстатки._Fld44834RRef = Склады.ssylka
LEFT JOIN [L0].[dbo].serii_nomenklatury AS СерииНоменклатуры ON ТоварыНаСкладахОстатки._Fld44836RRef = СерииНоменклатуры.ssylka
WHERE Номенклатура.vid_nomenklatury = 0x8D9B6427378958AD11E35283A68E63A8 AND (_Fld44834RRef <> 0xA2277085C2A4312A11EA2AE960B0EFA4
AND _Fld44834RRef <> 0xA2277085C2A4312A11EA2AE98A2796D2) AND _Period = '5999-11-01' AND _Fld44837 > 0   
GROUP BY
	Номенклатура.naimenovanie,
	_Fld44831RRef,
	Склады.naimenovanie,
	_Fld44834RRef,
	_Fld44836RRef,
	СерииНоменклатуры.naimenovanie,
	СерииНоменклатуры.data_proizvodstva,
	СерииНоменклатуры.goden_do