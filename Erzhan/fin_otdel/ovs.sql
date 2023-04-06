SELECT
  source_database AS ��������
 ,CAST(PERIOD AS DATE) AS ����
 ,SCHET_KT AS ������
 ,SCHET_DT AS ������
 ,ORGANIZACIYA AS �����������_guid
 ,PODRAZDELENIE_KT AS ���������������
 ,PODRAZDELENIE_DT AS ���������������
 ,NAPRAVLENIE_DEYATELNOSTI_KT AS �������������������������
 ,NAPRAVLENIE_DEYATELNOSTI_DT AS �������������������������
 ,SUMMA * -1 AS �����
 ,VALYUTNAYA_SUMMA_KT AS �������������
 ,VALYUTNAYA_SUMMA_DT AS ���������������
 ,KOLICHESTVO_KT AS ������������
 ,KOLICHESTVO_DT AS ������������
 ,SODERZHANIE ����������
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
 ,'��' AS ��� INTO #buh0
FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

INSERT #buh0
  SELECT
    source_database AS ��������
   ,CAST(PERIOD AS DATE) AS ����
   ,SCHET_DT ������
   ,SCHET_KT ������
   ,ORGANIZACIYA AS �����������_guid
   ,PODRAZDELENIE_DT ���������������
   ,PODRAZDELENIE_KT ���������������
   ,NAPRAVLENIE_DEYATELNOSTI_DT �������������������������
   ,NAPRAVLENIE_DEYATELNOSTI_KT �������������������������
   ,SUMMA �����
   ,VALYUTNAYA_SUMMA_DT ���������������
   ,VALYUTNAYA_SUMMA_KT ���������������
   ,KOLICHESTVO_DT ������������
   ,KOLICHESTVO_KT ������������
   ,SODERZHANIE ����������
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
   ,'��' AS ���
  FROM L1.dbo.REGISTR_BUHGALTERII_HOZRASCHETNYI

SELECT
  ����
 ,��������
 ,������ AS ������
 ,������ AS ������
 ,�����������_guid
 ,�����
 ,CASE
    WHEN b.subconto_dt_1_type IN ('�����������', '��������������') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN ('�����������', '��������������') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN ('�����������', '��������������') THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type IN ('�����������', '��������������') THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type IN ('�����������', '��������������') THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type IN ('�����������', '��������������') THEN subconto_ct_3_guid
  END AS �����������_guid
 ,CASE
    WHEN b.subconto_dt_1_type IN ('�������������', '��������������') THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type IN ('�������������', '��������������') THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type IN ('�������������', '��������������') THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type IN ('�������������', '��������������') THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type IN ('�������������', '��������������') THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type IN ('�������������', '��������������') THEN subconto_ct_3_guid
  END AS ������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '������������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '������������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '������������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '������������' THEN subconto_ct_3_guid
  END AS ������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '�����������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '�����������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '�����������������������������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '�����������������������������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '�����������������������������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '�����������������������������' THEN subconto_ct_3_guid
  END AS ���������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '����������������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '����������������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '����������������������������������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '����������������������������������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '����������������������������������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '����������������������������������' THEN subconto_ct_3_guid
  END AS ����������������������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '������' THEN subconto_ct_3_guid
  END AS ������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '�����' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '�����' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '�����' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '�����' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '�����' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '�����' THEN subconto_ct_3_guid
  END AS �����_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '��������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '��������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '��������������������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '��������������������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '��������������������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '��������������������' THEN subconto_ct_3_guid
  END AS ��������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '��������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '��������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '��������������������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '��������������������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '��������������������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '��������������������' THEN subconto_ct_3_guid
  END AS ��������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '��������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '��������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '��������������������������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '��������������������������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '��������������������������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '��������������������������' THEN subconto_ct_3_guid
  END AS ��������������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '��������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '��������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '��������������������������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '��������������������������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '��������������������������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '��������������������������' THEN subconto_ct_3_guid
  END AS ��������������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '�������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '�������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '�������������������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '�������������������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '�������������������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '�������������������' THEN subconto_ct_3_guid
  END AS �������������������_guid
 ,CASE
    WHEN b.subconto_dt_1_type = '���������������������������' THEN subconto_dt_1_guid
    WHEN b.subconto_dt_2_type = '���������������������������' THEN subconto_dt_2_guid
    WHEN b.subconto_dt_3_type = '���������������������������' THEN subconto_dt_3_guid
    WHEN b.subconto_ct_1_type = '���������������������������' THEN subconto_ct_1_guid
    WHEN b.subconto_ct_2_type = '���������������������������' THEN subconto_ct_2_guid
    WHEN b.subconto_ct_3_type = '���������������������������' THEN subconto_ct_3_guid
  END AS ���������������������������_guid
 ,���
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type
 ,subconto_ct_1_type
 ,subconto_ct_2_type
 ,subconto_ct_3_type
 ,�������������������������
 ,������������������������� INTO #buh1
