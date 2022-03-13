/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT [ssylka] as [guid]
      ,[naimenovanie]
      ,[i_n_n] as [IIN_BIN]
  FROM [L0].[dbo].[organizatsii]

  create table [L1].[dbo].[ORGANIZATSII](
  [GUID] [binary](16) not null
      ,[NAIMENOVANIE]nvarchar(60)null
      ,[IIN_BIN] nvarchar(16)null
)