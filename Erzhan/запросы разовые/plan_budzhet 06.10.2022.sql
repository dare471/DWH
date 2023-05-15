WITH FACT_1 AS(     /**** ДВИЖЕНИЕ ДЕНЕГ ПО СЧЕТАМ '1030','1010' ***/
				SELECT
				dateadd(day,1,EOMONTH(a.Период,-1)) месяц,
				CASE WHEN a.СчетДт IN('1030','1010') THEN a.Сумма*(-1) ELSE a.Сумма END AS Сумма,
				a.СчетДт,
				a.СчетКт,
				o.description as organizasii ,
				 /* здесь я хочу обеденить код из РегБугХоз с кодым из AA_DWH_X directoriDDS */
				case
					when m.код IN ('00-000317','00-000318','00-000319','00-000320') and s.description = 'Сезон 2023' then 'Оплата поставщикам сезона 2023 года'--Оплата поставщикам сезона 2023 года
					when m.код IN ('00-000317','00-000318','00-000319','00-000320') and s.description = 'Сезон 2022' then 'Оплата поставщикам сезона 2022 года'--Оплата поставщикам сезона 2022 года
					when m.код IN ('00-000317','00-000318','00-000319','00-000320') AND s.description = 'Сезон 2021' then 'Оплата поставщикам сезона 2021 года'--Оплата поставщикам сезона 2021 года
					when m.код IN ('00-000317','00-000318','00-000319','00-000320') AND s.description = 'Сезон 2020' then 'Оплата поставщикам сезона 2020 года'--Оплата поставщикам сезона 2020 года
					when m.код IN ('00-000317','00-000318','00-000319','00-000320') and (s.description not in('Сезон 2023','Сезон 2022','Сезон 2021','Сезон 2020')) then 'Оплата поставщикам сезона 2019 года и ранее'--Оплата поставщикам сезона 2019 года и ранее

					when m.код IN ('00-000290','00-000290') and s.description = 'Сезон 2023' then 'Поступления сезона 2023 года' --Поступления сезона 2023 года
					when m.код IN ('00-000290','00-000290') and s.description = 'Сезон 2022' then 'Поступления сезона 2022 года' --Поступления сезона 2022 года
					when m.код IN ('00-000290','00-000290') and s.description = 'Сезон 2021' then 'Поступления сезона 2021 года' --Поступления сезона 2021 года
					when m.код IN ('00-000290','00-000290') and s.description = 'Сезон 2020' then 'Поступления сезона 2020 года'--Поступления сезона 2020 года
					when m.код IN ('00-000290','00-000290') and (s.description not IN ('Сезон 2020','Сезон 2021','Сезон 2022','Сезон 2023') ) then 'Поступления просроченной задолженности прошлых лет'--Поступления просроченной задолженности прошлых лет
				else m.Наименование
				end as СтатьяБюджета_guid

				FROM [AA_DWH].[dbo].[РегистрБухгалтерии.Хозрасчетный] a 
				LEFT JOIN [AA_DWH].[dbo].Организации o on a.Организация=o.guid 
				LEFT JOIN [AA_DWH].[dbo].[Статьи_ДДС] m 
					ON m.guid = (CASE
									WHEN a.subconto_dt_1_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
									WHEN a.subconto_dt_2_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
									WHEN a.subconto_dt_3_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid
									WHEN a.subconto_ct_1_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
									WHEN a.subconto_ct_2_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
									WHEN a.subconto_ct_3_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
								  END) 
				LEFT JOIN [AA_DWH].[dbo].[ДоговорыКонтрагентов] dsp 
					ON dsp.guid=(CASE
								WHEN a.subconto_dt_1_type = 'ДоговорыКонтрагентов' THEN subconto_dt_1_guid
								WHEN a.subconto_dt_2_type = 'ДоговорыКонтрагентов' THEN subconto_dt_2_guid
								WHEN a.subconto_dt_3_type = 'ДоговорыКонтрагентов' THEN subconto_dt_3_guid
								WHEN a.subconto_ct_1_type = 'ДоговорыКонтрагентов' THEN subconto_ct_1_guid
								WHEN a.subconto_ct_2_type = 'ДоговорыКонтрагентов' THEN subconto_ct_2_guid
								WHEN a.subconto_ct_3_type = 'ДоговорыКонтрагентов' THEN subconto_ct_3_guid
							END)
				LEFT JOIN [AA_DWH].dbo.Сезоны AS s 
					ON s.guid = dsp.Сезон_guid

				where o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								) and
					   (a.СчетДт in ('1030','1010'--,'1050'
								) or a.СчетКт in('1030','1010'--,'1050'
						)) and   
					   Период>EOMONTH('01.11.2021',0) and 
					   not(СчетДт in ('1010','1030'--,'1050','1021'
						   ) 
						   and СчетКт in ('1010','1030'--,'1050','1021'
						))

)
,FACT AS(
		SELECT 
			F1.месяц
			,SUM(F1.Сумма) AS Сумма
			,F1.organizasii
			,F1.СтатьяБюджета_guid
		FROM FACT_1 F1
		GROUP BY 
		F1.месяц
		,F1.organizasii
		,F1.СтатьяБюджета_guid





	UNION ALL


		SELECT 
			[Период] AS месяц
			,sum([СальдоНаНачалоПериода]) AS Сумма
			,o.description as organizasii
			,'Сальдо на начало' СтатьяБюджета_guid
		FROM [AA_DWH].[dbo].[ИтогиПоСчетамХозрасчетный]isx  
		LEFT JOIN AA_DWH.dbo.Организации o on isx.Организация_guid=o.guid
		  WHERE o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,     -----ORGANIZATSIA GUID
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								)AND
		  isx.Счет in ('1010','1030','1050','1021')
		  and isx.[Период]<>'3999-11-01' and isx.[Период]>= '2019' --or isx.[Период]='2021-02-01'

		  group by [Период]--,o.description,isx.Счет
		  ,o.description
		 -- ORDER BY [Период]--,o.description desc

 )
 , AILAR AS (/*** МЕСЯЦЫ  ДЛЯ ДОБАВЛЕНИЕ 0,01 В ЗНАЧЕНИЕ СУММЫ И СТАТЬЯ ДДС***/
			 SELECT DISTINCT FACT.месяц
			 FROM FACT
			 WHERE FACT.месяц>='2022-01-01'
			)
