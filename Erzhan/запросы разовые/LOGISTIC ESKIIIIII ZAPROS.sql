

SELECT 
	n.description name
	,n.������������� man
	,b.������������� �����,
	convert(nvarchar(50),b.������������_guid,1) guid
	,scor.������������� pay
	,scor.������������������� price
	,case when sum(��������) is null then (sum( b.����������))
	   else (sum( b.����������)-sum(��������)) end AS  quan
	,datepart(week,b.[������������]) week,
	DATEADD(WEEK,datepart(week,b.[������������]),'25/12/2020') date

FROM [AA_DWH].[dbo].[��������������������] a
left join (select sum(����������) ����������
				, �������_guid
				,������������_guid
				,�������������
				,�������������_guid
				,min(������������)������������
			from [AA_DWH].[dbo].[����������������������] 
			--WHERE �������_guid=0xAF90D4F5EF10792511ED44C64B26520D
			group by �������_guid
				,������������_guid
				,�������������
				,�������������_guid
	) b on a.guid=b.�������_guid
left join (
			select queto.guid
				,case when kbo.������������� is null then queto.������������� else kbo.������������� end �������������
				,queto.�������������������
			from (select 
					zxc.guid
					,case when gkh.������������� is null then 1 else gkh.������������� end �������������
					,case when gkh.������������������� is null then zxc.price else gkh.������������������� end �������������������
  
					from (
							select convert(nvarchar(50),ggg.guid,1) guid
								,ggg.�������������������
								,case when bro.������������� is null then ggg.������������� else bro.������������� end �������������

							from (select 
					                 convert(nvarchar(50),n.������������_guid,1) guid
									 ,case when ��������� in('��� "������-���������"','��� "������� ��������� ���������"') then 0.2 else 1 end �������������
                                     ,isnull(s.��������������KZT,isnull(max(case when �������='���� ������' then  p.���� end),max(case when �������='���� ������ EUR' then  p.���� end)*510))�������������������   /* ����� ���� �� ��������� � ������������, ���� ���, �� '���� ������' � �����, ���� ���, �� '���� ������ EUR' �� ����� 510*/

								 from (SELECT distinct
											n.�������������,
											n.description ������������
											,sd.������������_guid [������������_guid] 
										FROM [AA_DWH].[dbo].[����������������������] sd
										LEFT JOIN [AA_DWH].[dbo].[������������] n on n.guid_binary = sd.[������������_guid]
										LEFT JOIN [AA_DWH].[dbo].[��������������������] dc on dc.guid = sd.[�������_guid]
										LEFT JOIN [AA_DWH].[dbo].����������� c on c.guid = dc.[����������_guid]
										LEFT JOIN [AA_DWH].[dbo].������ s on s.guid = dc.[�����_guid]
										WHERE dc.����������� IN ('� ����������� / ����������')
										AND dc.[source_base] = 'erp'
										AND [������] = '���������'
										AND c.[description] <> 'LLC Alem Agro KG (���� ���� ���� ��� ���)'
										AND (s.description = '����� 2022')
										) n 
									left join [AA_DWH].[dbo].����������������_��������� p on p.������������_guid=n.������������_guid
									left join (select a.������������_guid
														,a.���������
														, a.��������������KZT 
												from (SELECT
															sd.������������_guid,
															c.description ���������,
															max(ROUND(CASE WHEN (v.������ IS NOT NULL AND v.���� IS NOT NULL) THEN sd.[����]*v.���� ELSE sd.[����] END,2)) AS [��������������KZT] 
 
														FROM [AA_DWH].[dbo].[����������������������] sd
														  LEFT JOIN [AA_DWH].[dbo].[��������������������] dc on dc.guid = sd.[�������_guid]
														  LEFT JOIN [AA_DWH].[dbo].����������� c on c.guid = dc.[����������_guid]
														  LEFT JOIN [AA_DWH].[dbo].������ s on s.guid = dc.[�����_guid]
														  LEFT JOIN [AA_DWH].[dbo].��������� m on m.guid = dc.[��������_guid]
														  LEFT JOIN [AA_DWH].[dbo].[����������All] v on v.������ = dc.[����] AND v.������ = dc.��������������������
														  WHERE dc.����������� IN ('� ����������� / ������������', '������', '���� �� ����')
														  AND dc.[source_base] = 'erp'
														  AND m.description IN ('��������� �����', '������ ������', '������� ������ ������������')
														  AND [������] = '���������'
														  AND c.[description] <> 'LLC Alem Agro KG (���� ���� ���� ��� ���)'
														-- AND (s.description = '����� 2022')
														  GROUP BY 
														 sd.������������_guid,
														c.description
														)a  
												join(select 
														a.������������_guid
														, max(��������������KZT) ��������������KZT
													from  (SELECT
																sd.������������_guid,
																c.description ���������,
																max(ROUND(CASE WHEN (v.������ IS NOT NULL AND v.���� IS NOT NULL) THEN sd.[����]*v.���� ELSE sd.[����] END,2)) AS [��������������KZT] 
															FROM [AA_DWH].[dbo].[����������������������] sd

															  LEFT JOIN [AA_DWH].[dbo].[��������������������] dc on dc.guid = sd.[�������_guid]
															  LEFT JOIN [AA_DWH].[dbo].����������� c on c.guid = dc.[����������_guid]
															  LEFT JOIN [AA_DWH].[dbo].������ s on s.guid = dc.[�����_guid]
															  LEFT JOIN [AA_DWH].[dbo].��������� m on m.guid = dc.[��������_guid]
															  LEFT JOIN [AA_DWH].[dbo].[����������All] v on v.������ = dc.[����] AND v.������ = dc.��������������������
															  WHERE dc.����������� IN ('� ����������� / ������������', '������', '���� �� ����')
																  AND dc.[source_base] = 'erp'
																  AND m.description IN ('��������� �����', '������ ������', '������� ������ ������������')
																  AND [������] = '���������'
																  AND c.[description] <> 'LLC Alem Agro KG (���� ���� ���� ��� ���)'
																-- AND (s.description = '����� 2022')
															  GROUP BY 
															 sd.������������_guid,
															c.description 
														) a 
													group by a.������������_guid
												) b on a.������������_guid=b.������������_guid and a.��������������KZT=b.��������������KZT
											) s on n.������������_guid=s.������������_guid    
										WHERE   
											isnull(����, 0) <> 0 
											and p.������� like '%���� ������%' 
											and year(p.date)='2022' 
										group by convert(nvarchar(50),n.������������_guid,1),
										s.���������,s.��������������KZT
										) ggg
									left join (SELECT distinct convert(nvarchar(50),c.guid_binary,1) guid_binary,
													c.description
													,c.��������
													,case when ��������='������������' then 0.2 else 1 end �������������
												FROM [AA_DWH].[dbo].[������������] c
												where �������������='Pioneer' 
													and �������� is not null 
													and ��������!=''
												) bro on bro.guid_binary=ggg.guid
								) gkh
					right join (SELECT convert(nvarchar(50),a.guid_binary,1) guid
								,w.���� price
								FROM [AA_DWH].[dbo].������������ a 
								LEFT JOIN [AA_DWH].[dbo].[����������������_���������] w ON w.������������_guid = a.guid_binary 
								LEFT JOIN[AA_DWH].[dbo].[������] r_b ON r_b.[guid] = w.[�����_guid] 
								JOIN(SELECT ������������_guid
											, �������
											, ���������
											, max(date) date
										FROM            [AA_DWH].[dbo].����������������_���������
										WHERE        isnull(����, 0) <> 0
										GROUP BY ������������_guid, �������, ���������
									) b ON b.������������_guid = w.������������_guid 
										AND b.��������� = w.��������� 
										AND b.date = w.date 
										AND b.������� = w.�������
									WHERE a.description IS NOT NULL AND isnull(w.����, 0) <> 0 AND (w.������� = '���� ������') AND (a.��������2 = '��� ' OR
																a.��������2 = '������ ' OR
																a.��������2 = '���������')
									) zxc on zxc.guid=gkh.guid
				) queto
			left join (select convert(nvarchar(50),guid_binary,1) guid_binary
							,description
							,�������������
							,case when �������������='Valagro' then 0
									when �������������='BASF' then 0
									when description='�������� ����, 10*500 ��.' then 0.5
									when �������������='FMC' then 0.15 end �������������
						from [AA_DWH].[dbo].[������������] a
						where (case when �������������='Valagro' then 0
									when �������������='BASF' then 0
									when description='�������� ����, 10*500 ��.' then 0.5
									when �������������='FMC' then 0.15 end) is not null and (a.��������2 = '��� ' OR
																a.��������2 = '������ ' OR
																a.��������2 = '���������')
		) kbo on kbo.guid_binary=queto.guid
	) scor on convert(nvarchar(50),scor.guid,1)=convert(nvarchar(50),b.������������_guid,1)
