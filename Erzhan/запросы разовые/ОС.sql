WITH MAX_KOI AS(
SELECT MAX([period]) AS [period]
		,MAX(MOS.m_o_l) AS m_o_l
		,MAX(mestonakhozhdenie) AS mestonakhozhdenie
      ,[osnovnoe_sredstvo]
FROM [L0].[dbo].[mestonakhozhdenie_o_s_bukhgalterskiy_uchet] MOS 
--WHERE MOS.osnovnoe_sredstvo=0x80D500155D01C90111E7E084D6C4B877
GROUP BY [osnovnoe_sredstvo]
)

SELECT distinct dateadd(year,-2000,Mk.[period]) as [period]
      ,[synonym_registrator]
      ,[aktivnost]
	  ,mk.osnovnoe_sredstvo
	  ,mk.m_o_l
      ,[organizatsiya]
      ,mk.[mestonakhozhdenie]
      ,[adres_mestonakhozhdeniya]
      ,[oblast_dannykh_osnovnye_dannye]
	  ,FL.NAIMENOVANIE
	  ,OE.NAIMENOVANIE
	  ,SP.NAIMENOVANIE
	  ,OE.INVENTARNYY_NOMER
FROM MAX_KOI MK
LEFT JOIN [L0].[dbo].[mestonakhozhdenie_o_s_bukhgalterskiy_uchet] MOS
	ON MK.period=MOS.period
	AND MK.osnovnoe_sredstvo=MOS.osnovnoe_sredstvo
LEFT JOIN L1.DBO.FIZICHESKIE_LITSA FL 
	ON MK.m_o_l=FL.GUID
LEFT JOIN L1.DBO.OBEKTY_EKSPLUATATSII OE 
	ON mk.osnovnoe_sredstvo=OE.guid
LEFT JOIN L1.DBO.STRUKTURA_PREDPRIYATIYA SP 
	ON mk.mestonakhozhdenie=SP.GUID

--WHERE MK.period IS NOT NULL

	--ORDER BY FL.NAIMENOVANIE,Mk.osnovnoe_sredstvo,
	--MK.[period],OE.NAIMENOVANIE DESC