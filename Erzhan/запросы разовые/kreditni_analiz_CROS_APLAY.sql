/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT GID.[NOMER_DOGOVORA]
      ,[TIP_DOGOVORA]
      ,[STATUS]
      ,GID.[DOGOVOR_GUID]
      ,[DATA_PO_GRAFIKU]
      ,[PROTSENT_OPLATY]
      ,[SUMMA_OPLATY]
      ,[PERIOD]
      ,[SOURCE_BASE]
  FROM [L1].[dbo].[GRAFIK_ISPOLNENIYA_DOGOVORA] GID
  CROSS APPLY  (
  SELECT CAST([DATA_OPLATY_VOZVRATA] AS DATE) AS [DATA_OPLATY_VOZVRATA]
      ,[NOMER_DOGOVORA]
      ,SUM([SUMMA])*(-1) AS [SUMMA]
      --,[ORGANIZATSYA_GUID]
      --,[KONTRAGENT_GUID]
      ,[DOGOVOR_GUID]
      --,[KASPI]
  FROM [L1].[dbo].[RASCHETY_S_KLIENTAMI_PO_DOKUMENTAM] RSK
  LEFT JOIN L1.dbo.KONTRAGENTY AS K
	ON RSK.KONTRAGENT_GUID=K.GUID
  WHERE TIP_DOKUMENTA IN ('Корректировка реализации','Расчет курсовых разниц',
'Приходный кассовый ордер','Списание задолженности','Ввод начальных остатков',
'Поступление безналичных денежных средств','Операция по платежной карте',
'Взаимозачет задолженности','Списание безналичных денежных средств')
--AND GID.DOGOVOR_GUID=RSK.DOGOVOR_GUID

GROUP BY CAST([DATA_OPLATY_VOZVRATA] AS DATE) 
		,RSK.[NOMER_DOGOVORA]
		,RSK.[DOGOVOR_GUID]
) RSK