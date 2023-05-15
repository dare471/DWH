SELECT dateadd(year,-2000,[period]) AS [PERIOD]
         ,case when [synonym_registrator]='Прием на работу' then 'Прием'
          when [synonym_registrator]='Увольнение' then 'Увольнение'
          when [synonym_registrator]='Перемещение в другое подразделение' or [synonym_registrator]='Кадровый перевод' then 'Перемещение' 
            end AS VIDSOBYTIYA 
         ,[fizicheskoe_litso] AS [FIZICHESKOE_LITSO_GUID]
         ,kis.dolzhnost as [DOLZHNOST_GUID]
         ,kis.organizatsiya as [ORGANIZATSIYA_GUID]
         ,isnull(
				 CASE WHEN [fizicheskoe_litso] IN (0xA2257085C2A4312A11EA0B582A2C7D57,0xA2277085C2A4312A11EA2255B7ECEE3B) THEN 0x80D200155D01C90111E7BF940C0A33DF
						WHEN [fizicheskoe_litso] = 0xA22B7085C2A4312A11EA8912064E4DFC THEN 0xA2337085C2A4312A11EB347829D1F27A 
						WHEN [fizicheskoe_litso] = 0x80D300155D01C90111E7D97687907709 THEN 0xBFC5B8CB29F9512311ED987771808E51
						WHEN [fizicheskoe_litso] = 0x80DF000C29E67B2E11E63907945313F7 AND  kis.organizatsiya = 0x80DE000C29E67B2E11E636C101BBCFE5 AND sp.ssilka=0xA21F7085C2A4312A11E9F3E8C74A132D THEN 0xA21F7085C2A4312A11E9F3E8ABBCB7F2
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
  --AND [fizicheskoe_litso] = 0x80DF000C29E67B2E11E63907945313F7 --AND  kis.organizatsiya = 0x80DE000C29E67B2E11E636C101BBCFE5
  --AND dateadd(year,-2000,[period])!='2023-01-01 00:01:01')

--order by [period],sp.ssilka