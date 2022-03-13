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
	 sp.dogovor as dogovor_guid
	,sp.nomenklatura as nomenklatura_guid
	,vkn.naimenovanie vidy_kultur
	,spd.kolichestvo
	,spd.tsena
	,spd.summa
	,tsena_so_skidkoy
	,spd.summa_so_skidkoy
	,DATEADD(YEAR,-2000,sp.period)data_otgruzki
	,spd.sklad_otgruzki as sklad_otgruzki_guid
	,s.naimenovanie as [sklad_otgruzki]
	,'erp' AS source_base
	,case 
		when spd.prosrochennyy_tovar=0x00 then 'нет'
		else 'да' 
	end prosrochennyy_tovar
	,spd.norma_raskhodovaniya
	,spd.kratnost_obrabotki
  FROM  SrezPoslednikh sp
  left join [L0].[dbo].[spetsifikatsiya_po_dogovoru]spd on sp.dogovor=spd.dogovor
		and sp.nomenklatura=spd.nomenklatura
		and sp.nomer_stroki_t_ch=spd.nomer_stroki_t_ch
		and sp.period=spd.period
		and sp.srok_postavki=spd.srok_postavki
	LEFT JOIN [L0].[dbo].vidy_kultur_nomenklatury vkn on spd.vidy_kultury=vkn.ssylka
	left join [L0].dbo.sklady s on spd.sklad_otgruzki=s.ssylka
where spd.kolichestvo<>0 and spd.summa<>0




CREATE TABLE [L1].[DBO].[SPETSIFIKATSIYA_PO_DOGOVORU](
	[DOGOVOR_GUID] [BINARY](16) NOT NULL,
	[NOMENKLATURA_GUID] [BINARY](16) NOT NULL,
	[KOLICHESTVO] [NUMERIC](15, 3) NOT NULL,
	[TSENA] [NUMERIC](15, 2) NOT NULL,
	[SUMMA] [NUMERIC](15, 2) NOT NULL,
	[TSENA_SO_SKIDKOY] [NUMERIC](15, 2) NOT NULL,
	[SUMMA_SO_SKIDKOY] [NUMERIC](15, 2) NOT NULL,
	[VIDY_KULTUR] [NVARCHAR](150) NULL,
	[DATA_OTGRUZKI] [DATE] NULL,
	[SKLAD_OTGRUZKI_GUID] [BINARY](16) NULL,
	[SKLAD_OTGRUZKI] [NVARCHAR](150) NULL,
	[SOURCE_BASE] [VARCHAR](5) NULL,
	[PROSROCHENNYY_TOVAR] [VARCHAR](3) NULL,
	[NORMA_RASKHODOVANIYA] [NUMERIC](15, 3) NULL,
	[KRATNOST_OBRABOTKI] [NUMERIC](5, 0) NULL
)