WITH DOGOVOR AS (
SELECT
  dog.guid
 ,dog.NAIMENOVANIE AS �������
 ,dog.DOGOVOR_VNUTRI_GRUPPY
 ,dog.DATA
 ,dog.SOGLASOVAN
 ,k.NAIMENOVANIE AS ����������
 ,m.NAIMENOVANIE AS ��������
 --,br.NAIMENOVANIE AS ������������
 ,sez.NAIMENOVANIE AS �����
 ,dog.SUMMA
 
-- INTO #dogovor

FROM L1.dbo.DOGOVORY_KONTRAGENTOV AS dog
LEFT JOIN L1.[dbo].MENEDZHERY AS m
  ON m.[guid] = dog.MENEDZHER_GUID
LEFT JOIN L1.[dbo].KONTRAGENTY AS k
  ON k.[guid] = dog.KONTRAGENT_GUID
LEFT JOIN L1.dbo.SEZONY AS sez
  ON sez.guid = dog.SEZON_GUID
--LEFT JOIN L1.dbo.������������� AS br
--  ON br.guid = dog.������������_guid
)

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
 ,dog.DATA AS ����_��������
 ,dog.����������
 ,dog.�������� AS ��������
 --,dog.������������
 ,dog.�����
 ,s.NAIMENOVANIE AS �����
 ,n.NAIMENOVANIE AS ������������
-- ,n.��������1
-- ,n.��������2
-- ,n.��������������������� AS ���������
-- ,n.�������������
 ,prod.KOLICHESTVO
 ,prod.SUMMA_VYRUCHKI
 ,prod.SUMMA_VYRUCHKI_BEZ_NDS
 ,prod.STOIMOST
 ,prod.STOIMOST_BEZ_NDS
 ,prod.SUMMA_VYRUCHKI - prod.STOIMOST AS [������� �������]
 ,prod.SUMMA_VYRUCHKI_BEZ_NDS - prod.STOIMOST_BEZ_NDS AS [������� ������� (��� ���)]
 ,CONVERT(VARCHAR(50), prod.NOMENKLATURA_GUID, 1) AS ������������_guid
FROM L1.[dbo].VYRUCHKA_I_SEBESTOIMOST_PRODAZH AS prod
LEFT JOIN dogovor AS dog
  ON dog.guid = prod.DOGOVOR_GUID
LEFT JOIN L1.[dbo].NOMENKLATURA AS n
  ON n.GUID= prod.NOMENKLATURA_GUID
LEFT JOIN L1.[dbo].ORGANIZATSII AS o
  ON o.[guid] = prod.ORGANIZATSIYA_GUID
LEFT JOIN L1.[dbo].SKLADY AS s
  ON s.[guid] = prod.SKLAD_GUID
WHERE dog.DOGOVOR_VNUTRI_GRUPPY = 0
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

--DROP TABLE #dogovor