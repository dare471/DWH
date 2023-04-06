SELECT
  source_database AS Источник
 ,CAST(PERIOD AS DATE) AS Дата
 ,SCHET_KT AS СчетДт
 ,SCHET_DT AS СчетКт
 ,ORGANIZACIYA AS Организация_guid
 ,PODRAZDELENIE_KT AS ПодразделениеДт
 ,PODRAZDELENIE_DT AS ПодразделениеКт
 ,NAPRAVLENIE_DEYATELNOSTI_KT AS НаправлениеДеятельностиДт
 ,NAPRAVLENIE_DEYATELNOSTI_DT AS НаправлениеДеятельностиКт
 ,SUMMA * -1 AS Сумма
 ,VALYUTNAYA_SUMMA_KT AS ВалютнаяСумма
 ,VALYUTNAYA_SUMMA_DT AS ВалютнаяСуммаКт
 ,KOLICHESTVO_KT AS КоличествоДт
 ,KOLICHESTVO_DT AS КоличествоКт
 ,SODERZHANIE Содержание
 ,subconto_ct_1_type AS subconto_dt_1_type
 ,subconto_ct_1_guid AS subconto_dt_1_guid
 ,subconto_ct_2_type AS subconto_dt_2_type
 ,subconto_ct_2_guid AS subconto_dt_2_guid
 ,subconto_ct_3_type AS subconto_dt_3_type
 ,subconto_ct_3_guid AS subconto_dt_3_guid
 ,subconto_dt_1_type AS subconto_ct_1_type
 ,subconto_dt_1_guid AS subconto_ct_1_guid
 ,subconto_dt_2_type AS subconto_ct_2_type
 ,subconto_dt_2_guid AS subconto_ct_2_guid
 ,subconto_dt_3_type AS subconto_ct_3_type
 ,subconto_dt_3_guid AS subconto_ct_3_guid
 ,'Расход' AS Тип INTO #buh0
FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

INSERT #buh0
  SELECT
    source_database AS Источник
   ,CAST(PERIOD AS DATE) AS Дата
   ,SCHET_DT СчетДт
   ,SCHET_KT СчетКт
   ,ORGANIZACIYA AS Организация_guid
   ,PODRAZDELENIE_DT ПодразделениеДт
   ,PODRAZDELENIE_KT ПодразделениеКт
   ,NAPRAVLENIE_DEYATELNOSTI_DT НаправлениеДеятельностиДт
   ,NAPRAVLENIE_DEYATELNOSTI_KT НаправлениеДеятельностиКт
   ,SUMMA Сумма
   ,VALYUTNAYA_SUMMA_DT ВалютнаяСуммаДт
   ,VALYUTNAYA_SUMMA_KT ВалютнаяСуммаКт
   ,KOLICHESTVO_DT КоличествоДт
   ,KOLICHESTVO_KT КоличествоКт
   ,SODERZHANIE Содержание
   ,subconto_dt_1_type
   ,subconto_dt_1_guid
   ,subconto_dt_2_type
   ,subconto_dt_2_guid
   ,subconto_dt_3_type
   ,subconto_dt_3_guid
   ,subconto_ct_1_type
   ,subconto_ct_1_guid
   ,subconto_ct_2_type
   ,subconto_ct_2_guid
   ,subconto_ct_3_type
   ,subconto_ct_3_guid
   ,'Доход' AS Тип
  FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

