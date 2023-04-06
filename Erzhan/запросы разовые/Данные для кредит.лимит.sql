--570121301787

WITH ALLL AS (
SELECT 
	 SUBSTRING(ssns.naimenovanie, 7,4) AS YY ,isnull(isnull(STRK.RODITEL2, STRK.RODITEL), STRK.naimenovanie) AS Дирекция, m.naimenovanie Менеджер
	,b.naimenovanie БизнесРегион, k.Область, k.Район, k.Село, k.НаселенныйПункт, k.родитель
	,k.БИНРодителя, k.БИНКХ, k.КХ, d.КвоДоговоров, d.СуммаДоговоров, p.Предоплата
	,round( p.Предоплата/(case when d.СуммаДоговоров=0 then 1 else d.СуммаДоговоров end),4)*100 ДоляПредоплаты
	,s.summa СуммаОтгруз, v.summa СуммаВозврат, o.summa СуммаОплат, vo.СуммаВозвратОплат
	,ea.ПокупкаЭСФ, ea.ПоКупкаЭСФАА, ea.ДоляЭСФАА--, ea.год
 FROM (--КвоДоговоров--СуммаДоговоров------------------------------------------------------------------------------------------------------------
		select dk.[menedzher_guid] [menedzher_guid], dk.[biznes_region_guid] [biznes_region_guid]
			,dk.[kontragent_guid] [kontragent_guid], dk.[sezon_guid]
			,count(dk.[naimenovanie]) КвоДоговоров, sum([summa])СуммаДоговоров
		 FROM [L1].[dbo].[dogovory_kontragentov] dk
		  left join [L0].[dbo].[organizatsii] o on o.[ssylka]=dk.[organizatsiya_guid]
		   where [status] = 'Действует' and [summa] > 0 and [tip_dogovora] = 'С покупателем / заказчиком'  
			 and o.[naimenovanie] like '%ТОО «Alem Agro Holding (АлемАгро Холдинг)»%'
		  group by dk.[menedzher_guid], dk.[biznes_region_guid], dk.[kontragent_guid], dk.[sezon_guid]
		) d

	LEFT JOIN (--КХ----КАТО----------------------------------------------------------------------------------------------------------
				SELECT DISTINCT  c.[guid], c.[description] [КХ]--[Наименование клиента]--, c.[ВходитВГруппуКомпанийАлемАгро]
					  ,c.ИИН_БИН [БИНКХ],c.[ФактАдресКонтрагента]--, c.[kato], c.[source_base], CONVERT(VARCHAR(50), c.[guid_partner], 1) AS [guid_partner]
					  ,CASE WHEN FIRST_VALUE(p.description) OVER (PARTITION BY c.[guid] ORDER BY c.[guid_partner]) IS NULL THEN c.description ELSE FIRST_VALUE(p.description) OVER (PARTITION BY c.[guid] ORDER BY c.[guid_partner]) END AS [родитель]
					  ,CASE WHEN FIRST_VALUE(p.[ИИН_БИН]) OVER (PARTITION BY c.[guid] ORDER BY c.[guid_partner]) IS NULL THEN c.[ИИН_БИН] ELSE FIRST_VALUE(p.[ИИН_БИН]) OVER (PARTITION BY c.[guid] ORDER BY c.[guid_partner]) END AS [БИНРодителя]
					  ,concat(c.[description], ' - ', c.[ИИН_БИН]) [contragentDetails]
					  , c.[isDiller], r.relationType, cato.region Область, cato.district Район, cato.village01 Село, cato.village02 НаселенныйПункт 
				  FROM [AA_DWH].[dbo].[Контрагенты] c
				  LEFT JOIN [AA_DWH].[dbo].[relationShip] r ON c.guid_partner = r.contragent2_guid
				  left join [AA_DWH].[dbo].Контрагенты p on r.contragent1_guid=p.guid_partner 
				  LEFT JOIN ( SELECT a.cato_Id, a.name, a.[group]
								  ,l1.name region ,case when a.[lvl1]<>'00' then a.[lvl1]+'0000000' else null end region_code
								  ,l2.name district ,case when a.[lvl1]<>'00' and a.[lvl2]<>'00'then a.[lvl1]+a.[lvl2]+'00000' else null end district_code,
								  l3.name village01 ,l4.name village02
								  ,'Казахстан' country ,concat('Казахстан', ', ', l1.name, ', ', l2.name, ', ', l3.name, ', ', l4.name) [location]
								  ,case when a.[lvl2]<>'00' and a.[lvl3]<>'00' and a.lvl4<>'000' then a.[lvl1]+a.[lvl2]+a.lvl3+'000' else null end village_code
							  FROM [AA_DWH_X].[dbo].[cato] a left join [AA_DWH_X].[dbo].[cato] l1 on (case when a.[lvl1]<>'00' then a.[lvl1]+'0000000' else null end) = l1.cato_Id
															 left join [AA_DWH_X].[dbo].[cato] l2 on (case when a.[lvl2]<>'00' then a.[lvl1]+a.[lvl2]+'00000' else null end) = l2.cato_Id  
															 left join [AA_DWH_X].[dbo].[cato] l3 on (case when a.[lvl3]<>'00' then a.[lvl1]+a.[lvl2]+a.lvl3+'000' else null end) = l3.cato_Id
															 left join [AA_DWH_X].[dbo].[cato] l4 on (case when a.[lvl4]<>'000' then a.[lvl1]+a.[lvl2]+a.lvl3+a.[lvl4] else null end) = l4.cato_Id
							) cato ON  cato.cato_Id = c.kato where c.[source_base] = 'erp') k ON d.kontragent_guid = k.guid

LEFT JOIN [L1].dbo.sezony ssns on d.sezon_guid=ssns.guid
LEFT JOIN [L1].dbo.menedzhery m on d.menedzher_guid=m.guid
OUTER APPLY (SELECT TOP 1 KADR.struktura_predpriyatiya_guid
			  FROM [L1].[dbo].[kadrovaya_istoriya_sotrudnikov]  KADR
			   WHERE KADR.fizicheskoe_litso_guid = M.FIZICHESKOE_LITSO_GUID ORDER BY KADR.period DESC) KADR 
LEFT JOIN [L1].[dbo].[struktura_predpriyatiya] STRK ON STRK.guid = KADR.struktura_predpriyatiya_guid
LEFT JOIN [L0].dbo.biznes_regiony b on d.biznes_region_guid=b.ssylka
LEFT JOIN (--Предоплата------------------------------------------------------------------------------------------------------------
			SELECT [menedzher_guid] ,[biznes_region_guid]
				,[kontragent_guid] ,[sezon_guid]
				,SUM(CASE WHEN min_data_otgruzki >= data_po_grafiku THEN summa_oplaty ELSE 0 END) Предоплата
			 FROM 	(select dk.[menedzher_guid] ,dk.[biznes_region_guid]
						,dk.[kontragent_guid] ,dk.[sezon_guid]
						,dk.[data] ,dk.[naimenovanie]
						,dk.[summa] ,dk.[usloviya_oplaty]
						,g.summa_oplaty ,g.data_po_grafiku
						,MIN(s.[data_otgruzki]) min_data_otgruzki
					 FROM [L1].[dbo].[dogovory_kontragentov] dk
					  LEFT JOIN [L0].[dbo].[organizatsii] o on o.[ssylka]=dk.[organizatsiya_guid]
					  LEFT JOIN [L1].[dbo].[grafik_ispolneniya_dogovora] g ON g.dogovor_guid = dk.guid
					  LEFT JOIN [L1].[dbo].[spetsifikatsiya_po_dogovoru] s ON s.dogovor_guid = dk.guid
					   where dk.[status]='Действует' and dk.[summa]>0  
					     and dk.[tip_dogovora]='С покупателем / заказчиком'  
						 and o.[naimenovanie] like '%ТОО «Alem Agro Holding (АлемАгро Холдинг)»%'
						group by dk.[menedzher_guid], dk.[biznes_region_guid], dk.[kontragent_guid], dk.[sezon_guid],dk.[data],
					dk.[naimenovanie], dk.[summa], dk.[usloviya_oplaty], g.summa_oplaty, g.data_po_grafiku
					) min_data_otgr
			GROUP BY [menedzher_guid], [biznes_region_guid], [kontragent_guid], [sezon_guid]
			) p ON d.kontragent_guid = p.kontragent_guid 
				AND d.biznes_region_guid = p.biznes_region_guid 
				AND d.menedzher_guid = p.menedzher_guid 
				AND d.sezon_guid = p.sezon_guid

--ДоляПредоплаты--------------------------------------------------------------------------------------------------------------
--round( pred.Предоплата2021/(case when d.СуммаДоговор2021=0 then 1 else d.СуммаДоговор2021 end),4)*100 ДоляПредоплаты2021

LEFT JOIN (--СуммаОтгруз--------------------------------------------------------------------------------------------------------------
			SELECT 
				 [menedzher_guid]
				,[biznes_region_guid]
				,r.KONTRAGENT_GUID
				,[sezon_guid]
				,SUM(r.[summa]) [summa]
			  FROM [L1].[dbo].[raschety_s_klientami] r
			   LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid]
			    where [synonym_registrator] = 'Реализация товаров и услуг' 
				 group by [menedzher_guid], [biznes_region_guid], r.KONTRAGENT_GUID, [sezon_guid]
		  ) s ON d.kontragent_guid = s.kontragent_guid 
			  AND d.biznes_region_guid = s.biznes_region_guid 
			  AND d.menedzher_guid = s.menedzher_guid 
			  AND d.sezon_guid = s.sezon_guid

