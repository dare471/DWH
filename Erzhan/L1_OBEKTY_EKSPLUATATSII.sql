SELECT distinct oe.[ssylka] AS [guid]
	,oe.NAIMENOVANIE
      ,oe2.naimenovanie as [RODITEL]
	  ,oe.NAIMENOVANIE_POLNOE
	  ,oe.INVENTARNYY_NOMER
	  ,oe.GOS_NOMER
	  ,oe.id__wialon as ID_WIALON
	  ,oe.name__wialon as NAME_WIALON
	  --into [L1].[dbo].[OBEKTY_EKSPLUATATSII]
  FROM [L0].[dbo].[OBEKTY_EKSPLUATATSII] oe
  left join [L0].[dbo].[obekty_ekspluatatsii]  oe2 on oe.roditel=oe2.ssylka
  --where oe.[pometka_udaleniya]=0x00