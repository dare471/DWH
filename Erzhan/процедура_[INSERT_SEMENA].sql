USE [CRM_DWH]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_SEMENA]    Script Date: 10.01.2023 9:46:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER procedure [dbo].[INSERT_SEMENA] 
AS 

BEGIN 
INSERT [CRM_DWH].[dbo].CRM_SEMENA
SELECT B.[nomenklatura_guid] [nomenklatura_guid]
      ,B.[direksiya] [direksiya]
      ,[Компании]
      ,[Культура]
      ,[Регион]
      ,[Название продукта]
      ,[Технология]
      ,0 AS [Подтверждение]
      ,[Продано]
	  ,0 AS [Остаток]
      ,[Отгружено]
      ,[Не отгружено]
      ,[Стоки 2021]
      ,[Стоки 2022]
	  ,[Стоки 2023]
      ,[Поступление_2021]
      ,[Поступление_2022]
	  ,[Поступление_2023]
FROM (

SELECT [nomenklatura_guid] [nomenklatura_guid]
      ,[direksiya] 
FROM [CRM_DWH].[dbo].CRM_SEMENA_CHECK
  EXCEPT
SELECT [nomenklatura_guid] [nomenklatura_guid]
      ,[direksiya] 
FROM [CRM_DWH].[dbo].CRM_SEMENA
)A
left join [CRM_DWH].[dbo].CRM_SEMENA_CHECK B 
	ON A.nomenklatura_guid=B.nomenklatura_guid AND A.direksiya=B.direksiya


end

--begin
--UPDATE [CRM_DWH].[dbo].[2_SEMENA_TEST] 
--SET Компании=@KOMPANIA
--	,[Поступление]=@POSTUPLENIE

--where [nomenklatura_guid] in (select [nomenklatura_guid]  from [CRM_DWH].[dbo].[SEMENA_TEST])
--		and [direksiya] in (select [direksiya]  from [CRM_DWH].[dbo].[SEMENA_TEST])
--END