LEFT JOIN (--СуммаВозврат--------------------------------------------------------------------------------------------------------------
			SELECT 
				 [menedzher_guid]
				,[biznes_region_guid]
				,r.[KONTRAGENT_GUID]
				,[sezon_guid]
				,SUM(r.[summa]) [summa]
			  FROM [L1].[dbo].[raschety_s_klientami] r
			   LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid]
			     where [synonym_registrator] = 'Возврат товаров от клиента' 
				  group by [menedzher_guid], [biznes_region_guid], r.[KONTRAGENT_GUID], [sezon_guid]
		  ) v ON d.kontragent_guid = v.kontragent_guid 
			  AND d.biznes_region_guid = v.biznes_region_guid 
			  AND d.menedzher_guid = v.menedzher_guid 
			  AND d.sezon_guid = v.sezon_guid

LEFT JOIN 	(--СуммаОплат--------------------------------------------------------------------------------------------------------------
			SELECT 
				 [menedzher_guid]
				,[biznes_region_guid]
				,dk.[KONTRAGENT_GUID]
				,[sezon_guid]
				,SUM(r.[summa]) [summa]
			 FROM [L1].[dbo].[raschety_s_klientami] r
			  LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid]
			   where [synonym_registrator] IN (  'Приходный кассовый ордер'
												,'Взаимозачет задолженности'
												,'Поступление безналичных денежных средств') 
				 AND dk.[kontragent_guid] = 0x801E00155D01C90111E6E2B175C51CD1
			  group by [menedzher_guid], [biznes_region_guid], dk.[kontragent_guid], [sezon_guid]
			) o ON d.kontragent_guid = o.kontragent_guid 
				AND d.biznes_region_guid = o.biznes_region_guid 
				AND d.menedzher_guid = o.menedzher_guid 
				AND d.sezon_guid = o.sezon_guid

