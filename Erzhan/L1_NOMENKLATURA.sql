SELECT n.[ssylka] as [guid]
		,n2.ssylka as [roditel_guid]
	  ,CASE 
		WHEN n.[pometka_udaleniya] = 0x00 THEN 'Нет'
		ELSE 'Да'
	END AS [pometka_udaleniya]
      ,n.naimenovanie as[naimenovanie]
	  ,n2.naimenovanie [roditel]
	  ,case when n3.naimenovanie ='Лимагрейн' then 'Семена'
			when n3.naimenovanie='Семена 'then 'Семена'
			else n3.naimenovanie 
	  end as [roditel2]
	  ,p.naimenovanie proizvoditeli
	  ,kn.naimenovanie [kategorii_nomenklatury]
	  ,n.ves_znamenatel ves_v_edinitse_khraneniya
	  ,uei.naimenovanie edinitsa_khraneniya
	  ,n.ves_chislitel ves_v_edinitse_izmereniya
	  ,uei2.naimenovanie edinitsa_izmereniya
	  ,n.vid_tseny_min
	  ,n.vid_tseny_zakupa
	  ,n.vid_tseny_zakupa_1_0_0 as vid_tseny_zakupa_100
	  ,'erp' as [source_base]
	  ,vkn.naimenovanie vidy_kultur_nomenklatury
	  ,vt.naimenovanie vidy_tekhnologiy
	  ,n.naimenovanie_dlya_e_s_f as [naimenovanie_dlya_ESF]
	  ,n.assortiment_tovara as [assortiment_tovara_guid]
	  ,n.tekhnologiya as [tekhnologiya_guid]
  FROM [L0].[dbo].[nomenklatura] n 
  left join [L0].[dbo].[nomenklatura] n2 on n.roditel=n2.ssylka
  left join [L0].[dbo].[nomenklatura] n3 on n2.roditel=n3.ssylka
  left join [L0].[dbo].[kategorii_nomenklatury] kn on n.kategoriya=kn.ssylka
  left join [L0].[dbo].[upakovki_edinitsy_izmereniya] uei on n.edinitsa_izmereniya=uei.ssylka
  left join [L0].[dbo].[upakovki_edinitsy_izmereniya] uei2 on n.ves_edinitsa_izmereniya=uei2.ssylka
  left join [L0].dbo.kultury vkn on n.kultura=vkn.ssylka
  left join [L0].[dbo].vidy_tekhnologiy vt on n.tekhnologiya=vt.ssylka
  left join [L0].[dbo].proizvoditeli p on n.proizvoditel=p.ssylka