,DOBAVLENIE_0 AS (/***  ЭТО НУЖНО ДЛЯ ВЫЧИТАНИЕ, ЧТОБЫ У НАС ПОЛУЧИЛОСЬ МИНУСЫ В Финансовая И Инвестиционная деятельность ***/
				SELECT 
				A.месяц
				,ISNULL(DA.СтатьяБюджета_guid,'Поступление выручки от реализации активов') AS СтатьяБюджета_guid
				,ISNULL(DA.Сумма,0.01)Сумма
				FROM AILAR A
				LEFT JOIN (
							 SELECT  FACT.месяц
							 ,FACT.СтатьяБюджета_guid
							 ,FACT.Сумма
							 FROM FACT
							 WHERE FACT.СтатьяБюджета_guid = 'Поступление выручки от реализации активов'
						 )AS DA 
					ON A.месяц=DA.месяц
				WHERE DA.СтатьяБюджета_guid IS NULL 

	UNION ALL

				SELECT 
				A.месяц
				,ISNULL(FIN.СтатьяБюджета_guid,'Возврат нам кредитов и займов (сотрудники)') AS СтатьяБюджета_guid
				,ISNULL(FIN.Сумма,0.01)Сумма
				FROM AILAR A
				LEFT JOIN (
							 SELECT  FACT.месяц
							 ,FACT.СтатьяБюджета_guid
							 ,FACT.Сумма
							 FROM FACT
							 WHERE FACT.СтатьяБюджета_guid IN ('Получение нами кредитов и займов (сторонние организации)'
																,'Возврат нам кредитов и займов (сторонние организации)'
																,'Возврат нам кредитов и займов (сотрудники)'
													,'Поступление взносов в уставный капитал'
													) )AS FIN 
					ON A.месяц=FIN.месяц
				WHERE FIN.СтатьяБюджета_guid IS NULL 
)
--,PLAN_GOI AS (/*** ПЛАН, ЕСЛИ НЕТ НУЖНО ДОБАВИТЬ **/
--			SELECT 
--			CASE WHEN codeDDS='AL-000001' THEN 'Поступления сезона 2021 года'
--				WHEN codeDDS='AL-000002' THEN 'Поступления сезона 2020 года'
--				WHEN codeDDS='AL-000003' THEN 'Поступления просроченной задолженности прошлых лет'
--				WHEN codeDDS='AL-000004' THEN 'Оплата поставщикам сезона 2021 года'
--				WHEN codeDDS='AL-000005' THEN 'Оплата поставщикам сезона 2020 года'
--				WHEN codeDDS='AL-000006' THEN 'Оплата поставщикам сезона 2019 года и ранее'
--				ELSE SD.NAIMENOVANIE 
--			END AS [codeDDS]
--				  ,sum([Value])[Value]
--				  ,dateadd(day,1,EOMONTH([planMonth],-1)) месяц
--			  FROM [AA_DWH_X].[dbo].[PlanBudzhet] AS PB
--			  LEFT JOIN L1.DBO.STATI_DDS SD 
--				ON PB.codeDDS=SD.KOD
--			--WHERE dateadd(day,1,EOMONTH([planMonth],-1)) ='2021-01-01'
--			group by CASE WHEN codeDDS='AL-000001' THEN 'Поступления сезона 2021 года'
--							WHEN codeDDS='AL-000002' THEN 'Поступления сезона 2020 года'
--							WHEN codeDDS='AL-000003' THEN 'Поступления просроченной задолженности прошлых лет'
--							WHEN codeDDS='AL-000004' THEN 'Оплата поставщикам сезона 2021 года'
--							WHEN codeDDS='AL-000005' THEN 'Оплата поставщикам сезона 2020 года'
--							WHEN codeDDS='AL-000006' THEN 'Оплата поставщикам сезона 2019 года и ранее'
--							ELSE SD.NAIMENOVANIE 
--						END
--					,dateadd(day,1,EOMONTH([planMonth],-1))
--			)




