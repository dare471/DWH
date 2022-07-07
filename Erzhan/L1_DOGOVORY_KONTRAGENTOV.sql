with dokument_podpishi as (
select max(dvs.ssylka)ssylka
,dvs.dokument
from [L0].dbo.dokument_v_servise dvs
group by dokument
)
, kadr as ( 
SELECT [period] AS [PERIOD]
         ,[fizicheskoe_litso] AS [FIZICHESKOE_LITSO_GUID]
         ,isnull(sp.ssylka,0x00000000000000000000000000000000) as [STRUKTURA_PREDPRIYATIYA_GUID]
  FROM [L0].[dbo].[kadrovaya_istoriya_sotrudnikov]kis
  left join [L0].dbo.[shtatnoe_raspisanie] shr on kis.dolzhnost_po_shtatnomu_raspisaniyu=shr.ssylka
  left join [L0].dbo.[mesto_pozitsii_shtatnogo_raspisaniya_v_strukture_predpriyatiya] mes on shr.ssylka=mes.[pozitsiya]
  left join [L0].[dbo].[struktura_predpriyatiya] sp  on sp.ssylka=mes.[podrazdelenie]
)



SELECT  dk.[ssylka] as [GUID]
		,DK.osnovnoy_dogovor AS OSNOVNOY_DOGOVOR
		,DK.nomer_dop_soglasheniya AS NOMER_DOP_SOGLASHENIYA
		,case when dk.standartnye_usloviya_zaklyucheniya=0x01 then 'да' 
		else 'нет'
		end as [AVTOSOGLASOVANIE],
		v.naimenovanie as [VALYUTA_VZAIMORASCHETOV]
		,CASE dvs.status_podpisaniya
		WHEN 0x892F605F8F6DB1594FE49CD6F11701C9 THEN 'Подписан одной стороной'
		WHEN 0x90158A8D012EB12A4B16ADE08E902B8D THEN 'Подписан двумя сторонами'
		WHEN 0xAB0D3886E9B65BEE46F91B79F1C1A98F THEN 'Отменен'
		ELSE 'Не подписан'
	END AS [STATUS_PODPISANIYA]
		,CASE dk.tip_dogovora
		WHEN 0xA3389E59ECB123F5411A3ED37167043E THEN 'С покупателем / заказчиком'
		WHEN 0x8B4A2312CE4B533D4A75139DDFDB8623 THEN 'Импорт'
		WHEN 0x8CA38FB9F79383F2423DF86B12E91F6D THEN 'Ввоз из ЕАЭС'
		WHEN 0xB4AB7CA032D09A4C4CC873A7230CD346 THEN 'С поставщиком / исполнителем'
		ELSE 'Пустое значение'
		END AS [TIP_DOGOVORA],
	CASE dk.status
		WHEN 0xA92F27FC8D2DBD51466ED7D8981B86F1 THEN 'Действует'
		WHEN 0x82D1CD037C7784B2447E1C9C3915309E THEN 'Ожидается согласование'
		WHEN 0xA2EA1532A615D3884BDCF62760B790DE THEN 'Отменен'
		WHEN 0xB272C13AAE12525743C0BFD226B5DC0E THEN 'Закрыт'
	END AS [STATUS],
		dk.naimenovanie as [NAIMENOVANIE]
		,CAST(dk.dogovory_vnutri_gruppy AS bit) AS [DOGOVOR_VNUTRI_GRUPPY]
	,DATEADD(YEAR, - 2000, CAST(dk.data_nachala_deystviya AS date)) AS [DATA_NACHALA_DEYSTVIYA],
	DATEADD(YEAR, - 2000, CAST(dk.data_okonchaniya_deystviya AS date)) AS [DATA_OKONCHANIYA_DEYSTVIYA],
	DATEADD(YEAR, - 2000,dk.data ) AS [DATA],
	dk.nomer AS [NOMER],
	CAST(dk.soglasovan AS bit) AS [SOGLASOVAN],
	dk.organizatsiya as [ORGANIZATSIYA_GUID],
	dk.kontragent as [KONTRAGENT_GUID],
	dk.menedzher as [MENEDZHER_GUID],
	dk.biznes_region as [BIZNES_REGION_GUID],
	case when 
	kis.STRUKTURA_PREDPRIYATIYA_GUID is null then 0x00000000000000000000000000000000 else kis.STRUKTURA_PREDPRIYATIYA_GUID end as STRUKTURA_PREDPRIYATIYA_GUID 
	,
	dk.sezon as [SEZON_GUID],
	dk.sklad as [SKLAD_GUID],
	dk.summa as [SUMMA],
	ppd.naimenovanie AS [PROGRAMMA_DOGOVORA],
	'' AS [STAVKA_NDS],
	'' AS [STAVKA_NSP],
	'' AS [VIDSTAVKI_NDS],
	'' AS [BEZNALICHNYY_RASCHET], 
	uo.naimenovanie AS [USLOVIYA_OPLATY],
	'erp' AS [SOURCE_BASE],
	dk.agent_partner as [AGENT_PARTNER_GUID],
	dk.protsent_agentskikh as [PROTSENT_AGENTSKIKH],
	dk.summa_agentskikh as [SUMMA_AGENTSKIKH],
	dk.zakaz_klienta as [ZAKAZ_KLIENTA_GUID],
	CASE sposob_dostavki
		WHEN 0x9B5E4A5ABB206D854BE9B32BF442A653 THEN 'Самовывоз (с нашего склада)'
		WHEN 0x9B7EC3D470857E364E10EF7D3C09E30D THEN 'Наша транспортная служба до клиента'
		ELSE 'Не указан'
	END AS [SPOSOB_DOSTAVKI],
	dk.adres_dostavki AS ADRES_DOSTAVKI,
	CASE szk.sostoyanie	
		WHEN 0x9AE0BC17F922537141FF55A099D7C9C4 THEN 'Закрыт'
		WHEN 0xA22914A8595EC642469AF2899D7A3D9A THEN 'Ожидается обеспечение'
		WHEN 0x84AC6800414CE3C840A5B1433593EF02 THEN 'Готов к отгрузке'
		WHEN 0xA281091E5FC11DF345ED2CC3A72ECDB2 THEN 'Готов к обеспечению'
		WHEN 0xA86CBC4572045C644AF55B7CE8025E90 THEN 'В процессе отгрузки'
		ELSE 'Неопределено'
	END AS [SOSTOYANIE]
	,dk.standartnye_usloviya_zaklyucheniya as [STANDARTNYE_USLOVIYA_ZAKLYUCHENIYA]
	, CASe when dk.valyuta_vzaimoraschetov=0x80DE000C29E67B2E11E628A40BA74F44 then dk.summa 
	else dk.summa * kv.kurs end as [SUMMA_KZ_TG]
