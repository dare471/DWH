SELECT DATEADD(YEAR, -2000,[period]) AS [period]
      ,[subekt_proverki] as [subekt_proverki_kontragent_guid]
	  ,k.partner as [subekt_proverki_partner_guid]
	  ,k.naimenovanie as [subekt_proverki_naimenovanie]
      ,CAST([yavlyaetsya] AS bit) AS [yavlyaetsya]
      ,[kommentariy]
      ,CAST([problemnyy_po_kompra] AS BIT) AS [problemnyy_po_PKB]
      ,CAST([problemnyy_po_dolgam] AS bit) AS [problemnyy_po_dolgam]
      ,CAST([problemnyy_po_yu_d] AS bit) AS [problemnyy_po_yu_d]
      ,[obshchaya_summa_dolga]
	  --INTO L1.dbo.TOXIC_PULL
  FROM [L0].[dbo].[toxic_pull] tp
  left join [L0].dbo.kontragenty k on  tp.subekt_proverki=k.ssylka