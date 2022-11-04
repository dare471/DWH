
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
      set @KOMPANIA  = ( select [��������]from inserted)
      set @KULTURA= (	SELECT [��������]from inserted)
      set @REGION= (	SELECT [������]from inserted)
     set @NAME_NOMEN= (	SELECT [�������� ��������]from inserted)
      set @TEXNOLOGIA= (	SELECT [����������]from inserted)
     set @POTVERZHDENIE= (	SELECT [�������������]from inserted)
     set @PRODANA= (	SELECT [�������]from inserted)
     set @OTGRUZHENO= (	SELECT [���������]from inserted)
     set @NEOTGRUZHENO = (	SELECT [�� ���������]from inserted)
    set @STOK_21 = (	SELECT [����� 2021]from inserted)
    set @STOK_22 = (	SELECT [����� 2022]from inserted)
set @POSTUPLENIE_21= (	SELECT [�����������_2021]from inserted)
set @POSTUPLENIE_22= (	SELECT [�����������_2022]from inserted)

IF  EXISTS(SELECT * FROM [CRM_DWH].[dbo].[CRM_SEMENA] WHERE [nomenklatura_guid] = @nomenklatura_guid and [direksiya] = @direksiya)
BEGIN
UPDATE [CRM_DWH].[dbo].[CRM_SEMENA] 
SET [�������]= @PRODANA 
	,[���������]=@OTGRUZHENO 
	,[����� 2021]=@STOK_21
	,[����� 2022]=@STOK_22
	,[�����������_2021]=@POSTUPLENIE_21
	,[�����������_2022]=@POSTUPLENIE_22

END
ELSE INSERT INTO [CRM_DWH].[dbo].[CRM_SEMENA] (
	   [nomenklatura_guid]
      ,[direksiya]
      ,[��������]
      ,[��������]
      ,[������]
      ,[�������� ��������]
      ,[����������]
      ,[�������������]
      ,[�������]
      ,[���������]
	  ,[�� ���������]
      ,[����� 2021]
      ,[����� 2022]
      ,[����������� 2021]
      ,[����������� 2022])
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
