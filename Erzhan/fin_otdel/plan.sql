SELECT DISTINCT
  CAST(period AS DATE) AS period
 ,n.NAIMENOVANIE AS ������������
 ,md.NAIMENOVANIE AS ��������
 ,S.NAIMENOVANIE �����
 ,PLN.KOLICHESTVO ����������
 ,PLN.SUMMA �����
 ,CONVERT(VARCHAR(25), pln.NOMENKLATURA_GUID, 1) AS ������������_guid
FROM L1.dbo.PLAN_PRODAZH AS pln
LEFT JOIN L1.[dbo].MENEDZHERY AS md
  ON md.[guid] = pln.MENEDZHER_GUID
LEFT JOIN L1.[dbo].NOMENKLATURA AS n
  ON n.GUID= pln.NOMENKLATURA_GUID
LEFT JOIN L1.dbo.SEZONY AS S 
	ON PLN.SEZON_GUID=S.GUID

WHERE PLN.STATUS = '���������'
AND VIDY_PLANOV='���� ������ ���������'

SELECT DISTINCT 
  CAST(period AS DATE) AS period
 ,n.description AS ������������
 ,md.description AS ��������
 ,�����
 ,����������
 ,�����
 ,CONVERT(VARCHAR(25), pln.������������_guid, 1) AS ������������_guid
FROM AA_DWH.dbo.����������� AS pln
LEFT JOIN [AA_DWH].[dbo].[���������] AS md
  ON md.[guid] = pln.��������_guid
LEFT JOIN [AA_DWH].[dbo].[������������] AS n
  ON n.[guid_binary] = pln.������������_guid
WHERE ������ = '���������'