LEFT JOIN 	(--СуммаВозвратОплат--------------------------------------------------------------------------------------------------------------
			SELECT vo.* 
			 FROM 	(
					SELECT 
						 dk.[kontragent_guid]
						,dk.sezon_guid
						,dk.biznes_region_guid
						,dk.menedzher_guid 
						,[synonym_registrator]
						,SUM(CASE WHEN r.period >= lr.lastReturn AND r.summa >0 THEN r.summa ELSE NULL END) [СуммаВозвратОплат] 
					 FROM [L1].[dbo].[raschety_s_klientami] r
					  LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid]
					  LEFT JOIN [L0].[dbo].[sezony] s ON dk.sezon_guid = s.ssylka
					  LEFT JOIN 	(SELECT 
										 dk.[kontragent_guid]
										,dk.sezon_guid sezon_guid
										,MAX([period]) lastReturn 
									  FROM [L1].[dbo].[raschety_s_klientami] r 
									   LEFT JOIN [L1].[dbo].[dogovory_kontragentov] dk ON dk.guid = r.[dogovor_guid] 
									   LEFT JOIN [L0].[dbo].[sezony] s ON dk.sezon_guid = s.ssylka 
									    WHERE [synonym_registrator] IN ('Возврат товаров от клиента')
									  GROUP BY dk.[kontragent_guid], dk.sezon_guid
									) lr ON lr.[kontragent_guid] = dk.kontragent_guid 
									     AND lr.sezon_guid = dk.sezon_guid
						WHERE [synonym_registrator] IN ( 'Приходный кассовый ордер'
														,'Взаимозачет задолженности'
														,'Поступление безналичных денежных средств'
														, 'Возврат товаров от клиента')
					      AND lastReturn IS NOT NULL
					     GROUP BY dk.[kontragent_guid], [synonym_registrator], dk.sezon_guid, dk.biznes_region_guid, dk.menedzher_guid
					) vo
			  WHERE vo.[synonym_registrator] = 'Возврат товаров от клиента'
			) vo ON d.kontragent_guid = vo.kontragent_guid 
			     AND d.biznes_region_guid = vo.biznes_region_guid 
				 AND d.menedzher_guid = vo.menedzher_guid 
				 AND d.sezon_guid = vo.sezon_guid

