WITH FACT_1 AS(     /**** �������� ����� �� ������ '1030','1010' ***/
				SELECT
				dateadd(day,1,EOMONTH(a.������,-1)) �����,
				CASE WHEN a.������ IN('1030','1010') THEN a.�����*(-1) ELSE a.����� END AS �����,
				a.������,
				a.������,
				o.description as organizasii ,
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
				else m.������������
				end as �������������_guid

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
					   ������>EOMONTH('01.11.2021',0) and 
					   not(������ in ('1010','1030'--,'1050','1021'
						   ) 
						   and ������ in ('1010','1030'--,'1050','1021'
						))

)
,FACT AS(
		SELECT 
			F1.�����
			,SUM(F1.�����) AS �����
			,F1.organizasii
			,F1.�������������_guid
		FROM FACT_1 F1
		GROUP BY 
		F1.�����
		,F1.organizasii
		,F1.�������������_guid





	UNION ALL


		SELECT 
			[������] AS �����
			,sum([���������������������]) AS �����
			,o.description as organizasii
			,'������ �� ������' �������������_guid
		FROM [AA_DWH].[dbo].[�������������������������]isx  
		LEFT JOIN AA_DWH.dbo.����������� o on isx.�����������_guid=o.guid
		  WHERE o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,     -----ORGANIZATSIA GUID
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
		  ,o.description
		 -- ORDER BY [������]--,o.description desc

 )
 , AILAR AS (/*** ������  ��� ���������� 0,01 � �������� ����� � ������ ���***/
			 SELECT DISTINCT FACT.�����
			 FROM FACT
			 WHERE FACT.�����>='2022-01-01'
			)
,DOBAVLENIE_0 AS (/***  ��� ����� ��� ���������, ����� � ��� ���������� ������ � ���������� � �������������� ������������ ***/
				SELECT 
				A.�����
				,ISNULL(DA.�������������_guid,'����������� ������� �� ���������� �������') AS �������������_guid
				,ISNULL(DA.�����,0.01)�����
				FROM AILAR A
				LEFT JOIN (
							 SELECT  FACT.�����
							 ,FACT.�������������_guid
							 ,FACT.�����
							 FROM FACT
							 WHERE FACT.�������������_guid = '����������� ������� �� ���������� �������'
						 )AS DA 
					ON A.�����=DA.�����
				WHERE DA.�������������_guid IS NULL 

	UNION ALL

				SELECT 
				A.�����
				,ISNULL(FIN.�������������_guid,'������� ��� �������� � ������ (����������)') AS �������������_guid
				,ISNULL(FIN.�����,0.01)�����
				FROM AILAR A
				LEFT JOIN (
							 SELECT  FACT.�����
							 ,FACT.�������������_guid
							 ,FACT.�����
							 FROM FACT
							 WHERE FACT.�������������_guid IN ('��������� ���� �������� � ������ (��������� �����������)'
																,'������� ��� �������� � ������ (��������� �����������)'
																,'������� ��� �������� � ������ (����������)'
													,'����������� ������� � �������� �������'
													) )AS FIN 
					ON A.�����=FIN.�����
				WHERE FIN.�������������_guid IS NULL 
)
--,PLAN_GOI AS (/*** ����, ���� ��� ����� �������� **/
--			SELECT 
--			CASE WHEN codeDDS='AL-000001' THEN '����������� ������ 2021 ����'
--				WHEN codeDDS='AL-000002' THEN '����������� ������ 2020 ����'
--				WHEN codeDDS='AL-000003' THEN '����������� ������������ ������������� ������� ���'
--				WHEN codeDDS='AL-000004' THEN '������ ����������� ������ 2021 ����'
--				WHEN codeDDS='AL-000005' THEN '������ ����������� ������ 2020 ����'
--				WHEN codeDDS='AL-000006' THEN '������ ����������� ������ 2019 ���� � �����'
--				ELSE SD.NAIMENOVANIE 
--			END AS [codeDDS]
--				  ,sum([Value])[Value]
--				  ,dateadd(day,1,EOMONTH([planMonth],-1)) �����
--			  FROM [AA_DWH_X].[dbo].[PlanBudzhet] AS PB
--			  LEFT JOIN L1.DBO.STATI_DDS SD 
--				ON PB.codeDDS=SD.KOD
--			--WHERE dateadd(day,1,EOMONTH([planMonth],-1)) ='2021-01-01'
--			group by CASE WHEN codeDDS='AL-000001' THEN '����������� ������ 2021 ����'
--							WHEN codeDDS='AL-000002' THEN '����������� ������ 2020 ����'
--							WHEN codeDDS='AL-000003' THEN '����������� ������������ ������������� ������� ���'
--							WHEN codeDDS='AL-000004' THEN '������ ����������� ������ 2021 ����'
--							WHEN codeDDS='AL-000005' THEN '������ ����������� ������ 2020 ����'
--							WHEN codeDDS='AL-000006' THEN '������ ����������� ������ 2019 ���� � �����'
--							ELSE SD.NAIMENOVANIE 
--						END
--					,dateadd(day,1,EOMONTH([planMonth],-1))
--			)




SELECT /*CASE ����� ��� ����������*/
*
,CASE WHEN PARENT_3='����������� ������ �� ��������, � �.�.' THEN 1
	WHEN PARENT_3='������ �����������, � �.�.' THEN 2
	WHEN PARENT_3='������������ �������, � �.�.' THEN 3
	WHEN PARENT_3='����������� ������ �� ������� �� ��������� (��������)' THEN 4
	WHEN PARENT_3='������������ ������� (�������� ���)' THEN 5
	WHEN PARENT_3='��������� ������' THEN 6
	WHEN PARENT_3='��������� ������' THEN 7
	WHEN PARENT_3='����������� ������� �� ���������� �������' THEN 8
	WHEN PARENT_3='������� ������������ �������' THEN 9
	WHEN PARENT_3='������ �����������' THEN 10
	WHEN PARENT_3='������ �������' THEN 11
	WHEN PARENT_3='�������� �������' THEN 12
END AS NOMER_PARENT_3
FROM(
	select  F.�������������_guid AS �������������_���
		  ,[�����] AS ����
		  ,[�����]
		  ,f.organizasii
	FROM FACT F  
UNION ALL
SELECT 
	D.�������������_guid
	,D.����� AS ����
	,D.�����
	,null as organizasii
FROM DOBAVLENIE_0 AS D

) FP
LEFT JOIN [L1_X].[dbo].[FIN_REFERENCE_DDS] FRD 
	ON FP.�������������_���=FRD.DDS
WHERE 1=1
--AND �����='2022-01-01'
--and FP.�������������_���='����������� ������ �� ������� �� ��������� (��������)'
	ORDER BY --[�����],
	FRD.PARENT_1