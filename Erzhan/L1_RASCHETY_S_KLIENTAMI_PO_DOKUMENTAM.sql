SELECT 
             
			 synonym_registrator as TIP_DOKUMENTA
            ,DATEADD(YEAR, -2000,Period) AS DATA_OPLATY_VOZVRATA
            ,DogovoryKontragentov.nomer  AS NOMER_DOGOVORA
            ,CASE WHEN [vid_dvizheniya]=0 THEN (SUM(dolg_regl + predoplata_regl)*(-1)) ELSE SUM(dolg_regl + predoplata_regl) END AS SUMMA
            ,klyuchi_analitiki_ucheta_po_partneram.organizatsiya AS ORGANIZATSYA_GUID
            ,klyuchi_analitiki_ucheta_po_partneram.kontragent AS KONTRAGENT_GUID
            ,klyuchi_analitiki_ucheta_po_partneram.dogovor AS DOGOVOR_GUID
            ,CASE postuplenie_beznalichnykh_denezhnykh_sredstv.kaspi
                WHEN 0x00 THEN 'Нет'
                WHEN 0x01 THEN 'Да' 
                ELSE '-'
            END AS KASPI 
			--into [L1].dbo.RASCHETY_S_KLIENTAMI_PO_DOKUMENTAM
            FROM L0.dbo.[rascheti_s_klientami_po_dokumentam] AS raschety_s_klientami_po_dokumentam 
              LEFT JOIN L0.dbo.klyuchi_analitiki_ucheta_po_partneram AS klyuchi_analitiki_ucheta_po_partneram ON raschety_s_klientami_po_dokumentam.analitika_ucheta_po_partneram = klyuchi_analitiki_ucheta_po_partneram.ssylka
              LEFT JOIN L0.dbo.dogovory_kontragentov AS DogovoryKontragentov ON DogovoryKontragentov.ssylka = klyuchi_analitiki_ucheta_po_partneram.dogovor
              LEFT JOIN L0.dbo.postuplenie_beznalichnykh_denezhnykh_sredstv AS postuplenie_beznalichnykh_denezhnykh_sredstv ON raschety_s_klientami_po_dokumentam.registrator = postuplenie_beznalichnykh_denezhnykh_sredstv.ssylka   
            --WHERE DogovoryKontragentov.ssylka <> 0x00000000000000000000000000000000 --AND (raschety_s_klientami_po_dokumentam.khozyaistvennaya_operaciya = 0x8EAD955D0FF48E4D4878A37710DB127E OR raschety_s_klientami_po_dokumentam.khozyaistvennaya_operaciya = 0xA72B8055F1ED21FF4A9CCFB33E8F72AF OR raschety_s_klientami_po_dokumentam.khozyaistvennaya_operaciya = 0xB4AF52C1B39555E54EEAC8D5724DC975)
            --AND klyuchi_analitiki_ucheta_po_partneram.kontragent=0xAF96D4F5EF10792511ED8CA974F97E60
			
			GROUP BY 
     type_registrator
    ,Period
    ,DogovoryKontragentov.nomer
    ,klyuchi_analitiki_ucheta_po_partneram.organizatsiya
    ,klyuchi_analitiki_ucheta_po_partneram.kontragent
    ,klyuchi_analitiki_ucheta_po_partneram.dogovor
    ,postuplenie_beznalichnykh_denezhnykh_sredstv.kaspi
	,[vid_dvizheniya]
			 ,type_registrator
			 ,synonym_registrator
	ORDER BY Period