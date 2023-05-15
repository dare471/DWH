WITH DOGOVOR AS(
SELECT
   M.NAIMENOVANIE AS MENEDZHER
  ,SP.DIREKSYA
  ,DK.DATA
  ,K.NAIMENOVANIE AS KONTRAGENT
  ,N.NAIMENOVANIE AS NOMENKLATURA
  ,N.PROIZVODITELI
  ,SPD.KOLICHESTVO
  ,SPD.SUMMA_KZ_TG
FROM L1.dbo.DOGOVORY_KONTRAGENTOV DK
  LEFT JOIN L1.dbo.SPETSIFIKATSIYA_PO_DOGOVORU SPD
    ON SPD.DOGOVOR_GUID = DK.GUID
  LEFT JOIN L1.dbo.NOMENKLATURA N
    ON N.GUID = SPD.NOMENKLATURA_GUID
  LEFT JOIN L1.dbo.MENEDZHERY M
    ON M.GUID = DK.MENEDZHER_GUID 
  LEFT JOIN L1.dbo.KONTRAGENTY K
    ON K.GUID = DK.KONTRAGENT_GUID
  LEFT JOIN L1.dbo.STRUKTURA_PREDPRIYATIYA SP
    ON SP.GUID = DK.STRUKTURA_PREDPRIYATIYA_GUID
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
--  ,DK.DATA DESC
)
SELECT
   DENSE_RANK() OVER(PARTITION BY D.DIREKSYA ORDER BY SUM(D.SUMMA_KZ_TG) DESC) AS RANK
  ,D.DIREKSYA
  ,D.MENEDZHER
  ,SUM(D.SUMMA_KZ_TG) AS SUM
  --,SUM(SUM(D.SUMMA_KZ_TG)) OVER(PARTITION BY D.PROIZVODITELI) AS SUMMA
--INTO CRM_DWH.dbo.CRM_SALES_CONTEST_SHANS
FROM DOGOVOR D
GROUP BY
   D.DIREKSYA
  ,D.MENEDZHER
  ,D.PROIZVODITELI
ORDER BY
   D.DIREKSYA
  ,RANK

