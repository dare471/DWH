SELECT ZNP.[ssylka] AS GUID
      ,DATEADD(YEAR, -2000,[data]) AS [DATA]
      ,nomer AS NOMER
      ,avtomobil_gruzopodemnost_v_tonnakh as TONNAZH
      ,CONVERT(NVARCHAR(50), [kontragent],1) AS  [KONTRAGENT] 
      ,SZNP.[description] as STATUS
      ,P.[naimenovanie] as AVTOR
   ,VD.description as OPERATSIA
   ,S.[naimenovanie] as SKLAD_OTPRAVITEL
   ,VZNP.[naimenovanie] as VODITEL 
      ,DATEADD(YEAR, -2000,[data_vremya_reysa_plan_s]) AS [DATA_VREMYA_REYSA_PLAN_S]  
      ,DATEADD(YEAR, -2000,[data_vremya_reysa_plan_po]) AS [DATA_VREMYA_REYSA_PLAN_PO]
      ,DATEADD(YEAR, -2000,[data_vremya_reysa_fakt_s]) AS [DATA_VREMYA_REYSA_FAKT_S]
      ,DATEADD(YEAR, -2000,[data_vremya_reysa_fakt_po]) AS [DATA_VREMYA_REYSA_FAKT_PO] 
      ,[avtomobil_gosudarstvennyy_nomer] AS [AVTOMOBIL_GOSUDARSTVENNYY_NOMER]
      ,[avtomobil_marka] AS [AVTOMOBIL_MARKA]
      ,ZNP.[vid_perevozki] AS [VID_PEREVOZKI]
      ,ZNP.[pritsep] AS [PRITSEP]
      ,ZNP.[gosudarstvennyy_nomer_pritsepa] AS [GOSUDARSTVENNYY_NOMER_PRITSEPA]
       	  --into [L1].[dbo].[ZADANIE_NA_PEREVOZKU]
  FROM [L0].[dbo].[zadanie_na_perevozku] ZNP 
  LEFT JOIN [L0].[dbo].[statusy_zadaniy_na_perevozku] SZNP on ZNP.[status]=SZNP.[ssylka] 
  LEFT JOIN [L0].[dbo].[polzovateli] P on ZNP.[otvetstvennyy]=P.[ssylka] 
  LEFT JOIN [L0].[dbo].[vidy_dostavki] VD on ZNP.[operatsiya]=VD.ssylka 
  LEFT JOIN [L0].[dbo].[sklady] S on ZNP.[sklad]=S.[ssylka] 
  LEFT JOIN [L0].[dbo].[voditel_zadanie_na_perevozku] VZNP on ZNP.[voditel_perevozki]=VZNP.ssylka 
  where ZNP.[pometka_udaleniya]=0x00

