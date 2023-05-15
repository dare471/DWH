/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT N.[NAIMENOVANIE] AS Номенклатура
,N.GUID
      ,[EDINITSA_IZMERENIYA] AS [Единица измерения]
      ,[PROIZVODITELI] AS Производитель
      ,[KATEGORII_NOMENKLATURY] AS Категория
      ,[KATEGORII_NOMENKLATURY_GROUP] AS[Группа списка]
      ,[VIDY_KULTUR_NOMENKLATURY] AS Культура
      ,[VIDY_TEKHNOLOGIY] AS Технология


      ,AT.[naimenovanie] AS [Ассортимент товара]
	  ,K.naimenovanie AS Поставщик_Ассортимент
	  ,[preparativnaya_forma] AS[Препаративная форма_Ассортимент]
      ,P.naimenovanie AS Производитель_Ассортимент
      ,FAO.naimenovanie AS [ФАО семян_Ассортимент]
      ,VKN.naimenovanie AS Культура_Ассортимент
      ,VDV.naimenovanie AS Протравка_Ассортимент
	  ,KN.naimenovanie AS Категория_Ассортимент
	  ,ISNULL(KNRR.naimenovanie,KNR.naimenovanie) [Категория Группа_Ассортимент]
      ,BRE.naimenovanie  AS Бренд_Ассортимент
      ,VT.naimenovanie AS [Технология семян_Ассортимент]
      ,[segmentatsiya_po_tsene] AS [Сегментация по цене_Ассортимент]
      ,[kolichestvo_semyan_v_p_e] AS[Количество семян в п.е._Ассортимент]
      ,[naznachenie] AS Назначение_Ассортимент
	  ,OSTA.v_nalichii AS Остатки
      ,CASE WHEN [tovar_v_portfele]=1 THEN 'Да' ELSE 'Нет' END  AS [tovar_v_portfele_Ассортимент]
      ,CASE WHEN [sertifitsirovan]=1 THEN 'Да' ELSE 'Нет' END  AS [sertifitsirovan_Ассортимент]
      ,CASE WHEN [subsidiruetsya]=1 THEN 'Да' ELSE 'Нет' END  AS [subsidiruetsya_Ассортимент]
	  


  FROM [L1].[dbo].[NOMENKLATURA] AS N
LEFT JOIN [L0].[dbo].[assortiment_tovara] AS AT
	ON N.ASSORTIMENT_TOVARA_GUID=AT.SSYLKA
LEFT JOIN [L0].[dbo].kontragenty K
	ON AT.postavshchik=K.ssylka
LEFT JOIN [L0].[dbo].PROIZVODITELI P
	ON AT.PROIZVODITEL=P.ssylka
LEFT JOIN [L0].[dbo].PROIZVODITELI BRE
	ON AT.brend=BRE.ssylka
LEFT JOIN [L0].[dbo].kategorii_nomenklatury KN
	ON AT.kategoriya=KN.ssylka
LEFT JOIN [L0].[dbo].kategorii_nomenklatury KNR
	ON KN.roditel=KNR.ssylka
LEFT JOIN [L0].[dbo].kategorii_nomenklatury KNRR
	ON KNR.roditel=KNRR.ssylka
LEFT JOIN [L0].[dbo].vidy_tekhnologiy VT 
	ON AT.tekhnologiya_semyan=VT.ssylka
LEFT JOIN [L0].[dbo].vidy_tekhnologiy FAO
	ON AT.f_a_o_semyan=FAO.ssylka
LEFT JOIN [L0].[dbo].vidy_deystvuyushchikh_veshchestv VDV
	ON AT.protravka=VDV.ssylka
LEFT JOIN [L0].[dbo].vidy_kultur_nomenklatury VKN
	ON AT.kultura=VKN.ssylka
LEFT JOIN (SELECT 
        [NOMENKLATURA_GUID]
    --,datepart(week,getdate()) week
        ,SUM(case when TNS.[VID_DVIZHENIYA]=1 then [v_nalichii]*(-1) else [v_nalichii] end) AS [v_nalichii]
      FROM [L1].[dbo].[tovary_na_skladakh] TNS
      GROUP BY [NOMENKLATURA_GUID]) OSTA
	ON N.GUID=OSTA.NOMENKLATURA_GUID
WHERE ISNULL(KNRR.naimenovanie
	  ,KNR.naimenovanie)='Семена'
	  OR [KATEGORII_NOMENKLATURY_GROUP]='Семена'