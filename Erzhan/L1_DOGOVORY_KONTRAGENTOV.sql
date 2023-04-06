WITH dokument_podpishi AS (
SELECT MAX(dvs.ssylka)ssylka
,dvs.dokument
FROM [L0].dbo.dokument_v_servise dvs
GROUP BY dokument
)
,KADR_1 AS (
SELECT dateadd(year,-2000,[period]) AS [PERIOD]
         ,case when [synonym_registrator]='Прием на работу' then 'Прием'
          when [synonym_registrator]='Увольнение' then 'Увольнение'
          when [synonym_registrator]='Перемещение в другое подразделение' or [synonym_registrator]='Кадровый перевод' then 'Перемещение' 
            end AS VIDSOBYTIYA 
         ,[fizicheskoe_litso] AS [FIZICHESKOE_LITSO_GUID]
         --,kis.dolzhnost as [DOLZHNOST_GUID]
         ,kis.organizatsiya as [ORGANIZATSIYA_GUID]
         ,isnull(
				 CASE WHEN [fizicheskoe_litso] IN (0xA2257085C2A4312A11EA0B582A2C7D57,0xA2277085C2A4312A11EA2255B7ECEE3B) THEN 0x80D200155D01C90111E7BF940C0A33DF
						WHEN [fizicheskoe_litso] = 0xA22B7085C2A4312A11EA8912064E4DFC THEN 0xA2337085C2A4312A11EB347829D1F27A 
						WHEN [fizicheskoe_litso] = 0x80D300155D01C90111E7D97687907709 THEN 0xBFC5B8CB29F9512311ED987771808E51
						WHEN [fizicheskoe_litso] = 0x80DF000C29E67B2E11E63907945313F7 AND  kis.organizatsiya = 0x80DE000C29E67B2E11E636C101BBCFE5 AND sp.ssilka=0xA21F7085C2A4312A11E9F3E8C74A132D THEN 0xA21F7085C2A4312A11E9F3E8ABBCB7F2
						WHEN [fizicheskoe_litso] = 0x8110000C29EF79CA11E903498232D42D AND  kis.organizatsiya = 0xA22B7085C2A4312A11EA5D1C751AF2B4 AND sp.ssilka=0x8D9B6427378958AD11E35283A68E63AB THEN 0xBFC5B8CB29F9512311ED9875C3F9355B
					ELSE sp.ssilka 
				END ,0x00000000000000000000000000000000
				) as [STRUKTURA_PREDPRIYATIYA_GUID]
         ,kis.[podrazdelenie] AS [PODRAZDELENIE_GUID]
         ,CAST(GETDATE() AS DATE) A_DATE
  FROM [L0].[dbo].[kadrovaya_istoriya_sotrudnikov]kis
  left join [L0].dbo.[shtatnoe_raspisanie] shr on kis.dolzhnost_po_shtatnomu_raspisaniyu=shr.ssylka
  left join [L0].dbo.[mesto_pozitsii_shtatnogo_raspisaniya_v_strukture_predpriyatiya] mes on shr.ssylka=mes.[pozitsiya]
  left join [L0].[dbo].[struktura_predpriyatiya] sp  on sp.ssilka=mes.[podrazdelenie]

  WHERE 1=1
  --AND organizatsiya=0x80DE000C29E67B2E11E636A5C3C5D8AE
  --AND fizicheskoe_litso=0x8110000C29EF79CA11E903498232D42D
)




, kadr AS ( 
SELECT [period] AS [PERIOD] /*** СТРУКТУРА ПРЕДПРИЯТИЯНЫ  ШЫҒАРЫП АЛУ ҮШІН ****/
         ,[FIZICHESKOE_LITSO_GUID] AS [FIZICHESKOE_LITSO_GUID]
         ,ISNULL([STRUKTURA_PREDPRIYATIYA_GUID],0x00000000000000000000000000000000) AS [STRUKTURA_PREDPRIYATIYA_GUID]
  FROM KADR_1 kis
--[L0].[dbo].[kadrovaya_istoriya_sotrudnikov]
--  left join [L0].dbo.[shtatnoe_raspisanie] shr 
--ON kis.dolzhnost_po_shtatnomu_raspisaniyu=shr.ssylka
--  left join [L0].dbo.[mesto_pozitsii_shtatnogo_raspisaniya_v_strukture_predpriyatiya] mes 
--ON shr.ssylka=mes.[pozitsiya]
--  left join [L0].[dbo].[struktura_predpriyatiya] sp 
--ON sp.ssilka=mes.[podrazdelenie]
WHERE KIS.[period]=(
		SELECT MAX(KIS2.[period])
		FROM KADR_1 KIS2
  WHERE KIS2.[FIZICHESKOE_LITSO_GUID]=KIS.[FIZICHESKOE_LITSO_GUID]
  )
)



