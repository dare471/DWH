

WITH ALL_ZAPROS AS (/*** движение денег***/
SELECT 
      [Период]
      ,CASE WHEN [СчетДт] IN ('1030','1010','1050','1021') THEN RBX.[Сумма] END AS [DT_SUMMA]
	  ,CASE WHEN [СчетКт] IN ('1030','1010','1050','1021') THEN RBX.[Сумма] END AS [KT_SUMMA]
      ,DK.DOGOVOR_VNUTRI_GRUPPY
	  ,o.description Организации
	  ,o.guid AS ORGANIZASIYA_guid
	  --,CASE WHEN SDDS.Наименование='Заработная плата (заработная плата, отпускные, авансы)' THEN NULL ELSE K.description END AS KONTRAGENT
	  --,SDDS.Наименование AS STATI_DDS
	  ,K.NAIMENOVANIE AS KONTRAGENT
	  ,case 
					when SDDS.Наименование='Маркетинговые расходы' then 'Маркетинговые расходы к возмещению поставщиком ПРОЕКТЫ'--Маркетинговые расходы к возмещению поставщиком ПРОЕКТЫ
					when SDDS.код IN ('00-000317','00-000318','00-000319','00-000320') and s.NAIMENOVANIE = 'Сезон 2023' then 'Оплата поставщикам сезона 2023 года'--Оплата поставщикам сезона 2023 года
					when SDDS.код IN ('00-000317','00-000318','00-000319','00-000320') and s.NAIMENOVANIE= 'Сезон 2022' then 'Оплата поставщикам сезона 2022 года'--Оплата поставщикам сезона 2022 года
					when SDDS.код IN ('00-000317','00-000318','00-000319','00-000320') AND s.NAIMENOVANIE= 'Сезон 2021' then 'Оплата поставщикам сезона 2021 года'--Оплата поставщикам сезона 2021 года
					when SDDS.код IN ('00-000317','00-000318','00-000319','00-000320') AND s.NAIMENOVANIE= 'Сезон 2020' then 'Оплата поставщикам сезона 2020 года'--Оплата поставщикам сезона 2020 года
					when SDDS.код IN ('00-000317','00-000318','00-000319','00-000320') and (s.NAIMENOVANIE not in('Сезон 2023','Сезон 2022','Сезон 2021','Сезон 2020')) then 'Оплата поставщикам сезона 2019 года и ранее'--Оплата поставщикам сезона 2019 года и ранее
					when SDDS.код IN ('00-000317','00-000318','00-000319','00-000320') and S.NAIMENOVANIE IS NULL then 'Оплата поставщикам Без договора'--Оплата поставщикам Без договора
					
					when SDDS.код IN ('00-000290','УТ-000005') and  S.NAIMENOVANIE IS NULL then 'Поступления Без договора'--Оплата поставщикам Без договора
					when SDDS.код IN ('00-000290','УТ-000005') and s.NAIMENOVANIE = 'Сезон 2023' then 'Поступления сезона 2023 года' --Поступления сезона 2023 года
					when SDDS.код IN ('00-000290','УТ-000005') and s.NAIMENOVANIE = 'Сезон 2022' then 'Поступления сезона 2022 года' --Поступления сезона 2022 года
					when SDDS.код IN ('00-000290','УТ-000005') and s.NAIMENOVANIE = 'Сезон 2021' then 'Поступления сезона 2021 года' --Поступления сезона 2021 года
					when SDDS.код IN ('00-000290','УТ-000005') and s.NAIMENOVANIE = 'Сезон 2020' then 'Поступления сезона 2020 года'--Поступления сезона 2020 года
					when SDDS.код IN ('00-000290','УТ-000005') and (s.NAIMENOVANIE not IN ('Сезон 2020','Сезон 2021','Сезон 2022','Сезон 2023') ) then 'Поступления просроченной задолженности прошлых лет'--Поступления просроченной задолженности прошлых лет
					when SDDS.[Наименование] LIKE '_OLD_%' THEN Stuff(SDDS.[Наименование],1,5,'') 
					WHEN SDDS.Наименование='Приобретение ОС (здания и соотружения)' THEN 'Приобретение ОС (здания и сооружения)'
				else SDDS.Наименование
				end as STATI_DDS
	  ,DK.NAIMENOVANIE AS DOGOVOR
  FROM [AA_DWH].[dbo].[РегистрБухгалтерии.Хозрасчетный] RBX
  left join AA_DWH.dbo.Организации o 
	on o.guid=RBX.Организация
LEFT JOIN AA_DWH.dbo.Статьи_ДДС AS sdds ON sdds.guid = CASE
    WHEN RBX.subconto_dt_1_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
    WHEN RBX.subconto_dt_2_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
    WHEN RBX.subconto_dt_3_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid
    WHEN RBX.subconto_ct_1_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
    WHEN RBX.subconto_ct_2_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
    WHEN RBX.subconto_ct_3_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
  END
LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV DK  ON DK.guid = CASE
    WHEN RBX.subconto_dt_1_type = 'ДоговорыКонтрагентов' THEN subconto_dt_1_guid
    WHEN RBX.subconto_dt_2_type = 'ДоговорыКонтрагентов' THEN subconto_dt_2_guid
    WHEN RBX.subconto_dt_3_type = 'ДоговорыКонтрагентов' THEN subconto_dt_3_guid
    WHEN RBX.subconto_ct_1_type = 'ДоговорыКонтрагентов' THEN subconto_ct_1_guid
    WHEN RBX.subconto_ct_2_type = 'ДоговорыКонтрагентов' THEN subconto_ct_2_guid
    WHEN RBX.subconto_ct_3_type = 'ДоговорыКонтрагентов' THEN subconto_ct_3_guid
  END
LEFT JOIN L1.DBO.KONTRAGENTY K 
	ON DK.KONTRAGENT_GUID=K.GUID
LEFT JOIN L1.DBO.SEZONY S 
	ON DK.SEZON_GUID=S.GUID
  WHERE 1=1
  AND CAST(Период AS DATE)>='2022-01-01'
  AND (RBX.СчетДт in ('1030','1010') OR RBX.СчетКт in('1030','1010'))
  AND O.guid IN (0x80DE000C29E67B2E11E636A5C3C5D8AE,     -----ORGANIZATSIA GUID
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								)

)

