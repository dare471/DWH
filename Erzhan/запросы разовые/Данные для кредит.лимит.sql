--570121301787

WITH ALLL AS (
SELECT 
	 SUBSTRING(ssns.naimenovanie, 7,4) AS YY ,isnull(isnull(STRK.RODITEL2, STRK.RODITEL), STRK.naimenovanie) AS ��������, m.naimenovanie ��������
	,b.naimenovanie ������������, k.�������, k.�����, k.����, k.���������������, k.��������
	,k.�����������, k.�����, k.��, d.������������, d.��������������, p.����������
	,round( p.����������/(case when d.��������������=0 then 1 else d.�������������� end),4)*100 ��������������
	,s.summa �����������, v.summa ������������, o.summa ����������, vo.�����������������
	,ea.����������, ea.������������, ea.���������--, ea.���
 FROM (--������������--��������������------------------------------------------------------------------------------------------------------------
		select dk.[menedzher_guid] [menedzher_guid], dk.[biznes_region_guid] [biznes_region_guid]
			,dk.[kontragent_guid] [kontragent_guid], dk.[sezon_guid]
			,count(dk.[naimenovanie]) ������������, sum([summa])��������������
		 FROM [L1].[dbo].[dogovory_kontragentov] dk
		  left join [L0].[dbo].[organizatsii] o on o.[ssylka]=dk.[organizatsiya_guid]
		   where [status] = '���������' and [summa] > 0 and [tip_dogovora] = '� ����������� / ����������'  
			 and o.[naimenovanie] like '%��� �Alem Agro Holding (�������� �������)�%'
		  group by dk.[menedzher_guid], dk.[biznes_region_guid], dk.[kontragent_guid], dk.[sezon_guid]
		) d

	LEFT JOIN (--��----����----------------------------------------------------------------------------------------------------------
				SELECT DISTINCT  c.[guid], c.[description] [��]--[������������ �������]--, c.[�����������������������������]
					  ,c.���_��� [�����],c.[��������������������]--, c.[kato], c.[source_base], CONVERT(VARCHAR(50), c.[guid_partner], 1) AS [guid_partner]
					  ,CASE WHEN FIRST_VALUE(p.description) OVER (PARTITION BY c.[guid] ORDER BY c.[guid_partner]) IS NULL THEN c.description ELSE FIRST_VALUE(p.description) OVER (PARTITION BY c.[guid] ORDER BY c.[guid_partner]) END AS [��������]
					  ,CASE WHEN FIRST_VALUE(p.[���_���]) OVER (PARTITION BY c.[guid] ORDER BY c.[guid_partner]) IS NULL THEN c.[���_���] ELSE FIRST_VALUE(p.[���_���]) OVER (PARTITION BY c.[guid] ORDER BY c.[guid_partner]) END AS [�����������]
					  ,concat(c.[description], ' - ', c.[���_���]) [contragentDetails]
					  , c.[isDiller], r.relationType, cato.region �������, cato.district �����, cato.village01 ����, cato.village02 ��������������� 
				  FROM [AA_DWH].[dbo].[�����������] c
				  LEFT JOIN [AA_DWH].[dbo].[relationShip] r ON c.guid_partner = r.contragent2_guid
				  left join [AA_DWH].[dbo].����������� p on r.contragent1_guid=p.guid_partner 
				  LEFT JOIN ( SELECT a.cato_Id, a.name, a.[group]
								  ,l1.name region ,case when a.[lvl1]<>'00' then a.[lvl1]+'0000000' else null end region_code
								  ,l2.name district ,case when a.[lvl1]<>'00' and a.[lvl2]<>'00'then a.[lvl1]+a.[lvl2]+'00000' else null end district_code,
								  l3.name village01 ,l4.name village02
								  ,'���������' country ,concat('���������', ', ', l1.name, ', ', l2.name, ', ', l3.name, ', ', l4.name) [location]
								  ,case when a.[lvl2]<>'00' and a.[lvl3]<>'00' and a.lvl4<>'000' then a.[lvl1]+a.[lvl2]+a.lvl3+'000' else null end village_code
							  FROM [AA_DWH_X].[dbo].[cato] a left join [AA_DWH_X].[dbo].[cato] l1 on (case when a.[lvl1]<>'00' then a.[lvl1]+'0000000' else null end) = l1.cato_Id
															 left join [AA_DWH_X].[dbo].[cato] l2 on (case when a.[lvl2]<>'00' then a.[lvl1]+a.[lvl2]+'00000' else null end) = l2.cato_Id  
															 left join [AA_DWH_X].[dbo].[cato] l3 on (case when a.[lvl3]<>'00' then a.[lvl1]+a.[lvl2]+a.lvl3+'000' else null end) = l3.cato_Id
															 left join [AA_DWH_X].[dbo].[cato] l4 on (case when a.[lvl4]<>'000' then a.[lvl1]+a.[lvl2]+a.lvl3+a.[lvl4] else null end) = l4.cato_Id
							) cato ON  cato.cato_Id = c.kato where c.[source_base] = 'erp') k ON d.kontragent_guid = k.guid

LEFT JOIN [L1].dbo.sezony ssns on d.sezon_guid=ssns.guid
LEFT JOIN [L1].dbo.menedzhery m on d.menedzher_guid=m.guid
OUTER APPLY (SELECT TOP 1 KADR.struktura_predpriyatiya_guid
			  FROM [L1].[dbo].[kadrovaya_istoriya_sotrudnikov]  KADR
			   WHERE KADR.fizicheskoe_litso_guid = M.FIZICHESKOE_LITSO_GUID ORDER BY KADR.period DESC) KADR 
LEFT JOIN [L1].[dbo].[struktura_predpriyatiya] STRK ON STRK.guid = KADR.struktura_predpriyatiya_guid
LEFT JOIN [L0].dbo.biznes_regiony b on d.biznes_region_guid=b.ssylka
LEFT JOIN (--����������------------------------------------------------------------------------------------------------------------
			SELECT [menedzher_guid] ,[biznes_region_guid]
				,[kontragent_guid] ,[sezon_guid]
				,SUM(CASE WHEN min_data_otgruzki >= data_po_grafiku THEN summa_oplaty ELSE 0 END) ����������
			 FROM 	(select dk.[menedzher_guid] ,dk.[biznes_region_guid]
						,dk.[kontragent_guid] ,dk.[sezon_guid]
						,dk.[data] ,dk.[naimenovanie]
						,dk.[summa] ,dk.[usloviya_oplaty]
						,g.summa_oplaty ,g.data_po_grafiku
						,MIN(s.[data_otgruzki]) min_data_otgruzki
					 FROM [L1].[dbo].[dogovory_kontragentov] dk
					  LEFT JOIN [L0].[dbo].[organizatsii] o on o.[ssylka]=dk.[organizatsiya_guid]
					  LEFT JOIN [L1].[dbo].[grafik_ispolneniya_dogovora] g ON g.dogovor_guid = dk.guid
					  LEFT JOIN [L1].[dbo].[spetsifikatsiya_po_dogovoru] s ON s.dogovor_guid = dk.guid
					   where dk.[status]='���������' and dk.[summa]>0  
					     and dk.[tip_dogovora]='� ����������� / ����������'  
						 and o.[naimenovanie] like '%��� �Alem Agro Holding (�������� �������)�%'
						group by dk.[menedzher_guid], dk.[biznes_region_guid], dk.[kontragent_guid], dk.[sezon_guid],dk.[data],
					dk.[naimenovanie], dk.[summa], dk.[usloviya_oplaty], g.summa_oplaty, g.data_po_grafiku
					) min_data_otgr
			GROUP BY [menedzher_guid], [biznes_region_guid], [kontragent_guid], [sezon_guid]
			) p ON d.kontragent_guid = p.kontragent_guid 
				AND d.biznes_region_guid = p.biznes_region_guid 
				AND d.menedzher_guid = p.menedzher_guid 
				AND d.sezon_guid = p.sezon_guid

--��������������--------------------------------------------------------------------------------------------------------------
--round( pred.����������2021/(case when d.������������2021=0 then 1 else d.������������2021 end),4)*100 ��������������2021

LEFT JOIN (--�����������--------------------------------------------------------------------------------------------------------------
			SELECT 
				 [menedzher_guid]
				,[biznes_region_guid]
				,r.KONTRAGENT_GUID
				,[sezon_guid]
				,SUM(r.[summa]) [summa]
			  FROM [L1].[dbo].[raschety_s_klientami] r
			   LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid]
			    where [synonym_registrator] = '���������� ������� � �����' 
				 group by [menedzher_guid], [biznes_region_guid], r.KONTRAGENT_GUID, [sezon_guid]
		  ) s ON d.kontragent_guid = s.kontragent_guid 
			  AND d.biznes_region_guid = s.biznes_region_guid 
			  AND d.menedzher_guid = s.menedzher_guid 
			  AND d.sezon_guid = s.sezon_guid

