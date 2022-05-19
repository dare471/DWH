SELECT
	DATEADD(YEAR, -2000, PERIOD) AS [PERIOD],
	kurs AS KURS,
	v.naimenovanie AS VALYUTA
	--into [L1].dbo.KURSY_VALYUT_ALL
FROM [L0].dbo.kursy_valyut kv 
LEFT JOIN [L0].dbo.valyuty v ON kv.valyuta = v.ssylka