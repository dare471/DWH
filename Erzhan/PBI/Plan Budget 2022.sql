WITH DAXOD_RASXOD AS (
select
o.description as Организация,
--,DATEADD(yy, DATEDIFF(yy, 0, [Период]) , 0)[Период]
dateadd(day,1,EOMONTH(RBX.Период,-1)) месяц
,sum((Case when СчетКт='5710' and СчетДт in ('6010','6020','6030') then RBX.Сумма else 0 end))-sum((Case when СчетКт in('6010','6020','6030') and СчетДт='5710'then RBX.Сумма else 0 end)) as [Доход от реализации]
,sum((Case when СчетДт='5710' and СчетКт in('7010') then RBX.Сумма else 0 end))-sum((Case when СчетКт='5710' and  СчетДт in ('7010') then RBX.Сумма else 0 end)) as [Себестоимость]
,SUM((CASE WHEN СчетКт='6290'AND sdr.description IN('После сезонная скидка от поставщика (зарезервированная)','После сезонная скидка от поставщика') THEN RBX.Сумма  ELSE 0 END )) AS [После сезонная скидка от поставщика]
,SUM((CASE WHEN СчетДт LIKE '72%'AND sdr.description IN('Заработная плата','Заработная плата (премии)') THEN RBX.Сумма  ELSE 0 END )) - SUM((CASE WHEN СчетКт LIKE '72%'AND sdr.description IN('Заработная плата','Заработная плата (премии)') THEN RBX.Сумма  ELSE 0 END )) AS [Заработная плата]
,SUM((CASE WHEN СчетДт LIKE '72%'AND sdr.description='Заработная плата (бонусы)' THEN RBX.Сумма  ELSE 0 END )) - SUM((CASE WHEN СчетКт LIKE '72%'AND sdr.description='Заработная плата (бонусы)' THEN RBX.Сумма  ELSE 0 END )) AS [Заработная плата (бонусы)]

,SUM((CASE WHEN СчетДт LIKE '72%' AND sdr.description='Анализ, определение действующего вещества, испытания'THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '72%' AND sdr.description='Анализ, определение действующего вещества, испытания'THEN RBX.Сумма  ELSE 0 END )) 
+SUM((CASE WHEN СчетКт IN('1010','1030') AND SDDS.Наименование='Лабораторные исследования' THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетДт IN('1010','1030') AND SDDS.Наименование='Лабораторные исследования' THEN RBX.Сумма  ELSE 0 END )) AS [Расходы на опыты и испытания продукции]

,SUM((CASE WHEN СчетДт LIKE '72%' AND sdr.description='Амортизация 3 группы' THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '72%' AND sdr.description='Амортизация 3 группы' THEN RBX.Сумма  ELSE 0 END ))  AS [Амортизация ОС и НМА (IT)]
,SUM((CASE WHEN СчетДт LIKE '72%' AND sdr.description='Амортизация 2 группы' THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '72%' AND sdr.description='Амортизация 2 группы' THEN RBX.Сумма  ELSE 0 END ))  AS [Амортизация ОС (автопарк)]
,SUM((CASE WHEN СчетДт LIKE '72%' AND sdr.description IN ('Амортизация 1 группы','Амортизация 4 группы') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '72%' AND sdr.description IN ('Амортизация 1 группы','Амортизация 4 группы') THEN RBX.Сумма  ELSE 0 END ))  AS [Амортизация ОС и НМА (АХО)]
,SUM((CASE WHEN СчетДт LIKE '74%' AND sdr.description='Порча товара' THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '74%' AND sdr.description='Порча товара' THEN RBX.Сумма  ELSE 0 END ))  AS [Списание товаров на складе (порча, недостачи)]
,SUM((CASE WHEN СчетКт LIKE '62%' AND sdr.description='Доходы от реализации ОС и НМА' THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетДт LIKE '62%' AND sdr.description='Доходы от реализации ОС и НМА' THEN RBX.Сумма  ELSE 0 END ))  AS [Доходы от реализации ОС и НМА]
,SUM((CASE WHEN СчетКт LIKE '62%' AND sdr.description='Доходы от списания обязательств' THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетДт LIKE '62%' AND sdr.description='Доходы от списания обязательств' THEN RBX.Сумма  ELSE 0 END ))  AS [Доходы от списания обязательств]
,SUM((CASE WHEN СчетКт LIKE '62%' AND sdr.description IN ('Доходы от оприходования излишков на складах','Пересорт') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетДт  LIKE '62%' AND sdr.description IN ('Доходы от оприходования излишков на складах','Пересорт') THEN RBX.Сумма  ELSE 0 END ))
+SUM((CASE WHEN СчетКт LIKE '74%' AND sdr.description IN ('Пересорт') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетДт  LIKE '74%' AND sdr.description IN ('Пересорт') THEN RBX.Сумма  ELSE 0 END ))   AS [Доходы от оприходования излишков на складах]
,SUM((CASE WHEN СчетКт LIKE '62%' AND sdr.description IN ('Доход по штрафам, пеням, неустойкам') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетДт  LIKE '62%' AND sdr.description IN ('Доход по штрафам, пеням, неустойкам') THEN RBX.Сумма  ELSE 0 END )) AS [Доход по штрафам, пеням, неустойкам]
,SUM((CASE WHEN СчетДт LIKE '74%' AND sdr.description IN ('Себестоимость реализованных ОС и НМА') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '74%' AND sdr.description IN ('Себестоимость реализованных ОС и НМА') THEN RBX.Сумма  ELSE 0 END ))   AS [Себестоимость реализованных ОС и НМА]
,SUM((CASE WHEN СчетДт LIKE '74%' AND sdr.description IN ('Себестоимость списанных ОС и НМА','Списание при выбытии всех фиксированных активов группы НУ') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '74%' AND sdr.description IN ('Себестоимость списанных ОС и НМА','Списание при выбытии всех фиксированных активов группы НУ') THEN RBX.Сумма  ELSE 0 END ))   AS [Списание ОС и НМА]

,SUM((CASE WHEN СчетДт LIKE '62%' AND sdr.description IN ('Курсовые разницы') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт  LIKE '62%' AND sdr.description IN ('Курсовые разницы') THEN RBX.Сумма  ELSE 0 END ))
+SUM((CASE WHEN СчетДт LIKE '74%' AND sdr.description IN ('Курсовые разницы') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '74%' AND sdr.description IN ('Курсовые разницы') THEN RBX.Сумма  ELSE 0 END ))   AS [Расходы по курсовым разницам]

,SUM((CASE WHEN СчетДт LIKE '62%' AND sdr.description IN ('Расходы при конвертации валюты','Доходы при конвертации валюты') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт  LIKE '62%' AND sdr.description IN ('Расходы при конвертации валюты','Доходы при конвертации валюты') THEN RBX.Сумма  ELSE 0 END ))
+SUM((CASE WHEN СчетДт LIKE '74%' AND sdr.description IN ('Расходы при конвертации валюты','Доходы при конвертации валюты') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '74%' AND sdr.description IN ('Расходы при конвертации валюты','Доходы при конвертации валюты') THEN RBX.Сумма  ELSE 0 END ))   AS [Расходы при конвертации валюты]
,SUM((CASE WHEN СчетДт LIKE '74%' AND sdr.description IN ('Расходы по штрафам пеням неустойкам прочие') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт LIKE '74%' AND sdr.description IN ('Расходы по штрафам пеням неустойкам прочие') THEN RBX.Сумма  ELSE 0 END ))   AS [Расходы по штрафам, пеням, неустойкам]

,SUM((CASE WHEN СчетДт IN('1010','1030') AND SDDS.Наименование IN ('Компенсация расходов от поставщика') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт IN('1010','1030') AND SDDS.Наименование IN ('Компенсация расходов от поставщика') THEN RBX.Сумма  ELSE 0 END ))   AS [Возмещение расходов от поставщика]
,SUM((CASE WHEN СчетДт IN('1010','1030') AND SDDS.Наименование IN ('Доходы от реализации прочих активов') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт IN('1010','1030') AND SDDS.Наименование IN ('Доходы от реализации прочих активов') THEN RBX.Сумма  ELSE 0 END ))   AS [Доходы от реализации прочих активов]
,SUM((CASE WHEN СчетДт IN('1010','1030') AND SDDS.Наименование IN ('Услуги по агроконсалтингу') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт IN('1010','1030') AND SDDS.Наименование IN ('Услуги по агроконсалтингу') THEN RBX.Сумма  ELSE 0 END ))   AS [Услуги по агроконсалтингу]
,SUM((CASE WHEN СчетДт IN('1010','1030') AND SDDS.Наименование IN ('Страховые выплаты') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт IN('1010','1030') AND SDDS.Наименование IN ('Страховые выплаты') THEN RBX.Сумма  ELSE 0 END ))   AS [Страховые выплаты]
,SUM((CASE WHEN СчетДт IN('1010','1030') AND SDDS.Наименование IN ('Доход от сдачи в аренду имущества') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт IN('1010','1030') AND SDDS.Наименование IN ('Доход от сдачи в аренду имущества') THEN RBX.Сумма  ELSE 0 END ))   AS [Доход от сдачи в аренду имущества]
,SUM((CASE WHEN СчетДт IN('1010','1030') AND SDDS.Наименование IN ('Прочие доходы') THEN RBX.Сумма  ELSE 0 END)) - SUM((CASE WHEN СчетКт IN('1010','1030') AND SDDS.Наименование IN ('Прочие доходы') THEN RBX.Сумма  ELSE 0 END ))   AS [Прочие доходы]


--,dateadd(day,1,EOMONTH(RBX.Период,-1)) месяц

from  [AA_DWH].[dbo].[РегистрБухгалтерии.Хозрасчетный] RBX
  left join AA_DWH.dbo.Организации o on o.guid=RBX.Организация
  left join AA_DWH.dbo.СтруктураПредприятия p on p.guid=RBX.ПодразделениеДт
  left join AA_DWH.dbo.СтруктураПредприятия p2 on p2.guid=RBX.ПодразделениеКт
  left join AA_DWH.dbo.СтатьиДоходовРасходов sdr on sdr.guid=(CASE
    WHEN RBX.subconto_dt_1_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_dt_1_guid
    WHEN RBX.subconto_dt_2_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_dt_2_guid
    WHEN RBX.subconto_dt_3_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_dt_3_guid
    WHEN RBX.subconto_ct_1_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_ct_1_guid
    WHEN RBX.subconto_ct_2_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_ct_2_guid
    WHEN RBX.subconto_ct_3_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_ct_3_guid
  END)
 left join AA_DWH.dbo.Статьи_ДДС SDDS on SDDS.guid=(CASE
    WHEN RBX.subconto_dt_1_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
    WHEN RBX.subconto_dt_2_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
    WHEN RBX.subconto_dt_3_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid
    WHEN RBX.subconto_ct_1_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
    WHEN RBX.subconto_ct_2_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
    WHEN RBX.subconto_ct_3_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
  END)
  WHERE 1=1
 AND o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								)  
