WITH ALL_DATA AS (
SELECT
  source_database AS Источник
 ,CAST(PERIOD AS DATE) AS Дата
 ,SCHET_DT AS Счет
  -- ,СчетКт AS СчетКт
 ,ORGANIZACIYA AS Организация_guid
 ,PODRAZDELENIE_DT
  -- ,ПодразделениеКт
 ,NAPRAVLENIE_DEYATELNOSTI_DT
  -- ,НаправлениеДеятельностиКт
 ,SUMMA AS Сумма
 ,VALYUTNAYA_SUMMA_DT
  -- ,ВалютнаяСуммаКт
 ,KOLICHESTVO_DT
  -- ,КоличествоКт
 ,SODERZHANIE
 ,subconto_dt_1_type
 ,subconto_dt_1_guid
 ,subconto_dt_2_type
 ,subconto_dt_2_guid
 ,subconto_dt_3_type
 ,subconto_dt_3_guid
  -- ,subconto_ct_1_type
  -- ,subconto_ct_1_guid
  -- ,subconto_ct_2_type
  -- ,subconto_ct_2_guid
  -- ,subconto_ct_3_type
  -- ,subconto_ct_3_guid
 ,'Дт' AS Тип 
--INTO #buh0
FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

UNION ALL

--INSERT #buh0
  SELECT
    source_database AS Источник
   ,CAST(PERIOD AS DATE) AS Дата
   ,SCHET_KT AS Счет
    --  ,СчетДт AS СчетКт
   ,ORGANIZACIYA AS Организация_guid
   ,PODRAZDELENIE_KT AS ПодразделениеДт
    --  ,ПодразделениеДт AS ПодразделениеКт
   ,NAPRAVLENIE_DEYATELNOSTI_KT AS НаправлениеДеятельностиДт
    --  ,НаправлениеДеятельностиДт AS НаправлениеДеятельностиКт
   ,SUMMA * -1 AS Сумма
   ,VALYUTNAYA_SUMMA_KT AS ВалютнаяСуммаДт
    --  ,ВалютнаяСуммаДт AS ВалютнаяСуммаКт
   ,KOLICHESTVO_KT AS КоличествоДт
    --  ,КоличествоДт AS КоличествоКт
   ,SODERZHANIE
   ,subconto_ct_1_type AS subconto_dt_1_type
   ,subconto_ct_1_guid AS subconto_dt_1_guid
   ,subconto_ct_2_type AS subconto_dt_2_type
   ,subconto_ct_2_guid AS subconto_dt_2_guid
   ,subconto_ct_3_type AS subconto_dt_3_type
   ,subconto_ct_3_guid AS subconto_dt_3_guid
    --   ,subconto_dt_1_type AS subconto_ct_1_type
    --   ,subconto_dt_1_guid AS subconto_ct_1_guid
    --   ,subconto_dt_2_type AS subconto_ct_2_type
    --   ,subconto_dt_2_guid AS subconto_ct_2_guid
    --   ,subconto_dt_3_type AS subconto_ct_3_type
    --   ,subconto_dt_3_guid AS subconto_ct_3_guid
   ,'Кт' AS Тип
  FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

  )
,ALL_DATE_2 AS (
SELECT
  Дата
 ,Источник
 ,Счет AS Счет
 ,Организация_guid
 ,Сумма
 ,CASE
    WHEN b.subconto_dt_1_type IN ('Контрагенты', 'ФизическиеЛица') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN ('Контрагенты', 'ФизическиеЛица') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN ('Контрагенты', 'ФизическиеЛица') THEN subconto_dt_3_guid
  END AS Контрагенты_guid
 ,CASE
    WHEN b.subconto_dt_1_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN ('СтатьиДоходов', 'СтатьиРасходов') THEN subconto_dt_3_guid
  END AS Статьи_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'Номенклатура' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'Номенклатура' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'Номенклатура' THEN subconto_dt_3_guid
  END AS Номенклатура_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'СтатьиДвиженияДенежныхСредств' THEN subconto_dt_3_guid
  END AS СтатьиДДС_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ГруппыФинансовогоУчетаНоменклатуры' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ГруппыФинансовогоУчетаНоменклатуры' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ГруппыФинансовогоУчетаНоменклатуры' THEN subconto_dt_3_guid
  END AS ГруппыФинансовогоУчетаНоменклатуры_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'Склады' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'Склады' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'Склады' THEN subconto_dt_3_guid
  END AS Склады_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'Кассы' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'Кассы' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'Кассы' THEN subconto_dt_3_guid
  END AS Кассы_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ДоговорыКонтрагентов' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ДоговорыКонтрагентов' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ДоговорыКонтрагентов' THEN subconto_dt_3_guid
  END AS ДоговорыКонтрагентов_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'НематериальныеАктивы' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'НематериальныеАктивы' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'НематериальныеАктивы' THEN subconto_dt_3_guid
  END AS НематериальныеАктивы_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ДоговорыКредитовИДепозитов' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ДоговорыКредитовИДепозитов' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ДоговорыКредитовИДепозитов' THEN subconto_dt_3_guid
  END AS ДоговорыКредитовИДепозитов_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'БанковскиеСчетаОрганизаций' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'БанковскиеСчетаОрганизаций' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'БанковскиеСчетаОрганизаций' THEN subconto_dt_3_guid
  END AS БанковскиеСчетаОрганизаций_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ОбъектыЭксплуатации' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ОбъектыЭксплуатации' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ОбъектыЭксплуатации' THEN subconto_dt_3_guid
  END AS ОбъектыЭксплуатации_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'РегистрацииВНалоговомОргане' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'РегистрацииВНалоговомОргане' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'РегистрацииВНалоговомОргане' THEN subconto_dt_3_guid
  END AS РегистрацииВНалоговомОргане_guid
 ,Тип
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type 
 --INTO #buh1
FROM ALL_DATA AS b
WHERE YEAR(Дата) <= YEAR(GETDATE())
)

