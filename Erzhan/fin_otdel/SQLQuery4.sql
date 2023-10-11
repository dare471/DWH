WITH ALL_DATA AS (
SELECT
  source_database AS source_database
 ,CAST(PERIOD AS DATE) AS DATE
 ,SCHET_KT AS SCHET_DT
 ,SCHET_DT AS SCHET_KT
 ,ORGANIZACIYA AS ORGANIZACIYA_GUID
 ,PODRAZDELENIE_KT AS PODRAZDELENIE_DT
 ,PODRAZDELENIE_DT AS PODRAZDELENIE_KT
 ,NAPRAVLENIE_DEYATELNOSTI_KT AS NAPRAVLENIE_DEYATELNOSTI_DT
 ,NAPRAVLENIE_DEYATELNOSTI_DT AS NAPRAVLENIE_DEYATELNOSTI_KT
 ,SUMMA * (-1) AS SUMMA
 ,VALYUTNAYA_SUMMA_KT AS VALYUTNAYA_SUMMA_DT 
 ,VALYUTNAYA_SUMMA_DT AS VALYUTNAYA_SUMMA_KT 
 ,KOLICHESTVO_KT AS KOLICHESTVO_DT 
 ,KOLICHESTVO_DT AS KOLICHESTVO_KT 
 ,SODERZHANIE
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
 ,'Расход' AS TIP 
 --INTO #buh0
FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI
WHERE --[SCHET_DT] IN ('1210','3510') OR 
[SCHET_KT] IN ('1210','3510')

UNION ALL

--INSERT #buh0
  SELECT
    source_database 
   ,CAST(PERIOD AS DATE) AS DATE
   ,SCHET_DT 
   ,SCHET_KT 
   ,ORGANIZACIYA AS ORGANIZACIYA_GUID
   ,PODRAZDELENIE_DT 
   ,PODRAZDELENIE_KT 
   ,NAPRAVLENIE_DEYATELNOSTI_DT 
   ,NAPRAVLENIE_DEYATELNOSTI_KT 
   ,SUMMA 
   ,VALYUTNAYA_SUMMA_DT 
   ,VALYUTNAYA_SUMMA_KT 
   ,KOLICHESTVO_DT 
   ,KOLICHESTVO_KT 
   ,SODERZHANIE 
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
   ,'Доход' AS TIP
  FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI
WHERE [SCHET_DT] IN ('1210','3510')
--OR [SCHET_KT] IN ('1210','3510')
)

SELECT 
DK.NOMER
,K.NAIMENOVANIE
,O.NAIMENOVANIE
,AD.*

FROM ALL_DATA AS AD

LEFT JOIN L1.DBO.DOGOVORY_KONTRAGENTOV AS DK
	ON DK.GUID = CASE WHEN [SUBCONTO_DT_1_TYPE]='ДоговорыКонтрагентов' THEN [SUBCONTO_DT_1_GUID]
			WHEN [SUBCONTO_DT_2_TYPE]='ДоговорыКонтрагентов' THEN [SUBCONTO_DT_2_GUID]
			WHEN [SUBCONTO_DT_3_TYPE]='ДоговорыКонтрагентов' THEN [SUBCONTO_DT_3_GUID]
			WHEN [SUBCONTO_CT_1_TYPE]='ДоговорыКонтрагентов' THEN [SUBCONTO_CT_1_GUID]
			WHEN [SUBCONTO_CT_2_TYPE]='ДоговорыКонтрагентов' THEN [SUBCONTO_CT_2_GUID]
			WHEN [SUBCONTO_CT_3_TYPE]='ДоговорыКонтрагентов' THEN [SUBCONTO_CT_3_GUID]
		END
LEFT JOIN L1.dbo.KONTRAGENTY AS K
	ON K.GUID=CASE WHEN [SUBCONTO_DT_1_TYPE]='Контрагенты' THEN [SUBCONTO_DT_1_GUID]
					WHEN [SUBCONTO_DT_2_TYPE]='Контрагенты' THEN [SUBCONTO_DT_2_GUID]
					WHEN [SUBCONTO_DT_3_TYPE]='Контрагенты' THEN [SUBCONTO_DT_3_GUID]
					WHEN [SUBCONTO_CT_1_TYPE]='Контрагенты' THEN [SUBCONTO_CT_1_GUID]
					WHEN [SUBCONTO_CT_2_TYPE]='Контрагенты' THEN [SUBCONTO_CT_2_GUID]
					WHEN [SUBCONTO_CT_3_TYPE]='Контрагенты' THEN [SUBCONTO_CT_3_GUID]
				END
LEFT JOIN L1.dbo.ORGANIZATSII O ON AD.ORGANIZACIYA_GUID=O.GUID

WHERE 1=1
--AND DK.NOMER IN('2310/02/09-17','0015/20/01-21')
--AND K.NAIMENOVANIE ='ТОО "ЯССАН"'

ORDER BY ORGANIZACIYA_GUID ,DATE