AND dateadd(day,1,EOMONTH(RBX.Период,-1))>'2021-12-01'
  group by 
  o.description,RBX.Организация,
--,DATEADD(yy, DATEDIFF(yy, 0, [Период]) , 0)
dateadd(day,1,EOMONTH(RBX.Период,-1))
  --order by dateadd(day,1,EOMONTH(RBX.Период,-1))

)

, DDS AS(     /**** ДВИЖЕНИЕ ДЕНЕГ ПО СЧЕТАМ '1030','1010' ***/
				SELECT
				dateadd(day,1,EOMONTH(a.Период,-1)) месяц,
				CASE WHEN a.СчетДт IN('1030','1010') THEN a.Сумма*(-1) ELSE a.Сумма END AS Сумма,
				a.СчетДт,
				a.СчетКт,
				o.description as organizasii ,
				m.Наименование AS СтатьяБюджета_guid

				FROM [AA_DWH].[dbo].[РегистрБухгалтерии.Хозрасчетный] a 
				LEFT JOIN [AA_DWH].[dbo].Организации o on a.Организация=o.guid 
				LEFT JOIN [AA_DWH].[dbo].[Статьи_ДДС] m 
					ON m.guid = (CASE
									WHEN a.subconto_dt_1_type = 'СтатьиДвиженияДенежныхСредств' THEN a.subconto_dt_1_guid
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
					   dateadd(day,1,EOMONTH(a.Период,-1))>='2022-01-01' and 
					   not(СчетДт in ('1010','1030'--,'1050','1021'
						   ) 
						   and СчетКт in ('1010','1030'--,'1050','1021'
						))

)

,ALL_ AS (

SELECT 
	DDS.месяц AS MOTH
	,SUM(DDS.Сумма) AS SUMMA
	,DDS.organizasii AS ORGANIZASII
	,DDS.СтатьяБюджета_guid AS DDS_AND_DVIZH
FROM DDS 
WHERE DDS.СтатьяБюджета_guid NOT IN ('Возврат денежных средств от поставщика',
'Возврат денежных средств подотчетником','Возврат нам кредитов и займов (сотрудники)','Возврат нам кредитов и займов (сторонние организации)','Возврат оплаты клиенту',
'Возврат оплаты клиенту','Возврат оплаты клиенту (внутригрупповые расчеты)','Возврат от поставщика','Возврат от поставщика (внутригрупповые расчеты)',
'Возврат подотчетной суммы','Выдача займа сотруднику','Выдача нами кредитов и займов (внутригрупповые расчеты)','Выдача нами кредитов и займов (сотрудники)',
'Выдача нами кредитов и займов (сторонние организации)','Выдача нами кредитов и займов (учредители)','Гарантийные взносы','НДС','НДС (ЕАЭС)','НДС (импорт)',
'Оплата поставщикам (внутригрупповые расчеты)','Оплата поставщикам (капельное орошение)','Оплата поставщикам (семена)','Оплата поставщикам (СЗР)','Оплата поставщикам (трейдинг СХП)',
'Оплата поставщикам (удобрения)','Оплата поставщику','Перечисление денежных средств на другой счет','Погашение нами кредитов и займов (сторонние организации)',
'Получение нами кредитов и займов (сторонние организации)','Поступление денежных средств из банка (в тенге)','Поступление оплаты от клиента','Поступление оплаты от клиента (внутригрупповые расчеты)',
'Поступление оплаты от клиента за продукцию','Поступление оплаты от клиента за продукцию (трейдинг)','Приобретение НМА (программное обеспечение)',
'Приобретение ОС (автотранспорт)','Приобретение ОС (компьютеры и оргтехника)','Приобретение ОС (мебель и офисное оборудование)','Приобретение ОС (прочее)',
'Прочие выплаты','Прочие выплаты сотрудникам.','Прочие поступления','Прочие поступления','Прочие расходы (трейдинг)','Сдача денежных средств в банк (в тенге)',
'Таможенные платежи','Транспортные расходы (доставка с СВХ на наш склад)','Транспортные расходы (экспорт)','Транспортные расходы Башкирия (доставка от поставщика)',
'Транспортные расходы Испания (доставка от поставщика)','Транспортные расходы Италия (доставка от поставщика)','Транспортные расходы Кыргызстан (доставка от поставщика)',
'Транспортные расходы Местные (доставка от поставщика)','Транспортные расходы Россия (доставка от поставщика)','Транспортные расходы Турция (доставка от поставщика)','Получение нами кредитов и займов (внутригрупповые расчеты)','Доход по курсовым разницам'
,'Компенсация расходов от поставщика','Конвертация валюты (поступление)','Конвертация валюты (списание)','Конвертация валюты поступление','Убыток от курсовых разниц','Выплата заработной платы',
'Возврат заработной платы','Выплата заработной платы','Заработная плата (компенсации за неиспользованный отпуск, разовые премии)','Блок Заработная плата и налоги на ФОТ',
'Заработная плата (заработная плата, отпускные, авансы)','Возврат заработной платы','Отчисления в бюджет (ОПВ, СО, ОСМС)',
'Налоги на ФОТ (СН, ИПН)',
'Заработная плата','Возврат налогов','Лабораторные исследования'
)
GROUP BY 
	DDS.месяц
	,DDS.organizasii
	,DDS.СтатьяБюджета_guid

UNION ALL

SELECT месяц AS MOTH
	,VALUE AS SUMMA
	,Организация AS ORGANIZASII
	,DVIZH_DENEG AS DDS_AND_DVIZH 
FROM ( 
		SELECT месяц,Организация,[Доход от реализации], [Себестоимость],[После сезонная скидка от поставщика],[Заработная плата],[Заработная плата (бонусы)],[Расходы на опыты и испытания продукции]
		,[Амортизация ОС и НМА (IT)],[Амортизация ОС (автопарк)],[Списание товаров на складе (порча, недостачи)],[Доходы от реализации ОС и НМА],[Доходы от списания обязательств],[Доходы от оприходования излишков на складах]
		,[Доход по штрафам, пеням, неустойкам],[Себестоимость реализованных ОС и НМА],[Списание ОС и НМА],[Расходы по курсовым разницам],[Расходы при конвертации валюты],[Расходы по штрафам, пеням, неустойкам]
		,[Возмещение расходов от поставщика],[Доходы от реализации прочих активов],[Услуги по агроконсалтингу],[Страховые выплаты],[Доход от сдачи в аренду имущества],[Прочие доходы],[Амортизация ОС и НМА (АХО)]
		FROM DAXOD_RASXOD AS DR
	) P
UNPIVOT  
	(VALUE FOR DVIZH_DENEG IN ([Доход от реализации], [Себестоимость],[После сезонная скидка от поставщика],[Заработная плата],[Заработная плата (бонусы)],[Расходы на опыты и испытания продукции]
								,[Амортизация ОС и НМА (IT)],[Амортизация ОС (автопарк)],[Списание товаров на складе (порча, недостачи)],[Доходы от реализации ОС и НМА],[Доходы от списания обязательств],[Доходы от оприходования излишков на складах]
								,[Доход по штрафам, пеням, неустойкам],[Себестоимость реализованных ОС и НМА],[Списание ОС и НМА],[Расходы по курсовым разницам],[Расходы при конвертации валюты],[Расходы по штрафам, пеням, неустойкам]
								,[Возмещение расходов от поставщика],[Доходы от реализации прочих активов],[Услуги по агроконсалтингу],[Страховые выплаты],[Доход от сдачи в аренду имущества],[Прочие доходы],[Амортизация ОС и НМА (АХО)]
								)
	) AS UNPVT

	)

SELECT
ALL_.MOTH
,ALL_.ORGANIZASII
,ALL_.SUMMA
,ALL_.DDS_AND_DVIZH
,FRDO.[PARENT_1]
,FRDO.[PARENT_2]
FROM ALL_
LEFT JOIN L1_X.DBO.FIN_REFERENCE_DDS_OPiU AS FRDO
ON ALL_.DDS_AND_DVIZH=FRDO.DDS

--WHERE ALL_.DDS_AND_DVIZH='Заработная плата'

ORDER BY ALL_.MOTH
,ALL_.DDS_AND_DVIZH
,[DDS]