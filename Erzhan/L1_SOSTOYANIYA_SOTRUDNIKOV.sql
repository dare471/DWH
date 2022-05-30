SELECT dateadd(year,-2000,cast([period]as date)) as [period]
      ,[sotrudnik] as [sotrudnik_guid]
	  ,s.fizicheskoe_litso [fizicheskie_litsa_guid]
	  ,ss1.description as [sostoyaniya]
      ,dateadd(year,-2000,cast([deystvuet_do] as date))as [deystvuet_do]
      ,dateadd(year,-2000,cast([okonchanie_predpolozhitelno] as date))[okonchanie_predpolozhitelno]
	  ,CASE ss.vid_vremeni
			WHEN 0x80DE000C29E67B2E11E628A420E2E829 THEN 'Отпуск неоплачиваемый в соответствии с законом'
			ELSE 'Не указано'
		END AS vid_vremeni
  FROM [L0].[dbo].[sostoyaniya_sotrudnikov]ss
  left join [L0].[dbo].[sostoyaniya_sotrudnika]ss1 on ss.sostoyanie=ss1.ssylka
  left join [L0].dbo.sotrudniki s on ss.sotrudnik=s.ssylka