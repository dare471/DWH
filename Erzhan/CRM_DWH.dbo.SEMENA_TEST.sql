WITH SPETSIFIKATSIYA
AS (
  SELECT 
     [NOMENKLATURA_GUID]
    ,SD.DOGOVOR_GUID
    ,[KOLICHESTVO]
  FROM [L1].[dbo].[SPETSIFIKATSIYA_PO_DOGOVORU] SD
    LEFT JOIN L1.dbo.NOMENKLATURA N
      ON N.GUID = SD.NOMENKLATURA_GUID
    LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV DK
    ON DK.GUID = SD.DOGOVOR_GUID
  WHERE 1=1
    AND N.RODITEL2 = '������'
    AND DK.SEZON_GUID = 0xAF83D4F5EF10792511EBE2FB064EBC27
),
VYRUCHKA AS(
  SELECT 
     VYR.[NOMENKLATURA_GUID]
    ,DK.GUID AS DOGOVOR_GUID
    ,VYR.[KOLICHESTVO]
  FROM [L1].[dbo].[VYRUCHKA_I_SEBESTOIMOST_PRODAZH] VYR
    LEFT JOIN L1.dbo.NOMENKLATURA N
      ON N.GUID = VYR.NOMENKLATURA_GUID
    LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV DK
      ON DK.GUID = VYR.DOGOVOR_GUID
  WHERE 1=1
    AND N.RODITEL2 = '������'
    AND DK.SEZON_GUID = 0xAF83D4F5EF10792511EBE2FB064EBC27
),
ZAKUP_2021 AS
(
  SELECT 
     SUM([TSENA])[TSENA]
    ,SUM([KOLICHESTVO]) [KOLICHESTVO]
    ,[NOMENKLATURA_GUID]
  FROM [L1].[dbo].[ZAKAZ_POSTAVSHIKU]ZP
    LEFT JOIN L1.DBO.NOMENKLATURA N 
      ON ZP.NOMENKLATURA_GUID=N.GUID
  WHERE 1=1
    AND N.RODITEL2 = '������ '
    AND DATA > '01-10-2021'
  GROUP BY [NOMENKLATURA_GUID]
),
ZAKUP_2022 AS
(
  SELECT 
     SUM([TSENA])[TSENA]
    ,SUM([KOLICHESTVO]) [KOLICHESTVO]
    ,[NOMENKLATURA_GUID]
  FROM [L1].[dbo].[ZAKAZ_POSTAVSHIKU]ZP
    LEFT JOIN L1.DBO.NOMENKLATURA N 
      ON ZP.NOMENKLATURA_GUID=N.GUID
  WHERE 1=1
    AND N.RODITEL2 = '������ '
    AND DATA > '01-10-2022'
  GROUP BY [NOMENKLATURA_GUID]
),

STOCK_2021 AS
(SELECT * FROM 
  (SELECT 
     NOMENKLATURA_GUID
    ,N.NAIMENOVANIE
    ,SUM(case 
         when TNS.[VID_DVIZHENIYA]=1 
         then [v_nalichii]*(-1) 
         else [v_nalichii] 
       end) AS [v_nalichii]
    FROM [L1].[dbo].[tovary_na_skladakh] TNS
    LEFT JOIN L1.DBO.SKLADY S 
      ON TNS.SKLAD_GUID=S.GUID
    LEFT JOIN L1.DBO.NOMENKLATURA N 
    ON TNS.NOMENKLATURA_GUID=N.GUID
    WHERE N.RODITEL2='������ '
    AND S.ADRES_SKLADA IS NOT NULL
    AND TNS.PERIOD<'01-10-2021'
    GROUP BY 
     [NOMENKLATURA_GUID]
    ,N.NAIMENOVANIE
  --ORDER BY [v_nalichii] DESC
  )A WHERE [v_nalichii]>0
),
STOCK_2022 AS
(SELECT * FROM 
  (SELECT 
     NOMENKLATURA_GUID
    ,N.NAIMENOVANIE
    ,SUM(case 
         when TNS.[VID_DVIZHENIYA]=1 
         then [v_nalichii]*(-1) 
         else [v_nalichii] 
       end) AS [v_nalichii]
    FROM [L1].[dbo].[tovary_na_skladakh] TNS
    LEFT JOIN L1.DBO.SKLADY S 
      ON TNS.SKLAD_GUID=S.GUID
    LEFT JOIN L1.DBO.NOMENKLATURA N 
    ON TNS.NOMENKLATURA_GUID=N.GUID
    WHERE N.RODITEL2='������ '
    AND S.ADRES_SKLADA IS NOT NULL
    AND TNS.PERIOD<'01-10-2022'
    GROUP BY 
     [NOMENKLATURA_GUID]
    ,N.NAIMENOVANIE
  --ORDER BY [v_nalichii] DESC
  )A WHERE [v_nalichii]>0
),

