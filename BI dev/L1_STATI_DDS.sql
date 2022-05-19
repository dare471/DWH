SELECT
	'ERP' AS source_base,
	СтатьиДДС.ssylka AS [GUID],
	СтатьиДДС.kod AS [KOD],
	СтатьиДДС.naimenovanie AS [NAIMENOVANIE],
	ГруппыСтатейДДС3.naimenovanie AS [RODITEL_0],
	ГруппыСтатейДДС2.naimenovanie AS [RODITEL_1],
	ГруппыСтатейДДС1.naimenovanie AS [RODITEL_2],
	ГруппыСтатейДДС4.naimenovanie AS [RODITEL_3]
	--into [L1].dbo.[STATI_DDS]
FROM [L0].[DBO].[STATI_DVIZHENIYA_DENEZHNYKH_SREDSTV] AS СтатьиДДС
LEFT JOIN [L0].[DBO].[STATI_DVIZHENIYA_DENEZHNYKH_SREDSTV] AS ГруппыСтатейДДС1 ON СтатьиДДС.roditel= ГруппыСтатейДДС1.ssylka
LEFT JOIN [L0].[DBO].[STATI_DVIZHENIYA_DENEZHNYKH_SREDSTV] AS ГруппыСтатейДДС2 ON ГруппыСтатейДДС1.roditel = ГруппыСтатейДДС2.ssylka
LEFT JOIN [L0].[DBO].[STATI_DVIZHENIYA_DENEZHNYKH_SREDSTV] AS ГруппыСтатейДДС3 ON ГруппыСтатейДДС2.roditel = ГруппыСтатейДДС3.ssylka
LEFT JOIN [L0].[DBO].[STATI_DVIZHENIYA_DENEZHNYKH_SREDSTV] AS ГруппыСтатейДДС4 ON ГруппыСтатейДДС3.roditel = ГруппыСтатейДДС4.ssylka