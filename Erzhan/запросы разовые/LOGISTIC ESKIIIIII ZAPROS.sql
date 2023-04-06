

SELECT 
	n.description name
	,n.Производитель man
	,b.СкладОтгрузки Склад,
	convert(nvarchar(50),b.Номенклатура_guid,1) guid
	,scor.УсловияОплаты pay
	,scor.ЦенаДляПланирования price
	,case when sum(Отгрузка) is null then (sum( b.Количество))
	   else (sum( b.Количество)-sum(Отгрузка)) end AS  quan
	,datepart(week,b.[ДатаОтгрузки]) week,
	DATEADD(WEEK,datepart(week,b.[ДатаОтгрузки]),'25/12/2020') date

FROM [AA_DWH].[dbo].[ДоговорыКонтрагентов] a
left join (select sum(Количество) Количество
				, Договор_guid
				,Номенклатура_guid
				,СкладОтгрузки
				,СкладОтгрузки_guid
				,min(ДатаОтгрузки)ДатаОтгрузки
			from [AA_DWH].[dbo].[СпецификацияПоДоговору] 
			--WHERE Договор_guid=0xAF90D4F5EF10792511ED44C64B26520D
			group by Договор_guid
				,Номенклатура_guid
				,СкладОтгрузки
				,СкладОтгрузки_guid
	) b on a.guid=b.Договор_guid
