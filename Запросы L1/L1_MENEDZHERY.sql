/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT [ssylka] as [guid]
      ,[naimenovanie]
      ,[podrazdelenie] as [podrazdelenie_guid]
      ,[fizicheskoe_litso] as [fizicheskoe_litso_guid]
	  ,'erp' as [source_base]
  FROM [L0].[dbo].[polzovateli]




  USE [L1]
GO
CREATE TABLE [dbo].[MENEDZHERY](
	[GUID] [binary](16) NOT NULL,
	[NAIMENOVANIE] [nvarchar](100) NOT NULL,
	[FIZICHESKIE_LITSA_GUID] [binary](16) NOT NULL,
	[PODRAZDELENIE_GUID] [binary](16) NOT NULL,
	[SOURCE_BASE] [varchar](5) NULL)