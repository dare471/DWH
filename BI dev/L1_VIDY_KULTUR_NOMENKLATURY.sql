
SELECT VKN.[ssylka] AS GUID
      ,VKN.[roditel] AS [RODITEL_GUID]
      ,VKN.[kod] AS KOD
      ,VKN.[naimenovanie] AS [NAIMENOVANIE]
	  ,VKN2.naimenovanie AS[NAIMENOVANIE_RODITEL]
--INTO [L1].[dbo].[VIDY_KULTUR_NOMENKLATURY] 
  FROM [L0].[dbo].[vidy_kultur_nomenklatury] VKN
  LEFT JOIN [L0].[dbo].[vidy_kultur_nomenklatury] VKN2
	ON VKN.roditel=VKN2.ssylka

	WHERE  VKN.[pometka_udaleniya]=0x00