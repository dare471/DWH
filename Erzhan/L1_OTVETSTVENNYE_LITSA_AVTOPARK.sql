SELECT dateadd(year,-2000,cast([period] as date))[PERIOD]
      ,[SYNONYM_OBEKT_UCHETA]
      ,[obekt_ucheta] as OBEKTY_EKSPLUATATSII_GUID
      ,[sotrudnik] as [SOTRUDNIK_GUID]
	  --into [L1].[dbo].[OTVETSTVENNYE_LITSA_AVTOPARK]
  FROM [L0].[dbo].[OTVETSTVENNYE_LITSA_AVTOPARK]