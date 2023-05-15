WITH DOGOVOR AS(
SELECT
   M.NAIMENOVANIE AS MENEDZHER
  ,SP.DIREKSYA
  ,DK.DATA
  ,K.NAIMENOVANIE AS KONTRAGENT
  ,N.NAIMENOVANIE AS NOMENKLATURA
  ,N.PROIZVODITELI
  ,SPD.KOLICHESTVO
  ,SHP.COEF
  ,SUM(SPD.KOLICHESTVO) OVER(PARTITION BY M.NAIMENOVANIE) AS COUNT 
FROM L1.dbo.DOGOVORY_KONTRAGENTOV DK
  LEFT JOIN L1.dbo.SPETSIFIKATSIYA_PO_DOGOVORU SPD
    ON SPD.DOGOVOR_GUID = DK.GUID
  LEFT JOIN L1.dbo.NOMENKLATURA N
    ON N.GUID = SPD.NOMENKLATURA_GUID
  INNER JOIN L1.dbo.MENEDZHERY M
    ON M.GUID = DK.MENEDZHER_GUID 
  LEFT JOIN L1.dbo.KONTRAGENTY K
    ON K.GUID = DK.KONTRAGENT_GUID
  LEFT JOIN L1.dbo.STRUKTURA_PREDPRIYATIYA SP
    ON SP.GUID = DK.STRUKTURA_PREDPRIYATIYA_GUID
  INNER JOIN CRM_DWH.dbo.CRM_SALES_CONTEST_SHANS_PRODUCTS SHP
    ON SHP.GUID = SPD.NOMENKLATURA_GUID
WHERE 1=1
  AND DK.TIP_DOGOVORA = '� ����������� / ����������'
  AND DK.STATUS = '���������'
  AND DK.DOGOVOR_VNUTRI_GRUPPY = 0
  AND DK.SEZON_GUID = 0xAF90D4F5EF10792511ECEC824678758E
  AND N.PROIZVODITELI = '����'
  AND DK.DATA BETWEEN '18-01-2023' AND '31-08-2023'
  AND SP.DIREKSYA <> '�������� ����'
  
--ORDER BY
--   SP.DIREKSYA
--  ,M.NAIMENOVANIE
--  ,DK.DATA DESC
)
, CTE_RANKED AS(
SELECT
   D.MENEDZHER
  ,D.DIREKSYA
  ,D.DATA
  ,D.NOMENKLATURA
  ,D.KOLICHESTVO
  ,D.COEF
  ,ROW_NUMBER() OVER(PARTITION BY D.MENEDZHER ORDER BY D.DATA, D.NOMENKLATURA) AS RN
FROM DOGOVOR D
--ORDER BY 
--   D.MENEDZHER
--  ,D.DATA 
)
, CTE AS(
SELECT 
   C1.MENEDZHER
  ,C1.DIREKSYA
  ,C1.DATA
  ,C1.NOMENKLATURA
  ,C1.KOLICHESTVO
  ,C1.COEF
  ,(SELECT 
       SUM(C2.KOLICHESTVO) 
	FROM CTE_RANKED C2 
	WHERE 1=1
	  AND C2.MENEDZHER = C1.MENEDZHER
	  AND C2.RN <= C1.RN
    ) AS SUM_KOL
 
FROM CTE_RANKED C1
--ORDER BY 
--   C1.MENEDZHER
--  ,C1.DATA
)
SELECT 
   C.MENEDZHER
  ,C.DIREKSYA
  ,C.DATA
  ,C.NOMENKLATURA
  ,C.KOLICHESTVO
  ,C.SUM_KOL
  ,CASE
     WHEN ROW_NUMBER() OVER(PARTITION BY C.MENEDZHER ORDER BY C.DATA) = 1
	   THEN C.SUM_KOL - 1000
	 ELSE C.KOLICHESTVO
   END AS NUMBER_OF_PROMOTIONAL_PRODUCTS
  ,C.COEF
  ,CASE
     WHEN ROW_NUMBER() OVER(PARTITION BY C.MENEDZHER ORDER BY C.DATA) = 1
	   THEN (C.SUM_KOL - 1000) * C.COEF
	 ELSE C.KOLICHESTVO * C.COEF
   END AS CASHBACK
--INTO CRM_DWH.dbo.CRM_SALES_CONTEST_SHANS_CASHBACK
FROM CTE C
WHERE 1=1
  AND C.SUM_KOL >= 1000
ORDER BY 
   C.MENEDZHER
  ,C.DATA
