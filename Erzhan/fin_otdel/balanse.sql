WITH ALL_DATA AS (
SELECT
  source_database AS ��������
 ,CAST(PERIOD AS DATE) AS ����
 ,SCHET_DT AS ����
  -- ,������ AS ������
 ,ORGANIZACIYA AS �����������_guid
 ,PODRAZDELENIE_DT
  -- ,���������������
 ,NAPRAVLENIE_DEYATELNOSTI_DT
  -- ,�������������������������
 ,SUMMA AS �����
 ,VALYUTNAYA_SUMMA_DT
  -- ,���������������
 ,KOLICHESTVO_DT
  -- ,������������
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
 ,'��' AS ��� 
--INTO #buh0
FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

UNION ALL

--INSERT #buh0
  SELECT
    source_database AS ��������
   ,CAST(PERIOD AS DATE) AS ����
   ,SCHET_KT AS ����
    --  ,������ AS ������
   ,ORGANIZACIYA AS �����������_guid
   ,PODRAZDELENIE_KT AS ���������������
    --  ,��������������� AS ���������������
   ,NAPRAVLENIE_DEYATELNOSTI_KT AS �������������������������
    --  ,������������������������� AS �������������������������
   ,SUMMA * -1 AS �����
   ,VALYUTNAYA_SUMMA_KT AS ���������������
    --  ,��������������� AS ���������������
   ,KOLICHESTVO_KT AS ������������
    --  ,������������ AS ������������
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
   ,'��' AS ���
  FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

  )
,ALL_DATE_2 AS (
SELECT
  ����
 ,��������
 ,���� AS ����
 ,�����������_guid
 ,�����
 ,CASE
    WHEN b.subconto_dt_1_type IN ('�����������', '��������������') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN ('�����������', '��������������') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN ('�����������', '��������������') THEN subconto_dt_3_guid
  END AS �����������_guid
 ,CASE
    WHEN b.subconto_dt_1_type IN ('�������������', '��������������') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN ('�������������', '��������������') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN ('�������������', '��������������') THEN subconto_dt_3_guid
  END AS ������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '������������' THEN subconto_dt_3_guid
  END AS ������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '�����������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '�����������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '�����������������������������' THEN subconto_dt_3_guid
  END AS ���������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '����������������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '����������������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '����������������������������������' THEN subconto_dt_3_guid
  END AS ����������������������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '������' THEN subconto_dt_3_guid
  END AS ������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '�����' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '�����' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '�����' THEN subconto_dt_3_guid
  END AS �����_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '��������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '��������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '��������������������' THEN subconto_dt_3_guid
  END AS ��������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '��������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '��������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '��������������������' THEN subconto_dt_3_guid
  END AS ��������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '��������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '��������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '��������������������������' THEN subconto_dt_3_guid
  END AS ��������������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '��������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '��������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '��������������������������' THEN subconto_dt_3_guid
  END AS ��������������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '�������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '�������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '�������������������' THEN subconto_dt_3_guid
  END AS �������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '���������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '���������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '���������������������������' THEN subconto_dt_3_guid
  END AS ���������������������������_guid
 ,���
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type 
 --INTO #buh1
FROM ALL_DATA AS b
WHERE YEAR(����) <= YEAR(GETDATE())
)

,ALL_DATA_3 AS (

SELECT
  b.����
 ,b.��������
 ,org.NAIMENOVANIE AS �����������
 ,b.����
 ,b.�����
 ,d_r.NAIMENOVANIE AS [������ ������� ������]
 ,k.NAIMENOVANIE AS �����������
  ,CASE k.VKHODIT_V_GRUPPU_KOMPANIY_ALEM_AGRO
    WHEN 1 THEN '����������'
    ELSE '�������'
   END AS �����������
 ,sdds.NAIMENOVANIE AS ���������
 ,n.NAIMENOVANIE AS ������������
 --,gfu.NAIMENOVANIE AS [������ ��� �����]
 ,dgvk.NAIMENOVANIE AS [������� � ������������]
 --,kss.NAIMENOVANIE AS �����
 ,skld.NAIMENOVANIE AS ������
 ,bso.NAIMENOVANIE AS [���������� ����]
 ,dkd.NAIMENOVANIE AS [�������� �������� � ���������]
 --,nma.NAIMENOVANIE AS ���
 ,oe.NAIMENOVANIE AS [������� ������������]
 --,rno.NAIMENOVANIE AS [��� � ��������� ������]
 ,CASE
    WHEN LEFT(����, 1) IN ('1', '2') THEN '�'
    WHEN LEFT(����, 1) IN ('3', '4', '5') THEN '�'
    ELSE NULL
  END AS �_�
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type 
 
 --INTO #buh2

FROM ALL_DATE_2 AS b
LEFT JOIN L1.dbo.STATI_DOKHODOV_RASKHODOV AS d_r
  ON d_r.guid = b.������_guid
LEFT JOIN L1.dbo.KONTRAGENTY AS k
  ON k.guid = b.�����������_guid
LEFT JOIN L1.dbo.STATI_DDS AS sdds
  ON sdds.guid = b.���������_guid
LEFT JOIN L1.dbo.NOMENKLATURA AS n
  ON n.GUID = b.������������_guid
--LEFT JOIN L1.dbo.���������������������������������� AS gfu
--  ON gfu.guid = b.����������������������������������_guid
LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV AS dgvk
  ON dgvk.guid = b.��������������������_guid
--LEFT JOIN L1.dbo.����� AS kss
--  ON kss.guid = b.�����_guid
LEFT JOIN L1.dbo.SKLADY AS skld
  ON skld.guid = b.������_guid
LEFT JOIN L0.dbo.bankovskie_scheta_organizacii AS bso
  ON bso.ssilka = b.��������������������������_guid
LEFT JOIN L0.dbo.dogovori_kreditov_i_depozitov AS dkd
  ON dkd.ssilka = b.��������������������������_guid
--LEFT JOIN L1.dbo.�������������������� AS nma
--  ON nma.guid = b.��������������������_guid
LEFT JOIN L1.dbo.OBEKTY_EKSPLUATATSII AS oe
  ON oe.guid = b.�������������������_guid
--LEFT JOIN L1.dbo.��������������������������� AS rno
--  ON rno.guid = b.���������������������������_guid
LEFT JOIN L1.dbo.ORGANIZATSII AS org
  ON org.guid = b.�����������_guid
WHERE LEFT(����, 1) IN ('1', '2', '3', '4', '5')

)

SELECT
  ����
 ,��������
 ,�����������
  -- ,CASE
  --    WHEN ���� IN ('1210', '3510') THEN '1210-3510'
  --    WHEN ���� IN ('1710', '3310') THEN '1710-3310'
  --  ELSE ����
  --  END AS ����
 ,����
 ,CASE
    WHEN �_� = '�' THEN -�����
    ELSE �����
  END AS �����
 ,[������ ������� ������]
 ,�����������
  ,�����������
 ,���������
 ,������������
 --,[������ ��� �����]
 ,[������� � ������������]
 --,�����
 ,������
 ,[���������� ����]
 ,[�������� �������� � ���������]
 --,���
 ,[������� ������������]
 --,[��� � ��������� ������]
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type --INTO #group0
FROM ALL_DATA_3

--DROP TABLE #buh0
--DROP TABLE #buh1
--DROP TABLE #buh2
----DROP TABLE #group0