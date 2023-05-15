WITH SALDO AS(/**все данные**/
			SELECT cast(Период AS DATE)[Период]
					,SUM(CASE WHEN СчетДт in ('1030','1010','1050','1021') THEN r.Сумма ELSE 0 END) AS Дт,
					SUM(CASE WHEN СчетКт in('1030','1010','1050','1021') THEN r.Сумма ELSE 0 END) AS Кт
					,O.description Организация
					,R.Организация AS Организация_GUID
			FROM [AA_DWH].[dbo].[РегистрБухгалтерии.Хозрасчетный] r
			LEFT JOIN AA_DWH.dbo.Организации o on o.guid=r.Организация
			WHERE (r.СчетДт in ('1030','1010','1050','1021') OR r.СчетКт in('1030','1010','1050','1021')) 
			GROUP BY cast(Период AS DATE)
					,O.description
					,R.Организация 
		)
,MAX_ORGA AS (/**ЭТОТ ЗАПРОС НУЖЕН ДЛЯ МАХ ДАТЫ ОРГАНИЗАЦИИ**/
			SELECT 
				S2.Организация
				,Организация_GUID
				,MAX(S2.Период) AS Период
			FROM SALDO S2
			WHERE S2.Период!=CAST(GETDATE() AS DATE)
			GROUP BY S2.Организация
			,Организация_GUID
)

SELECT DISTINCT
	MO.Организация
	,CONVERT(NVARCHAR(50),MO.Организация_GUID,1)Организация_GUID
	,CAST(GETDATE() AS DATE) AS Период
	,SUM_ORG.runqty
FROM MAX_ORGA MO 
LEFT JOIN 
(/**СУММИРУЕМ С НАЧАЛО деятельности КОМПАНИИ**/
  SELECT 
	  S2.Период
	  ,S2.Дт
	  ,S2.Кт
	  --,S2.Дт-S2.Кт
	  ,S2.Организация
	  ,Организация_GUID
	  ,SUM(Дт) OVER(PARTITION BY S2.Организация,Организация_GUID
					ORDER BY Период,S2.Организация,Организация_GUID
					ROWS BETWEEN UNBOUNDED PRECEDING
							 AND CURRENT ROW)
		-SUM(Кт) OVER(
					PARTITION BY S2.Организация,Организация_GUID
					ORDER BY Период,S2.Организация,Организация_GUID
					ROWS BETWEEN UNBOUNDED PRECEDING
							 AND CURRENT ROW)
		AS runqty
	FROM SALDO AS  S2 
	WHERE S2.Период!=CAST(GETDATE() AS DATE)
    --ORDER BY Период desc
) SUM_ORG
ON MO.Организация=SUM_ORG.Организация
AND MO.Период =SUM_ORG.Период