left join [AA_DWH].[dbo].��������� m on a.��������_guid=m.guid
left join [AA_DWH].[dbo].������������ n on b.������������_guid=n.guid_binary
left join [AA_DWH].[dbo].������ s on s.guid=a.�����_guid
left join [AA_DWH].[dbo].����������� o on o.guid=a.�����������_guid
left join (SELECT 
				[�������_guid]
				,[������������_guid]
				,[������������_v2_guid]
				,sum([����������]) ��������
			FROM [AA_DWH].[dbo].[���������������������������_guid]
			group by [�������_guid]
				,[������������_guid]
				,[������������_v2_guid]
			) v on v.�������_guid=b.�������_guid and v.������������_guid=b.������������_guid
left join (SELECT  
				[������������_guid]
			FROM [AA_DWH].[dbo].[��������������������������������������] 
			where [source_base]='erp'
			group by   [������������_guid]
		) t on b.������������_guid=t.[������������_guid]
where s.description like '%2022%' 
		and   [������]='���������'
		and �����������= '� ����������� / ����������'
		and b.������������_guid is not null
		and o.description like '%��� �Alem Agro Holding (�������� �������)�%'
group by --a.description,
		n.description
		,n.�������������
		,b.�������������
		,scor.�������������
		,scor.�������������������
		,convert(nvarchar(50),b.������������_guid,1)
		,datepart(week,b.[������������])
		,DATEADD(WEEK,datepart(week,b.[������������]),'25/12/2020')
