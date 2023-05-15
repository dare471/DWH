
WITH SALDO_1 AS(/**все данные по салдо на начало периюда**/
			SELECT 
					cast(Период AS DATE)[Период]
					,LAG(SUM(CASE WHEN СчетДт in ('1030','1010','1050','1021','1024','1024') THEN r.Сумма ELSE 0 END))
							OVER (PARTITION BY O.description,R.Организация ORDER BY cast(Период AS DATE))
						 AS Дт
					,LAG(SUM(CASE WHEN СчетКт in('1030','1010','1050','1021','1024','1024') THEN r.Сумма ELSE 0 END))
							OVER (PARTITION BY O.description,R.Организация ORDER BY cast(Период AS DATE))
						 AS Кт
					,O.description Организация
					,R.Организация AS Организация_GUID
				FROM [AA_DWH].[dbo].[РегистрБухгалтерии.Хозрасчетный] r
				LEFT JOIN AA_DWH.dbo.Организации o on o.guid=r.Организация
				WHERE (r.СчетДт in ('1030','1010','1050','1021','1024','1024') OR r.СчетКт in('1030','1010','1050','1021','1024','1024')) 
				AND o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,     -----ORGANIZATSIA GUID
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								)
				GROUP BY cast(Период AS DATE)
						,O.description
						,R.Организация 
			)
,SALDO AS (
SELECT /**** салдо на начало ***/
	SALDO.Период
	,SALDO.SALDO AS SALDO
	,SALDO.Организация AS Организации
	,SALDO.Организация_GUID AS ORGANIZASIYA_guid

FROM (SELECT  /**** суммируем с первого дня  ****/
		S.Организация_GUID
		,S.Период
		,S.Организация
		,SUM(Дт) OVER(PARTITION BY S.Организация,Организация_GUID
					ORDER BY Период,S.Организация,Организация_GUID
					ROWS BETWEEN UNBOUNDED PRECEDING
								AND CURRENT ROW)
		-SUM(Кт) OVER(
					PARTITION BY S.Организация,Организация_GUID
					ORDER BY Период,S.Организация,Организация_GUID
					ROWS BETWEEN UNBOUNDED PRECEDING
								AND CURRENT ROW) AS SALDO
		FROM SALDO_1 S
		)SALDO	

)
,SALDO_NACHALO_MESSESA AS (/**** ЭТОТ СЕЛЕКТ НУЖЕН ДЛЯ ДОБАВЛЕНИЕ САЛДО НА НАЧАЛО МЕСЯЦА ПО ВСЕМ ОРГАНИЗАЦИЯМ ****/
		SELECT 
			[Период] AS месяц
			,sum([СальдоНаНачалоПериода]) AS Дт
			,o.description as organizasii
			,ISX.Организация_guid AS ORGANIZASIYA_guid
		FROM [AA_DWH].[dbo].[ИтогиПоСчетамХозрасчетный]isx  
		LEFT JOIN AA_DWH.dbo.Организации o on isx.Организация_guid=o.guid
		  WHERE o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,     -----ORGANIZATSIA GUID
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								)AND
		  isx.Счет in ('1010','1030','1050','1021')
		  and isx.[Период]<>'3999-11-01' and isx.[Период]>= '2022'

		  group by [Период]
		  ,o.description
		  ,ISX.Организация_guid 
		 )
,AILAR_ORGANIZASSYA AS (
SELECT
	SALDO.Период
	,SALDO.ORGANIZASIYA_guid
	,SALDO.Организации
FROM SALDO

UNION 

SELECT 
	SALDO_NACHALO_MESSESA.месяц AS Период
	,SALDO_NACHALO_MESSESA.ORGANIZASIYA_guid 
	,SALDO_NACHALO_MESSESA.organizasii AS Организации
FROM SALDO_NACHALO_MESSESA
)


,ORGENIZASYA_CALENDAR AS (
SELECT 
DISTINCT
FC.[CalendarDate] AS Период
,AILAR_ORGANIZASSYA.ORGANIZASIYA_guid
,AILAR_ORGANIZASSYA.Организации
FROM
 L1_X.dbo.FIN_CALENDAR AS FC
 ,AILAR_ORGANIZASSYA 
 --ORDER BY AILAR_ORGANIZASSYA .ORGANIZASIYA_guid
 )


SELECT /**** салдо на начало ***/
AILAR_ORGANIZASSYA.Период
,ISNULL(SALDO_NACHALO_MESSESA.Дт,SALDO.SALDO) AS SALDO_NA_NACHALO
,AILAR_ORGANIZASSYA.Организации AS Организации
,CONVERT(NVARCHAR(50),AILAR_ORGANIZASSYA.ORGANIZASIYA_guid,1) AS ORGANIZASIYA_guid
,'Сальдо на начало' AS STATI_DDS

FROM ORGENIZASYA_CALENDAR AS AILAR_ORGANIZASSYA
LEFT JOIN SALDO
	ON SALDO.Период=AILAR_ORGANIZASSYA.Период
	AND AILAR_ORGANIZASSYA.ORGANIZASIYA_guid=SALDO.ORGANIZASIYA_guid
LEFT JOIN SALDO_NACHALO_MESSESA 
	ON AILAR_ORGANIZASSYA.ORGANIZASIYA_guid=SALDO_NACHALO_MESSESA.ORGANIZASIYA_guid
	AND SALDO_NACHALO_MESSESA.месяц=AILAR_ORGANIZASSYA.Период
WHERE AILAR_ORGANIZASSYA.Период>EOMONTH('01.12.2021',0)

ORDER BY AILAR_ORGANIZASSYA.ORGANIZASIYA_guid,AILAR_ORGANIZASSYA.Период