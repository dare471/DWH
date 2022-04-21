/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT DATEADD(YEAR, - 2000, tn.[period]) AS PERIOD
      --,[synonym_registrator]
      --,[type_registrator]
      --,[registrator]
      --,[nomer_stroki]
      --,[aktivnost]
      ,[nomenklatura] as [NOMENKLATURA]
      --,[kharakteristika]
      --,[vid_tseny]
	  ,vt.naimenovanie [VID_TSENY]
      ,[tsena] as TSENA
      --,[upakovka]
      ,tn.VALYUTA as VALYUTA
      --,tn.[oblast_dannykh_osnovnye_dannye]
into [L1].[dbo].[TSENY_NOMENKLATURY]
  FROM [L0].[dbo].[tseny_nomenklatury]tn
  left join l0.dbo.vidy_tsen vt on tn.vid_tseny=vt.ssylka
  LEFT JOIN L1.DBO.NOMENKLATURA N ON TN.nomenklatura=N.GUID
