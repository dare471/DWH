SELECT n.[ssylka] as [GUID]
		,n2.ssylka as [RODITEL_GUID]
	  ,CASE 
		WHEN n.[pometka_udaleniya] = 0x00 THEN 'Нет'
		ELSE 'Да'
	END AS [POMETKA_UDALENIYA]
      ,n.naimenovanie as [NAIMENOVANIE]
	  ,n2.naimenovanie as [RODITEL]
	  ,case when n3.naimenovanie ='Лимагрейн' then 'Семена'
			when n3.naimenovanie='Семена 'then 'Семена'
			else n3.naimenovanie 
	  end as [RODITEL2]
	  ,p.naimenovanie as PROIZVODITELI
	  ,n.kod
	  ,kn.naimenovanie as [KATEGORII_NOMENKLATURY]
	  ,CASE WHEN KN.naimenovanie_RODITEL IN ('Пестициды','Биопрепараты') THEN 'СЗР' 
			ELSE KN.naimenovanie_RODITEL 
		END AS [KATEGORII_NOMENKLATURY_GROUP]
	  ,n.ves_znamenatel as VES_V_EDINITSE_KHRANENIYA
	  ,uei.naimenovanie as EDINITSA_KHRANENIYA
	  ,n.ves_chislitel as VES_V_EDINITSE_IZMERENIYA
	  ,uei2.naimenovanie as EDINITSA_IZMERENIYA
	  ,n.vid_tseny_min as VID_TSENY_MIN
	  ,n.vid_tseny_zakupa as VID_TSENY_ZAKUPA
	  ,n.vid_tseny_zakupa_1_0_0 as VID_TSENY_ZAKUPA_100
	  ,'erp' as [SOURCE_BASE]
	  ,vkn.naimenovanie AS VIDY_KULTUR_NOMENKLATURY
	  ,vt.naimenovanie AS VIDY_TEKHNOLOGIY
	  ,n.naimenovanie_dlya_e_s_f as [NAIMENOVANIE_DLYA_ESF]
	  ,n.assortiment_tovara as [ASSORTIMENT_TOVARA_GUID]
	  ,n.tekhnologiya as [TEKHNOLOGIYA_GUID]
	  ,N.kratnost AS KRATNOST
	  ,N.norma_raskhodovaniya AS NORMA_RASKHODOVANIYA
--into [L1].[DBO].[NOMENKLATURA] 
  FROM [L0].[dbo].[nomenklatura] n 
  left join [L0].[dbo].[nomenklatura] n2 on n.roditel=n2.ssylka
  left join [L0].[dbo].[nomenklatura] n3 on n2.roditel=n3.ssylka
  left join (SELECT KN.[ssylka]
				  ,KN.[naimenovanie]
				  ,ISNULL(CASE WHEN KN2.naimenovanie='Сортовые' THEN 'Семена' ELSE KN2.naimenovanie END , KN1.naimenovanie )AS naimenovanie_RODITEL
			  FROM [L0].[dbo].[kategorii_nomenklatury] KN
			  LEFT JOIN   [L0].[dbo].[kategorii_nomenklatury]  KN1
					ON KN.roditel=KN1.ssylka
			  LEFT JOIN   [L0].[dbo].[kategorii_nomenklatury]  KN2
					ON KN1.roditel=KN2.ssylka
					) kn on n.kategoriya=kn.ssylka
  left join [L0].[dbo].[upakovki_edinitsy_izmereniya] uei on n.edinitsa_izmereniya=uei.ssylka
  left join [L0].[dbo].[upakovki_edinitsy_izmereniya] uei2 on n.ves_edinitsa_izmereniya=uei2.ssylka
  left join [L0].dbo.kultury vkn on n.kultura=vkn.ssylka
  left join [L0].[dbo].vidy_tekhnologiy vt on n.tekhnologiya=vt.ssylka
  left join [L0].[dbo].proizvoditeli p on n.proizvoditel=p.ssylka