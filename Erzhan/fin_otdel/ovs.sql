SELECT
  source_database AS »сточник
 ,CAST(PERIOD AS DATE) AS ƒата
 ,SCHET_KT AS —четƒт
 ,SCHET_DT AS —чет т
 ,ORGANIZACIYA AS ќрганизаци€_guid
 ,PODRAZDELENIE_KT AS ѕодразделениеƒт
 ,PODRAZDELENIE_DT AS ѕодразделение т
 ,NAPRAVLENIE_DEYATELNOSTI_KT AS Ќаправлениеƒе€тельностиƒт
 ,NAPRAVLENIE_DEYATELNOSTI_DT AS Ќаправлениеƒе€тельности т
 ,SUMMA * -1 AS —умма
 ,VALYUTNAYA_SUMMA_KT AS ¬алютна€—умма
 ,VALYUTNAYA_SUMMA_DT AS ¬алютна€—умма т
 ,KOLICHESTVO_KT AS  оличествоƒт
 ,KOLICHESTVO_DT AS  оличество т
 ,SODERZHANIE —одержание
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
 ,' т' AS “ип INTO #buh0
FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

INSERT #buh0
  SELECT
    source_database AS »сточник
   ,CAST(PERIOD AS DATE) AS ƒата
   ,SCHET_DT —четƒт
   ,SCHET_KT —чет т
   ,ORGANIZACIYA AS ќрганизаци€_guid
   ,PODRAZDELENIE_DT ѕодразделениеƒт
   ,PODRAZDELENIE_KT ѕодразделение т
   ,NAPRAVLENIE_DEYATELNOSTI_DT Ќаправлениеƒе€тельностиƒт
   ,NAPRAVLENIE_DEYATELNOSTI_KT Ќаправлениеƒе€тельности т
   ,SUMMA —умма
   ,VALYUTNAYA_SUMMA_DT ¬алютна€—уммаƒт
   ,VALYUTNAYA_SUMMA_KT ¬алютна€—умма т
   ,KOLICHESTVO_DT  оличествоƒт
   ,KOLICHESTVO_KT  оличество т
   ,SODERZHANIE —одержание
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
   ,'ƒт' AS “ип
  FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

SELECT
  ƒата
 ,»сточник
 ,—четƒт AS —четƒт
 ,—чет т AS —чет т
 ,ќрганизаци€_guid
 ,—умма
 ,CASE
    WHEN b.subconto_dt_1_type IN (' онтрагенты', '‘изическиеЋица') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN (' онтрагенты', '‘изическиеЋица') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN (' онтрагенты', '‘изическиеЋица') THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type IN (' онтрагенты', '‘изическиеЋица') THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type IN (' онтрагенты', '‘изическиеЋица') THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type IN (' онтрагенты', '‘изическиеЋица') THEN subconto_ct_3_guid
  END AS  онтрагенты_guid
 ,CASE
    WHEN b.subconto_dt_1_type IN ('—татьиƒоходов', '—татьи–асходов') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN ('—татьиƒоходов', '—татьи–асходов') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN ('—татьиƒоходов', '—татьи–асходов') THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type IN ('—татьиƒоходов', '—татьи–асходов') THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type IN ('—татьиƒоходов', '—татьи–асходов') THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type IN ('—татьиƒоходов', '—татьи–асходов') THEN subconto_ct_3_guid
  END AS —татьи_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'Ќоменклатура' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'Ќоменклатура' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'Ќоменклатура' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'Ќоменклатура' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'Ќоменклатура' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'Ќоменклатура' THEN subconto_ct_3_guid
  END AS Ќоменклатура_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '—татьиƒвижени€ƒенежных—редств' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '—татьиƒвижени€ƒенежных—редств' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '—татьиƒвижени€ƒенежных—редств' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '—татьиƒвижени€ƒенежных—редств' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '—татьиƒвижени€ƒенежных—редств' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '—татьиƒвижени€ƒенежных—редств' THEN subconto_ct_3_guid
  END AS —татьиƒƒ—_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '√руппы‘инансового”четаЌоменклатуры' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '√руппы‘инансового”четаЌоменклатуры' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '√руппы‘инансового”четаЌоменклатуры' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '√руппы‘инансового”четаЌоменклатуры' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '√руппы‘инансового”четаЌоменклатуры' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '√руппы‘инансового”четаЌоменклатуры' THEN subconto_ct_3_guid
  END AS √руппы‘инансового”четаЌоменклатуры_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '—клады' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '—клады' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '—клады' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '—клады' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '—клады' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '—клады' THEN subconto_ct_3_guid
  END AS —клады_guid
 ,CASE
    WHEN b.subconto_dt_1_type = ' ассы' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = ' ассы' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = ' ассы' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = ' ассы' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = ' ассы' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = ' ассы' THEN subconto_ct_3_guid
  END AS  ассы_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ƒоговоры онтрагентов' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ƒоговоры онтрагентов' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ƒоговоры онтрагентов' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'ƒоговоры онтрагентов' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'ƒоговоры онтрагентов' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'ƒоговоры онтрагентов' THEN subconto_ct_3_guid
  END AS ƒоговоры онтрагентов_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'Ќематериальныејктивы' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'Ќематериальныејктивы' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'Ќематериальныејктивы' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'Ќематериальныејктивы' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'Ќематериальныејктивы' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'Ќематериальныејктивы' THEN subconto_ct_3_guid
  END AS Ќематериальныејктивы_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ƒоговоры редитов»ƒепозитов' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ƒоговоры редитов»ƒепозитов' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ƒоговоры редитов»ƒепозитов' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'ƒоговоры редитов»ƒепозитов' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'ƒоговоры редитов»ƒепозитов' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'ƒоговоры редитов»ƒепозитов' THEN subconto_ct_3_guid
  END AS ƒоговоры редитов»ƒепозитов_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'Ѕанковские—четаќрганизаций' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'Ѕанковские—четаќрганизаций' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'Ѕанковские—четаќрганизаций' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'Ѕанковские—четаќрганизаций' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'Ѕанковские—четаќрганизаций' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'Ѕанковские—четаќрганизаций' THEN subconto_ct_3_guid
  END AS Ѕанковские—четаќрганизаций_guid
 ,CASE
    WHEN b.subconto_dt_1_type = 'ќбъектыЁксплуатации' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = 'ќбъектыЁксплуатации' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = 'ќбъектыЁксплуатации' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = 'ќбъектыЁксплуатации' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = 'ќбъектыЁксплуатации' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = 'ќбъектыЁксплуатации' THEN subconto_ct_3_guid
  END AS ќбъектыЁксплуатации_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '–егистрации¬Ќалоговомќргане' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '–егистрации¬Ќалоговомќргане' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '–егистрации¬Ќалоговомќргане' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '–егистрации¬Ќалоговомќргане' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '–егистрации¬Ќалоговомќргане' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '–егистрации¬Ќалоговомќргане' THEN subconto_ct_3_guid
  END AS –егистрации¬Ќалоговомќргане_guid
 ,“ип
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type
 ,subconto_ct_1_type
 ,subconto_ct_2_type
 ,subconto_ct_3_type
 ,Ќаправлениеƒе€тельностиƒт
 ,Ќаправлениеƒе€тельности т INTO #buh1
