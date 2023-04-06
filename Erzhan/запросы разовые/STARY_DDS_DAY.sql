

WITH ALL_ZAPROS AS (/*** �������� �����***/
SELECT 
      [������]
      ,CASE WHEN [������] IN ('1030','1010','1050','1021') THEN RBX.[�����] END AS [DT_SUMMA]
	  ,CASE WHEN [������] IN ('1030','1010','1050','1021') THEN RBX.[�����] END AS [KT_SUMMA]
      ,DK.DOGOVOR_VNUTRI_GRUPPY
	  ,o.description �����������
	  ,o.guid AS ORGANIZASIYA_guid
	  --,CASE WHEN SDDS.������������='���������� ����� (���������� �����, ���������, ������)' THEN NULL ELSE K.description END AS KONTRAGENT
	  --,SDDS.������������ AS STATI_DDS
	  ,K.NAIMENOVANIE AS KONTRAGENT
	  ,case 
					when SDDS.������������='������������� �������' then '������������� ������� � ���������� ����������� �������'--������������� ������� � ���������� ����������� �������
					when SDDS.��� IN ('00-000317','00-000318','00-000319','00-000320') and s.NAIMENOVANIE = '����� 2023' then '������ ����������� ������ 2023 ����'--������ ����������� ������ 2023 ����
					when SDDS.��� IN ('00-000317','00-000318','00-000319','00-000320') and s.NAIMENOVANIE= '����� 2022' then '������ ����������� ������ 2022 ����'--������ ����������� ������ 2022 ����
					when SDDS.��� IN ('00-000317','00-000318','00-000319','00-000320') AND s.NAIMENOVANIE= '����� 2021' then '������ ����������� ������ 2021 ����'--������ ����������� ������ 2021 ����
					when SDDS.��� IN ('00-000317','00-000318','00-000319','00-000320') AND s.NAIMENOVANIE= '����� 2020' then '������ ����������� ������ 2020 ����'--������ ����������� ������ 2020 ����
					when SDDS.��� IN ('00-000317','00-000318','00-000319','00-000320') and (s.NAIMENOVANIE not in('����� 2023','����� 2022','����� 2021','����� 2020')) then '������ ����������� ������ 2019 ���� � �����'--������ ����������� ������ 2019 ���� � �����
					when SDDS.��� IN ('00-000317','00-000318','00-000319','00-000320') and S.NAIMENOVANIE IS NULL then '������ ����������� ��� ��������'--������ ����������� ��� ��������
					
					when SDDS.��� IN ('00-000290','��-000005') and  S.NAIMENOVANIE IS NULL then '����������� ��� ��������'--������ ����������� ��� ��������
					when SDDS.��� IN ('00-000290','��-000005') and s.NAIMENOVANIE = '����� 2023' then '����������� ������ 2023 ����' --����������� ������ 2023 ����
					when SDDS.��� IN ('00-000290','��-000005') and s.NAIMENOVANIE = '����� 2022' then '����������� ������ 2022 ����' --����������� ������ 2022 ����
					when SDDS.��� IN ('00-000290','��-000005') and s.NAIMENOVANIE = '����� 2021' then '����������� ������ 2021 ����' --����������� ������ 2021 ����
					when SDDS.��� IN ('00-000290','��-000005') and s.NAIMENOVANIE = '����� 2020' then '����������� ������ 2020 ����'--����������� ������ 2020 ����
					when SDDS.��� IN ('00-000290','��-000005') and (s.NAIMENOVANIE not IN ('����� 2020','����� 2021','����� 2022','����� 2023') ) then '����������� ������������ ������������� ������� ���'--����������� ������������ ������������� ������� ���
					when SDDS.[������������] LIKE '_OLD_%' THEN Stuff(SDDS.[������������],1,5,'') 
					WHEN SDDS.������������='������������ �� (������ � �����������)' THEN '������������ �� (������ � ����������)'
				else SDDS.������������
				end as STATI_DDS
	  ,DK.NAIMENOVANIE AS DOGOVOR
  FROM [AA_DWH].[dbo].[������������������.������������] RBX
  left join AA_DWH.dbo.����������� o 
	on o.guid=RBX.�����������
LEFT JOIN AA_DWH.dbo.������_��� AS sdds ON sdds.guid = CASE
    WHEN RBX.subconto_dt_1_type = '�����������������������������' THEN subconto_dt_1_guid
    WHEN RBX.subconto_dt_2_type = '�����������������������������' THEN subconto_dt_2_guid
    WHEN RBX.subconto_dt_3_type = '�����������������������������' THEN subconto_dt_3_guid
    WHEN RBX.subconto_ct_1_type = '�����������������������������' THEN subconto_ct_1_guid
    WHEN RBX.subconto_ct_2_type = '�����������������������������' THEN subconto_ct_2_guid
    WHEN RBX.subconto_ct_3_type = '�����������������������������' THEN subconto_ct_3_guid
  END
LEFT JOIN L1.dbo.DOGOVORY_KONTRAGENTOV DK  ON DK.guid = CASE
    WHEN RBX.subconto_dt_1_type = '��������������������' THEN subconto_dt_1_guid
    WHEN RBX.subconto_dt_2_type = '��������������������' THEN subconto_dt_2_guid
    WHEN RBX.subconto_dt_3_type = '��������������������' THEN subconto_dt_3_guid
    WHEN RBX.subconto_ct_1_type = '��������������������' THEN subconto_ct_1_guid
    WHEN RBX.subconto_ct_2_type = '��������������������' THEN subconto_ct_2_guid
    WHEN RBX.subconto_ct_3_type = '��������������������' THEN subconto_ct_3_guid
  END
LEFT JOIN L1.DBO.KONTRAGENTY K 
	ON DK.KONTRAGENT_GUID=K.GUID
LEFT JOIN L1.DBO.SEZONY S 
	ON DK.SEZON_GUID=S.GUID
  WHERE 1=1
  AND CAST(������ AS DATE)>='2022-01-01'
  AND (RBX.������ in ('1030','1010') OR RBX.������ in('1030','1010'))
  AND O.guid IN (0x80DE000C29E67B2E11E636A5C3C5D8AE,     -----ORGANIZATSIA GUID
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								)

)

