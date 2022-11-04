WITH DAXOD_RASXOD AS (
select
o.description as �����������,
--,DATEADD(yy, DATEDIFF(yy, 0, [������]) , 0)[������]
dateadd(day,1,EOMONTH(RBX.������,-1)) �����
,sum((Case when ������='5710' and ������ in ('6010','6020','6030') then RBX.����� else 0 end))-sum((Case when ������ in('6010','6020','6030') and ������='5710'then RBX.����� else 0 end)) as [����� �� ����������]
,sum((Case when ������='5710' and ������ in('7010') then RBX.����� else 0 end))-sum((Case when ������='5710' and  ������ in ('7010') then RBX.����� else 0 end)) as [�������������]
,SUM((CASE WHEN ������='6290'AND sdr.description IN('����� �������� ������ �� ���������� (�����������������)','����� �������� ������ �� ����������') THEN RBX.�����  ELSE 0 END )) AS [����� �������� ������ �� ����������]
,SUM((CASE WHEN ������ LIKE '72%'AND sdr.description IN('���������� �����','���������� ����� (������)') THEN RBX.�����  ELSE 0 END )) - SUM((CASE WHEN ������ LIKE '72%'AND sdr.description IN('���������� �����','���������� ����� (������)') THEN RBX.�����  ELSE 0 END )) AS [���������� �����]
,SUM((CASE WHEN ������ LIKE '72%'AND sdr.description='���������� ����� (������)' THEN RBX.�����  ELSE 0 END )) - SUM((CASE WHEN ������ LIKE '72%'AND sdr.description='���������� ����� (������)' THEN RBX.�����  ELSE 0 END )) AS [���������� ����� (������)]

,SUM((CASE WHEN ������ LIKE '72%' AND sdr.description='������, ����������� ������������ ��������, ���������'THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '72%' AND sdr.description='������, ����������� ������������ ��������, ���������'THEN RBX.�����  ELSE 0 END )) 
+SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������='������������ ������������' THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������='������������ ������������' THEN RBX.�����  ELSE 0 END )) AS [������� �� ����� � ��������� ���������]

