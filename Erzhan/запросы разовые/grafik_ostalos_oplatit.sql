/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
WITH OPLATA AS (
SELECT SUM(RSK.[SUMMA]) AS [SUMMA]
      ,DK.NAIMENOVANIE
      ,[DOGOVOR_GUID]
  FROM [L1].[dbo].[RASCHETY_S_KLIENTAMI] RSK
  LEFT JOIN L1.DBO.DOGOVORY_KONTRAGENTOV DK 
	ON RSK.DOGOVOR_GUID=DK.GUID
  WHERE 1=1
  --AND DOGOVOR_GUID IN(0xAF83D4F5EF10792511EBE0AC0CC08716)
  AND [SYNONYM_REGISTRATOR] IN 
('Взаимозачет задолженности',
'Поступление безналичных денежных средств',
'Приходный кассовый ордер',
--'Расходный кассовый ордер',
--'Списание безналичных денежных средств',
'Списание задолженности')

GROUP BY DK.NAIMENOVANIE
      ,[DOGOVOR_GUID]

  --ORDER BY [DOGOVOR_GUID]
  )
  ,DOGOVOR AS (
		  SELECT DK.SUMMA
		  ,DK.GUID
		  ,DK.NAIMENOVANIE
		  FROM L1.DBO.DOGOVORY_KONTRAGENTOV DK
		  WHERE DK.TIP_DOGOVORA='С покупателем / заказчиком'
  )

,VOZVRAT AS (
SELECT SUM(RSK.[SUMMA]) AS [SUMMA]
      ,DK.NAIMENOVANIE
      ,[DOGOVOR_GUID]
  FROM [L1].[dbo].[RASCHETY_S_KLIENTAMI] RSK
  LEFT JOIN L1.DBO.DOGOVORY_KONTRAGENTOV DK 
	ON RSK.DOGOVOR_GUID=DK.GUID
  WHERE 1=1
  --AND DOGOVOR_GUID IN(0xAF83D4F5EF10792511EBE0AC0CC08716)
  AND [SYNONYM_REGISTRATOR] IN 
('Возврат товаров от клиента'
,'Акт выполненных работ для клиента')

GROUP BY DK.NAIMENOVANIE
      ,[DOGOVOR_GUID]
)

,OSTATOK AS (
			SELECT 
			DK.GUID
			,DK.NAIMENOVANIE
			,DK.SUMMA-ISNULL(O.SUMMA,ISNULL(V.SUMMA,0)) AS [OSTATOK OPLATA]
			,DK.SUMMA AS SUMMA_KONTRAKTA
			,O.SUMMA AS SUMMA_OPLATY
			,V.SUMMA AS SUMMA_VOZVRATA
			FROM DOGOVOR DK
			LEFT JOIN OPLATA O
			ON DK.GUID=O.DOGOVOR_GUID
			LEFT JOIN VOZVRAT V
			ON DK.GUID=V.DOGOVOR_GUID
)

SELECT 
DISTINCT
GID.DOGOVOR_GUID
--,GID.DATA_PO_GRAFIKU
--,GID.SUMMA_OPLATY OPLATA_GRAFIK
,O.SUMMA_KONTRAKTA
,O.SUMMA_OPLATY
,O.[OSTATOK OPLATA]
,O.NAIMENOVANIE
,S.NAIMENOVANIE
,CASE WHEN GID.DATA_PO_GRAFIKU < CAST(GETDATE() AS DATE) THEN O.[OSTATOK OPLATA] END  AS [OSTATOK OPLATA] 


FROM L1.dbo.GRAFIK_ISPOLNENIYA_DOGOVORA GID
LEFT JOIN OSTATOK O
	ON GID.DOGOVOR_GUID=O.GUID
LEFT JOIN L1.DBO.DOGOVORY_KONTRAGENTOV DK
	ON GID.DOGOVOR_GUID=DK.GUID
LEFT JOIN L1.DBO.SEZONY S
	ON DK.SEZON_GUID=S.GUID
WHERE GID.DOGOVOR_GUID IN (
							SELECT O.GUID
							 FROM OSTATOK O
							 WHERE O.[OSTATOK OPLATA]!=0
							 )
	AND S.NAIMENOVANIE	>'Сезон 2019'
	AND DK.GUID=0xAF95D4F5EF10792511ED6592A00817D8
	AND GID.DATA_PO_GRAFIKU < CAST(GETDATE() AS DATE) 
ORDER BY 
GID.DOGOVOR_GUID