LEFT JOIN (--������������--------------------------------------------------------------------------------------------------------------
			SELECT 
				 [menedzher_guid]
				,[biznes_region_guid]
				,r.[KONTRAGENT_GUID]
				,[sezon_guid]
				,SUM(r.[summa]) [summa]
			  FROM [L1].[dbo].[raschety_s_klientami] r
			   LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid]
			     where [synonym_registrator] = '������� ������� �� �������' 
				  group by [menedzher_guid], [biznes_region_guid], r.[KONTRAGENT_GUID], [sezon_guid]
		  ) v ON d.kontragent_guid = v.kontragent_guid 
			  AND d.biznes_region_guid = v.biznes_region_guid 
			  AND d.menedzher_guid = v.menedzher_guid 
			  AND d.sezon_guid = v.sezon_guid

LEFT JOIN 	(--����������--------------------------------------------------------------------------------------------------------------
			SELECT 
				 [menedzher_guid]
				,[biznes_region_guid]
				,dk.[KONTRAGENT_GUID]
				,[sezon_guid]
				,SUM(r.[summa]) [summa]
			 FROM [L1].[dbo].[raschety_s_klientami] r
			  LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid]
			   where [synonym_registrator] IN (  '��������� �������� �����'
												,'����������� �������������'
												,'����������� ����������� �������� �������') 
				 AND dk.[kontragent_guid] = 0x801E00155D01C90111E6E2B175C51CD1
			  group by [menedzher_guid], [biznes_region_guid], dk.[kontragent_guid], [sezon_guid]
			) o ON d.kontragent_guid = o.kontragent_guid 
				AND d.biznes_region_guid = o.biznes_region_guid 
				AND d.menedzher_guid = o.menedzher_guid 
				AND d.sezon_guid = o.sezon_guid