SELECT DISTINCT dk.[ssylka] AS [GUID]
		,DK.osnovnoy_dogovor AS OSNOVNOY_DOGOVOR
		,DK.nomer_dop_soglasheniya AS NOMER_DOP_SOGLASHENIYA
		,CASE WHEN dk.standartnye_usloviya_zaklyucheniya=0x01 THEN 'да' 
			ELSE 'нет'
			END AS [AVTOSOGLASOVANIE],
		v.naimenovanie AS [VALYUTA_VZAIMORASCHETOV]
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
		END AS [TIP_DOGOVORA]
		,SDK.description [STATUS]
		,dk.naimenovanie AS [NAIMENOVANIE]
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
	CASE WHEN menedzher=0x92B70025907801D211E3672CA6AC4140 THEN 0xA21F7085C2A4312A11E9F3E8C74A132D 
		WHEN menedzher=0xA22C7085C2A4312A11EAA0AAA1D378E7 THEN 0xA21F7085C2A4312A11E9F3E8CFC3F143
	ELSE ISNULL(kadr.STRUKTURA_PREDPRIYATIYA_GUID,0) END AS STRUKTURA_PREDPRIYATIYA_GUID
	--case when 
	--kis.STRUKTURA_PREDPRIYATIYA_GUID is null then 0x00000000000000000000000000000000 else kis.STRUKTURA_PREDPRIYATIYA_GUID end AS STRUKTURA_PREDPRIYATIYA_GUID 
	,
	dk.sezon AS [SEZON_GUID],
	dk.sklad AS [SKLAD_GUID],
	dk.summa AS [SUMMA],
	ppd.naimenovanie AS [PROGRAMMA_DOGOVORA],
	CONVERT(NVARCHAR(50),'',1) AS [STAVKA_NDS],
	CONVERT(NVARCHAR(50),'',1) AS [STAVKA_NSP],
	CONVERT(NVARCHAR(150),'',1) AS [VIDSTAVKI_NDS],
	CONVERT(VARCHAR(50),'',1) AS [BEZNALICHNYY_RASCHET], 
	uo.naimenovanie AS [USLOVIYA_OPLATY],
	'erp' AS [SOURCE_BASE],
	dk.agent_partner AS [AGENT_PARTNER_GUID],
	dk.protsent_agentskikh AS [PROTSENT_AGENTSKIKH],
	dk.summa_agentskikh AS [SUMMA_AGENTSKIKH],
	dk.zakaz_klienta AS [ZAKAZ_KLIENTA_GUID],
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
	, CASe WHEN dk.valyuta_vzaimoraschetov=0x80DE000C29E67B2E11E628A40BA74F44 THEN dk.summa 
	ELSE dk.summa * kv.kurs END AS [SUMMA_KZ_TG]
--INTO [L1].[dbo].[DOGOVORY_KONTRAGENTOV]
  FROM [L0].[dbo].[dogovory_kontragentov] dk
  left join [L0].[dbo].programmy_po_dogovoram ppd ON dk.programma_dogovora=ppd.ssylka
  left join [L0].dbo.valyuty v ON dk.valyuta_vzaimoraschetov=v.ssylka
  LEFT join [L0].dbo.kursy_valyut kv ON CAST(kv.period AS date)=CAST(dk.data AS date) and v.ssylka=kv.valyuta
  left join [L0].dbo.usloviya_oplaty uo ON dk.usloviya_oplaty=uo.ssylka
  left join dokument_podpishi dp ON dk.ssylka=dp.dokument
  left join [L0].dbo.dokument_v_servise dvs ON dp.ssylka=dvs.ssylka
  left join [L0].dbo.sostoyaniya_zakazov_klientov szk ON dk.zakaz_klienta=szk.zakaz
  LEFT JOIN [L0].dbo.statusy_dogovorov_kontragentov AS SDK ON DK.status=SDK.ssylka
  left join (SELECT [ssylka] AS [guid]
				  ,[naimenovanie] AS [naimenovanie]
				  ,[podrazdelenie] AS [podrazdelenie_guid]
				  ,[fizicheskoe_litso] AS [fizicheskoe_litso_guid]
				  ,'erp' AS [source_base]
			  FROM [L0].[dbo].[polzovateli]
			  ) m ON dk.menedzher=m.guid
LEFT JOIN kadr ON kadr.FIZICHESKOE_LITSO_GUID=M.fizicheskoe_litso_guid
  --outer apply ( select TOP 1        /*** МЫНАНЫ 1ДИРЕКЦИЯДАН 2 ДИРЕКЦИЯГА АУЫСКАНДА КОЛДАНСА БОЛАДЫ, ҚАЗІР ҚОЛДАНСОН ДҰРЫС ЖАСАМАЙДЫ КЕІН ҚОЛДАН ЖАРАЙДЫМА?***/
		--			kis.*
		--			from kadr as kis
		--			where kis.fizicheskoe_litso_guid = m.[fizicheskoe_litso_guid]
		--				and kis.period < dk.[data]
		--			order by kis.period desc
		--		) kis
  WHERE 1=1
  --AND dk.status=0xA92F27FC8D2DBD51466ED7D8981B86F1 
  AND dk.pometka_udaleniya=0x00
 --AND  M.naimenovanie='Жангунов Ержан'
  --AND DK.nomer like '%Оп07/21%'
--  AND M.naimenovanie = 'Данильчук Александр Анатольевич'

ORDER BY DK.ssylka