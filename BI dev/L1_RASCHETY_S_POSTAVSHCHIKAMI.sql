SELECT dateadd([YEAR],-2000,[period]) as [period]
      ,[synonym_registrator]
	  ,dogovor.ssylka as dogovor_guid
      ,[type_registrator]
      ,[registrator] as [registrator_guid]
      ,[nomer_stroki]
      ,[aktivnost]
      ,[analitika_ucheta_po_partneram] as [analitika_ucheta_po_partneram_guid]
      ,[synonym_zakaz_postavshchiku]
      ,[type_zakaz_postavshchiku]
      ,[zakaz_postavshchiku] as [zakaz_postavshchiku_guid]
      ,[valyuta] as [valyuta_guid]
      ,rsp.[summa]
      ,[oplachivaetsya]
      ,[k_oplate]
      ,[k_postupleniyu]
      ,rsp.[khozyaystvennaya_operatsiya] as [khozyaystvennaya_operatsiya_guid]
      ,rsp.[forma_oplaty] as [forma_oplaty_guid]
      ,[zayavka_na_raskhodovanie_denezhnykh_sredstv] as [zayavka_na_raskhodovanie_denezhnykh_sredstv_guid]
      ,[synonym_zakupka_po_zakazu]
      ,[type_zakupka_po_zakazu]
      ,[zakupka_po_zakazu] as[zakupka_po_zakazu_guid]
      ,dateadd(year,-2000,[data_registratora])[data_registratora]
      ,dateadd(year,-2000,[data_platezha])[data_platezha]
      ,[summa_regl]
      ,[summa_upr]
      ,[zalog_za_taru]
      ,rsp.[statya_dvizheniya_denezhnykh_sredstv] as [statya_dvizheniya_denezhnykh_sredstv_guid]
      ,[synonym_raschetnyy_dokument]
      ,[type_raschetnyy_dokument]
      ,[raschetnyy_dokument] as [raschetnyy_dokument_guid]

  FROM [L0].[dbo].[raschety_s_postavshchikami] rsp
     LEFT JOIN [L0].dbo.klyuchi_analitiki_ucheta_po_partneram AS analitika 
        ON rsp.analitika_ucheta_po_partneram = analitika.ssylka 
	 LEFT JOIN [L0].dbo.dogovory_kontragentov AS dogovor 
        ON analitika.dogovor = dogovor.ssylka