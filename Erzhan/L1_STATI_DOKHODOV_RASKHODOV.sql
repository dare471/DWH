/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/

SELECT [ssylka] AS GUID
      ,[naimenovanie] AS NAIMENOVANIE
  FROM [L0].[dbo].[stati_dokhodov]
UNION
SELECT [ssylka] AS GUID
      ,[naimenovanie] AS NAIMENOVANIE
  FROM [L0].[dbo].[stati_raskhodov]