left join (
			select queto.guid
				,case when kbo.УсловияОплаты is null then queto.УсловияОплаты else kbo.УсловияОплаты end УсловияОплаты
				,queto.ЦенаДляПланирования
			from (select 
					zxc.guid
					,case when gkh.УсловияОплаты is null then 1 else gkh.УсловияОплаты end УсловияОплаты
					,case when gkh.ЦенаДляПланирования is null then zxc.price else gkh.ЦенаДляПланирования end ЦенаДляПланирования
  
					from (
							select convert(nvarchar(50),ggg.guid,1) guid
								,ggg.ЦенаДляПланирования
								,case when bro.УсловияОплаты is null then ggg.УсловияОплаты else bro.УсловияОплаты end УсловияОплаты

							from (select 
					                 convert(nvarchar(50),n.Номенклатура_guid,1) guid
									 ,case when Поставщик in('ТОО "Август-Казахстан"','ТОО "Кортева Агрисаенс Казахстан"') then 0.2 else 1 end УсловияОплаты
                                     ,isnull(s.ЦенаПоставщикаKZT,isnull(max(case when ВидЦены='Цены Закупа' then  p.Цена end),max(case when ВидЦены='Цены Закупа EUR' then  p.Цена end)*510))ЦенаДляПланирования   /* Берем цены из договоров с поставщиками, если нет, то 'Цены Закупа' в тенге, если нет, то 'Цены Закупа EUR' по курсу 510*/

								 from (SELECT distinct
											n.Производитель,
											n.description Номенклатура
											,sd.Номенклатура_guid [Номенклатура_guid] 
										FROM [AA_DWH].[dbo].[СпецификацияПоДоговору] sd
										LEFT JOIN [AA_DWH].[dbo].[Номенклатура] n on n.guid_binary = sd.[Номенклатура_guid]
										LEFT JOIN [AA_DWH].[dbo].[ДоговорыКонтрагентов] dc on dc.guid = sd.[Договор_guid]
										LEFT JOIN [AA_DWH].[dbo].Контрагенты c on c.guid = dc.[Контрагент_guid]
										LEFT JOIN [AA_DWH].[dbo].Сезоны s on s.guid = dc.[Сезон_guid]
										WHERE dc.ТипДоговора IN ('С покупателем / заказчиком')
										AND dc.[source_base] = 'erp'
										AND [Статус] = 'Действует'
										AND c.[description] <> 'LLC Alem Agro KG (ОсОО Алем Агро Кей Джи)'
										AND (s.description = 'Сезон 2022')
										) n 
									left join [AA_DWH].[dbo].ЦеныНоменклатуры_ПоСезонам p on p.Номенклатура_guid=n.Номенклатура_guid
									left join (select a.Номенклатура_guid
														,a.Поставщик
														, a.ЦенаПоставщикаKZT 
												from (SELECT
															sd.Номенклатура_guid,
															c.description Поставщик,
															max(ROUND(CASE WHEN (v.Валюта IS NOT NULL AND v.Курс IS NOT NULL) THEN sd.[Цена]*v.Курс ELSE sd.[Цена] END,2)) AS [ЦенаПоставщикаKZT] 
 
														FROM [AA_DWH].[dbo].[СпецификацияПоДоговору] sd
														  LEFT JOIN [AA_DWH].[dbo].[ДоговорыКонтрагентов] dc on dc.guid = sd.[Договор_guid]
														  LEFT JOIN [AA_DWH].[dbo].Контрагенты c on c.guid = dc.[Контрагент_guid]
														  LEFT JOIN [AA_DWH].[dbo].Сезоны s on s.guid = dc.[Сезон_guid]
														  LEFT JOIN [AA_DWH].[dbo].Менеджеры m on m.guid = dc.[Менеджер_guid]
														  LEFT JOIN [AA_DWH].[dbo].[КурсыВалютAll] v on v.Период = dc.[Дата] AND v.Валюта = dc.ВалютаВзаиморасчетов
														  WHERE dc.ТипДоговора IN ('С поставщиком / исполнителем', 'Импорт', 'Ввоз из ЕАЭС')
														  AND dc.[source_base] = 'erp'
														  AND m.description IN ('Дакариева Жанна', 'Даутов Нуржан', 'Жануева Дайана Муратхановна')
														  AND [Статус] = 'Действует'
														  AND c.[description] <> 'LLC Alem Agro KG (ОсОО Алем Агро Кей Джи)'
														-- AND (s.description = 'Сезон 2022')
														  GROUP BY 
														 sd.Номенклатура_guid,
														c.description
														)a  
												join(select 
														a.Номенклатура_guid
														, max(ЦенаПоставщикаKZT) ЦенаПоставщикаKZT
													from  (SELECT
																sd.Номенклатура_guid,
																c.description Поставщик,
																max(ROUND(CASE WHEN (v.Валюта IS NOT NULL AND v.Курс IS NOT NULL) THEN sd.[Цена]*v.Курс ELSE sd.[Цена] END,2)) AS [ЦенаПоставщикаKZT] 
															FROM [AA_DWH].[dbo].[СпецификацияПоДоговору] sd

															  LEFT JOIN [AA_DWH].[dbo].[ДоговорыКонтрагентов] dc on dc.guid = sd.[Договор_guid]
															  LEFT JOIN [AA_DWH].[dbo].Контрагенты c on c.guid = dc.[Контрагент_guid]
															  LEFT JOIN [AA_DWH].[dbo].Сезоны s on s.guid = dc.[Сезон_guid]
															  LEFT JOIN [AA_DWH].[dbo].Менеджеры m on m.guid = dc.[Менеджер_guid]
															  LEFT JOIN [AA_DWH].[dbo].[КурсыВалютAll] v on v.Период = dc.[Дата] AND v.Валюта = dc.ВалютаВзаиморасчетов
															  WHERE dc.ТипДоговора IN ('С поставщиком / исполнителем', 'Импорт', 'Ввоз из ЕАЭС')
																  AND dc.[source_base] = 'erp'
																  AND m.description IN ('Дакариева Жанна', 'Даутов Нуржан', 'Жануева Дайана Муратхановна')
																  AND [Статус] = 'Действует'
																  AND c.[description] <> 'LLC Alem Agro KG (ОсОО Алем Агро Кей Джи)'
																-- AND (s.description = 'Сезон 2022')
															  GROUP BY 
															 sd.Номенклатура_guid,
															c.description 
														) a 
													group by a.Номенклатура_guid
												) b on a.Номенклатура_guid=b.Номенклатура_guid and a.ЦенаПоставщикаKZT=b.ЦенаПоставщикаKZT
											) s on n.Номенклатура_guid=s.Номенклатура_guid    
										WHERE   
											isnull(Цена, 0) <> 0 
											and p.ВидЦены like '%Цены Закупа%' 
											and year(p.date)='2022' 
										group by convert(nvarchar(50),n.Номенклатура_guid,1),
										s.Поставщик,s.ЦенаПоставщикаKZT
										) ggg
									left join (SELECT distinct convert(nvarchar(50),c.guid_binary,1) guid_binary,
													c.description
													,c.Культура
													,case when Культура='Подсолнечник' then 0.2 else 1 end УсловияОплаты
												FROM [AA_DWH].[dbo].[Номенклатура] c
												where Производитель='Pioneer' 
													and Культура is not null 
													and Культура!=''
												) bro on bro.guid_binary=ggg.guid
								) gkh
					right join (SELECT convert(nvarchar(50),a.guid_binary,1) guid
								,w.Цена price
								FROM [AA_DWH].[dbo].Номенклатура a 
								LEFT JOIN [AA_DWH].[dbo].[ЦеныНоменклатуры_ПоСезонам] w ON w.Номенклатура_guid = a.guid_binary 
								LEFT JOIN[AA_DWH].[dbo].[Сезоны] r_b ON r_b.[guid] = w.[Сезон_guid] 
								JOIN(SELECT Номенклатура_guid
											, ВидЦены
											, ВидВалюты
											, max(date) date
										FROM            [AA_DWH].[dbo].ЦеныНоменклатуры_ПоСезонам
										WHERE        isnull(Цена, 0) <> 0
										GROUP BY Номенклатура_guid, ВидЦены, ВидВалюты
									) b ON b.Номенклатура_guid = w.Номенклатура_guid 
										AND b.ВидВалюты = w.ВидВалюты 
										AND b.date = w.date 
										AND b.ВидЦены = w.ВидЦены
									WHERE a.description IS NOT NULL AND isnull(w.Цена, 0) <> 0 AND (w.ВидЦены = 'Цены Закупа') AND (a.ГруппаУр2 = 'СЗР ' OR
																a.ГруппаУр2 = 'Семена ' OR
																a.ГруппаУр2 = 'Удобрения')
									) zxc on zxc.guid=gkh.guid
				) queto
			left join (select convert(nvarchar(50),guid_binary,1) guid_binary
							,description
							,Производитель
							,case when Производитель='Valagro' then 0
									when Производитель='BASF' then 0
									when description='Гранстар Мега, 10*500 гр.' then 0.5
									when Производитель='FMC' then 0.15 end УсловияОплаты
						from [AA_DWH].[dbo].[Номенклатура] a
						where (case when Производитель='Valagro' then 0
									when Производитель='BASF' then 0
									when description='Гранстар Мега, 10*500 гр.' then 0.5
									when Производитель='FMC' then 0.15 end) is not null and (a.ГруппаУр2 = 'СЗР ' OR
																a.ГруппаУр2 = 'Семена ' OR
																a.ГруппаУр2 = 'Удобрения')
		) kbo on kbo.guid_binary=queto.guid
	) scor on convert(nvarchar(50),scor.guid,1)=convert(nvarchar(50),b.Номенклатура_guid,1)
