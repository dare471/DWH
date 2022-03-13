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


 CREATE TABLE [L1].[dbo].[TAB_MESTA_PROZHIVANIYA_ZAYAVKANAKOMANDIROVKU](
	[GUID] [binary](16) NULL,
	[NOMER_STROKI] [numeric](5, 0) NULL,
	[i_d__stroki___mesta_prebyvaniya] [numeric](10, 0) NULL,
	[MESTO_PROZHIVANIYA] [nvarchar](50) NULL,
	[DATA_NACHALA_PROZHIVANIYA] [datetime2](0) NULL,
	[DATA_OKONCHANIYA_PROZHIVANIYA] [datetime2](0) NULL,
	[DNEY_PROZHIVANIYA] [numeric](3, 0) NULL,
	[STOIMOST_PROZHIVANIYA] [numeric](10, 2) NULL,
	[RUCHNOE_IZMENENIE_STOIMOSTI_PROZHIVANIYA] [binary](1) NULL,
	[SUMMA_PROZHIVANIYA] [numeric](10, 2) NULL,
	[LIMIT] [numeric](10, 2) NULL,
	[TIP_OPLATY] [binary](16) NULL,
	[A_DATE] [date] NULL
)