MAIN AS
(
SELECT 
  n.GUID nomenklatura_guid
  ,isnull(SP.[RODITEL2_GUID],isnull(SP.[RODITEL_GUID],SP.GUID)) as direksiya
   ,N.PROIZVODITELI AS '��������'
  ,N.VIDY_KULTUR_NOMENKLATURY AS '��������'
  ,isnull(SP.RODITEL2,isnull(SP.RODITEL,SP.NAIMENOVANIE)) as '������'
  ,N.NAIMENOVANIE AS '�������� ��������'
  ,N.VIDY_TEKHNOLOGIY AS '����������'
  ,0 AS '�������������'
  ,SUM(S.KOLICHESTVO) AS '�������'
  ,case when (SUM(S.KOLICHESTVO)) is NOT null then 0 else SUM(V.KOLICHESTVO) end AS '���������'
  ,SUM(S.KOLICHESTVO) - case when (SUM(V.KOLICHESTVO)) is null then 0 else SUM(V.KOLICHESTVO) end AS '�� ���������'
  ,MAX(STOCK_2021.v_nalichii) AS '����� 2021'
  ,MAX(STOCK_2022.v_nalichii) AS '����� 2022'
  ,MAX(Z_21.KOLICHESTVO) AS '�����������_2021'
  ,MAX(Z_22.KOLICHESTVO) AS '�����������_2022'

FROM [L1].[dbo].[NOMENKLATURA] N
  LEFT JOIN SPETSIFIKATSIYA S
    ON S.NOMENKLATURA_GUID = N.GUID
  LEFT JOIN VYRUCHKA V
    ON V.NOMENKLATURA_GUID = N.GUID
    AND V.DOGOVOR_GUID = S.DOGOVOR_GUID
  LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV DK
    ON DK.GUID = S.DOGOVOR_GUID
  LEFT JOIN L1.dbo.STRUKTURA_PREDPRIYATIYA SP
    ON SP.GUID = DK.STRUKTURA_PREDPRIYATIYA_GUID
  LEFT JOIN ZAKUP_2021 Z_21
    ON Z_21.NOMENKLATURA_GUID = N.GUID
  LEFT JOIN ZAKUP_2022 Z_22
    ON Z_22.NOMENKLATURA_GUID = N.GUID
  LEFT JOIN STOCK_2021 
    ON STOCK_2021.NOMENKLATURA_GUID = N.GUID
  LEFT JOIN STOCK_2022
    ON STOCK_2022.NOMENKLATURA_GUID = N.GUID
WHERE 1=1
  AND N.RODITEL2 = '������'
  AND N.VIDY_KULTUR_NOMENKLATURY IN ('������������','��������','����','�������')
GROUP BY
  n.GUID 
  --,sp.GUID 
  ,N.PROIZVODITELI
  ,N.VIDY_KULTUR_NOMENKLATURY
  ,isnull(SP.RODITEL2,isnull(SP.RODITEL,SP.NAIMENOVANIE))
  ,isnull(SP.[RODITEL2_GUID],isnull(SP.[RODITEL_GUID],SP.GUID))
  ,N.NAIMENOVANIE
  ,N.VIDY_TEKHNOLOGIY
--ORDER BY 
--   N.PROIZVODITELI
--  ,N.VIDY_KULTUR_NOMENKLATURY
 -- N.NAIMENOVANIE
 --,direksiya
 --,N.VIDY_KULTUR_NOMENKLATURY
 )
 SELECT 
 nomenklatura_guid
 ,ISNULL(direksiya,0) AS direksiya
   ,M.��������
  ,M.��������
  ,M.[�������� ��������]
  ,������
  ,M.����������
  ,M.�������������
  ,M.�������
  ,0 AS '�������'
  ,M.���������
  ,M.[�� ���������]
  ,M.[����� 2021]
  ,M.[����� 2022]
  ,M.�����������_2021
  ,M.�����������_2022
--into CRM_DWH.dbo.CRM_SEMENA_CHECK
 FROM MAIN M

 order by M.[�������� ��������]