SELECT
  Дата
 ,Источник
 ,СчетДт AS СчетДт
 ,СчетКт AS СчетКт
 ,Организация_guid
 ,Сумма
 ,CASE
    WHEN b.subconto_dt_1_type IN ('Контрагенты', 'ФизическиеЛица') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN ('Контрагенты', 'ФизическиеЛица') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN ('Контрагенты', 'ФизическиеЛица') THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type IN ('Контрагенты', 'ФизическиеЛица') THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type IN ('Контрагенты', 'ФизическиеЛица') THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type IN ('Контрагенты', 'ФизическиеЛица') THEN subconto_ct_3_guid
  END AS Контрагенты_guid
 ,CASE
    WHEN b.subconto_dt_1_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_ct_3_guid
  END AS Статьи_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'Номенклатура' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'Номенклатура' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'Номенклатура' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'Номенклатура' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'Номенклатура' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'Номенклатура' THEN subconto_ct_3_guid
  END AS Номенклатура_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_ct_3_guid
  END AS СтатьиДДС_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ГруппыФинансовогоУчетаНоменклатуры' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ГруппыФинансовогоУчетаНоменклатуры' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ГруппыФинансовогоУчетаНоменклатуры' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'ГруппыФинансовогоУчетаНоменклатуры' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'ГруппыФинансовогоУчетаНоменклатуры' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'ГруппыФинансовогоУчетаНоменклатуры' THEN subconto_ct_3_guid
  END AS ГруппыФинансовогоУчетаНоменклатуры_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'Склады' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'Склады' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'Склады' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'Склады' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'Склады' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'Склады' THEN subconto_ct_3_guid
  END AS Склады_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'Кассы' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'Кассы' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'Кассы' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'Кассы' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'Кассы' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'Кассы' THEN subconto_ct_3_guid
  END AS Кассы_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ДоговорыКонтрагентов' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ДоговорыКонтрагентов' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ДоговорыКонтрагентов' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'ДоговорыКонтрагентов' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'ДоговорыКонтрагентов' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'ДоговорыКонтрагентов' THEN subconto_ct_3_guid
  END AS ДоговорыКонтрагентов_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'НематериальныеАктивы' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'НематериальныеАктивы' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'НематериальныеАктивы' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'НематериальныеАктивы' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'НематериальныеАктивы' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'НематериальныеАктивы' THEN subconto_ct_3_guid
  END AS НематериальныеАктивы_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ДоговорыКредитовИДепозитов' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ДоговорыКредитовИДепозитов' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ДоговорыКредитовИДепозитов' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'ДоговорыКредитовИДепозитов' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'ДоговорыКредитовИДепозитов' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'ДоговорыКредитовИДепозитов' THEN subconto_ct_3_guid
  END AS ДоговорыКредитовИДепозитов_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'БанковскиеСчетаОрганизаций' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'БанковскиеСчетаОрганизаций' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'БанковскиеСчетаОрганизаций' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'БанковскиеСчетаОрганизаций' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'БанковскиеСчетаОрганизаций' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'БанковскиеСчетаОрганизаций' THEN subconto_ct_3_guid
  END AS БанковскиеСчетаОрганизаций_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ОбъектыЭксплуатации' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ОбъектыЭксплуатации' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ОбъектыЭксплуатации' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'ОбъектыЭксплуатации' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'ОбъектыЭксплуатации' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'ОбъектыЭксплуатации' THEN subconto_ct_3_guid
  END AS ОбъектыЭксплуатации_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'РегистрацииВНалоговомОргане' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'РегистрацииВНалоговомОргане' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'РегистрацииВНалоговомОргане' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'РегистрацииВНалоговомОргане' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'РегистрацииВНалоговомОргане' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'РегистрацииВНалоговомОргане' THEN subconto_ct_3_guid
  END AS РегистрацииВНалоговомОргане_guid
 ,Тип
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type
 ,subconto_ct_1_type
 ,subconto_ct_2_type
 ,subconto_ct_3_type
 ,НаправлениеДеятельностиДт
 ,НаправлениеДеятельностиКт INTO #buh1
FROM #buh0 AS b

SELECT
  b.Дата
 ,b.Источник
 ,org.NAIMENOVANIE AS Организация
 ,СчетДт
 ,СчетКт
 ,b.Сумма
 ,sdds.NAIMENOVANIE AS СДДС
 ,sdds.RODITEL_0 AS СДДС_группа
 ,sdds.RODITEL_1 AS ГруппаСтатей
 ,sdds.RODITEL_2 AS ГруппаГруппыСтатей
 ,d_r.NAIMENOVANIE AS [Статьи доходов затрат]
 ,k.NAIMENOVANIE AS Контрагенты
 ,n.NAIMENOVANIE AS Номенклатура
 ,gfu.NAIMENOVANIE AS [Группа фин учета]
 ,dgvk.NAIMENOVANIE AS [Договор с контрагентом]
 ,kss.NAIMENOVANIE AS Кассы
 ,skld.NAIMENOVANIE AS Склады
 ,bso.NAIMENOVANIE AS [Банковский счёт]
 ,dkd.NAIMENOVANIE AS [Договоры кредитов и депозитов]
 ,nma.NAIMENOVANIE AS НМА
 ,oe.NAIMENOVANIE AS [Объекты Эксплуатации]
 ,rno.NAIMENOVANIE AS [Рег в налоговом органе]
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type
 ,subconto_ct_1_type
 ,subconto_ct_2_type
 ,subconto_ct_3_type
 ,Тип INTO #dds0
