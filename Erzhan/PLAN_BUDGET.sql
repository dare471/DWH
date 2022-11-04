WITH FACT AS(
				SELECT
				--s.description,
				--dsp.guid,
				--m.Наименование [СтатьяБюджета],
				dateadd(day,1,EOMONTH(a.Период,-1)) месяц,
				SUM(a.Сумма)Сумма,
				--m.[Группа0],
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

					--when m.код='00-000293' and (s.description not like '%2020%' and s.description not like '%2021%' ) then 'AL-000003'	
				else m.Наименование
				end as СтатьяБюджета_guid
					  --into #fact
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
					   Период>EOMONTH('01.11.2019',0) and 
					   not(СчетДт in ('1010','1030'--,'1050','1021'
						   ) 
						   and СчетКт in ('1010','1030'--,'1050','1021'
						))
					AND M.Наименование='Выплата штрафов, пеней неустоек'
				group by --m.Наименование ,dsp.guid,
				dateadd(day,1,EOMONTH(a.Период,-1)) ,
				 --s.description,
				 --m.[Группа0],
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

				--when m.код='00-000293' and (s.description not like '%2020%' and s.description not like '%2021%' ) then 'AL-000003'


				else m.Наименование
				end 

UNION ALL


SELECT 
	[Период] AS месяц
	,sum([СальдоНаНачалоПериода]) AS Сумма
	,'Сальдо на начало' СтатьяБюджета_guid
FROM [AA_DWH].[dbo].[ИтогиПоСчетамХозрасчетный]isx  
LEFT JOIN AA_DWH.dbo.Организации o on isx.Организация_guid=o.guid
  
  WHERE o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,
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
 -- ORDER BY [Период]--,o.description desc


),
PLAN_GOI AS (
			SELECT 
			CASE WHEN codeDDS='AL-000001' THEN 'Поступления сезона 2021 года'
				WHEN codeDDS='AL-000002' THEN 'Поступления сезона 2020 года'
				WHEN codeDDS='AL-000003' THEN 'Поступления просроченной задолженности прошлых лет'
				WHEN codeDDS='AL-000004' THEN 'Оплата поставщикам сезона 2021 года'
				WHEN codeDDS='AL-000005' THEN 'Оплата поставщикам сезона 2020 года'
				WHEN codeDDS='AL-000006' THEN 'Оплата поставщикам сезона 2019 года и ранее'
				ELSE SD.NAIMENOVANIE 
			END AS [codeDDS]
				  ,sum([Value])[Value]
				  ,dateadd(day,1,EOMONTH([planMonth],-1)) месяц
			  FROM [AA_DWH_X].[dbo].[PlanBudzhet] AS PB
			  LEFT JOIN L1.DBO.STATI_DDS SD 
				ON PB.codeDDS=SD.KOD
			--WHERE dateadd(day,1,EOMONTH([planMonth],-1)) ='2021-01-01'
			group by CASE WHEN codeDDS='AL-000001' THEN 'Поступления сезона 2021 года'
							WHEN codeDDS='AL-000002' THEN 'Поступления сезона 2020 года'
							WHEN codeDDS='AL-000003' THEN 'Поступления просроченной задолженности прошлых лет'
							WHEN codeDDS='AL-000004' THEN 'Оплата поставщикам сезона 2021 года'
							WHEN codeDDS='AL-000005' THEN 'Оплата поставщикам сезона 2020 года'
							WHEN codeDDS='AL-000006' THEN 'Оплата поставщикам сезона 2019 года и ранее'
							ELSE SD.NAIMENOVANIE 
						END
					,dateadd(day,1,EOMONTH([planMonth],-1))
			)




SELECT *
FROM(
	select  isnull(F.СтатьяБюджета_guid,p.codeDDS)СтатьяБюджета_Код
		  ,CASE WHEN F.СтатьяБюджета_guid='Сальдо на начало' THEN F.Сумма 
				ELSE P.value 
			END AS План
		  ,[Сумма] Факт
		  ,isnull(f.[месяц],P.месяц)[месяц]
	FROM PLAN_GOI AS P--f1 
	FULL JOIN FACT F  
		on (F.СтатьяБюджета_guid=P.codeDDS and F.[месяц]=P.месяц)
) FP
LEFT JOIN [L1_X].[dbo].[FIN_REFERENCE_DDS] FRD 
	ON FP.СтатьяБюджета_Код=FRD.DDS

	ORDER BY [месяц]