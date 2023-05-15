/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
--INSERT INTO L1.DBO.DOGOVORY_KONTRAGENTOV
SELECT 
	  
	  DK.[ssylka] AS GUID
      ,DK.[roditel] AS [OSNOVNOY_DOGOVOR]
	  ,CONVERT(NUMERIC(3,0),0,1) AS [NOMER_DOP_SOGLASHENIYA]
	  ,CONVERT(varchar(3),'',1) AS [AVTOSOGLASOVANIE]
	  ,V.naimenovanie AS [VALYUTA_VZAIMORASCHETOV]
	  ,CONVERT(VARCHAR(24),'',1) AS [STATUS_PODPISANIYA]
	  ,CASE dk.vid_dogovora
			WHEN 0x935B18F5973FA1B44DAAC1A443500EE9 THEN 'С покупателем / заказчиком'
			WHEN 0xBDCDD33AE9ABE8A64958962A37B66BCA THEN 'С поставщиком / исполнителем'
			WHEN 0xA5A5792289B17CE24F6A1FF1294DD31F THEN 'Прочее'
			ELSE 'Пустое значение'
		END AS [TIP_DOGOVORA]
	  ,CASE WHEN SDK.description IS NULL THEN 'Не определено' 
			ELSE SDK.description 
		END AS [STATUS]
      ,DK.[naimenovanie] AS [NAIMENOVANIE]
	  ,CAST(0 AS bit) AS [DOGOVOR_VNUTRI_GRUPPY]
	  ,DATEADD(YEAR, - 2000, CAST(DK.data_dogovora AS date)) AS [DATA_NACHALA_DEYSTVIYA]
	  ,CAST(DATEADD(yy, DATEDIFF(yy, 0, DK.data_dogovora) + 1, -1) AS DATE) AS [DATA_OKONCHANIYA_DEYSTVIYA]
	  ,DATEADD(YEAR, - 2000,dk.data ) AS [DATA]
      ,[nomer_dogovora] AS NOMER
	  ,0 AS [SOGLASOVAN]
      ,[organizatsiya] AS [ORGANIZATSIYA_GUID]
	  ,DK.vladelets AS [KONTRAGENT_GUID]
	  ,DK.menedzher AS [MENEDZHER_GUID]
	  ,DK.biznes_region AS [BIZNES_REGION_GUID]
	  ,0x00000000000000000000000000000000 AS [STRUKTURA_PREDPRIYATIYA_GUID]
	  ,sezon AS [SEZON_GUID]
	  ,sklad AS [SKLAD_GUID]
	  ,summa AS [SUMMA]
	  ,CONVERT(NVARCHAR(25),NULL,1) AS [PROGRAMMA_DOGOVORA]
	  ,ISNULL(SNDS.[naimenovanie],'') AS  [STAVKA_NDS]
	  ,ISNULL(SNPS.[naimenovanie],'') AS [STAVKA_NSP]
	  ,KPN.[kod] AS [VIDSTAVKI_NDS]
	  ,CASE WHEN beznalichnyy_raschet=0 THEN 'Нет'
			WHEN beznalichnyy_raschet=1 THEN 'Да'
			ELSE 'ХЗ'
		END AS [BEZNALICHNYY_RASCHET]
	  ,UO.[naimenovanie] AS [USLOVIYA_OPLATY]
	  ,'AA_KG' AS [SOURCE_BASE]
	  ,0x00000000000000000000000000000000 AS [AGENT_PARTNER_GUID]
      ,0 AS [PROTSENT_AGENTSKIKH]
      ,0 AS [SUMMA_AGENTSKIKH]
	  ,CONVERT(VARCHAR(35),'',1) AS [SPOSOB_DOSTAVKI]
      ,CONVERT(NVARCHAR(500),'',1) AS [ADRES_DOSTAVKI]
      ,CONVERT(VARCHAR(21),'',1)  AS [SOSTOYANIE]
      ,CONVERT(BINARY(1),0,1) AS [STANDARTNYE_USLOVIYA_ZAKLYUCHENIYA]
	  ,0 AS [SUMMA_KZ_TG]
--INTO [L1].[dbo].[DOGOVORY_KONTRAGENTOV_KG]
  FROM [L0_kg].[dbo].[dogovory_kontragentov]DK
  LEFT JOIN [L0].dbo.statusy_dogovorov_kontragentov AS SDK ON DK.status=SDK.ssylka
  LEFT JOIN L0_kg.DBO.kontragenty AS K
	ON DK.vladelets=K.ssylka
LEFT JOIN L0_kg.dbo.stavki_n_d_s AS SNDS
	ON SNDS.ssylka=DK.stavka_n_d_s
LEFT JOIN L0_kg.dbo.stavki_n_s_p AS SNPS
	ON SNPS.ssylka=DK.stavka_n_s_p
LEFT JOIN L0_kg.dbo.kody_postavok_n_d_s AS KPN
	ON DK.kod_postavki_n_d_s=KPN.ssylka
LEFT JOIN L0_kg.dbo.valyuty AS V 
	ON DK.valyuta_raschetov=V.ssylka
LEFT JOIN [L0_kg].[dbo].[usloviya_oplaty] AS UO
	ON DK.usloviya_oplaty=UO.[ssylka]
  WHERE DK.pometka_udaleniya=0
  --AND DK.ssylka=0xAF99D4F5EF10792511EDCD32E8C71B45
  ORDER BY DK.ssylka