LEFT JOIN 	(--�����������������--------------------------------------------------------------------------------------------------------------
			SELECT vo.* 
			 FROM 	(
					SELECT 
						 dk.[kontragent_guid]
						,dk.sezon_guid
						,dk.biznes_region_guid
						,dk.menedzher_guid 
						,[synonym_registrator]
						,SUM(CASE WHEN r.period >= lr.lastReturn AND r.summa >0 THEN r.summa ELSE NULL END) [�����������������] 
					 FROM [L1].[dbo].[raschety_s_klientami] r
					  LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid]
					  LEFT JOIN [L0].[dbo].[sezony] s ON dk.sezon_guid = s.ssylka
					  LEFT JOIN 	(SELECT 
										 dk.[kontragent_guid]
										,dk.sezon_guid sezon_guid
										,MAX([period]) lastReturn 
									  FROM [L1].[dbo].[raschety_s_klientami] r 
									   LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid] 
									   LEFT JOIN [L0].[dbo].[sezony] s ON dk.sezon_guid = s.ssylka 
									    WHERE [synonym_registrator] IN ('������� ������� �� �������')
									  GROUP BY dk.[kontragent_guid], dk.sezon_guid
									) lr ON lr.[kontragent_guid] = dk.kontragent_guid 
									     AND lr.sezon_guid = dk.sezon_guid
						WHERE [synonym_registrator] IN ( '��������� �������� �����'
														,'����������� �������������'
														,'����������� ����������� �������� �������'
														, '������� ������� �� �������')
					      AND lastReturn IS NOT NULL
					     GROUP BY dk.[kontragent_guid], [synonym_registrator], dk.sezon_guid, dk.biznes_region_guid, dk.menedzher_guid
					) vo
			  WHERE vo.[synonym_registrator] = '������� ������� �� �������'
			) vo ON d.kontragent_guid = vo.kontragent_guid 
			     AND d.biznes_region_guid = vo.biznes_region_guid 
				 AND d.menedzher_guid = vo.menedzher_guid 
				 AND d.sezon_guid = vo.sezon_guid

