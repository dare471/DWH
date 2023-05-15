USE [CRM_DWH]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_SEMENA]    Script Date: 10.01.2023 9:46:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[UPDATE_SEMENA]

AS 

begin


UPDATE [CRM_DWH].[dbo].CRM_SEMENA
SET Компании = st.Компании, 
  Культура = st.Культура,
  [Регион]=st.[Регион],
  [Название продукта]=st.[Название продукта],
  [Технология]=st.[Технология],
  [Продано]=st.[Продано],
  [Отгружено]=st.[Отгружено],
  [Не отгружено]=st.[Не отгружено],
  [Стоки 2021]=st.[Стоки 2021],
  [Стоки 2022]=st.[Стоки 2022],
  [Стоки 2023]=st.[Стоки 2023],
  [Поступление_2021]=st.[Поступление_2021],
  [Поступление_2022]=st.[Поступление_2022],
  [Поступление_2023]=st.[Поступление_2023]
from [CRM_DWH].[dbo].CRM_SEMENA as st2
INNER JOIN [CRM_DWH].[dbo].CRM_SEMENA_CHECK st 
ON ST.nomenklatura_guid = st2.nomenklatura_guid 
and st.direksiya=st2.direksiya;
END