FROM #buh0 AS b

SELECT
  b.����
 ,b.��������
  ,org.NAIMENOVANIE AS �����������
 ,������
 ,������
 ,b.�����
 ,sdds.NAIMENOVANIE AS ����
 ,sdds.RODITEL_1 AS ����_������
 ,d_r.NAIMENOVANIE AS [������ ������� ������]
 ,k.NAIMENOVANIE AS �����������
 ,n.NAIMENOVANIE AS ������������
 ,gfu.NAIMENOVANIE AS [������ ��� �����]
 ,dgvk.NAIMENOVANIE AS [������� � ������������]
 ,kss.NAIMENOVANIE AS �����
 ,skld.NAIMENOVANIE AS ������
 ,bso.NAIMENOVANIE AS [���������� ����]
 ,dkd.NAIMENOVANIE AS [�������� �������� � ���������]
 ,nma.NAIMENOVANIE AS ���
 ,oe.NAIMENOVANIE AS [������� ������������]
 ,rno.NAIMENOVANIE AS [��� � ��������� ������]
 ,subconto_dt_1_type
 ,subconto_dt_2_type
 ,subconto_dt_3_type
 ,subconto_ct_1_type
 ,subconto_ct_2_type
 ,subconto_ct_3_type
 ,���
-- ,�������������������������
-- ,�������������������������
FROM #buh1 AS b
LEFT JOIN L1.dbo.STATI_DOKHODOV_RASKHODOV AS d_r
  ON d_r.guid = b.������_guid
LEFT JOIN L1.dbo.KONTRAGENTY AS k
  ON k.guid = b.�����������_guid
LEFT JOIN L1.dbo.STATI_DDS AS sdds
  ON sdds.guid = b.���������_guid
LEFT JOIN L1.dbo.NOMENKLATURA AS n
  ON n.guid = b.������������_guid
LEFT JOIN L1.dbo.GRUPPI_FINANSOVOGO_UCHETA_NOMENKLATURI AS gfu
  ON gfu.guid = b.����������������������������������_guid
LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV AS dgvk
  ON dgvk.guid = b.��������������������_guid
LEFT JOIN L1.dbo.KASSI AS kss
  ON kss.GUID = b.�����_guid
LEFT JOIN L1.dbo.SKLADY AS skld
  ON skld.guid = b.������_guid
LEFT JOIN L1.dbo.BANKOVSKIE_SCHETA_ORGANIZACII AS bso
  ON bso.guid = b.��������������������������_guid
LEFT JOIN L1.dbo.DOGOVORI_KREDITOV_I_DEPOZITOV AS dkd
  ON dkd.guid = b.��������������������������_guid
LEFT JOIN L1.dbo.NEMATERIALNIE_AKTIVI AS nma
  ON nma.guid = b.��������������������_guid
LEFT JOIN L1.dbo.OBEKTY_EKSPLUATATSII AS oe
  ON oe.guid = b.�������������������_guid
LEFT JOIN L1.dbo.REGISTRACII_V_NALOGOVOM_ORGANE AS rno
  ON rno.guid = b.���������������������������_guid
LEFT JOIN L1.dbo.ORGANIZATSII AS org
  ON org.guid = b.�����������_guid

DROP TABLE #buh0
DROP TABLE #buh1