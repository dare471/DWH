/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT [nomer_stroki] AS [NOMER_STROKI]
      ,[i_d__stroki___mesta_prebyvaniya] AS [I_D__STROKI___MESTA_PREBYVANIYA]
      ,TTS.NAIMENOVANIE [TIP_TRANSPORTA]
      ,[avto] AS AVTO_GUID
	  ,OE.naimenovanie AS [AVTO_NAIMENOVANIE]
      ,DATEADD(YEAR, -2000, [data_vyezda]) AS [DATA_VYEZDA]
      ,DATEADD(YEAR, -2000, [data_pribytiya]) AS [DATA_PRIBYTIYA]
      ,[DNEY_V_PUTI]
      ,[CHASY_V_PUTI]
      ,[PUNKT_A]
      ,[PUNKT_B]
      ,[RASSTOYANIE_KM]
      ,[SUMMA_PROEZDA]
      ,[LIMIT]
      ,CASE 
		WHEN [tip_oplaty] = 0xBD0234D3C45464464E97CF39C5C81E45 THEN 'Безналичная перечисление на банковский счет'
		WHEN [tip_oplaty] = 0xBE9F9C2BA0299F784E53CE62C5ED1FDA THEN 'Наличная на карту'
		ELSE 'Наличная с кассы'
	END AS [TIP_OPLATY]
      ,[PRIMECHANIE]
      ,CASE 
		WHEN [stroka_smeny_zony] = 0x00 THEN 'Нет'
		ELSE 'Да'
	END AS [STROKA_SMENY_ZONY]
      ,[I_D__SVYAZANNOY_STROKI]
      ,[OBLAST_DANNYKH_OSNOVNYE_DANNYE]
      ,TMZ.[ssylka] AS KOMANDIROVKA_GUID

--INTO [L1].[dbo].MARSHRUT_ZAYAVKA_NA_KOMANDIROVKU

  FROM [L0].[dbo].[tab_marshrut_zayavkanakomandirovku] AS TMZ
LEFT JOIN [L0].[dbo].obekty_ekspluatatsii OE 
	ON TMZ.avto=OE.ssylka
LEFT JOIN [L0].[dbo].tipy_transportnykh_sredstv TTS
	ON TTS.ssylka=TMZ.tip_transporta
