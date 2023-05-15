/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
create procedure CRM_DWH.INSERT_2_SEMENA_TEST 
	@nomenklatura_guid binary(16), 
    @direksiya binary(16), 
	@KOMPANIA NVARCHAR(150),
	@KULTURA NVARCHAR(50),
	@REGION NVARCHAR(50),
	@NAME_NOMEN NVARCHAR(100),
	@TEXNOLOGIA NVARCHAR(25),
	@POTVERZHDENIE INT, 
    @PRODANA NUMERIC(15,3), 
    @OTGRUZHENO NUMERIC(15,3),
	@STOK_21 NUMERIC(15,6),
	@POSTUPLENIE NUMERIC(15,6)
AS 

SELECT nomenklatura_guid = @nomenklatura_guid 
	  ,direksiya=@direksiya
      ,[Компании]=@KOMPANIA
      ,[Культура]=@KULTURA
      ,[Регион]=@REGION
      ,[Название продукта]=@NAME_NOMEN
      ,[Технология]=@TEXNOLOGIA
      ,[Подтверждение]=@POSTUPLENIE
      ,[Продано]=@PRODANA
      ,[Отгружено]=@OTGRUZHENO
      ,[Стоки 2021]=@STOK_21
      ,[Поступление]=@POSTUPLENIE
  FROM [CRM_DWH].[dbo].[SEMENA_TEST]
  --WHERE nomenklatura_guid=0x80D3000C2910767B11E5D601F1411D64 AND direksiya=0xA21F7085C2A4312A11E9F3E80BE8C7D2
  
--IF EXISTS (SELECT nomenklatura_guid FROM [CRM_DWH].[dbo].[2_SEMENA_TEST] WHERE nomenklatura_guid = @nomenklatura_guid )
--BEGIN
--UPDATE [CRM_DWH].[dbo].[2_SEMENA_TEST] 
--SET [Продано]= @PRODANA 
--,[Отгружено]=@OTGRUZHENO 
--,[Стоки 2021]=@STOK_21
--,[Поступление]=@POSTUPLENIE


--WHERE nomenklatura_guid = @nomenklatura_guid 


IF EXISTS (SELECT nomenklatura_guid,[direksiya] FROM [CRM_DWH].[dbo].[2_SEMENA_TEST] 
WHERE nomenklatura_guid <> @nomenklatura_guid 
	AND [direksiya]<>@direksiya)
BEGIN
INSERT INTO [CRM_DWH].[dbo].[2_SEMENA_TEST] (
		[nomenklatura_guid]
      ,[direksiya]
      ,[Компании]
      ,[Культура]
      ,[Регион]
      ,[Название продукта]
      ,[Технология]
      ,[Подтверждение]
      ,[Продано]
      ,[Отгружено]
      ,[Стоки 2021]
      ,[Поступление])
	  VALUES (@nomenklatura_guid,@direksiya,@KOMPANIA,@KULTURA,@REGION,@NAME_NOMEN,@TEXNOLOGIA,@POTVERZHDENIE,@PRODANA,@OTGRUZHENO,@STOK_21,@POSTUPLENIE)
	  
--dWHERE nomenklatura_guid = @nomenklatura_guid AND direksiya=@direksiya  
END