FROM #buh1 AS b
LEFT JOIN L1.dbo.STATI_DOKHODOV_RASKHODOV AS d_r
  ON d_r.guid = b.Статьи_guid
LEFT JOIN L1.dbo.KONTRAGENTY AS k
  ON k.guid = b.Контрагенты_guid
LEFT JOIN L1.dbo.STATI_DDS AS sdds
  ON sdds.guid = b.СтатьиДДС_guid
LEFT JOIN L1.dbo.NOMENKLATURA AS n
  ON n.guid = b.Номенклатура_guid
LEFT JOIN L1.dbo.GRUPPI_FINANSOVOGO_UCHETA_NOMENKLATURI AS gfu
  ON gfu.guid = b.ГруппыФинансовогоУчетаНоменклатуры_guid
LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV AS dgvk
  ON dgvk.guid = b.ДоговорыКонтрагентов_guid
LEFT JOIN L1.dbo.KASSI AS kss
  ON kss.ssilka = b.Кассы_guid
LEFT JOIN L1.dbo.SKLADY AS skld
  ON skld.guid = b.Склады_guid
LEFT JOIN L1.dbo.BANKOVSKIE_SCHETA_ORGANIZACII AS bso
  ON bso.guid = b.БанковскиеСчетаОрганизаций_guid
LEFT JOIN L1.dbo.DOGOVORI_KREDITOV_I_DEPOZITOV AS dkd
  ON dkd.guid = b.ДоговорыКредитовИДепозитов_guid
LEFT JOIN L1.dbo.NEMATERIALNIE_AKTIVI AS nma
  ON nma.guid = b.НематериальныеАктивы_guid
LEFT JOIN L1.dbo.OBEKTY_EKSPLUATATSII AS oe
  ON oe.guid = b.ОбъектыЭксплуатации_guid
LEFT JOIN L1.dbo.REGISTRACII_V_NALOGOVOM_ORGANE AS rno
  ON rno.guid = b.РегистрацииВНалоговомОргане_guid
LEFT JOIN L1.dbo.ORGANIZATSII AS org
  ON org.guid = b.Организация_guid
WHERE LEFT(СчетДт, 2) = '10'
AND (LEFT(СчетКт, 1) = '1'
  OR СчетКт IN ('3310', '3510'))

SELECT
  [Договор с контрагентом]
 ,SUM(Сумма) AS Сумма INTO #dds1
FROM #dds0
WHERE [Договор с контрагентом] IS NOT NULL
GROUP BY [Договор с контрагентом]

SELECT
  dog.guid
 ,dog.NAIMENOVANIE AS Договор
 ,dog.DOGOVOR_VNUTRI_GRUPPY AS ДоговорВнутриГруппы
 ,dog.DATA AS Дата
 ,dog.SOGLASOVAN
 ,k.NAIMENOVANIE AS Контрагент
 ,m.NAIMENOVANIE AS Менеджер
 ,br.DIREKSYA AS БизнесРегион
 ,sez.NAIMENOVANIE AS Сезон
 ,dog.SUMMA INTO #dogovor
FROM L1.dbo.DOGOVORY_KONTRAGENTOV AS dog
LEFT JOIN L1.[dbo].MENEDZHERY AS m
  ON m.[guid] = dog.MENEDZHER_GUID
LEFT JOIN L1.[dbo].KONTRAGENTY AS k
  ON k.[guid] = dog.KONTRAGENT_GUID
LEFT JOIN L1.dbo.SEZONY AS sez
  ON sez.guid = dog.SEZON_GUID
