/****** [L1].[dbo].[DOGOVORI_KREDITOV_I_DEPOZITOV] KOSASYN  ******/
SELECT [SSILKA] AS GUID
	  ,[NOMER]
      ,CONVERT(NVARCHAR(100),DKID.[NAIMENOVANIE])[NAIMENOVANIE]
      ,[ORGANIZACIYA] AS [ORGANIZACIYA_GUID]
      ,[OTVETSTVENNII] AS [OTVETSTVENNII_GUID]
      ,[PARTNER] AS [PARTNER_GUID]
	  ,'Лизинг' AS KHAREKTER_DOGOVORA
	  ,'Лизинг' AS TIP_DOGOVORA
	  ,CASE [status]
			WHEN 0x82D1CD037C7784B2447E1C9C3915309E THEN 'Не согласован'
			WHEN 0xA92F27FC8D2DBD51466ED7D8981B86F1 THEN 'Действует'
			WHEN 0xA2EA1532A615D3884BDCF62760B790DE THEN 'Отменен'
			WHEN 0xB5C5689E9B6FFBB34CBFB80BB736CAC0 THEN 'На согласовании'
			ELSE 'Закрыт'
		END AS [STATUS]
	  ,DATEADD(YEAR, -2000, data) AS DATA
      ,valyuty.naimenovanie AS [VALYUTA_VZAIMORASCHETOV]
      ,DKID.[POMETKA_UDALENIYA]

  FROM [L0].[dbo].[dogovori_lizinga]DKID
  LEFT JOIN L0.dbo.valyuty
	ON DKID.valyuta_vzaimoraschetov=valyuty.ssylka