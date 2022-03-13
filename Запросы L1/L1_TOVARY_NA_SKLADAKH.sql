SELECT 
	_Fld44831RRef AS [NOMENKLATURA_GUID],
	_Fld44834RRef AS [SKLAD_GUID],
	_Fld44836RRef AS SERIYA_GUID,
	DATEADD(YEAR, -2000,�����������������.data_proizvodstva) AS DATA_PROIZVODSTVA,
	DATEADD(YEAR, -2000,�����������������.goden_do) AS GODEN_DO,
	CASE
		WHEN DATEADD(YEAR, -2000,�����������������.goden_do) < SYSDATETIME() THEN '�������'
		WHEN DATEADD(YEAR, -2000,�����������������.goden_do) > SYSDATETIME() THEN '�����'  
		END AS STATUS_GODNOSTI,
	CASE 
	WHEN DATEDIFF (dayofyear , SYSDATETIME() , DATEADD(YEAR, -2000,�����������������.goden_do) ) < 0 THEN 0
	ELSE DATEDIFF (dayofyear , SYSDATETIME() , DATEADD(YEAR, -2000,�����������������.goden_do) )
		END AS DNEY_DO_ISTECHENIYA_SROKA_GODNOSTI,
	SUM(_Fld44837) AS KOLICHESTVO,
	SUM(_Fld44838) AS K_OTGRUZKE,
	'erp' AS SOURCE_BASE
	
FROM [L0].dbo.[itogi_tovary_na_skladakh] as ����������������������
LEFT JOIN [L0].[dbo].nomenklatura AS ������������ ON ����������������������._Fld44831RRef = ������������.ssylka
LEFT JOIN [L0].[dbo].sklady AS ������ ON ����������������������._Fld44834RRef = ������.ssylka
LEFT JOIN [L0].[dbo].serii_nomenklatury AS ����������������� ON ����������������������._Fld44836RRef = �����������������.ssylka
WHERE ������������.vid_nomenklatury = 0x8D9B6427378958AD11E35283A68E63A8 AND (_Fld44834RRef <> 0xA2277085C2A4312A11EA2AE960B0EFA4
AND _Fld44834RRef <> 0xA2277085C2A4312A11EA2AE98A2796D2) AND _Period = '5999-11-01' AND _Fld44837 > 0   
GROUP BY
	������������.naimenovanie,
	_Fld44831RRef,
	������.naimenovanie,
	_Fld44834RRef,
	_Fld44836RRef,
	�����������������.naimenovanie,
	�����������������.data_proizvodstva,
	�����������������.goden_do


	CREATE TABLE [L1].[dbo].[TOVARY_NA_SKLADAKH](
	[NOMENKLATURA_GUID] [binary](16) NULL,
	[SKLAD_GUID] [binary](16) NULL,
	[SERIYA_GUID] [binary](16) NULL,
	[DATA_PROIZVODSTVA] [datetime2](0) NULL,
	[GODEN_DO] [datetime2](0) NULL,
	[STATUS_GODNOSTI] [varchar](7) NULL,
	[DNEY_DO_ISTECHENIYA_SROKA_GODNOSTI] [int] NULL,
	[KOLICHESTVO] [numeric](38, 3) NULL,
	[K_OTGRUZKE] [numeric](38, 3) NULL,
	[SOURCE_BASE] [varchar](3) NOT NULL
)