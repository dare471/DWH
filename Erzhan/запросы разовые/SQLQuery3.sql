/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT [SOURCE_DATABASE]
      ,[PERIOD]
      ,[RECORDER_TYPE_SYNONYM]
      ,[RECORDER_NUMBER]
      ,[REGISTRATOR]
      ,[NOMER_STROKI]
      ,[SCHET_DT]
      ,[SCHET_KT]
      ,[ORGANIZACIYA]
      ,[VALYUTA_DT]
      ,[VALYUTA_KT]
      ,[PODRAZDELENIE_DT]
      ,[PODRAZDELENIE_KT]
      ,[NAPRAVLENIE_DEYATELNOSTI_DT]
      ,[NAPRAVLENIE_DEYATELNOSTI_KT]
      ,[SUMMA]
      ,[VALYUTNAYA_SUMMA_DT]
      ,[VALYUTNAYA_SUMMA_KT]
      ,[KOLICHESTVO_DT]
      ,[KOLICHESTVO_KT]
      ,[SUMMA_NU_DT]
      ,[SUMMA_NU_KT]
      ,[SUMMA_PR_DT]
      ,[SUMMA_PR_KT]
      ,[SUMMA_VR_DT]
      ,[SUMMA_VR_KT]
      ,[SUMMS_UU]
      ,[SUMMS_FO]
      ,[SODERZHANIE]
      ,[NE_KORREKTIROVAT_STOIMOST_FVTOMATICHESKI]
      ,[OBLASTDANNYHOSNOVNYEDANNYE]
      --,[subconto_dt_1_type]
      --,[subconto_dt_1_guid]
      --,[subconto_dt_2_type]
      --,[subconto_dt_2_guid]
      --,[subconto_dt_3_type]
      --,[subconto_dt_3_guid]
      --,[subconto_ct_1_type]
      --,[subconto_ct_1_guid]
      --,[subconto_ct_2_type]
      --,[subconto_ct_2_guid]
      --,[subconto_ct_3_type]
      --,[subconto_ct_3_guid]
	  ,[SUBCONTO_DT_1_TYPE]
	  ,CASE WHEN (CASE WHEN subconto_ct_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
						WHEN subconto_ct_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
						WHEN subconto_ct_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
						WHEN subconto_dt_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
						WHEN subconto_dt_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
						WHEN subconto_dt_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid END )=0xA23F00155D01C80911E9E8EF71D29C11
			AND [subconto_dt_1_type] IN ('Контрагенты','ФизическиеЛица') THEN NULL ELSE subconto_dt_1_guid END AS SUBCONTO_DT_1_GUID 
	  
      ,[SUBCONTO_DT_2_TYPE]
	  ,CASE WHEN (CASE WHEN subconto_ct_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
						WHEN subconto_ct_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
						WHEN subconto_ct_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
						WHEN subconto_dt_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
						WHEN subconto_dt_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
						WHEN subconto_dt_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid END )=0xA23F00155D01C80911E9E8EF71D29C11
			AND [subconto_dt_2_type] IN ('Контрагенты','ФизическиеЛица') THEN NULL ELSE subconto_dt_2_guid END AS SUBCONTO_DT_2_GUID
	  
      ,[SUBCONTO_DT_3_TYPE]
	  ,CASE WHEN (CASE WHEN subconto_ct_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
						WHEN subconto_ct_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
						WHEN subconto_ct_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
						WHEN subconto_dt_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
						WHEN subconto_dt_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
						WHEN subconto_dt_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid END )=0xA23F00155D01C80911E9E8EF71D29C11
			AND [subconto_dt_3_type] IN ('Контрагенты','ФизическиеЛица') THEN NULL ELSE subconto_dt_3_guid END AS SUBCONTO_DT_3_GUID

      ,[SUBCONTO_CT_1_TYPE]
	  ,CASE WHEN (CASE WHEN subconto_ct_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
						WHEN subconto_ct_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
						WHEN subconto_ct_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
						WHEN subconto_dt_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
						WHEN subconto_dt_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
						WHEN subconto_dt_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid END )=0xA23F00155D01C80911E9E8EF71D29C11
			AND [subconto_ct_1_type] IN ('Контрагенты','ФизическиеЛица') THEN NULL ELSE subconto_ct_1_guid END AS SUBCONTO_CT_1_GUID
		
      ,[SUBCONTO_CT_2_TYPE]
	  ,CASE WHEN (CASE WHEN subconto_ct_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
						WHEN subconto_ct_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
						WHEN subconto_ct_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
						WHEN subconto_dt_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
						WHEN subconto_dt_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
						WHEN subconto_dt_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid END )=0xA23F00155D01C80911E9E8EF71D29C11
			AND [subconto_ct_2_type] IN ('Контрагенты','ФизическиеЛица') THEN NULL ELSE subconto_ct_2_guid END AS SUBCONTO_CT_2_GUID
		
      ,[SUBCONTO_CT_3_TYPE]
	  ,CASE WHEN (CASE WHEN subconto_ct_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
						WHEN subconto_ct_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
						WHEN subconto_ct_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
						WHEN subconto_dt_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
						WHEN subconto_dt_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
						WHEN subconto_dt_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid END )=0xA23F00155D01C80911E9E8EF71D29C11
			AND [subconto_ct_3_type] IN ('Контрагенты','ФизическиеЛица') THEN NULL ELSE subconto_ct_3_guid END AS SUBCONTO_CT_3_GUID
		
      
      ,[KASPI]
--INTO [L1].[DBO].[REGISTR_BUHGALTERII_HOZRASCHETNYI]
  FROM [L0].[dbo].[registr_buhgalterii_hozraschetnyj]

--WHERE (CASE WHEN subconto_ct_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
--			WHEN subconto_ct_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
--			WHEN subconto_ct_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
--			WHEN subconto_dt_1_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
--			WHEN subconto_dt_2_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
--			WHEN subconto_dt_3_type='СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid END )=0xA23F00155D01C80911E9E8EF71D29C11