LEFT JOIN 	(--ПоКупкаЭСФАА--------------------------------------------------------------------------------------------------------------
			SELECT 
				 e.bin
				,SUM(e.ПоКупкаЭСФАА) ПоКупкаЭСФАА 
				,SUM(e.Сумма) ПокупкаЭСФ
				,COALESCE(SUM(e.ПоКупкаЭСФАА)/ NULLIF(SUM(e.Сумма),0), 0)*100 ДоляЭСФАА
				,e.год 
			 FROM 	(SELECT 
						 DISTINCT [esfCode]
						,[Продукт]
						,[ценаНДС] AS [Сумма]
						,CASE WHEN [Реализатор]='Товарищество с ограниченной ответственностью "Alem Agro Holding (АлемАгро Холдинг)"' THEN [ценаНДС] ELSE NULL END AS ПоКупкаЭСФАА
						,[Количество]
						,substring([esfCode], 18,4) [год]
						,bin
					 FROM [AA_DWH_X].[dbo].[L1_esfFinal]
					  LEFT JOIN ( 
					  SELECT DISTINCT d.bin, d.id, n.number Olzhas FROM [AA_DWH_X].[dbo].[L0_ids_shymbulaq_disclosed] d LEFT JOIN [AA_DWH_X].[dbo].[L0_ids_shymbulaq] n ON n.id = d.id
								) b ON b.Olzhas = [n]
						WHERE [Статус] IN ( 'Заявка к оплате'
										   ,'Заявка оплачена'
										   ,'Заявка подана'
										   ,'Сформирован платеж')
						  AND b.bin IS NOT NULL AND [esfCode] IS NOT NULL
					) e 
			  GROUP BY e.bin, e.год
			) ea ON k.БИНКХ = ea.bin 
			    AND SUBSTRING(ssns.naimenovanie, 7,4) = ea.год

)