--into [L1].[dbo].[DOGOVORY_KONTRAGENTOV]
  FROM [L0].[dbo].[dogovory_kontragentov] dk
  left join [L0].[dbo].programmy_po_dogovoram ppd on dk.programma_dogovora=ppd.ssylka
  left join [L0].dbo.valyuty v on  dk.valyuta_vzaimoraschetov=v.ssylka
  LEFT join [L0].dbo.kursy_valyut kv on cast(kv.period AS date)=CAST(dk.data AS date) and v.ssylka=kv.valyuta
  left join [L0].dbo.usloviya_oplaty uo on dk.usloviya_oplaty=uo.ssylka
  left join dokument_podpishi dp on dk.ssylka=dp.dokument
  left join [L0].dbo.dokument_v_servise dvs on dp.ssylka=dvs.ssylka
  left join [L0].dbo.sostoyaniya_zakazov_klientov szk on dk.zakaz_klienta=szk.zakaz
  left join (SELECT [ssylka] as [guid]
				  ,[naimenovanie] as [naimenovanie]
				  ,[podrazdelenie] as [podrazdelenie_guid]
				  ,[fizicheskoe_litso] as [fizicheskoe_litso_guid]
				  ,'erp' as [source_base]
			  FROM [L0].[dbo].[polzovateli]
			  ) m on dk.menedzher=m.guid
  outer apply ( select TOP 1
					kis.*
					from kadr as kis
					where kis.fizicheskoe_litso_guid = m.[fizicheskoe_litso_guid]
						and kis.period < dk.[data]
					order by kis.period desc
				) kis
  where dk.status=0xA92F27FC8D2DBD51466ED7D8981B86F1 and dk.pometka_udaleniya=0x00