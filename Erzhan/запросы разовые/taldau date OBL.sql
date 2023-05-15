WITH CROP_ID_DISTINCT AS(
						SELECT 
							MAX([crop_ID]) AS [crop_ID]
							,[crop]
						FROM [L0_X].[dbo].[TALDAU_OBLAST]
						GROUP BY [crop]
					)

,ALL_DATA AS(
SELECT DISTINCT
	[location_ID]
      ,[all_ID]
      ,[categories_ID]
      --,CID.[crop_ID]
      ,[location]
      ,[all]
      ,[categories]
	  ,CASE WHEN CID.[crop]='�������� ���������' THEN '�������� ���������'
			WHEN CID.[crop] IN ('�������','�������� (����)','������, ���� � ����','����� (�������), ����� � �������� �������� ������') THEN '�������� ��������'
			ELSE '������ ��������'
		END AS [crop]
	  --,CID.[crop]
      ,[name] AS [YEAR]
      ,[date]
	  ,SUM(CONVERT(NUMERIC(20,2),[value],1))/10000 AS [value]
	  --,SUM(CONVERT(NUMERIC(20,2),[value],1)) OVER (PARTITION BY CASE WHEN CROP='�������� ��������')
      --,SUM(CONVERT(NUMERIC(20,2),[value],1))/1000 AS [value]
  FROM CROP_ID_DISTINCT AS CID
  LEFT JOIN [L0_X].[dbo].[TALDAU_OBLAST] AS [TO]
  ON CID.[crop_ID]=[TO].[crop_ID]
  WHERE [all_ID]=808497
  AND [categories_ID]=450122
  AND CID.[crop] IN ('���, ������������','����� � ��������, ���������� � �����������','����� ��������������','�������� ����������� ����������','�������� �������� ������',
  '�������','�������� (����)','������, ���� � ����','����� (�������), ����� � �������� �������� ������','����� ������� ������� (������)','����� ������� �������'
  ,'�������� ���������') 

  GROUP BY [location_ID]
      ,[all_ID]
      ,[categories_ID]
      --,CID.[crop_ID]
      ,[location]
      ,[all]
      ,[categories]
	  ,CASE WHEN CID.[crop]='�������� ���������' THEN '�������� ���������'
			WHEN CID.[crop] IN ('�������','�������� (����)','������, ���� � ����','����� (�������), ����� � �������� �������� ������') THEN '�������� ��������'
			ELSE '������ ��������'
		END 
      --,CID.[crop]
	  ,[name]
      ,[date]

  --ORDER BY [location_ID],[name]--,[crop_ID],[crop],[all_ID]
  )


  SELECT 
	--[location_ID]
 --     ,[all_ID]
 --     ,[categories_ID]
      --,CID.[crop_ID]
      [location]
      --,[all]
      --,[categories]
	  ,[YEAR]
      ,[date]
	  ,[������ ��������]
	  ,[�������� ��������]
	  ,[�������� ���������]
	  --,[crop]
	  --,[value] 
	  --,CASE WHEN [crop]='������ ��������' THEN [value] END AS'������ ��������' 
	  --,CASE WHEN [crop]='�������� ��������' THEN [value] END AS '�������� ��������'
	  --,CASE WHEN [crop]='�������� ���������' THEN [value] END AS '�������� ���������' 
  FROM ALL_DATA
  PIVOT (SUM([value]) FOR [crop] IN 
	  ([������ ��������]
	  ,[�������� ��������]
	  ,[�������� ���������])) AS P