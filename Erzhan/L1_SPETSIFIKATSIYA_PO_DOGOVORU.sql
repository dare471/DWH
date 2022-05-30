with SrezPoslednikh as
(
	select 
	MAX(spd.[period])[period]
	,spd.dogovor
	,spd.nomenklatura
	,spd.nomer_stroki_t_ch
	,spd.srok_postavki
from L0.dbo.spetsifikatsiya_po_dogovoru spd
group by 
	spd.dogovor
	,spd.nomenklatura
	,spd.nomer_stroki_t_ch
	,spd.srok_postavki 
)
SELECT 
	 sp.dogovor as [DOGOVOR_GUID]
	,dateadd(year,-2000,sp.period)[PERIOD]
	,sp.nomenklatura as [NOMENKLATURA_GUID]
	,vkn.naimenovanie as [VIDY_KULTUR]
	,SPD.vidy_kultury AS [VIDY_KULTUR_GUID]
	,spd.kolichestvo as [KOLICHESTVO]
	,cast(spd.summa / spd.kolichestvo as numeric(10,2)) as [TSENA]
	,spd.summa as [SUMMA]
	,tsena_so_skidkoy as [TSENA_SO_SKIDKOY]
	,[tsena_po_prays_listu] as [TSENA_PO_PRAYS_LISTU]
	,[tsena_min] as [TSENA_MIN]
	,spd.summa_so_skidkoy as [SUMMA_SO_SKIDKOY]
	,DATEADD(YEAR,-2000,sp.srok_postavki)as [DATA_OTGRUZKI]
	,spd.sklad_otgruzki as [SKLAD_OTGRUZKI_GUID]
	,s.naimenovanie as [SKLAD_OTGRUZKI]
	,'erp' AS [SOURCE_BASE]
	,case 
		when spd.prosrochennyy_tovar=0x00 then 'нет'
		else 'да' 
	 end as [PROSROCHENNYY_TOVAR]
	,spd.norma_raskhodovaniya as [NORMA_RASKHODOVANIYA]
	,spd.kratnost_obrabotki as [KRATNOST_OBRABOTKI]
	,CASe when dk.valyuta_vzaimoraschetov=0x80DE000C29E67B2E11E628A40BA74F44 then spd.summa 
	else spd.summa * kv.kurs end as [SUMMA_KZ_TG]
	--into [L1].dbo.[SPETSIFIKATSIYA_PO_DOGOVORU]
  FROM  SrezPoslednikh sp
  left join [L0].[dbo].[spetsifikatsiya_po_dogovoru]spd on sp.dogovor=spd.dogovor
		and sp.nomenklatura=spd.nomenklatura
		and sp.nomer_stroki_t_ch=spd.nomer_stroki_t_ch
		and sp.period=spd.period
		and sp.srok_postavki=spd.srok_postavki
	LEFT JOIN [L0].[dbo].vidy_kultur_nomenklatury vkn on spd.vidy_kultury=vkn.ssylka
	left join [L0].dbo.sklady s on spd.sklad_otgruzki=s.ssylka
	left join [L0].[dbo].[dogovory_kontragentov] dk on spd.dogovor=dk.ssylka
	left join [L0].dbo.valyuty v on  dk.valyuta_vzaimoraschetov=v.ssylka
	LEFT join [L0].dbo.kursy_valyut kv on cast(kv.period AS date)=CAST(dk.data AS date) and v.ssylka=kv.valyuta
where spd.kolichestvo<>0 and spd.summa<>0
and dk.status=0xA92F27FC8D2DBD51466ED7D8981B86F1 and dk.pometka_udaleniya=0x00