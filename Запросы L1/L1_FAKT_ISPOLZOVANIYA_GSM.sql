SELECT fig.organizatsiya as ORGANIZATSIYA
      ,[karta_g_s_m] as [KARTA_GSM]
      ,dateadd(year,-2000,[data_ispolzovaniya]) as [DATA_ISPOLZOVANIYA]
      ,n.naimenovanie  as [TIP_GSM]
      ,[kolichestvo] as [KOLICHESTVO]
      ,[tsena] as [TSENA]
      ,[summa] as [SUMMA]
      ,[adres] as [ADRES]
	  --into [L1].[dbo].[FAKT_ISPOLZOVANIYA_GSM]
  FROM [L0].[dbo].[tab_fakt_ispolzovaniya_faktispolzovaniyagsm] tfi
  left join [L0].[dbo].[fakt_ispolzovaniya_g_s_m] fig on tfi.ssylka=fig.ssylka
  left join [L0].dbo.nomenklatura n on tfi.tip_g_s_m=n.ssylka