FROM #buh0 AS b

SELECT
  b.ƒата
 ,b.»сточник
  ,org.NAIMENOVANIE AS ќрганизаци€
 ,—четƒт
 ,—чет т
 ,b.—умма
 ,sdds.NAIMENOVANIE AS —ƒƒ—
 ,sdds.RODITEL_1 AS —ƒƒ—_группа
 ,d_r.NAIMENOVANIE AS [—татьи доходов затрат]
 ,k.NAIMENOVANIE AS  онтрагенты
 ,n.NAIMENOVANIE AS Ќоменклатура
 ,gfu.NAIMENOVANIE AS [√руппа фин учета]
 ,dgvk.NAIMENOVANIE AS [ƒоговор с контрагентом]
 ,kss.NAIMENOVANIE AS  ассы
 ,skld.NAIMENOVANIE AS —клады
 ,bso.NAIMENOVANIE AS [Ѕанковский счЄт]
 ,dkd.NAIMENOVANIE AS [ƒоговоры кредитов и депозитов]
 ,nma.NAIMENOVANIE AS Ќћј
 ,oe.NAIMENOVANIE AS [ќбъекты Ёксплуатации]
 ,rno.NAIMENOVANIE AS [–ег в налоговом органе]
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type
 ,subconto_ct_1_type
 ,subconto_ct_2_type
 ,subconto_ct_3_type
 ,“ип
-- ,Ќаправлениеƒе€тельностиƒт
-- ,Ќаправлениеƒе€тельности т
FROM #buh1 AS b
LEFT JOIN L1.dbo.STATI_DOKHODOV_RASKHODOV AS d_r
  ON d_r.guid = b.—татьи_guid
LEFT JOIN L1.dbo.KONTRAGENTY AS k
  ON k.guid = b. онтрагенты_guid
LEFT JOIN L1.dbo.STATI_DDS AS sdds
  ON sdds.guid = b.—татьиƒƒ—_guid
LEFT JOIN L1.dbo.NOMENKLATURA AS n
  ON n.guid = b.Ќоменклатура_guid
LEFT JOIN L1.dbo.GRUPPI_FINANSOVOGO_UCHETA_NOMENKLATURI AS gfu
  ON gfu.guid = b.√руппы‘инансового”четаЌоменклатуры_guid
LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV AS dgvk
  ON dgvk.guid = b.ƒоговоры онтрагентов_guid
LEFT JOIN L1.dbo.KASSI AS kss
  ON kss.GUID = b. ассы_guid
LEFT JOIN L1.dbo.SKLADY AS skld
  ON skld.guid = b.—клады_guid
LEFT JOIN L1.dbo.BANKOVSKIE_SCHETA_ORGANIZACII AS bso
  ON bso.guid = b.Ѕанковские—четаќрганизаций_guid
LEFT JOIN L1.dbo.DOGOVORI_KREDITOV_I_DEPOZITOV AS dkd
  ON dkd.guid = b.ƒоговоры редитов»ƒепозитов_guid
LEFT JOIN L1.dbo.NEMATERIALNIE_AKTIVI AS nma
  ON nma.guid = b.Ќематериальныејктивы_guid
LEFT JOIN L1.dbo.OBEKTY_EKSPLUATATSII AS oe
  ON oe.guid = b.ќбъектыЁксплуатации_guid
LEFT JOIN L1.dbo.REGISTRACII_V_NALOGOVOM_ORGANE AS rno
  ON rno.guid = b.–егистрации¬Ќалоговомќргане_guid
LEFT JOIN L1.dbo.ORGANIZATSII AS org
  ON org.guid = b.ќрганизаци€_guid

DROP TABLE #buh0
DROP TABLE #buh1