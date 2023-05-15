/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT DATEADD(YEAR,-2000,[period])[PERIOD]
      ,[synonym_registrator] AS [SYNONYM_REGISTRATOR]
      ,[registrator] AS [REGISTRATOR_GUID]
      ,[osnovnoe_sredstvo] AS [OBEKTY_EKSPLUATATSII_GUID]
      ,[organizatsiya] AS  [ORGANIZATSIYA_GUID]
      ,[sostoyanie] AS  [SOSTOYANI_GUID]
      
--INTO [L1].[dbo].[SOSTOYANIYA_OS_ORGANIZATSIY]
  FROM [L0].[dbo].[sostoyaniya_o_s_organizatsiy]