, AILAR AS (/*** МЕСЯЦЫ  ДЛЯ ДОБАВЛЕНИЕ 0,01 В ЗНАЧЕНИЕ СУММЫ И СТАТЬЯ ДДС***/

SELECT DISTINCT /***  ***/
DATEADD(DAY,1,EOMONTH(AZ.Период,-1))Период
FROM ALL_ZAPROS AS AZ 
)

,DOBAVLENIE_0 AS (/***  ЭТО НУЖНО ДЛЯ ВЫЧИТАНИЕ, ЧТОБЫ У НАС ПОЛУЧИЛОСЬ МИНУСЫ В Финансовая И Инвестиционная деятельность ***/
				SELECT 
					A.Период
					,ISNULL(DA.STATI_DDS,'Поступление выручки от реализации активов') AS СтатьяБюджета_guid
					,ISNULL(DA.DT_SUMMA,0.01)Дт
					,ISNULL(DA.KT_SUMMA,0.00)Кт
				FROM AILAR A
				LEFT JOIN (
							 SELECT  DATEADD(DAY,1,EOMONTH(AZ.Период,-1))Период
							 ,AZ.STATI_DDS
							 ,AZ.DT_SUMMA
							 ,AZ.KT_SUMMA
							 FROM ALL_ZAPROS AZ
							 WHERE AZ.STATI_DDS= 'Поступление выручки от реализации активов'
						 )AS DA 
					ON A.Период=DA.Период
				WHERE DA.STATI_DDS IS NULL 

	UNION ALL

				SELECT 
					A.Период
					,ISNULL(FIN.STATI_DDS,'Возврат нам кредитов и займов (сотрудники)') AS СтатьяБюджета_guid
					,ISNULL(FIN.DT_SUMMA,0.01)Дт
					,ISNULL(FIN.KT_SUMMA,0.00)Кт
				FROM AILAR A
				LEFT JOIN (
							 SELECT  DATEADD(DAY,1,EOMONTH(AZ.Период,-1))Период
							 ,AZ.STATI_DDS
							 ,AZ.DT_SUMMA
							 ,AZ.KT_SUMMA
							 FROM ALL_ZAPROS AZ
							 WHERE AZ.STATI_DDS IN ('Получение нами кредитов и займов (сторонние организации)'
																,'Возврат нам кредитов и займов (сторонние организации)'
																,'Возврат нам кредитов и займов (сотрудники)'
													,'Поступление взносов в уставный капитал'
													) )AS FIN 
					ON A.Период=FIN.Период
				WHERE FIN.STATI_DDS IS NULL 
)


SELECT 
*
FROM (
SELECT 
  ALL_ZAPROS.DOGOVOR
  ,ALL_ZAPROS.DOGOVOR_VNUTRI_GRUPPY
  ,ALL_ZAPROS.DT_SUMMA
  ,ALL_ZAPROS.KT_SUMMA
  ,ALL_ZAPROS.KONTRAGENT
  ,CONVERT(NVARCHAR(50),ALL_ZAPROS.ORGANIZASIYA_guid,1) AS ORGANIZASIYA_guid
  ,ALL_ZAPROS.Организации
  ,ALL_ZAPROS.STATI_DDS
  ,ALL_ZAPROS.Период
  FROM ALL_ZAPROS

UNION ALL

SELECT
	NULL AS DOGOVOR
  ,0 AS DOGOVOR_VNUTRI_GRUPPY
  ,DOBAVLENIE_0.Дт AS DT_SUMMA
  ,DOBAVLENIE_0.Кт AS KT_SUMMA
  ,NULL AS KONTRAGENT
  ,NULL AS ORGANIZASIYA_guid
  ,NULL AS Организации
  ,DOBAVLENIE_0.СтатьяБюджета_guid AS STATI_DDS
  ,DOBAVLENIE_0.Период
FROM DOBAVLENIE_0
) AS ALL_ZAPROS



  LEFT JOIN L1_X.DBO.FIN_REFERENCE_DDS FRD
	ON FRD.DDS=ALL_ZAPROS.STATI_DDS

WHERE 1=1
--AND FRD.PARENT_1= 'Поступления сезона 2022 года'

ORDER BY Период
		,FRD.PARENT_1
