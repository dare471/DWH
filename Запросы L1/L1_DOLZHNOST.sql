/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT [ssylka] as [guid]
      ,[naimenovanie]
  FROM [L0].[dbo].[dolzhnosti] d 


  create table [L1].dbo.[DOLZHNOSTI](
  [GUID] binary (16)not null,
  [NAIMENOVANIE] nvarchar(150)null)