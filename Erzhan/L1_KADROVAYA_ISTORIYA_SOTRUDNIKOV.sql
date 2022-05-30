SELECT dateadd(year,-2000,[period]) AS [PERIOD]
         ,case when [synonym_registrator]='Прием на работу' then 'Прием'
          when [synonym_registrator]='Увольнение' then 'Увольнение'
          when [synonym_registrator]='Перемещение в другое подразделение' or [synonym_registrator]='Кадровый перевод' then 'Перемещение' 
            end AS VIDSOBYTIYA 
         ,[fizicheskoe_litso] AS [FIZICHESKOE_LITSO_GUID]
         ,kis.dolzhnost as [DOLZHNOST_GUID]
         ,kis.organizatsiya as [ORGANIZATSIYA_GUID]
         ,isnull(sp.ssylka,0x00000000000000000000000000000000) as [STRUKTURA_PREDPRIYATIYA_GUID]
         ,kis.[podrazdelenie] AS [PODRAZDELENIE_GUID]
         ,CAST(GETDATE() AS DATE) A_DATE
  FROM [L0].[dbo].[kadrovaya_istoriya_sotrudnikov]kis
  left join [L0].dbo.[shtatnoe_raspisanie] shr on kis.dolzhnost_po_shtatnomu_raspisaniyu=shr.ssylka
  left join [L0].dbo.[mesto_pozitsii_shtatnogo_raspisaniya_v_strukture_predpriyatiya] mes on shr.ssylka=mes.[pozitsiya]
  left join [L0].[dbo].[struktura_predpriyatiya] sp  on sp.ssylka=mes.[podrazdelenie]
order by [period],sp.ssylka