SELECT 
	 ALLL.Дирекция  
	,ALLL.Менеджер
	,ALLL.БизнесРегион
	,ALLL.Область
	,ALLL.Район
	,ALLL.Село
	,ALLL.НаселенныйПункт
	,ALLL.родитель
	,ALLL.БИНРодителя
	,ALLL.БИНКХ
	,ALLL.КХ

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.КвоДоговоров END) КвоДоговоров2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.КвоДоговоров END) КвоДоговоров2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.КвоДоговоров END) КвоДоговоров2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.КвоДоговоров END) КвоДоговоров2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.КвоДоговоров END) КвоДоговоров2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.КвоДоговоров END) КвоДоговоров2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.КвоДоговоров END) КвоДоговоров2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.СуммаДоговоров END ) СуммаДоговор2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.СуммаДоговоров END ) СуммаДоговор2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.СуммаДоговоров END ) СуммаДоговор2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.СуммаДоговоров END ) СуммаДоговор2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.СуммаДоговоров END ) СуммаДоговор2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.СуммаДоговоров END ) СуммаДоговор2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.СуммаДоговоров END ) СуммаДоговор2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.Предоплата END ) Предоплата2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.Предоплата END ) Предоплата2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.Предоплата END ) Предоплата2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.Предоплата END ) Предоплата2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.Предоплата END ) Предоплата2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.Предоплата END ) Предоплата2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.Предоплата END ) Предоплата2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.ДоляПредоплаты END ) ДоляПредоплаты2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.ДоляПредоплаты END ) ДоляПредоплаты2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.ДоляПредоплаты END ) ДоляПредоплаты2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.ДоляПредоплаты END ) ДоляПредоплаты2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.ДоляПредоплаты END ) ДоляПредоплаты2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.ДоляПредоплаты END ) ДоляПредоплаты2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.ДоляПредоплаты END ) ДоляПредоплаты2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.СуммаОтгруз END ) СуммаОтгруз2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.СуммаОтгруз END ) СуммаОтгруз2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.СуммаОтгруз END ) СуммаОтгруз2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.СуммаОтгруз END ) СуммаОтгруз2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.СуммаОтгруз END ) СуммаОтгруз2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.СуммаОтгруз END ) СуммаОтгруз2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.СуммаОтгруз END ) СуммаОтгруз2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.СуммаВозврат END ) СуммаВозврат2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.СуммаВозврат END ) СуммаВозврат2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.СуммаВозврат END ) СуммаВозврат2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.СуммаВозврат END ) СуммаВозврат2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.СуммаВозврат END ) СуммаВозврат2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.СуммаВозврат END ) СуммаВозврат2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.СуммаВозврат END ) СуммаВозврат2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.СуммаВозврат END ) СуммаОплат2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.СуммаВозврат END ) СуммаОплат2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.СуммаВозврат END ) СуммаОплат2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.СуммаВозврат END ) СуммаОплат2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.СуммаВозврат END ) СуммаОплат2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.СуммаВозврат END ) СуммаОплат2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.СуммаВозврат END ) СуммаОплат2023

	,SUM(CASE WHEN ALLL.YY = 2017 THEN ALLL.СуммаВозвратОплат END ) СуммаВозвратОплат2017
	,SUM(CASE WHEN ALLL.YY = 2018 THEN ALLL.СуммаВозвратОплат END ) СуммаВозвратОплат2018
	,SUM(CASE WHEN ALLL.YY = 2019 THEN ALLL.СуммаВозвратОплат END ) СуммаВозвратОплат2019
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.СуммаВозвратОплат END ) СуммаВозвратОплат2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.СуммаВозвратОплат END ) СуммаВозвратОплат2021
	,SUM(CASE WHEN ALLL.YY = 2022 THEN ALLL.СуммаВозвратОплат END ) СуммаВозвратОплат2022
	,SUM(CASE WHEN ALLL.YY = 2023 THEN ALLL.СуммаВозвратОплат END ) СуммаВозвратОплат2023
	
	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.ПокупкаЭСФ END ) ПокупкаЭСФ2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.ПокупкаЭСФ END ) ПокупкаЭСФ2021

	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.ПоКупкаЭСФАА END ) ПоКупкаЭСФАА2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.ПоКупкаЭСФАА END ) ПоКупкаЭСФАА2021

	,SUM(CASE WHEN ALLL.YY = 2020 THEN ALLL.ДоляЭСФАА END ) ДоляЭСФАА2020
	,SUM(CASE WHEN ALLL.YY = 2021 THEN ALLL.ДоляЭСФАА END ) ДоляЭСФАА2021
	
 FROM ALLL 
   GROUP BY	 ALLL.Дирекция  
		    ,ALLL.Менеджер
			,ALLL.БизнесРегион
			,ALLL.Область
			,ALLL.Район
			,ALLL.Село
			,ALLL.НаселенныйПункт
			,ALLL.родитель
			,ALLL.БИНРодителя
			,ALLL.БИНКХ
			,ALLL.КХ