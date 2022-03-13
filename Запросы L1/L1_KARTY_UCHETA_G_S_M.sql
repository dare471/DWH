with srez as 
(
	SELECT
	MAX([period] )[PERIOD]
      ,[obekt_ucheta] as OBEKTY_EKSPLUATATSII_GUID
      ,[sotrudnik] as [SOTRUDNIK_GUID]
  FROM [L0].[dbo].[OTVETSTVENNYE_LITSA_AVTOPARK] 
  GROUP BY [obekt_ucheta],[sotrudnik]
  )
  
SELECT KUG.[ssylka] as [GUID]
	  ,[SOTRUDNIK_GUID]
      ,[postavshchik] as [POSTAVSHCHIK]
      ,[nomer_karty] as [NOMER_KARTY]
      ,[organizatsiya] as [ORGANIZATSIYA_GUID]
	  ,CAST(kug.naimenovanie AS nvarchar) + '/' + CAST(FL.familiya + ' ' + FL.initsialy_imeni AS nvarchar) +'/'+CAST(K.naimenovanie AS nvarchar) AS NAME
	  --into [L1].[dbo].[KARTY_UCHETA_GSM]
  FROM srez S
  LEFT JOIN [L0].[dbo].[karty_ucheta_g_s_m] KUG ON S.OBEKTY_EKSPLUATATSII_GUID=KUG.ssylka  
  LEFT JOIN [L0].dbo.fizicheskie_litsa FL ON S.SOTRUDNIK_GUID=FL.ssylka
  LEFT JOIN [L0].dbo.kontragenty K ON KUG.postavshchik=K.ssylka
  WHERE KUG.[pometka_udaleniya]=0x00
      