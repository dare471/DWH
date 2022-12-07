SELECT [ssylka] AS [GUID]
         ,[nomer_stroki] AS [NOMER_STROKI]
      ,[i_d__stroki___mesta_prebyvaniya] AS [i_d__stroki___mesta_prebyvaniya]
      ,[mesto_prozhivaniya] AS [MESTO_PROZHIVANIYA]
      ,DATEADD(YEAR, -2000, [data_nachala_prozhivaniya]) AS [DATA_NACHALA_PROZHIVANIYA]
      ,DATEADD(YEAR, -2000, [data_okonchaniya_prozhivaniya]) AS [DATA_OKONCHANIYA_PROZHIVANIYA]
      ,[dney_prozhivaniya] AS [DNEY_PROZHIVANIYA]
      ,[stoimost_prozhivaniya] AS [STOIMOST_PROZHIVANIYA]
      ,[ruchnoe_izmenenie_stoimosti_prozhivaniya] AS [RUCHNOE_IZMENENIE_STOIMOSTI_PROZHIVANIYA]
      ,[summa_prozhivaniya] AS [SUMMA_PROZHIVANIYA]
      ,[limit] AS [LIMIT]
      ,[tip_oplaty] AS [TIP_OPLATY]
,CAST(GETDATE() AS DATE) A_DATE
 FROM [L0].[dbo].[tab_mesta_prozhivaniya_zayavkanakomandirovku]