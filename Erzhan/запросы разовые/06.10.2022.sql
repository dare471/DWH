select
RBX.ќрганизаци€,o.description
,DATEADD(yy, DATEDIFF(yy, 0, [ѕериод]) , 0)[ѕериод]
,dateadd(day,1,EOMONTH(RBX.ѕериод,-1)) мес€ц
,sum((Case when —чет т='5710' and —четƒт in ('6010','6020','6030') then RBX.—умма else 0 end))-sum((Case when —чет т in('6010','6020','6030') and —четƒт='5710'then RBX.—умма else 0 end)) as [¬ыручка]
--,sum((Case when —четƒт='5710' and —чет т in('7010') then r.—умма else 0 end))-sum((Case when —чет т='5710' and  —четƒт in ('7010') then r.—умма else 0 end)) as [—ебестоимость реализованных товаров]
--,sum((Case when —четƒт='5710' and —чет т in('7210','7212') then r.—умма else 0 end))-sum((Case when —чет т='5710' and  —четƒт in ('7210','7212') then r.—умма else 0 end)) as [ќбщие и административные расходы]
--,sum((Case when —четƒт='5710' and —чет т in('6280','7440') then r.—умма else 0 end))-sum((Case when —чет т='5710' and  —четƒт in ('6280','7440') then r.—умма else 0 end)) as [»зменение в ќ ” на торговую дебиторскую задолженность]
--,sum((Case when —четƒт='5710' and —чет т in('7110') then r.—умма else 0 end))-sum((Case when —чет т='5710' and  —четƒт in ('7110') then r.—умма else 0 end)) as[–асходы по реализации]
--,sum((Case when —чет т='5710' and —четƒт in ('6210','6230','6290')then r.—умма else 0 end))-sum((Case when —чет т in('6210','6230','6290') and —четƒт='5710' then r.—умма else 0 end)) as [ѕрочие доходы]
--,sum((Case when —четƒт='5710' and —чет т in('7410','7480') then r.—умма else 0 end))-sum((Case when —чет т='5710' and  —четƒт in ('7410','7480') then r.—умма else 0 end)) as [ѕрочие расходы]
--,sum((Case when —чет т='5710' and —четƒт in ('6110')then r.—умма else 0 end))-sum((Case when —чет т in('6110') and —четƒт='5710' then r.—умма else 0 end)) as [‘инансовые доходы]
--,sum((Case when —четƒт='5710' and —чет т in('7310','7340') then r.—умма else 0 end))-sum((Case when —чет т='5710' and  —четƒт in ('7310','7340') then r.—умма else 0 end)) as [«атраты по финансированию]
--,sum((Case when —четƒт='5710' and —чет т in('6250','7430') then r.—умма else 0 end))-sum((Case when —чет т='5710' and  —четƒт in ('6250','7430') then r.—умма else 0 end)) as [ урсова€ разница]
--,sum((Case when —четƒт='5710' and —чет т in('7710') then r.—умма else 0 end))-sum((Case when —чет т='5710' and  —четƒт in ('7710') then r.—умма else 0 end)) as [–асходы по налогу на прибыль]

