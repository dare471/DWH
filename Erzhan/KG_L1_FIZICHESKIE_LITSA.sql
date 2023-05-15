/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT F.[ssylka] AS GUID
,[naimenovanie] AS [NAIMENOVANIE]
,CONVERT(NVARCHAR(150),'',1) AS [DOLZHNOST]
,CONVERT(NVARCHAR(10),CASE WHEN pol=0xA8B54CC3A93B774D4AF5B55569908429 THEN 'Мужской' ELSE 'Женский' END,1) AS POL
,i_n_n AS [I_I_N]
,[MESTO_ROZHDENIYA]
  ,PARSENAME(REPLACE(naimenovanie, ' ', '.'), 1) AS [FAMILIYA]
  ,PARSENAME(REPLACE(naimenovanie, ' ', '.'), 2) AS [IMYA]
  ,CONVERT(NVARCHAR(50),(PARSENAME(REPLACE(naimenovanie, ' ', '.'), 3)),1) AS [OTCHESTVO]
  ,LEFT(PARSENAME(REPLACE(naimenovanie, ' ', '.'), 2),1)+'.' AS [INITSIALY_IMENI]
  ,[data_rozhdeniya] AS [DATA_ROZHDENIYA]
  ,'aa_kg' [SOURCE_BASE]
  FROM [L0_kg].[dbo].[fizicheskie_litsa] AS F

  WHERE 1=1
  AND [pometka_udaleniya]=0