WITH FACT AS(
				SELECT
				--s.description,
				--dsp.guid,
				--m.������������ [�������������],
				dateadd(day,1,EOMONTH(a.������,-1)) �����,
				SUM(a.�����)�����,
				--m.[������0],
				 /* ����� � ���� ��������� ��� �� ��������� � ����� �� AA_DWH_X directoriDDS */
				case
					when m.��� IN ('00-000317','00-000318','00-000319','00-000320') and s.description = '����� 2023' then '������ ����������� ������ 2023 ����'--������ ����������� ������ 2023 ����
					when m.��� IN ('00-000317','00-000318','00-000319','00-000320') and s.description = '����� 2022' then '������ ����������� ������ 2022 ����'--������ ����������� ������ 2022 ����
					when m.��� IN ('00-000317','00-000318','00-000319','00-000320') AND s.description = '����� 2021' then '������ ����������� ������ 2021 ����'--������ ����������� ������ 2021 ����
					when m.��� IN ('00-000317','00-000318','00-000319','00-000320') AND s.description = '����� 2020' then '������ ����������� ������ 2020 ����'--������ ����������� ������ 2020 ����
					when m.��� IN ('00-000317','00-000318','00-000319','00-000320') and (s.description not in('����� 2023','����� 2022','����� 2021','����� 2020')) then '������ ����������� ������ 2019 ���� � �����'--������ ����������� ������ 2019 ���� � �����

					when m.��� IN ('00-000290','00-000290') and s.description = '����� 2023' then '����������� ������ 2023 ����' --����������� ������ 2023 ����
					when m.��� IN ('00-000290','00-000290') and s.description = '����� 2022' then '����������� ������ 2022 ����' --����������� ������ 2022 ����
					when m.��� IN ('00-000290','00-000290') and s.description = '����� 2021' then '����������� ������ 2021 ����' --����������� ������ 2021 ����
					when m.��� IN ('00-000290','00-000290') and s.description = '����� 2020' then '����������� ������ 2020 ����'--����������� ������ 2020 ����
					when m.��� IN ('00-000290','00-000290') and (s.description not IN ('����� 2020','����� 2021','����� 2022','����� 2023') ) then '����������� ������������ ������������� ������� ���'--����������� ������������ ������������� ������� ���

					--when m.���='00-000293' and (s.description not like '%2020%' and s.description not like '%2021%' ) then 'AL-000003'	
				else m.������������
				end as �������������_guid
					  --into #fact
				FROM [AA_DWH].[dbo].[������������������.������������] a 
				LEFT JOIN [AA_DWH].[dbo].����������� o on a.�����������=o.guid 
				LEFT JOIN [AA_DWH].[dbo].[������_���] m 
					ON m.guid = (CASE
									WHEN a.subconto_dt_1_type = '�����������������������������' THEN subconto_dt_1_guid
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
					   ������>EOMONTH('01.11.2019',0) and 
					   not(������ in ('1010','1030'--,'1050','1021'
						   ) 
						   and ������ in ('1010','1030'--,'1050','1021'
						))
					AND M.������������='������� �������, ����� ��������'
				group by --m.������������ ,dsp.guid,
				dateadd(day,1,EOMONTH(a.������,-1)) ,
				 --s.description,
				 --m.[������0],
				case
				when m.��� IN ('00-000317','00-000318','00-000319','00-000320') and s.description = '����� 2023' then '������ ����������� ������ 2023 ����'--������ ����������� ������ 2023 ����
				when m.��� IN ('00-000317','00-000318','00-000319','00-000320') and s.description = '����� 2022' then '������ ����������� ������ 2022 ����'--������ ����������� ������ 2022 ����
				when m.��� IN ('00-000317','00-000318','00-000319','00-000320') AND s.description = '����� 2021' then '������ ����������� ������ 2021 ����'--������ ����������� ������ 2021 ����
				when m.��� IN ('00-000317','00-000318','00-000319','00-000320') AND s.description = '����� 2020' then '������ ����������� ������ 2020 ����'--������ ����������� ������ 2020 ����
				when m.��� IN ('00-000317','00-000318','00-000319','00-000320') and (s.description not in('����� 2023','����� 2022','����� 2021','����� 2020')) then '������ ����������� ������ 2019 ���� � �����'--������ ����������� ������ 2019 ���� � �����

				when m.��� IN ('00-000290','00-000290') and s.description = '����� 2023' then '����������� ������ 2023 ����' --����������� ������ 2023 ����
				when m.��� IN ('00-000290','00-000290') and s.description = '����� 2022' then '����������� ������ 2022 ����' --����������� ������ 2022 ����
				when m.��� IN ('00-000290','00-000290') and s.description = '����� 2021' then '����������� ������ 2021 ����' --����������� ������ 2021 ����
				when m.��� IN ('00-000290','00-000290') and s.description = '����� 2020' then '����������� ������ 2020 ����'--����������� ������ 2020 ����
				when m.��� IN ('00-000290','00-000290') and (s.description not IN ('����� 2020','����� 2021','����� 2022','����� 2023') ) then '����������� ������������ ������������� ������� ���'--����������� ������������ ������������� ������� ���

				--when m.���='00-000293' and (s.description not like '%2020%' and s.description not like '%2021%' ) then 'AL-000003'


				else m.������������
				end 

UNION ALL


SELECT 
	[������] AS �����
	,sum([���������������������]) AS �����
	,'������ �� ������' �������������_guid
FROM [AA_DWH].[dbo].[�������������������������]isx  
LEFT JOIN AA_DWH.dbo.����������� o on isx.�����������_guid=o.guid
  
  WHERE o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,
						0x80DE000C29E67B2E11E636C101BBCFE5,
						0x8128000C29EF79CA11E9757EB6129375,
						0x83C700155D01C90111E7025A688EA921,
						0x83C700155D01C90111E7025ADF7BAD12,
						0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
						0xA2307085C2A4312A11EADBB4E5396FFA
						)AND
  isx.���� in ('1010','1030','1050','1021')
  and isx.[������]<>'3999-11-01' and isx.[������]>= '2019' --or isx.[������]='2021-02-01'

  group by [������]--,o.description,isx.����
 -- ORDER BY [������]--,o.description desc


),
PLAN_GOI AS (
			SELECT 
			CASE WHEN codeDDS='AL-000001' THEN '����������� ������ 2021 ����'
				WHEN codeDDS='AL-000002' THEN '����������� ������ 2020 ����'
				WHEN codeDDS='AL-000003' THEN '����������� ������������ ������������� ������� ���'
				WHEN codeDDS='AL-000004' THEN '������ ����������� ������ 2021 ����'
				WHEN codeDDS='AL-000005' THEN '������ ����������� ������ 2020 ����'
				WHEN codeDDS='AL-000006' THEN '������ ����������� ������ 2019 ���� � �����'
				ELSE SD.NAIMENOVANIE 
			END AS [codeDDS]
				  ,sum([Value])[Value]
				  ,dateadd(day,1,EOMONTH([planMonth],-1)) �����
			  FROM [AA_DWH_X].[dbo].[PlanBudzhet] AS PB
			  LEFT JOIN L1.DBO.STATI_DDS SD 
				ON PB.codeDDS=SD.KOD
			--WHERE dateadd(day,1,EOMONTH([planMonth],-1)) ='2021-01-01'
			group by CASE WHEN codeDDS='AL-000001' THEN '����������� ������ 2021 ����'
							WHEN codeDDS='AL-000002' THEN '����������� ������ 2020 ����'
							WHEN codeDDS='AL-000003' THEN '����������� ������������ ������������� ������� ���'
							WHEN codeDDS='AL-000004' THEN '������ ����������� ������ 2021 ����'
							WHEN codeDDS='AL-000005' THEN '������ ����������� ������ 2020 ����'
							WHEN codeDDS='AL-000006' THEN '������ ����������� ������ 2019 ���� � �����'
							ELSE SD.NAIMENOVANIE 
						END
					,dateadd(day,1,EOMONTH([planMonth],-1))
			)




SELECT *
FROM(
	select  isnull(F.�������������_guid,p.codeDDS)�������������_���
		  ,CASE WHEN F.�������������_guid='������ �� ������' THEN F.����� 
				ELSE P.value 
			END AS ����
		  ,[�����] ����
		  ,isnull(f.[�����],P.�����)[�����]
	FROM PLAN_GOI AS P--f1 
	FULL JOIN FACT F  
		on (F.�������������_guid=P.codeDDS and F.[�����]=P.�����)
) FP
LEFT JOIN [L1_X].[dbo].[FIN_REFERENCE_DDS] FRD 
	ON FP.�������������_���=FRD.DDS

	ORDER BY [�����]