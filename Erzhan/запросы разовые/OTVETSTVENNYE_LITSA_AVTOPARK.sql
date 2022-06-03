SELECT distinct
	   ola.PERIOD AS nachalo_otvetstvennosti,
	   ola.OBEKTY_EKSPLUATATSII_GUID,
	   ola.SOTRUDNIK_GUID,
	   oe.NAIMENOVANIE as oe_naimenovanie,
	   MIN(ots2.PERIOD) AS okonchanie_otvetstvennosti
	   ,fl.naimenovanie as fl_naimenovanie
	   ,isnull(oe.NAIMENOVANIE,kug.NOMER_KARTY) as oe_naimenovanie
	   --,oe.*
	   FROM [L1].[dbo].[OTVETSTVENNYE_LITSA_AVTOPARK] AS ola
	   left join [L1].[dbo].[OBEKTY_EKSPLUATATSII] oe on ola.OBEKTY_EKSPLUATATSII_GUID=oe.guid
	   left join [L1].[dbo].[fizicheskie_litsa] fl on ola.SOTRUDNIK_GUID=fl.guid
	   LEFT JOIN [L1].[dbo].[OTVETSTVENNYE_LITSA_AVTOPARK] AS ots2 ON
	   ola.OBEKTY_EKSPLUATATSII_GUID = ots2.OBEKTY_EKSPLUATATSII_GUID
		 AND ola.PERIOD < ots2.PERIOD
	   left join [L1].[dbo].[KARTY_UCHETA_GSM] kug on ola.OBEKTY_EKSPLUATATSII_GUID=kug.guid


	WHERE 1=1
	AND oe.NAIMENOVANIE LIKE '%652%' or
	 FL.NAIMENOVANIE LIKE '%ÀØÒ%'
	--and kug.NAME like '%200100140%'
		  GROUP BY ola.PERIOD, 
					ola.OBEKTY_EKSPLUATATSII_GUID, 
					ola.SOTRUDNIK_GUID,
					oe.NAIMENOVANIE,
					fl.naimenovanie
					,kug.NOMER_KARTY
					--,oe.GOS_NOMER
					--,oe.guid
					--,oe.ID_WIALON
					--,oe.INVENTARNYY_NOMER
					--,oe.NAIMENOVANIE
					--,oe.NAIMENOVANIE_POLNOE
					--,oe.NAME_WIALON
					--,oe.RODITEL
ORDER BY ola.SOTRUDNIK_GUID,ola.PERIOD