WITH ALL_ORDERS AS (
SELECT PO.[ssylka] 
   ,PO.[nomer]  
   ,[vsego_mest]  
   ,PO.[data] as [data_otgruzki]  
   ,P.[naimenovanie] as Avtor  
   ,K.[naimenovanie] as KlientPoluchatel 
   ,S.[naimenovanie] as SkladPoluchatel  
   ,SO.[description] as SkladskieOperasii  
   ,SRO.description as Status
FROM [L0].[dbo].[prikhodnyy_order_na_tovary] PO 
LEFT JOIN [L0].[dbo].[polzovateli] P on PO.[otvetstvennyy]=P.[ssylka] 
LEFT JOIN [L0].[dbo].[partnery] K on PO.[otpravitel]=K.[ssylka] 
LEFT JOIN [L0].[dbo].[sklady] S on PO.[otpravitel]=S.[ssylka] 
LEFT JOIN [L0].[dbo].[skladskie_operatsii] SO on PO.[skladskaya_operatsiya]=SO.ssylka 
LEFT JOIN [L0].[dbo].[statusy_prikhodnykh_orderov] SRO on PO.status=SRO.[ssylka] 
where PO.[pometka_udaleniya]=0x00  
UNION 
SELECT R.[ssylka]  
      ,R.[nomer]  
   ,[vsego_mest]  
      ,[data_otgruzki]  
      ,P.[naimenovanie] as Avtor  
      ,K.[naimenovanie] as KlientPoluchatel  
   ,S.[naimenovanie] as SkladPoluchatel  

      ,SO.[description] as SkladskieOperasii  
   ,SRO.description as Status
FROM [L0].[dbo].[raskhodnyy_order_na_tovary] R 
LEFT JOIN [L0].[dbo].[statusy_raskhodnykh_orderov] SRO on R.status=SRO.[ssylka] 
LEFT JOIN [L0].[dbo].[polzovateli] P on R.[otvetstvennyy]=P.[ssylka] 
LEFT JOIN [L0].[dbo].[partnery] K on R.[poluchatel]=K.[ssylka] 
LEFT JOIN [L0].[dbo].[sklady] S on R.[poluchatel]=S.[ssylka] 
LEFT JOIN [L0].[dbo].[skladskie_operatsii] SO on R.[skladskaya_operatsiya]=SO.ssylka 
 
where R.[pometka_udaleniya]=0x00  
)


SELECT [synonym_ssylka_raskhodnyy_order_na_tovary] AS [SYNONYM_SSYLKA_RASKHODNYY_ORDER_NA_TOVARY]
      ,[type_ssylka_raskhodnyy_order_na_tovary] AS [TYPE_SSYLKA_RASKHODNYY_ORDER_NA_TOVARY]
      ,[ssylka_raskhodnyy_order_na_tovary] AS [SSYLKA_RASKHODNYY_ORDER_NA_TOVARY]
      ,SOZ.[ssylka] AS GUID
	  ,AO.Avtor AS AVTOR
	  ,AO.data_otgruzki AS DATA_OTGRUZKI
	  ,AO.KlientPoluchatel AS KLIENTPOLUCHATEL
	  ,AO.nomer AS NOMER_ORDERA
	  ,AO.SkladPoluchatel AS SKLAD_POLUCHATEL
	  ,AO.SkladskieOperasii AS SKLADSKIE_OPERASII
	  ,AO.Status AS STATUS
	  ,AO.vsego_mest AS VSEGO_MEST

--INTO L1.DBO.SKLADSKIE_ORDERA_ZADANIENAPEREVOZKU

  FROM [L0].[dbo].[tab_skladskie_ordera_zadanienaperevozku] SOZ
LEFT JOIN ALL_ORDERS AO
	ON SOZ.ssylka_raskhodnyy_order_na_tovary=AO.ssylka