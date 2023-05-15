/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT 
		[LVL1]+'-'+[LVL2] AS [CADASTR_Id]
      ,[LVL1]
      ,[LVL2]
      ,[NAIMENOVANIE]
--INTO [L1_X].[dbo].[CADASTR_CATO]
FROM [L0_X].[dbo].[CADASTR_CATO]