SELECT /*CASE НУЖЕН ДЛЯ СОРТИРОВКИ*/
*
,CASE WHEN PARENT_3='Поступление оплаты от клиентов, в т.ч.' THEN 1
	WHEN PARENT_3='Оплата поставщикам, в т.ч.' THEN 2
	WHEN PARENT_3='Операционные расходы, в т.ч.' THEN 3
	WHEN PARENT_3='Поступление оплаты от клиента за продукцию (трейдинг)' THEN 4
	WHEN PARENT_3='Операционные расходы (трейдинг СХП)' THEN 5
	WHEN PARENT_3='Получение займов' THEN 6
	WHEN PARENT_3='Погашение займов' THEN 7
	WHEN PARENT_3='Поступление выручки от реализации активов' THEN 8
	WHEN PARENT_3='Покупка долгосрочных активов' THEN 9
	WHEN PARENT_3='Прочие поступления' THEN 10
	WHEN PARENT_3='Прочие выплаты' THEN 11
	WHEN PARENT_3='Курсовые разницы' THEN 12
END AS NOMER_PARENT_3
FROM(
	select  F.СтатьяБюджета_guid AS СтатьяБюджета_Код
		  ,[Сумма] AS Факт
		  ,[месяц]
		  ,f.organizasii
	FROM FACT F  
UNION ALL
SELECT 
	D.СтатьяБюджета_guid
	,D.Сумма AS Факт
	,D.месяц
	,null as organizasii
FROM DOBAVLENIE_0 AS D

) FP
LEFT JOIN [L1_X].[dbo].[FIN_REFERENCE_DDS] FRD 
	ON FP.СтатьяБюджета_Код=FRD.DDS
WHERE 1=1
--AND месяц='2022-01-01'
--and FP.СтатьяБюджета_Код='Поступление оплаты от клиента за продукцию (трейдинг)'
	ORDER BY --[месяц],
	FRD.PARENT_1