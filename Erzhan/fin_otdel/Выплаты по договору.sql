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
 ,'������' AS ��� INTO #buh0
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
   ,'�����' AS ���
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
 ,sdds.RODITEL_0 AS ����_������
 ,sdds.RODITEL_1 AS ������������
 ,sdds.RODITEL_2 AS ������������������
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
 ,��� INTO #dds0
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
  ON kss.ssilka = b.�����_guid
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
WHERE LEFT(������, 2) = '10'
AND (LEFT(������, 1) = '1'
  OR ������ IN ('3310', '3510'))

SELECT
  [������� � ������������]
 ,SUM(�����) AS ����� INTO #dds1
FROM #dds0
WHERE [������� � ������������] IS NOT NULL
GROUP BY [������� � ������������]

SELECT
  dog.guid
 ,dog.NAIMENOVANIE AS �������
 ,dog.DOGOVOR_VNUTRI_GRUPPY AS �������������������
 ,dog.DATA AS ����
 ,dog.SOGLASOVAN
 ,k.NAIMENOVANIE AS ����������
 ,m.NAIMENOVANIE AS ��������
 ,br.DIREKSYA AS ������������
 ,sez.NAIMENOVANIE AS �����
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
  CAST([Date] AS DATE) AS ����
 ,CASE --�������� ����� ��� ������ � ������
    WHEN DAY([Date]) BETWEEN 1 AND 9 THEN DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 1)
    WHEN DAY([Date]) BETWEEN 10 AND 19 THEN DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 11)
    WHEN DAY([Date]) BETWEEN 20 AND 31 THEN DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 21)
  END AS ������
 ,o.NAIMENOVANIE AS �����������
 ,dog.�������
  --,dog.�������������������
 ,dog.���� AS ����_��������
 ,dog.����������
 ,dog.�������� AS ��������
 ,dog.������������
 ,dog.�����
 ,s.NAIMENOVANIE AS �����
 ,n.NAIMENOVANIE AS ������������
 --,n.��������1
 --,n.��������2
 ,n.KATEGORII_NOMENKLATURY_GROUP AS ���������
 ,n.PROIZVODITELI �������������
 ,prod.KOLICHESTVO ����������
 ,prod.SUMMA_VYRUCHKI ������������
 ,prod.SUMMA_VYRUCHKI_BEZ_NDS ������������������
 ,prod.STOIMOST ���������
 ,prod.STOIMOST_BEZ_NDS ���������������
 ,prod.SUMMA_VYRUCHKI - prod.STOIMOST AS [������� �������]
 ,prod.SUMMA_VYRUCHKI_BEZ_NDS - prod.STOIMOST_BEZ_NDS AS [������� ������� (��� ���)] 
 
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
WHERE dog.������������������� = 0
--WHERE dog.���������� NOT IN (
--'Alem Agro Trade" ���'
--, 'LLC Alem Agro KG (���� ���� ���� ��� ���)'
--, 'TOO "KazAgroSystems"'
--, '��� "Alem Agro Holding (���� ���� �������)"'
--, '��� �����-���� LTD�'
--, '��� "IrriTech Systems"'
--, '��� "Alem Agro Trade"'
--, '��� "KazAgroSystems"'
--, '��� "����-���� LTD"'
--, '��� �Alem Agro Holding (���� ���� �������)�'
--)

SELECT
  sg.�����
 ,sg.�����������
 ,sg.�������
 ,sg.����_��������
 ,sg.����������
 ,sg.��������
 ,sg.������������
 ,dds.����� AS [����� ������]
 ,SUM(sg.������������) AS �������
FROM #sales_group AS sg
LEFT JOIN #dds1 AS dds
  ON dds.[������� � ������������] = sg.�������
GROUP BY sg.�����
        ,sg.�����������
        ,sg.�������
        ,sg.����_��������
        ,sg.����������
        ,sg.��������
        ,sg.������������
        ,dds.�����

DROP TABLE #buh0
DROP TABLE #buh1
DROP TABLE #dds0
DROP TABLE #dds1
DROP TABLE #dogovor
DROP TABLE #sales_group