SELECT f.[ssylka] as [guid]
      ,[naimenovanie]
      ,pfl.description [pol]
      ,[i_n_n]
      ,[mesto_rozhdeniya]
	  ,f.familiya
	  ,f.imya
	  ,f.otchestvo
	  ,f.initsialy_imeni
	  ,cast((DATEADD(YEAR, -2000, f.data_rozhdeniya))as date) as data_rozhdeniya
	  ,'erp' AS source_base
  FROM [L0].[dbo].[fizicheskie_litsa] f
  left join [L0].dbo.pol_fizicheskogo_litsa pfl on f.pol=pfl.ssylka