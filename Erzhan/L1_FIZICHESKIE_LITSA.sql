WITH KADR AS(

SELECT DISTINCT
      KIS.[fizicheskoe_litso]
	  ,CASE WHEN KIS.[period]=MAX(KIS.[period]) OVER (PARTITION BY [fizicheskoe_litso]) THEN D.naimenovanie END AS DOLZHNOST
FROM [L0].[dbo].[kadrovaya_istoriya_sotrudnikov] KIS 
LEFT JOIN [L0].[dbo].dolzhnosti D
	ON KIS.dolzhnost=D.ssylka
  --WHERE DOLZHNOST IS NOT NULL
)

SELECT -- DISTINCT
	f.[ssylka] as GUID
      ,F.[naimenovanie] AS NAIMENOVANIE
	  ,K.DOLZHNOST AS DOLZHNOST
      ,pfl.description AS POL
      ,[i_n_n] AS I_I_N
      ,[mesto_rozhdeniya] AS MESTO_ROZHDENIYA
	  ,f.familiya AS FAMILIYA
	  ,f.imya AS IMYA
	  ,f.otchestvo AS OTCHESTVO
	  ,f.initsialy_imeni AS INITSIALY_IMENI
	  ,cast((DATEADD(YEAR, -2000, f.data_rozhdeniya))as date) as DATA_ROZHDENIYA
	  ,'erp' AS SOURCE_BASE
--INTO [L1].[dbo].FIZICHESKIE_LITSA
FROM [L0].[dbo].[fizicheskie_litsa] f
left join [L0].dbo.pol_fizicheskogo_litsa pfl on f.pol=pfl.ssylka
LEFT JOIN KADR K
	ON K.fizicheskoe_litso=F.ssylka AND DOLZHNOST IS NOT NULL
ORDER BY DOLZHNOST