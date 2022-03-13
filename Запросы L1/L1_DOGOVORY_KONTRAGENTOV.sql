/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
with dokument_podpishi as (
select max(dvs.ssylka)ssylka
,dvs.dokument
from [L0].dbo.dokument_v_servise dvs
group by dokument
)


SELECT  dk.[ssylka] as[guid]
		,case when dk.standartnye_usloviya_zaklyucheniya=0x01 then 'да' 
		else 'нет'
		end as avto_soglasovanie,
		v.naimenovanie as valyuta_vzaimoraschetov
		,CASE dvs.status_podpisaniya
		WHEN 0x892F605F8F6DB1594FE49CD6F11701C9 THEN 'Подписан одной стороной'
		WHEN 0x90158A8D012EB12A4B16ADE08E902B8D THEN 'Подписан двумя сторонами'
		WHEN 0xAB0D3886E9B65BEE46F91B79F1C1A98F THEN 'Отменен'
		ELSE 'Не подписан'
	END AS status_podpisaniya
		,CASE dk.tip_dogovora
		WHEN 0xA3389E59ECB123F5411A3ED37167043E THEN 'С покупателем / заказчиком'
		WHEN 0x8B4A2312CE4B533D4A75139DDFDB8623 THEN 'Импорт'
		WHEN 0x8CA38FB9F79383F2423DF86B12E91F6D THEN 'Ввоз из ЕАЭС'
		WHEN 0xB4AB7CA032D09A4C4CC873A7230CD346 THEN 'С поставщиком / исполнителем'
		ELSE 'Пустое значение'
		END AS tip_dogovora,
	CASE dk.status
		WHEN 0xA92F27FC8D2DBD51466ED7D8981B86F1 THEN 'Действует'
		WHEN 0x82D1CD037C7784B2447E1C9C3915309E THEN 'Ожидается согласование'
		WHEN 0xA2EA1532A615D3884BDCF62760B790DE THEN 'Отменен'
		WHEN 0xB272C13AAE12525743C0BFD226B5DC0E THEN 'Закрыт'
	END AS [status],
		dk.naimenovanie
		,CAST(dk.dogovory_vnutri_gruppy AS bit) AS dogovor_vnutri_gruppy
	,DATEADD(YEAR, - 2000, CAST(dk.data_nachala_deystviya AS date)) AS data_nachala_deystviya,
	DATEADD(YEAR, - 2000, CAST(dk.data_okonchaniya_deystviya AS date)) AS data_okonchaniya_deystviya,
	DATEADD(YEAR, - 2000, CAST(dk.data AS date)) AS [data],
	dk.nomer AS nomer,
	CAST(dk.soglasovan AS bit) AS Согласован,
	dk.organizatsiya as[organizatsiya_guid],
	dk.kontragent as [kontragent_guid],
	dk.menedzher as [menedzher_guid],
	dk.biznes_region as [biznes_region_guid],
	dk.sezon as [sezon_guid],
	dk.sklad as [sklad_guid],
	dk.summa,
	ppd.naimenovanie AS programma_dogovora,
	'' AS stavka_NDS,
	'' AS stavka_NSP,
	'' AS vidStavki_NDS,
	'' AS beznalichnyy_raschet, 
	uo.naimenovanie AS usloviya_oplaty,
	'erp' AS source_base,
	dk.agent_partner as [agent_partner_guid],
	dk.protsent_agentskikh,
	dk.summa_agentskikh,
	dk.zakaz_klienta as [zakaz_klienta_guid],
	CASE sposob_dostavki
		WHEN 0x9B5E4A5ABB206D854BE9B32BF442A653 THEN 'Самовывоз (с нашего склада)'
		WHEN 0x9B7EC3D470857E364E10EF7D3C09E30D THEN 'Наша транспортная служба до клиента'
		ELSE 'Не указан'
	END AS sposob_dostavki,
	dk.adres_dostavki,
	CASE szk.sostoyanie	
		WHEN 0x9AE0BC17F922537141FF55A099D7C9C4 THEN 'Закрыт'
		WHEN 0xA22914A8595EC642469AF2899D7A3D9A THEN 'Ожидается обеспечение'
		WHEN 0x84AC6800414CE3C840A5B1433593EF02 THEN 'Готов к отгрузке'
		WHEN 0xA281091E5FC11DF345ED2CC3A72ECDB2 THEN 'Готов к обеспечению'
		WHEN 0xA86CBC4572045C644AF55B7CE8025E90 THEN 'В процессе отгрузки'
		ELSE 'Неопределено'
	END AS sostoyanie
	,dk.standartnye_usloviya_zaklyucheniya
  FROM [L0].[dbo].[dogovory_kontragentov] dk
  left join [L0].[dbo].programmy_po_dogovoram ppd on dk.programma_dogovora=ppd.ssylka
  left join [L0].dbo.valyuty v on  dk.valyuta_vzaimoraschetov=v.ssylka
  left join [L0].dbo.usloviya_oplaty uo on dk.usloviya_oplaty=uo.ssylka
  left join dokument_podpishi dp on dk.ssylka=dp.dokument
  left join [L0].dbo.dokument_v_servise dvs on dp.ssylka=dvs.ssylka
  left join [L0].dbo.sostoyaniya_zakazov_klientov szk on dk.zakaz_klienta=szk.zakaz



  CREATE TABLE [L1].[dbo].[DOGOVORY_KONTRAGENTOV](
	[GUID] [binary](16) NOT NULL,
	[NAIMENOVANIE] [nvarchar](150) NOT NULL,
	[DOGOVOR_VNUTRI_GRUPPY] [bit] NULL,
	[DATA_NACHALA_DEYSTVIYA] [date] NULL,
	[DATA_OKONCHANIYA_DEYSTVIYA] [date] NULL,
	[DATA] [date] NULL,
	[NOMER] [nvarchar](128) NOT NULL,
	[SOGLASOVAN] [bit] NULL,
	[ORGANIZATSIYA_GUID] [binary](16) NOT NULL,
	[KONTRAGENT_GUID] [binary](16) NOT NULL,
	[MENEDZHER_GUID] [binary](16) NOT NULL,
	[BIZNES_REGION_GUID] [binary](16) NOT NULL,
	[SEZON_GUID] [binary](16) NOT NULL,
	[SKLAD_GUID] [binary](16) NOT NULL,
	[SUMMA] [numeric](15, 2) NOT NULL,
	[PROGRAMMA_DOGOVORA] [nvarchar](50) NULL,
	[TIP_DOGOVORA] [varchar](50) NULL,
	[AVTOSOGLASOVANIE] [varchar](50) NULL,
	[SOURCE_BASE] [varchar](5) NULL,
	[STAVKA_NDS] [varchar](50) NULL,
	[STAVKA_NSP] [varchar](50) NULL,
	[VIDSTAVKI_NDS] [varchar](150) NULL,
	[BEZNALICHNYY_RASCHET] [varchar](50) NULL,
	[AGENT_PARTNER_GUID] [binary](16) NULL,
	[SUMMA_AGENTSKIKH] [numeric](15, 2) NULL,
	[PROTSENT_AGENTSKIKH] [numeric](10, 3) NULL,
	[VALYUTA_VZAIMORASCHETOV] [nvarchar](50) NULL,
	[USLOVIYA_OPLATY] [nvarchar](50) NULL,
	[STATUS_PODPISANIYA] [varchar](150) NULL,
	[STATUS] [varchar](150) NULL,
	[ZAKAZ_KLIENTA_GUID] [binary](16) NULL,
	[SPOSOB_DOSTAVKI] [varchar](150) NULL,
	[ADRES_DOSTAVKI] [nvarchar](500) NULL,
	[SOSTOYANIE] [varchar](150) NULL,
	[STANDARTNYE_USLOVIYA_ZAKLYUCHENIYA] [binary](1) null
)