

CREATE TABLE [CRM_DWH].[dbo].[2_SEMENA_TEST](
	[nomenklatura_guid] [binary](16) NULL,
	[direksiya] [binary](16) NULL,
	[Компании] [nvarchar](150) NULL,
	[Культура] [nvarchar](50) NULL,
	[Регион] [nvarchar](50) NULL,
	[Название продукта] [nvarchar](100) NULL,
	[Технология] [nvarchar](25) NULL,
	[Подтверждение] [int] NOT NULL,
	[Продано] [numeric](38, 3) NULL,
	[Отгружено] [numeric](38, 3) NULL,
	[Не отгружено] [numeric](38, 3) NULL,
	[Стоки 2021] [numeric](38, 6) NULL,
	[Поступление] [numeric](38, 6) NULL
) ON [PRIMARY]
GO


DECLARE @maxPrice MONEY, 
    @minPrice MONEY, 
    @dif MONEY, 
    @count INT
 
SET @count = (SELECT SUM(ProductCount) FROM Orders);
 
SELECT @minPrice=MIN(Price), @maxPrice = MAX(Price) FROM Products
 
SET @dif = @maxPrice - @minPrice;
 