LEFT JOIN L1.dbo.STRUKTURA_PREDPRIYATIYA AS br
  ON br.guid = dog.STRUKTURA_PREDPRIYATIYA_GUID

SELECT
  CAST([Date] AS DATE) AS Дата
 ,CASE --создаётся связь для декады в планах
    WHEN DAY([Date]) BETWEEN 1 AND 9 THEN DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 1)
    WHEN DAY([Date]) BETWEEN 10 AND 19 THEN DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 11)
    WHEN DAY([Date]) BETWEEN 20 AND 31 THEN DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 21)
  END AS Декада
 ,o.NAIMENOVANIE AS Организация
 ,dog.Договор
  --,dog.ДоговорВнутриГруппы
 ,dog.Дата AS Дата_договора
 ,dog.Контрагент
 ,dog.Менеджер AS Менеджер
 ,dog.БизнесРегион
 ,dog.Сезон
 ,s.NAIMENOVANIE AS Склад
 ,n.NAIMENOVANIE AS Номенклатура
 --,n.ГруппаУр1
 --,n.ГруппаУр2
 ,n.KATEGORII_NOMENKLATURY_GROUP AS Категория
 ,n.PROIZVODITELI Производитель
 ,prod.KOLICHESTVO Количество
 ,prod.SUMMA_VYRUCHKI СуммаВыручки
 ,prod.SUMMA_VYRUCHKI_BEZ_NDS СуммаВыручкиБезНДС
 ,prod.STOIMOST Стоимость
 ,prod.STOIMOST_BEZ_NDS СтоимостьБезНДС
 ,prod.SUMMA_VYRUCHKI - prod.STOIMOST AS [Валовая прибыль]
 ,prod.SUMMA_VYRUCHKI_BEZ_NDS - prod.STOIMOST_BEZ_NDS AS [Валовая прибыль (без НДС)] 
 
 INTO #sales_group

FROM L1.[dbo].VYRUCHKA_I_SEBESTOIMOST_PRODAZH AS prod
LEFT JOIN #dogovor AS dog
  ON dog.guid = prod.DOGOVOR_GUID
LEFT JOIN L1.[dbo].NOMENKLATURA AS n
  ON n.GUID = prod.NOMENKLATURA_GUID
LEFT JOIN L1.[dbo].ORGANIZATSII AS o
  ON o.[guid] = prod.ORGANIZATSIYA_GUID
LEFT JOIN L1.[dbo].SKLADY AS s
  ON s.[guid] = prod.SKLAD_GUID
WHERE dog.ДоговорВнутриГруппы = 0
--WHERE dog.Контрагент NOT IN (
--'Alem Agro Trade" ТОО'
--, 'LLC Alem Agro KG (ОсОО Алем Агро Кей Джи)'
--, 'TOO "KazAgroSystems"'
--, 'ТОО "Alem Agro Holding (Алем Агро Холдинг)"'
--, 'ТОО «Алем-Агро LTD»'
--, 'ТОО "IrriTech Systems"'
--, 'ТОО "Alem Agro Trade"'
--, 'ТОО "KazAgroSystems"'
--, 'ТОО "Алем-Агро LTD"'
--, 'ТОО «Alem Agro Holding (Алем Агро Холдинг)»'
--)

SELECT
  sg.Сезон
 ,sg.Организация
 ,sg.Договор
 ,sg.Дата_договора
 ,sg.Контрагент
 ,sg.Менеджер
 ,sg.БизнесРегион
 ,dds.Сумма AS [Сумма выплат]
 ,SUM(sg.СуммаВыручки) AS Выручка
FROM #sales_group AS sg
LEFT JOIN #dds1 AS dds
  ON dds.[Договор с контрагентом] = sg.Договор
GROUP BY sg.Сезон
        ,sg.Организация
        ,sg.Договор
        ,sg.Дата_договора
        ,sg.Контрагент
        ,sg.Менеджер
        ,sg.БизнесРегион
        ,dds.Сумма

DROP TABLE #buh0
DROP TABLE #buh1
DROP TABLE #dds0
DROP TABLE #dds1
DROP TABLE #dogovor
DROP TABLE #sales_group