/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
WITH ALL_DATA AS (
SELECT --EOMONTH([period]) AS [period]
	  [period]
	  ,CASE WHEN CAST(period AS DATE)BETWEEN '2021-02-01' AND '2021-02-02' THEN '2021-01-28'
			WHEN CAST(period AS DATE)BETWEEN '2021-03-01' AND '2021-03-05' THEN '2021-02-28'
			WHEN CAST(period AS DATE)BETWEEN '2021-04-01' AND '2021-04-05' THEN '2021-03-28'
			WHEN CAST(period AS DATE)BETWEEN '2021-06-01' AND '2021-06-05' THEN '2021-05-28'
			WHEN CAST(period AS DATE)BETWEEN '2021-07-01' AND '2021-07-05' THEN '2021-06-28'
			WHEN CAST(period AS DATE)BETWEEN '2021-11-01' AND '2021-11-05' THEN '2021-10-28'
			WHEN CAST(period AS DATE)BETWEEN '2022-03-01' AND '2022-03-05' THEN '2022-02-28'
			WHEN CAST(period AS DATE)BETWEEN '2022-04-01' AND '2022-04-05' THEN '2022-03-28'
			WHEN CAST(period AS DATE) BETWEEN '2023-03-01' AND '2023-03-07' THEN '2023-02-28'
	ELSE CAST(period AS DATE) 
	END 'БОЛЕЕ_МЕНЕЕ_КОРЕКТНЫЕ_ДАТЫ'
	  ,K.NAIMENOVANIE AS 'FIZICHESKOE_LITSO'
      ,SUM(CASE WHEN SDDS.NAIMENOVANIE='Возврат заработной платы' THEN [summa]*(-1) ELSE [summa] END) AS [summa]
	  
	  ,SP.DIREKSYA
	  ,SP.NAIMENOVANIE
  FROM [L0].[dbo].[registr_buhgalterii_hozraschetnyj] AS RBX
 -- LEFT JOIN L1.dbo.FIZICHESKIE_LITSA M
	--ON M.GUID=(CASE WHEN [subconto_dt_1_type]='ФизическиеЛица' THEN [subconto_dt_1_guid]
	--				WHEN [subconto_dt_2_type]='ФизическиеЛица' THEN [subconto_dt_2_guid]
	--				WHEN [subconto_dt_3_type]='ФизическиеЛица' THEN [subconto_dt_3_guid]
	--				WHEN [subconto_ct_1_type]='ФизическиеЛица' THEN [subconto_ct_1_guid]
	--				WHEN [subconto_ct_2_type]='ФизическиеЛица' THEN [subconto_ct_2_guid]
	--				WHEN [subconto_ct_3_type]='ФизическиеЛица' THEN [subconto_ct_3_guid]
	--			END)
	LEFT JOIN L1.dbo.STATI_DDS AS SDDS
	ON SDDS.GUID=(CASE WHEN [subconto_dt_1_type]='СтатьиДвиженияДенежныхСредств' THEN [subconto_dt_1_guid]
					WHEN [subconto_dt_2_type]='СтатьиДвиженияДенежныхСредств' THEN [subconto_dt_2_guid]
					WHEN [subconto_dt_3_type]='СтатьиДвиженияДенежныхСредств' THEN [subconto_dt_3_guid]
					WHEN [subconto_ct_1_type]='СтатьиДвиженияДенежныхСредств' THEN [subconto_ct_1_guid]
					WHEN [subconto_ct_2_type]='СтатьиДвиженияДенежныхСредств' THEN [subconto_ct_2_guid]
					WHEN [subconto_ct_3_type]='СтатьиДвиженияДенежныхСредств' THEN [subconto_ct_3_guid]
				END)
  LEFT JOIN L1.dbo.KONTRAGENTY AS K
	ON K.GUID=(CASE WHEN [subconto_dt_1_type] IN ('ФизическиеЛица','Контрагенты') THEN [subconto_dt_1_guid]
					WHEN [subconto_dt_2_type] IN ('ФизическиеЛица','Контрагенты') THEN [subconto_dt_2_guid]
					WHEN [subconto_dt_3_type] IN ('ФизическиеЛица','Контрагенты') THEN [subconto_dt_3_guid]
					WHEN [subconto_ct_1_type] IN ('ФизическиеЛица','Контрагенты') THEN [subconto_ct_1_guid]
					WHEN [subconto_ct_2_type] IN ('ФизическиеЛица','Контрагенты') THEN [subconto_ct_2_guid]
					WHEN [subconto_ct_3_type] IN ('ФизическиеЛица','Контрагенты') THEN [subconto_ct_3_guid]
				END)
LEFT JOIN L1.dbo.FIZICHESKIE_LITSA  AS FL
	ON FL.NAIMENOVANIE=k.NAIMENOVANIE
LEFT JOIN L1.dbo.MENEDZHERY AS MENEDZHERY
	ON MENEDZHERY.FIZICHESKOE_LITSO_GUID=FL.GUID
LEFT JOIN L1.dbo.STRUKTURA_PREDPRIYATIYA AS SP
	ON SP.GUID=MENEDZHERY.STRUKTURA_PREDPRIYATIYA_GUID

WHERE SDDS.NAIMENOVANIE IN ('Заработная плата (заработная плата, отпускные, авансы)','Возврат заработной платы')
AND period>='2021'
--AND ISNULL(M.NAIMENOVANIE,K.NAIMENOVANIE) LIKE ('Бухар%')
--AND ISNULL(M.NAIMENOVANIE,K.NAIMENOVANIE) LIKE ('%ЛАСЫН%')
AND SP.DIREKSYA='Головной офис'
GROUP BY --EOMONTH([period])
[period]
	  ,K.NAIMENOVANIE
	  ,SP.DIREKSYA
,sp.NAIMENOVANIE
)

SELECT 
AD.FIZICHESKOE_LITSO
,AD.БОЛЕЕ_МЕНЕЕ_КОРЕКТНЫЕ_ДАТЫ
,AD.period
,AD.NAIMENOVANIE
,AD.summa
, EOMONTH(AD.БОЛЕЕ_МЕНЕЕ_КОРЕКТНЫЕ_ДАТЫ) [Kонец месяца]
,AVG(AD.summa) OVER (PARTITION BY AD.NAIMENOVANIE, EOMONTH(AD.БОЛЕЕ_МЕНЕЕ_КОРЕКТНЫЕ_ДАТЫ)) [Cредная по месяцам]
,SUM(AD.summa) OVER (PARTITION BY AD.FIZICHESKOE_LITSO, EOMONTH(AD.БОЛЕЕ_МЕНЕЕ_КОРЕКТНЫЕ_ДАТЫ)) [Сумма по месяцам]
FROM ALL_DATA AS AD

ORDER BY AD.FIZICHESKOE_LITSO,AD.period
,EOMONTH(AD.БОЛЕЕ_МЕНЕЕ_КОРЕКТНЫЕ_ДАТЫ)
