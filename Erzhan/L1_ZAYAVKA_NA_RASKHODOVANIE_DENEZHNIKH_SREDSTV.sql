/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT [ssilka] AS [GUID]
      --,[pometka_udaleniya]
      ,DATEADD(YEAR,-2000,[data]) AS [DATA]
      ,[nomer] AS NOMER
      ,[proveden] AS PROVEDEN
      ,[organizaciya] AS [ORGANIZACIYA_GUID]
      ,SZRDS.description AS [STATUS]
      ,KO.description AS [KHOZYAISTVENNAYA_OPERACIYA]
      ,[summa_dokumenta] AS [SUMMA_DOKUMENTA]
      ,[valyuta] AS [VALYUTA_GUID]
      ,[BANKOVSKII_SCHET] AS [BANKOVSKII_SCHET_GUID]
      ,[KASSA] AS [KASSA_GUID]
      ,[NAZNACHENIE_PLATEZHA]
      ,DATEADD(YEAR,-2000,[zhelatelnaya_data_platezha]) AS [ZHELATELNAYA_DATA_PLATEZHA]
      ,[kontragent] AS [KONTRAGENT_GUID]
      ,[bankovskii_schet_kontragenta] AS [BANKOVSKII_SCHET_KONTRAGENTA_GUID]
      ,[podrazdelenie] AS [PODRAZDELENIE_GUID]
      ,[kto_zayavil] AS [KTO_ZAYAVIL_GUID]
      ,[kommentarii] AS [KOMMENTARII]
      ,DATEADD(YEAR,-2000,[data_platezha]) AS [DATA_PLATEZHA]
      ,[synonym_dokument_osnovanie] AS [SYNONYM_DOKUMENT_OSNOVANIE]
      ,[DOKUMENT_OSNOVANIE] AS [DOKUMENT_OSNOVANIE_GUID]
      ,[STATYA_DVIZHENIYA_DENEZHNIKH_SREDSTV] AS [STATYA_DVIZHENIYA_DENEZHNIKH_SREDSTV_GUID]
      ,[AVTOR] AS [AVTOR_GUID]
      ,[SYNONYM_DOGOVOR]
      ,[dogovor] AS [DOGOVOR_GUID]

--INTO L1.[dbo].[ZAYAVKA_NA_RASKHODOVANIE_DENEZHNIKH_SREDSTV]

  FROM [L0].[dbo].[zayavka_na_raskhodovanie_denezhnikh_sredstv] AS ZRDS
  LEFT JOIN [L0].[dbo].statusy_zayavok_na_raskhodovanie_denezhnykh_sredstv AS SZRDS
  ON ZRDS.status=SZRDS.ssylka
  LEFT JOIN [L0].[dbo].[khozyaystvennye_operatsii] AS KO 
  ON ZRDS.khozyaistvennaya_operaciya=KO.ssylka

  WHERE [pometka_udaleniya]=0
  --AND nomer LIKE '%8534'