, AILAR AS (/*** ������  ��� ���������� 0,01 � �������� ����� � ������ ���***/

SELECT DISTINCT /***  ***/
DATEADD(DAY,1,EOMONTH(AZ.������,-1))������
FROM ALL_ZAPROS AS AZ 
)

,DOBAVLENIE_0 AS (/***  ��� ����� ��� ���������, ����� � ��� ���������� ������ � ���������� � �������������� ������������ ***/
				SELECT 
					A.������
					,ISNULL(DA.STATI_DDS,'����������� ������� �� ���������� �������') AS �������������_guid
					,ISNULL(DA.DT_SUMMA,0.01)��
					,ISNULL(DA.KT_SUMMA,0.00)��
				FROM AILAR A
				LEFT JOIN (
							 SELECT  DATEADD(DAY,1,EOMONTH(AZ.������,-1))������
							 ,AZ.STATI_DDS
							 ,AZ.DT_SUMMA
							 ,AZ.KT_SUMMA
							 FROM ALL_ZAPROS AZ
							 WHERE AZ.STATI_DDS= '����������� ������� �� ���������� �������'
						 )AS DA 
					ON A.������=DA.������
				WHERE DA.STATI_DDS IS NULL 

	UNION ALL

				SELECT 
					A.������
					,ISNULL(FIN.STATI_DDS,'������� ��� �������� � ������ (����������)') AS �������������_guid
					,ISNULL(FIN.DT_SUMMA,0.01)��
					,ISNULL(FIN.KT_SUMMA,0.00)��
				FROM AILAR A
				LEFT JOIN (
							 SELECT  DATEADD(DAY,1,EOMONTH(AZ.������,-1))������
							 ,AZ.STATI_DDS
							 ,AZ.DT_SUMMA
							 ,AZ.KT_SUMMA
							 FROM ALL_ZAPROS AZ
							 WHERE AZ.STATI_DDS IN ('��������� ���� �������� � ������ (��������� �����������)'
																,'������� ��� �������� � ������ (��������� �����������)'
																,'������� ��� �������� � ������ (����������)'
													,'����������� ������� � �������� �������'
													) )AS FIN 
					ON A.������=FIN.������
				WHERE FIN.STATI_DDS IS NULL 
)


SELECT 
*
FROM (
SELECT 
  ALL_ZAPROS.DOGOVOR
  ,ALL_ZAPROS.DOGOVOR_VNUTRI_GRUPPY
  ,ALL_ZAPROS.DT_SUMMA
  ,ALL_ZAPROS.KT_SUMMA
  ,ALL_ZAPROS.KONTRAGENT
  ,CONVERT(NVARCHAR(50),ALL_ZAPROS.ORGANIZASIYA_guid,1) AS ORGANIZASIYA_guid
  ,ALL_ZAPROS.�����������
  ,ALL_ZAPROS.STATI_DDS
  ,ALL_ZAPROS.������
  FROM ALL_ZAPROS

UNION ALL

SELECT
	NULL AS DOGOVOR
  ,0 AS DOGOVOR_VNUTRI_GRUPPY
  ,DOBAVLENIE_0.�� AS DT_SUMMA
  ,DOBAVLENIE_0.�� AS KT_SUMMA
  ,NULL AS KONTRAGENT
  ,NULL AS ORGANIZASIYA_guid
  ,NULL AS �����������
  ,DOBAVLENIE_0.�������������_guid AS STATI_DDS
  ,DOBAVLENIE_0.������
FROM DOBAVLENIE_0
) AS ALL_ZAPROS



  LEFT JOIN L1_X.DBO.FIN_REFERENCE_DDS FRD
	ON FRD.DDS=ALL_ZAPROS.STATI_DDS

WHERE 1=1
--AND FRD.PARENT_1= '����������� ������ 2022 ����'

ORDER BY ������
		,FRD.PARENT_1
