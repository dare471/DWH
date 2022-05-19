/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT TOP (1000) [nomenklatura_guid]
      ,[direksiya]
      ,[Компании]
      ,[Культура]
      ,[Регион]
      ,[Название продукта]
      ,[Технология]
      ,[Подтверждение]
      ,[Продано]
      ,[Отгружено]
      ,[Не отгружено]
      ,[Стоки 2021]
      ,[Поступление]
FROM [CRM_DWH].[dbo].[2_SEMENA_TEST]

  INSERT INTO [CRM_DWH].[dbo].[SEMENA_TEST] ([nomenklatura_guid]
      ,[direksiya]
      ,[Компании]
      ,[Культура]
      ,[Регион]
      ,[Название продукта]
      ,[Технология]
      ,[Подтверждение]
      ,[Продано]
      ,[Отгружено]
      ,[Не отгружено]
      ,[Стоки 2021]
      ,[Поступление])
  VALUES(0xAF8ED4F5EF10792511ECBA2CC466833E
  ,0xA21F7085C2A4312A11E9F3E8C74A132D
  ,'KWS','Кукуруза'
  ,'Головной офис'
  ,'Семена кукурузы гибрид КВС Нестор, 50000 зерен в п.е., протравка  Redigo M, ФАО 190'
  ,'ФАО 190'
  ,0
  ,475.000
  ,0.000
  ,475.000
  ,NULL
  ,2808.000000)



EXEC [CRM_DWH].[dbo].update_2_SEMENA_TEST @nomenklatura_guid=0x80D3000C2910767B11E5D601F1411D55, @direksiya=0xA21F7085C2A4312A11E9F3E80BE8C7D2
, @PRODANA=120.000
,@OTGRUZHENO=0
,@STOK_21=2572
,@POSTUPLENIE=45

EXEC [CRM_DWH].[dbo].INSERT_2_SEMENA_TEST 
@inomenklatura_guid = 0x40D3000C2910767B11E5D601F1411D6
,@idireksiya=0x121F7085C2A4312A11E9F3E80BE8C7D
,@iPRODANA=120.000
,@iOTGRUZHENO=0
,@iKOMPANIA=null
,@iSTOK_21=2572
,@iPOSTUPLENIE=499
,@iKULTURA=null
,@iREGION=null
,@iNAME_NOMEN='nomenklaturagoi'
,@iTEXNOLOGIA=null
,@iPOTVERZHDENIE=null