,SUM((CASE WHEN ������ LIKE '72%' AND sdr.description='����������� 3 ������' THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '72%' AND sdr.description='����������� 3 ������' THEN RBX.�����  ELSE 0 END ))  AS [����������� �� � ��� (IT)]
,SUM((CASE WHEN ������ LIKE '72%' AND sdr.description='����������� 2 ������' THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '72%' AND sdr.description='����������� 2 ������' THEN RBX.�����  ELSE 0 END ))  AS [����������� �� (��������)]
,SUM((CASE WHEN ������ LIKE '72%' AND sdr.description IN ('����������� 1 ������','����������� 4 ������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '72%' AND sdr.description IN ('����������� 1 ������','����������� 4 ������') THEN RBX.�����  ELSE 0 END ))  AS [����������� �� � ��� (���)]
,SUM((CASE WHEN ������ LIKE '74%' AND sdr.description='����� ������' THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '74%' AND sdr.description='����� ������' THEN RBX.�����  ELSE 0 END ))  AS [�������� ������� �� ������ (�����, ���������)]
,SUM((CASE WHEN ������ LIKE '62%' AND sdr.description='������ �� ���������� �� � ���' THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '62%' AND sdr.description='������ �� ���������� �� � ���' THEN RBX.�����  ELSE 0 END ))  AS [������ �� ���������� �� � ���]
,SUM((CASE WHEN ������ LIKE '62%' AND sdr.description='������ �� �������� ������������' THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '62%' AND sdr.description='������ �� �������� ������������' THEN RBX.�����  ELSE 0 END ))  AS [������ �� �������� ������������]
,SUM((CASE WHEN ������ LIKE '62%' AND sdr.description IN ('������ �� ������������� �������� �� �������','��������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������  LIKE '62%' AND sdr.description IN ('������ �� ������������� �������� �� �������','��������') THEN RBX.�����  ELSE 0 END ))
+SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('��������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������  LIKE '74%' AND sdr.description IN ('��������') THEN RBX.�����  ELSE 0 END ))   AS [������ �� ������������� �������� �� �������]
,SUM((CASE WHEN ������ LIKE '62%' AND sdr.description IN ('����� �� �������, �����, ����������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������  LIKE '62%' AND sdr.description IN ('����� �� �������, �����, ����������') THEN RBX.�����  ELSE 0 END )) AS [����� �� �������, �����, ����������]
,SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('������������� ������������� �� � ���') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('������������� ������������� �� � ���') THEN RBX.�����  ELSE 0 END ))   AS [������������� ������������� �� � ���]
,SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('������������� ��������� �� � ���','�������� ��� ������� ���� ������������� ������� ������ ��') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('������������� ��������� �� � ���','�������� ��� ������� ���� ������������� ������� ������ ��') THEN RBX.�����  ELSE 0 END ))   AS [�������� �� � ���]

,SUM((CASE WHEN ������ LIKE '62%' AND sdr.description IN ('�������� �������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������  LIKE '62%' AND sdr.description IN ('�������� �������') THEN RBX.�����  ELSE 0 END ))
+SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('�������� �������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('�������� �������') THEN RBX.�����  ELSE 0 END ))   AS [������� �� �������� ��������]

,SUM((CASE WHEN ������ LIKE '62%' AND sdr.description IN ('������� ��� ����������� ������','������ ��� ����������� ������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������  LIKE '62%' AND sdr.description IN ('������� ��� ����������� ������','������ ��� ����������� ������') THEN RBX.�����  ELSE 0 END ))
+SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('������� ��� ����������� ������','������ ��� ����������� ������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('������� ��� ����������� ������','������ ��� ����������� ������') THEN RBX.�����  ELSE 0 END ))   AS [������� ��� ����������� ������]
,SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('������� �� ������� ����� ���������� ������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ LIKE '74%' AND sdr.description IN ('������� �� ������� ����� ���������� ������') THEN RBX.�����  ELSE 0 END ))   AS [������� �� �������, �����, ����������]

,SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('����������� �������� �� ����������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('����������� �������� �� ����������') THEN RBX.�����  ELSE 0 END ))   AS [���������� �������� �� ����������]
,SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('������ �� ���������� ������ �������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('������ �� ���������� ������ �������') THEN RBX.�����  ELSE 0 END ))   AS [������ �� ���������� ������ �������]
,SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('������ �� ���������������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('������ �� ���������������') THEN RBX.�����  ELSE 0 END ))   AS [������ �� ���������������]
,SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('��������� �������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('��������� �������') THEN RBX.�����  ELSE 0 END ))   AS [��������� �������]
,SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('����� �� ����� � ������ ���������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('����� �� ����� � ������ ���������') THEN RBX.�����  ELSE 0 END ))   AS [����� �� ����� � ������ ���������]
,SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('������ ������') THEN RBX.�����  ELSE 0 END)) - SUM((CASE WHEN ������ IN('1010','1030') AND SDDS.������������ IN ('������ ������') THEN RBX.�����  ELSE 0 END ))   AS [������ ������]


--,dateadd(day,1,EOMONTH(RBX.������,-1)) �����

from  [AA_DWH].[dbo].[������������������.������������] RBX
  left join AA_DWH.dbo.����������� o on o.guid=RBX.�����������
  left join AA_DWH.dbo.�������������������� p on p.guid=RBX.���������������
  left join AA_DWH.dbo.�������������������� p2 on p2.guid=RBX.���������������
  left join AA_DWH.dbo.��������������������� sdr on sdr.guid=(CASE
    WHEN RBX.subconto_dt_1_type IN ('�������������', '��������������') THEN subconto_dt_1_guid
    WHEN RBX.subconto_dt_2_type IN ('�������������', '��������������') THEN subconto_dt_2_guid
    WHEN RBX.subconto_dt_3_type IN ('�������������', '��������������') THEN subconto_dt_3_guid
    WHEN RBX.subconto_ct_1_type IN ('�������������', '��������������') THEN subconto_ct_1_guid
    WHEN RBX.subconto_ct_2_type IN ('�������������', '��������������') THEN subconto_ct_2_guid
    WHEN RBX.subconto_ct_3_type IN ('�������������', '��������������') THEN subconto_ct_3_guid
  END)
 left join AA_DWH.dbo.������_��� SDDS on SDDS.guid=(CASE
    WHEN RBX.subconto_dt_1_type = '�����������������������������' THEN subconto_dt_1_guid
    WHEN RBX.subconto_dt_2_type = '�����������������������������' THEN subconto_dt_2_guid
    WHEN RBX.subconto_dt_3_type = '�����������������������������' THEN subconto_dt_3_guid
    WHEN RBX.subconto_ct_1_type = '�����������������������������' THEN subconto_ct_1_guid
    WHEN RBX.subconto_ct_2_type = '�����������������������������' THEN subconto_ct_2_guid
    WHEN RBX.subconto_ct_3_type = '�����������������������������' THEN subconto_ct_3_guid
  END)
  WHERE 1=1
 AND o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								)  
AND dateadd(day,1,EOMONTH(RBX.������,-1))>'2021-12-01'
  group by 
  o.description,RBX.�����������,
--,DATEADD(yy, DATEDIFF(yy, 0, [������]) , 0)
dateadd(day,1,EOMONTH(RBX.������,-1))
  --order by dateadd(day,1,EOMONTH(RBX.������,-1))

)

, DDS AS(     /**** �������� ����� �� ������ '1030','1010' ***/
				SELECT
				dateadd(day,1,EOMONTH(a.������,-1)) �����,
				CASE WHEN a.������ IN('1030','1010') THEN a.�����*(-1) ELSE a.����� END AS �����,
				a.������,
				a.������,
				o.description as organizasii ,
				m.������������ AS �������������_guid

				FROM [AA_DWH].[dbo].[������������������.������������] a 
				LEFT JOIN [AA_DWH].[dbo].����������� o on a.�����������=o.guid 
				LEFT JOIN [AA_DWH].[dbo].[������_���] m 
					ON m.guid = (CASE
									WHEN a.subconto_dt_1_type = '�����������������������������' THEN a.subconto_dt_1_guid
									WHEN a.subconto_dt_2_type = '�����������������������������' THEN subconto_dt_2_guid
									WHEN a.subconto_dt_3_type = '�����������������������������' THEN subconto_dt_3_guid
									WHEN a.subconto_ct_1_type = '�����������������������������' THEN subconto_ct_1_guid
									WHEN a.subconto_ct_2_type = '�����������������������������' THEN subconto_ct_2_guid
									WHEN a.subconto_ct_3_type = '�����������������������������' THEN subconto_ct_3_guid
								  END) 
				LEFT JOIN [AA_DWH].[dbo].[��������������������] dsp 
					ON dsp.guid=(CASE
								WHEN a.subconto_dt_1_type = '��������������������' THEN subconto_dt_1_guid
								WHEN a.subconto_dt_2_type = '��������������������' THEN subconto_dt_2_guid
								WHEN a.subconto_dt_3_type = '��������������������' THEN subconto_dt_3_guid
								WHEN a.subconto_ct_1_type = '��������������������' THEN subconto_ct_1_guid
								WHEN a.subconto_ct_2_type = '��������������������' THEN subconto_ct_2_guid
								WHEN a.subconto_ct_3_type = '��������������������' THEN subconto_ct_3_guid
							END)
				LEFT JOIN [AA_DWH].dbo.������ AS s 
					ON s.guid = dsp.�����_guid

				where o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								) and
					   (a.������ in ('1030','1010'--,'1050'
								) or a.������ in('1030','1010'--,'1050'
						)) and   
					   dateadd(day,1,EOMONTH(a.������,-1))>='2022-01-01' and 
					   not(������ in ('1010','1030'--,'1050','1021'
						   ) 
						   and ������ in ('1010','1030'--,'1050','1021'
						))

)

,ALL_ AS (

SELECT 
	DDS.����� AS MOTH
	,SUM(DDS.�����) AS SUMMA
	,DDS.organizasii AS ORGANIZASII
	,DDS.�������������_guid AS DDS_AND_DVIZH
FROM DDS 
WHERE DDS.�������������_guid NOT IN ('������� �������� ������� �� ����������',
'������� �������� ������� �������������','������� ��� �������� � ������ (����������)','������� ��� �������� � ������ (��������� �����������)','������� ������ �������',
'������� ������ �������','������� ������ ������� (��������������� �������)','������� �� ����������','������� �� ���������� (��������������� �������)',
'������� ����������� �����','������ ����� ����������','������ ���� �������� � ������ (��������������� �������)','������ ���� �������� � ������ (����������)',
'������ ���� �������� � ������ (��������� �����������)','������ ���� �������� � ������ (����������)','����������� ������','���','��� (����)','��� (������)',
'������ ����������� (��������������� �������)','������ ����������� (��������� ��������)','������ ����������� (������)','������ ����������� (���)','������ ����������� (�������� ���)',
'������ ����������� (���������)','������ ����������','������������ �������� ������� �� ������ ����','��������� ���� �������� � ������ (��������� �����������)',
'��������� ���� �������� � ������ (��������� �����������)','����������� �������� ������� �� ����� (� �����)','����������� ������ �� �������','����������� ������ �� ������� (��������������� �������)',
'����������� ������ �� ������� �� ���������','����������� ������ �� ������� �� ��������� (��������)','������������ ��� (����������� �����������)',
'������������ �� (�������������)','������������ �� (���������� � ����������)','������������ �� (������ � ������� ������������)','������������ �� (������)',
'������ �������','������ ������� �����������.','������ �����������','������ �����������','������ ������� (��������)','����� �������� ������� � ���� (� �����)',
'���������� �������','������������ ������� (�������� � ��� �� ��� �����)','������������ ������� (�������)','������������ ������� �������� (�������� �� ����������)',
'������������ ������� ������� (�������� �� ����������)','������������ ������� ������ (�������� �� ����������)','������������ ������� ���������� (�������� �� ����������)',
'������������ ������� ������� (�������� �� ����������)','������������ ������� ������ (�������� �� ����������)','������������ ������� ������ (�������� �� ����������)','��������� ���� �������� � ������ (��������������� �������)','����� �� �������� ��������'
,'����������� �������� �� ����������','����������� ������ (�����������)','����������� ������ (��������)','����������� ������ �����������','������ �� �������� ������','������� ���������� �����',
'������� ���������� �����','������� ���������� �����','���������� ����� (����������� �� ���������������� ������, ������� ������)','���� ���������� ����� � ������ �� ���',
'���������� ����� (���������� �����, ���������, ������)','������� ���������� �����','���������� � ������ (���, ��, ����)',
'������ �� ��� (��, ���)',
'���������� �����','������� �������','������������ ������������'
)
GROUP BY 
	DDS.�����
	,DDS.organizasii
	,DDS.�������������_guid

UNION ALL

SELECT ����� AS MOTH
	,VALUE AS SUMMA
	,����������� AS ORGANIZASII
	,DVIZH_DENEG AS DDS_AND_DVIZH 
FROM ( 
		SELECT �����,�����������,[����� �� ����������], [�������������],[����� �������� ������ �� ����������],[���������� �����],[���������� ����� (������)],[������� �� ����� � ��������� ���������]
		,[����������� �� � ��� (IT)],[����������� �� (��������)],[�������� ������� �� ������ (�����, ���������)],[������ �� ���������� �� � ���],[������ �� �������� ������������],[������ �� ������������� �������� �� �������]
		,[����� �� �������, �����, ����������],[������������� ������������� �� � ���],[�������� �� � ���],[������� �� �������� ��������],[������� ��� ����������� ������],[������� �� �������, �����, ����������]
		,[���������� �������� �� ����������],[������ �� ���������� ������ �������],[������ �� ���������������],[��������� �������],[����� �� ����� � ������ ���������],[������ ������],[����������� �� � ��� (���)]
		FROM DAXOD_RASXOD AS DR
	) P
UNPIVOT  
	(VALUE FOR DVIZH_DENEG IN ([����� �� ����������], [�������������],[����� �������� ������ �� ����������],[���������� �����],[���������� ����� (������)],[������� �� ����� � ��������� ���������]
								,[����������� �� � ��� (IT)],[����������� �� (��������)],[�������� ������� �� ������ (�����, ���������)],[������ �� ���������� �� � ���],[������ �� �������� ������������],[������ �� ������������� �������� �� �������]
								,[����� �� �������, �����, ����������],[������������� ������������� �� � ���],[�������� �� � ���],[������� �� �������� ��������],[������� ��� ����������� ������],[������� �� �������, �����, ����������]
								,[���������� �������� �� ����������],[������ �� ���������� ������ �������],[������ �� ���������������],[��������� �������],[����� �� ����� � ������ ���������],[������ ������],[����������� �� � ��� (���)]
								)
	) AS UNPVT

	)

SELECT
ALL_.MOTH
,ALL_.ORGANIZASII
,ALL_.SUMMA
,ALL_.DDS_AND_DVIZH
,FRDO.[PARENT_1]
,FRDO.[PARENT_2]
FROM ALL_
LEFT JOIN L1_X.DBO.FIN_REFERENCE_DDS_OPiU AS FRDO
ON ALL_.DDS_AND_DVIZH=FRDO.DDS

--WHERE ALL_.DDS_AND_DVIZH='���������� �����'

ORDER BY ALL_.MOTH
,ALL_.DDS_AND_DVIZH
,[DDS]