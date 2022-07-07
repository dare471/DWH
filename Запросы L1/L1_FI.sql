/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT f.[ssylka]
      ,[naimenovanie]
      ,pfl.description [pol]

      ,[f_i_o]
	  ,DATEADD(YEAR, -2000, f.data_rozhdeniya)data_rozhdeniya
  FROM [L0].[dbo].[fizicheskie_litsa] f
  left join [L0].dbo.pol_fizicheskogo_litsa pfl on f.pol=pfl.ssylka

--  CREATE TABLE [dbo].[FIZICHESKIE_LITSA](
--  [GUID] [BINARY](16) NULL,
--  [NAIMENOVANIE] [NVARCHAR](50) NULL,
--  [POL] [NVARCHAR](255) NULL,
--  [I_N_N] [NVARCHAR](12) NULL,
--  [MESTO_ROZHDENIYA] [NVARCHAR](240) NULL,
--  [FAMILIYA] [NVARCHAR](50) NULL,
--  [IMYA] [NVARCHAR](50) NULL,
--  [OTCHESTVO] [NVARCHAR](50) NULL,
--  [INITSIALY_IMENI] [NVARCHAR](10) NULL,
--  [DATA_ROZHDENIYA] [DATE] NULL,
--  [SOURCE_BASE] [VARCHAR](3) NOT NULL
--)