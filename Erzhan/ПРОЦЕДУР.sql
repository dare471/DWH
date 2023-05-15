

CREATE TABLE [CRM_DWH].[dbo].[2_SEMENA_TEST](
	[nomenklatura_guid] [binary](16) NULL,
	[direksiya] [binary](16) NULL,
	[��������] [nvarchar](150) NULL,
	[��������] [nvarchar](50) NULL,
	[������] [nvarchar](50) NULL,
	[�������� ��������] [nvarchar](100) NULL,
	[����������] [nvarchar](25) NULL,
	[�������������] [int] NOT NULL,
	[�������] [numeric](38, 3) NULL,
	[���������] [numeric](38, 3) NULL,
	[�� ���������] [numeric](38, 3) NULL,
	[����� 2021] [numeric](38, 6) NULL,
	[�����������] [numeric](38, 6) NULL
) ON [PRIMARY]
GO


DECLARE @maxPrice MONEY, 
    @minPrice MONEY, 
    @dif MONEY, 
    @count INT
 
SET @count = (SELECT SUM(ProductCount) FROM Orders);
 
SELECT @minPrice=MIN(Price), @maxPrice = MAX(Price) FROM Products
 
SET @dif = @maxPrice - @minPrice;
 
