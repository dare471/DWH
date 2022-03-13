SELECT  [proizvoditel]
      ,[1_prioritet]
      ,[2_prioritet]
      ,[3_prioritet]
      ,[4_prioritet]
      ,[5_prioritet]
      ,[6_prioritet]
      ,[7_prioritet]
  FROM [L0].[dbo].[matritsa_po_proizvoditelyam_zakup]

CREATE TABLE [L1].[DBO].[MATRITSA_PO_PROIZVODITELYAM_ZAKUP](
	[PROIZVODITEL] [NVARCHAR](50) NULL,
	[1_PRIORITET] [NVARCHAR](50) NULL,
	[2_PRIORITET] [NVARCHAR](50) NULL,
	[3_PRIORITET] [NVARCHAR](50) NULL,
	[4_PRIORITET] [NVARCHAR](50) NULL,
	[5_PRIORITET] [NVARCHAR](50) NULL,
	[6_PRIORITET] [NVARCHAR](50) NULL,
	[7_PRIORITET] [NVARCHAR](50) NULL
) ON [PRIMARY]
GO