,ALL_DATA_3 AS (

SELECT
  b.Дата
 ,b.Источник
 ,org.NAIMENOVANIE AS Организация
 ,b.Счет
 ,b.Сумма
 ,d_r.NAIMENOVANIE AS [Статьи доходов затрат]
 ,k.NAIMENOVANIE AS Контрагенты
  ,CASE k.VKHODIT_V_GRUPPU_KOMPANIY_ALEM_AGRO
    WHEN 1 THEN 'Внутренние'
    ELSE 'Внешние'
   END AS Внутригрупп
 ,sdds.NAIMENOVANIE AS СтатьиДДС
 ,n.NAIMENOVANIE AS Номенклатура
 --,gfu.NAIMENOVANIE AS [Группа фин учета]
 ,dgvk.NAIMENOVANIE AS [Договор с контрагентом]
 --,kss.NAIMENOVANIE AS Кассы
 ,skld.NAIMENOVANIE AS Склады
 ,bso.NAIMENOVANIE AS [Банковский счёт]
 ,dkd.NAIMENOVANIE AS [Договоры кредитов и депозитов]
 --,nma.NAIMENOVANIE AS НМА
 ,oe.NAIMENOVANIE AS [Объекты Эксплуатации]
 --,rno.NAIMENOVANIE AS [Рег в налоговом органе]
 ,CASE
    WHEN LEFT(Счет, 1) IN ('1', '2') THEN 'А'
    WHEN LEFT(Счет, 1) IN ('3', '4', '5') THEN 'П'
    ELSE NULL
  END AS А_П
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type 
 
 --INTO #buh2

FROM ALL_DATE_2 AS b
LEFT JOIN L1.dbo.STATI_DOKHODOV_RASKHODOV AS d_r
  ON d_r.guid = b.Статьи_guid
LEFT JOIN L1.dbo.KONTRAGENTY AS k
  ON k.guid = b.Контрагенты_guid
LEFT JOIN L1.dbo.STATI_DDS AS sdds
  ON sdds.guid = b.СтатьиДДС_guid
LEFT JOIN L1.dbo.NOMENKLATURA AS n
  ON n.GUID = b.Номенклатура_guid
--LEFT JOIN L1.dbo.ГруппыФинансовогоУчетаНоменклатуры AS gfu
--  ON gfu.guid = b.ГруппыФинансовогоУчетаНоменклатуры_guid
LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV AS dgvk
  ON dgvk.guid = b.ДоговорыКонтрагентов_guid
--LEFT JOIN L1.dbo.Кассы AS kss
--  ON kss.guid = b.Кассы_guid
LEFT JOIN L1.dbo.SKLADY AS skld
  ON skld.guid = b.Склады_guid
LEFT JOIN L0.dbo.bankovskie_scheta_organizacii AS bso
  ON bso.ssilka = b.БанковскиеСчетаОрганизаций_guid
LEFT JOIN L0.dbo.dogovori_kreditov_i_depozitov AS dkd
  ON dkd.ssilka = b.ДоговорыКредитовИДепозитов_guid
--LEFT JOIN L1.dbo.НематериальныеАктивы AS nma
--  ON nma.guid = b.НематериальныеАктивы_guid
LEFT JOIN L1.dbo.OBEKTY_EKSPLUATATSII AS oe
  ON oe.guid = b.ОбъектыЭксплуатации_guid
--LEFT JOIN L1.dbo.РегистрацииВНалоговомОргане AS rno
--  ON rno.guid = b.РегистрацииВНалоговомОргане_guid
LEFT JOIN L1.dbo.ORGANIZATSII AS org
  ON org.guid = b.Организация_guid
WHERE LEFT(Счет, 1) IN ('1', '2', '3', '4', '5')

)

SELECT
  Дата
 ,Источник
 ,Организация
  -- ,CASE
  --    WHEN Счет IN ('1210', '3510') THEN '1210-3510'
  --    WHEN Счет IN ('1710', '3310') THEN '1710-3310'
  --  ELSE Счет
  --  END AS Счет
 ,Счет
 ,CASE
    WHEN А_П = 'П' THEN -Сумма
    ELSE Сумма
  END AS Сумма
 ,[Статьи доходов затрат]
 ,Контрагенты
  ,Внутригрупп
 ,СтатьиДДС
 ,Номенклатура
 --,[Группа фин учета]
 ,[Договор с контрагентом]
 --,Кассы
 ,Склады
 ,[Банковский счёт]
 ,[Договоры кредитов и депозитов]
 --,НМА
 ,[Объекты Эксплуатации]
 --,[Рег в налоговом органе]
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type --INTO #group0
FROM ALL_DATA_3

--DROP TABLE #buh0
--DROP TABLE #buh1
--DROP TABLE #buh2
----DROP TABLE #group0