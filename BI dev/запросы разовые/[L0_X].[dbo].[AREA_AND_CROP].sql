/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/

SELECT 
		RIGHT('000000000000' + CAST([IIN_BIN] as varchar), 12)AS [IIN_BIN]
      ,[OBLAST]
      ,[OBL]
	  ,C.cato_Id 
      ,[RAION]
      ,[NAIMENOVANIE]
      ,[CLIENT_AA_21]
      ,[KULTURA]
      ,[PLOSHAD]
INTO [L1_X].[dbo].[AREA_AND_CROP]
  FROM [L0_X].[dbo].[AREA_AND_CROP]AAC
LEFT JOIN [L1_X].[dbo].cato C 
ON AAC.OBL=C.[group] 
AND AAC.RAION=C.name

--WHERE 1=1