LEFT JOIN 	(--������������--------------------------------------------------------------------------------------------------------------
			SELECT 
				 e.bin
				,SUM(e.������������) ������������ 
				,SUM(e.�����) ����������
				,COALESCE(SUM(e.������������)/ NULLIF(SUM(e.�����),0), 0)*100 ���������
				,e.��� 
			 FROM 	(SELECT 
						 DISTINCT [esfCode]
						,[�������]
						,[�������] AS [�����]
						,CASE WHEN [����������]='������������ � ������������ ���������������� "Alem Agro Holding (�������� �������)"' THEN [�������] ELSE NULL END AS ������������
						,[����������]
						,substring([esfCode], 18,4) [���]
						,bin
					 FROM [AA_DWH_X].[dbo].[L1_esfFinal]
					  LEFT JOIN ( 
					  SELECT DISTINCT d.bin, d.id, n.number Olzhas FROM [AA_DWH_X].[dbo].[L0_ids_shymbulaq_disclosed] d LEFT JOIN [AA_DWH_X].[dbo].[L0_ids_shymbulaq] n ON n.id = d.id
								) b ON b.Olzhas = [n]
						WHERE [������] IN ( '������ � ������'
										   ,'������ ��������'
										   ,'������ ������'
										   ,'����������� ������')
						  AND b.bin IS NOT NULL AND [esfCode] IS NOT NULL
					) e 
			  GROUP BY e.bin, e.���
			) ea ON k.����� = ea.bin 
			    AND SUBSTRING(ssns.naimenovanie, 7,4) = ea.���

)




SELECT 
	 ALLL.��������  
	,ALLL.��������
	,ALLL.������������
	,ALLL.�������
	,ALLL.�����
	,ALLL.����
	,ALLL.���������������
	,ALLL.��������
	,ALLL.�����������
	,ALLL.�����
	,ALLL.��

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.������������ END) ������������2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.������������ END) ������������2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.������������ END) ������������2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.������������ END) ������������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.������������ END) ������������2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.������������ END) ������������2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.������������ END) ������������2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.�������������� END ) ������������2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.�������������� END ) ������������2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.�������������� END ) ������������2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.�������������� END ) ������������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.�������������� END ) ������������2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.�������������� END ) ������������2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.�������������� END ) ������������2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.���������� END ) ����������2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.���������� END ) ����������2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.���������� END ) ����������2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.���������� END ) ����������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.���������� END ) ����������2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.���������� END ) ����������2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.���������� END ) ����������2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.�������������� END ) ��������������2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.�������������� END ) ��������������2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.�������������� END ) ��������������2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.�������������� END ) ��������������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.�������������� END ) ��������������2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.�������������� END ) ��������������2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.�������������� END ) ��������������2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.����������� END ) �����������2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.����������� END ) �����������2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.����������� END ) �����������2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.����������� END ) �����������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.����������� END ) �����������2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.����������� END ) �����������2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.����������� END ) �����������2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.������������ END ) ������������2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.������������ END ) ������������2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.������������ END ) ������������2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.������������ END ) ������������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.������������ END ) ������������2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.������������ END ) ������������2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.������������ END ) ������������2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.������������ END ) ����������2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.������������ END ) ����������2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.������������ END ) ����������2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.������������ END ) ����������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.������������ END ) ����������2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.������������ END ) ����������2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.������������ END ) ����������2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.����������������� END ) �����������������2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.����������������� END ) �����������������2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.����������������� END ) �����������������2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.����������������� END ) �����������������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.����������������� END ) �����������������2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.����������������� END ) �����������������2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.����������������� END ) �����������������2023
	
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.���������� END ) ����������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.���������� END ) ����������2021

	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.������������ END ) ������������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.������������ END ) ������������2021

	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.��������� END ) ���������2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.��������� END ) ���������2021
	
 FROM ALLL 
   GROUP BY	 ALLL.��������  
		    ,ALLL.��������
			,ALLL.������������
			,ALLL.�������
			,ALLL.�����
			,ALLL.����
			,ALLL.���������������
			,ALLL.��������
			,ALLL.�����������
			,ALLL.�����
			,ALLL.��