--,sum(Case when —четƒт in ('1030','1010','1050','1021','1022','1090','1151') then r.—умма else 0 end)-sum(Case when —чет т in('1030','1010','1050','1021','1022','1090','1151') then r.—умма else 0 end) as [ƒенежные средства]
--,sum((Case when —четƒт in ('1710') then r.—умма else 0 end))-sum((Case when —чет т in('1710') then r.—умма else 0 end)) as [јвансы выданные поставщикам]
--,sum((Case when —чет т in('3510') then r.—умма else 0 end))-sum((Case when —четƒт in ('3510') then r.—умма else 0 end)) as [јвансы полученные от клиентов]
--,sum((Case when —чет т in('4010') then r.—умма else 0 end))-sum((Case when —четƒт in ('4010') then r.—умма else 0 end)) as [ƒолгосрочные кредиты и займы]
--,sum((Case when —четƒт in ('2210.1') then r.—умма else 0 end))-sum((Case when —чет т in('2210.1') then r.—умма else 0 end)) as [ƒолгосрочные финансовые вложени€ (инвестиции)]
--,sum((Case when —четƒт in ('1210','1280') then r.—умма else 0 end))-sum((Case when —чет т in('1210','1280') then r.—умма else 0 end)) as [«адолженность клиентов]
--,sum((Case when —чет т in('3310') then r.—умма else 0 end))-sum((Case when —четƒт in ('3310') then r.—умма else 0 end)) as [«адолженность перед поставщиками]
--,sum((Case when —четƒт in ('1254') then r.—умма else 0 end))-sum((Case when —чет т in('1254') then r.—умма else 0 end)) as [«аймы работникам]
--,case when(sum((Case when —четƒт in ('1410','3110') then r.—умма else 0 end))-sum((Case when —чет т in('1410','3110') then r.—умма else 0 end)))>0 then sum((Case when —четƒт in ('1410','3110') then r.—умма else 0 end))-sum((Case when —чет т in('1410','3110') then r.—умма else 0 end)) else 0 end as [ ѕЌ]
--,case when(sum((Case when —чет т in('1410','3110') then r.—умма else 0 end))-sum((Case when —четƒт in ('1410','3110') then r.—умма else 0 end)))>0 then sum((Case when —чет т in('1410','3110') then r.—умма else 0 end))-sum((Case when —четƒт in ('1410','3110') then r.—умма else 0 end))else 0 end as [ ѕЌ задолженность]
--,sum((Case when —чет т in('3010') then r.—умма else 0 end))-sum((Case when —четƒт in ('3010') then r.—умма else 0 end)) as [ раткосрочные кредиты и займы]
--,sum((Case when —четƒт in ('1310') then r.—умма else 0 end))-sum((Case when —чет т in ('1310') then r.—умма else 0 end)) as [ћатериалы]
--,case when (sum((Case when —четƒт in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.—умма else 0 end))-sum((Case when —чет т in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.—умма else 0 end)))>0 
--then sum((Case when —четƒт in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.—умма else 0 end))-sum((Case when —чет т in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.—умма else 0 end)) else 0 end as [Ќƒ—]
--,case when (sum((Case when —чет т in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.—умма else 0 end))-sum((Case when —четƒт in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.—умма else 0 end)))>0
--then sum((Case when —чет т in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.—умма else 0 end))-sum((Case when —четƒт in ('1421','1423.1','1423.2','1423.3','3131','3132.3','3132.5') then r.—умма else 0 end)) else 0 end as [Ќƒ— задолженность]
--,sum((Case when —четƒт in ('2730','2740') then r.—умма else 0 end))-sum((Case when —чет т in('2730','2740') then r.—умма else 0 end)) as [Ќематериальные активы]
--,sum((Case when —чет т in('5610','5620','5710') then r.—умма else 0 end))-sum((Case when —четƒт in ('5610','5620','5710') then r.—умма else 0 end)) as [Ќераспределенна€ прибыль]
--,sum((Case when —чет т in('3040') then r.—умма else 0 end))-sum((Case when —четƒт in ('3040') then r.—умма else 0 end)) as [ќб€зательства по дивидендам]
--,sum((Case when —чет т in('3350','3385','3430') then r.—умма else 0 end))-sum((Case when —четƒт in ('3350','3385','3430') then r.—умма else 0 end)) as [ќб€зательства по заработной плате]
--,sum((Case when —четƒт in ('2411','2412','2421') then r.—умма else 0 end))-sum((Case when —чет т in('2411','2412','2421') then r.—умма else 0 end)) as [ќсновные средства]
--,sum((Case when —четƒт in ('2810') then r.—умма else 0 end))-sum((Case when —чет т in('2810') then r.—умма else 0 end)) as [ќтложенные налоговые активы]
--,sum((Case when —четƒт in ('1251') then r.—умма else 0 end))-sum((Case when —чет т in('1251') then r.—умма else 0 end)) as [ѕодотчетники]
--,sum((Case when —четƒт in ('2442','2451') then r.—умма else 0 end))-sum((Case when —чет т in('2442','2451') then r.—умма else 0 end)) as [ѕрочие внеоборотные активы]
--,sum((Case when —чет т in('4150') then r.—умма else 0 end))-sum((Case when —четƒт in ('4150') then r.—умма else 0 end)) as [ѕрочие долгосрочные об€зательства]
--,sum((Case when —четƒт in ('1220','1253','1274','1720','1740') then r.—умма else 0 end))-sum((Case when —чет т in('1220','1253','1274','1720','1740') then r.—умма else 0 end)) as [ѕрочие краткосрочные активы]
--,sum((Case when —чет т in('0000','3050','3080','3382','3388.1') then r.—умма else 0 end))-sum((Case when —четƒт in ('0000','3050','3080','3382','3388.1') then r.—умма else 0 end)) as [ѕрочие краткосрочные об€зательства]
--,sum((Case when —четƒт in ('1430') then r.—умма else 0 end))-sum((Case when —чет т in('1430') then r.—умма else 0 end)) as [ѕрочие налоги]
--,sum((Case when —чет т in('3120','3150','3160','3170','3180','3190','3211','3212','3213','3221','3230') then r.—умма else 0 end))
--                       -sum((Case when —четƒт in ('3120','3150','3160','3170','3180','3190','3211','3212','3213','3221','3230') then r.—умма else 0 end)) as [ѕрочие налоги (долг)]
--,sum((Case when —четƒт in ('1330','1363') then r.—умма else 0 end))-sum((Case when —чет т in('1330','1363') then r.—умма else 0 end)) as [“овары]
--,sum((Case when —чет т in('5110','5030') then r.—умма else 0 end))-sum((Case when —четƒт in ('5110','5030') then r.—умма else 0 end)) as [”ставный капитал]


from  [AA_DWH].[dbo].[–егистрЅухгалтерии.’озрасчетный] RBX
  left join AA_DWH.dbo.ќрганизации o on o.guid=RBX.ќрганизаци€
  left join AA_DWH.dbo.—труктураѕредпри€ти€ p on p.guid=RBX.ѕодразделениеƒт
  left join AA_DWH.dbo.—труктураѕредпри€ти€ p2 on p2.guid=RBX.ѕодразделение т
  WHERE 1=1
 AND o.guid IN(0x80DE000C29E67B2E11E636A5C3C5D8AE,
								0x80DE000C29E67B2E11E636C101BBCFE5,
								0x8128000C29EF79CA11E9757EB6129375,
								0x83C700155D01C90111E7025A688EA921,
								0x83C700155D01C90111E7025ADF7BAD12,
								0x8D7000115B5E9E4F11DDE08A5E3D9BEF,
								0xA2307085C2A4312A11EADBB4E5396FFA
								)  

  group by o.description,RBX.ќрганизаци€
,DATEADD(yy, DATEDIFF(yy, 0, [ѕериод]) , 0)
,dateadd(day,1,EOMONTH(RBX.ѕериод,-1))
  order by dateadd(day,1,EOMONTH(RBX.ѕериод,-1)), ѕериод,ќрганизаци€



--  13220233730.07
--0.00
--0.00
--0.00
--432922285.71
--0.00
--22564797.41