left join [AA_DWH].[dbo].Менеджеры m on a.Менеджер_guid=m.guid
left join [AA_DWH].[dbo].Номенклатура n on b.Номенклатура_guid=n.guid_binary
left join [AA_DWH].[dbo].Сезоны s on s.guid=a.Сезон_guid
left join [AA_DWH].[dbo].Организации o on o.guid=a.Организация_guid
left join (SELECT 
				[Договор_guid]
				,[Номенклатура_guid]
				,[Номенклатура_v2_guid]
				,sum([Количество]) Отгрузка
			FROM [AA_DWH].[dbo].[ВыручкаИСебестоимостьПродаж_guid]
			group by [Договор_guid]
				,[Номенклатура_guid]
				,[Номенклатура_v2_guid]
			) v on v.Договор_guid=b.Договор_guid and v.Номенклатура_guid=b.Номенклатура_guid
left join (SELECT  
				[Номенклатура_guid]
			FROM [AA_DWH].[dbo].[ТоварыНаСкладахОстаткиПоСрокамГодности] 
			where [source_base]='erp'
			group by   [Номенклатура_guid]
		) t on b.Номенклатура_guid=t.[Номенклатура_guid]
where s.description like '%2022%' 
		and   [Статус]='Действует'
		and ТипДоговора= 'С покупателем / заказчиком'
		and b.Номенклатура_guid is not null
		and o.description like '%ТОО «Alem Agro Holding (АлемАгро Холдинг)»%'
group by --a.description,
		n.description
		,n.Производитель
		,b.СкладОтгрузки
		,scor.УсловияОплаты
		,scor.ЦенаДляПланирования
		,convert(nvarchar(50),b.Номенклатура_guid,1)
		,datepart(week,b.[ДатаОтгрузки])
		,DATEADD(WEEK,datepart(week,b.[ДатаОтгрузки]),'25/12/2020')
