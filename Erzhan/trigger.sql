
CREATE TRIGGER [dbo].[RA2Newsletter] 
   ON  [CRM_DWH].[dbo].CRM_SEMENA_CHECK
   AFTER INSERT
 AS
    declare
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
	@NEOTGRUZHENO NUMERIC(15,3),
	@STOK_21 NUMERIC(15,6),
	@STOK_22 NUMERIC(15,6),
	@POSTUPLENIE_21 NUMERIC(15,6),
	@POSTUPLENIE_22 NUMERIC(15,6)
set @nomenklatura_guid = (	SELECT [nomenklatura_guid] from inserted)
      set @direksiya=(select [direksiya]from inserted)
      set @KOMPANIA  = ( select [Компании]from inserted)
      set @KULTURA= (	SELECT [Культура]from inserted)
      set @REGION= (	SELECT [Регион]from inserted)
     set @NAME_NOMEN= (	SELECT [Название продукта]from inserted)
      set @TEXNOLOGIA= (	SELECT [Технология]from inserted)
     set @POTVERZHDENIE= (	SELECT [Подтверждение]from inserted)
     set @PRODANA= (	SELECT [Продано]from inserted)
     set @OTGRUZHENO= (	SELECT [Отгружено]from inserted)
     set @NEOTGRUZHENO = (	SELECT [Не отгружено]from inserted)
    set @STOK_21 = (	SELECT [Стоки 2021]from inserted)
    set @STOK_22 = (	SELECT [Стоки 2022]from inserted)
set @POSTUPLENIE_21= (	SELECT [Поступление_2021]from inserted)
set @POSTUPLENIE_22= (	SELECT [Поступление_2022]from inserted)

IF  EXISTS(SELECT * FROM [CRM_DWH].[dbo].[CRM_SEMENA] WHERE [nomenklatura_guid] = @nomenklatura_guid and [direksiya] = @direksiya)
BEGIN
UPDATE [CRM_DWH].[dbo].[CRM_SEMENA] 
SET [Продано]= @PRODANA 
	,[Отгружено]=@OTGRUZHENO 
	,[Стоки 2021]=@STOK_21
	,[Стоки 2022]=@STOK_22
	,[Поступление_2021]=@POSTUPLENIE_21
	,[Поступление_2022]=@POSTUPLENIE_22

END
ELSE INSERT INTO [CRM_DWH].[dbo].[CRM_SEMENA] (
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
	  ,[Не отгружено]
      ,[Стоки 2021]
      ,[Стоки 2022]
      ,[Поступление 2021]
      ,[Поступление 2022])
	  VALUES (@nomenklatura_guid,@direksiya,@KOMPANIA,@KULTURA,@REGION,@NAME_NOMEN,@TEXNOLOGIA,@POTVERZHDENIE,@PRODANA,@OTGRUZHENO,@NEOTGRUZHENO,@STOK_21,@STOK_22,@POSTUPLENIE_21,@POSTUPLENIE_22)
--BEGIN
----    SET NOCOUNT ON;

----    -- Insert statements for trigger here
--EXEC INSERT_2_SEMENA_TEST
-- @inomenklatura_guid=@nomenklatura_guid, 
--    @idireksiya=@direksiya, 
--	@iKOMPANIA=@KOMPANIA ,
--	@iKULTURA=@KULTURA ,
--	@iREGION =@REGION ,
--	@iNAME_NOMEN =@NAME_NOMEN ,
--	@iTEXNOLOGIA =@TEXNOLOGIA ,
--	@iPOTVERZHDENIE =@POTVERZHDENIE , 
--    @iPRODANA =@PRODANA , 
--    @iOTGRUZHENO =@OTGRUZHENO ,
--	--@NEOTGRUZHENO ,
--	@iSTOK_21 =@STOK_21 ,
--	@iPOSTUPLENIE =@POSTUPLENIE 
----END


--@nomenklatura_guid=@inomenklatura_guid,
--@direksiya=@idireksiya,
--@KOMPANIA =@iKOMPANIA,
--@KULTURA =@iKULTURA,
--@REGION =@iREGION ,
--@NAME_NOMEN =@iNAME_NOMEN ,
--@TEXNOLOGIA =@iTEXNOLOGIA ,
--@POTVERZHDENIE =@iPOTVERZHDENIE ,
--@PRODANA =@iPRODANA ,
--@OTGRUZHENO =@iOTGRUZHENO ,
--	--@NEOTGRUZHENO ,
--@STOK_21 =@iSTOK_21 ,
--@POSTUPLENIE =@iPOSTUPLENIE 
