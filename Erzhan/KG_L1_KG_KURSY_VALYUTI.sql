
SELECT DATEADD(YEAR,-2000,[period]) AS PERIOD
      ,[valyuta] AS VALYUTA_GUID
      ,[kurs] AS KURS
	  ,V.naimenovanie AS VALYUTA_NAIMENOVANIE

--INTO L1.DBO.KG_KURSY_VALYUTI

  FROM [L0_kg].[dbo].[kursy_valyut] AS KV
  LEFT JOIN [L0_kg].[dbo].valyuty V
	ON KV.valyuta=V.ssylka