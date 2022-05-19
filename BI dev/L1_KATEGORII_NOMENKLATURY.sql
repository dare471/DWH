/******Che tam?  ******/
SELECT
	KATEGORII_NOMENKLATURY.ssylka AS GUID,
	KATEGORII_NOMENKLATURY.kod AS CODE,
	KATEGORII_NOMENKLATURY.naimenovanie AS NAIMENOVANIE,
	КатегорииНоменклатуры1.naimenovanie AS PARENT_0,
	КатегорииНоменклатуры2.naimenovanie AS PARENT_1,
	КатегорииНоменклатуры3.naimenovanie AS PARENT_2,
	КатегорииНоменклатуры4.naimenovanie AS PARENT_3
	--into L1.dbo.KATEGORII_NOMENKLATURY 
FROM L0.dbo.kategorii_nomenklatury AS KATEGORII_NOMENKLATURY
LEFT JOIN L0.dbo.kategorii_nomenklatury AS КатегорииНоменклатуры1 
	ON KATEGORII_NOMENKLATURY.roditel = КатегорииНоменклатуры1.ssylka

LEFT JOIN L0.dbo.kategorii_nomenklatury AS КатегорииНоменклатуры2 
	ON КатегорииНоменклатуры1.roditel = КатегорииНоменклатуры2.ssylka
LEFT JOIN L0.dbo.kategorii_nomenklatury AS КатегорииНоменклатуры3 
	ON КатегорииНоменклатуры2.roditel= КатегорииНоменклатуры3.ssylka
LEFT JOIN L0.dbo.kategorii_nomenklatury AS КатегорииНоменклатуры4 
	ON КатегорииНоменклатуры3.roditel= КатегорииНоменклатуры4.ssylka