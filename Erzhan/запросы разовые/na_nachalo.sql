WITH SALDO AS(/**��� ������**/
			SELECT cast(������ AS DATE)[������]
					,SUM(CASE WHEN ������ in ('1030','1010','1050','1021') THEN r.����� ELSE 0 END) AS ��,
					SUM(CASE WHEN ������ in('1030','1010','1050','1021') THEN r.����� ELSE 0 END) AS ��
					,O.description �����������
					,R.����������� AS �����������_GUID
			FROM [AA_DWH].[dbo].[������������������.������������] r
			LEFT JOIN AA_DWH.dbo.����������� o on o.guid=r.�����������
			WHERE (r.������ in ('1030','1010','1050','1021') OR r.������ in('1030','1010','1050','1021')) 
			GROUP BY cast(������ AS DATE)
					,O.description
					,R.����������� 
		)
,MAX_ORGA AS (/**���� ������ ����� ��� ��� ���� �����������**/
			SELECT 
				S2.�����������
				,�����������_GUID
				,MAX(S2.������) AS ������
			FROM SALDO S2
			WHERE S2.������!=CAST(GETDATE() AS DATE)
			GROUP BY S2.�����������
			,�����������_GUID
)

SELECT DISTINCT
	MO.�����������
	,CONVERT(NVARCHAR(50),MO.�����������_GUID,1)�����������_GUID
	,CAST(GETDATE() AS DATE) AS ������
	,SUM_ORG.runqty
FROM MAX_ORGA MO 
LEFT JOIN 
(/**��������� � ������ ������������ ��������**/
  SELECT 
	  S2.������
	  ,S2.��
	  ,S2.��
	  --,S2.��-S2.��
	  ,S2.�����������
	  ,�����������_GUID
	  ,SUM(��) OVER(PARTITION BY S2.�����������,�����������_GUID
					ORDER BY ������,S2.�����������,�����������_GUID
					ROWS BETWEEN UNBOUNDED PRECEDING
							 AND CURRENT ROW)
		-SUM(��) OVER(
					PARTITION BY S2.�����������,�����������_GUID
					ORDER BY ������,S2.�����������,�����������_GUID
					ROWS BETWEEN UNBOUNDED PRECEDING
							 AND CURRENT ROW)
		AS runqty
	FROM SALDO AS  S2 
	WHERE S2.������!=CAST(GETDATE() AS DATE)
    --ORDER BY ������ desc
) SUM_ORG
ON MO.�����������=SUM_ORG.�����������
AND MO.������ =SUM_ORG.������

