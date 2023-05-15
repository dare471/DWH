USE [L0_X]
GO


CREATE TABLE [dbo].[SUBSIDIES_FERTILIZER_2022](
	DateInserted  datetime DEFAULT CURRENT_TIMESTAMP,
	[ID] int IDENTITY(2,1),
	[REGION] [nvarchar](30) NULL,
	[APPLICANT] [nvarchar](250) NULL,
	[APPDATE] [nvarchar](30) NULL,
	[STATUS] [nvarchar](50) NULL,
	[USAGEAREA] [nvarchar](15) NULL,
	[PROVIDER] [nvarchar](300) NULL,
	[PRODUCT] [nvarchar](350) NULL,
	[UNIT] [nvarchar](10) NULL,
	[VOLUME] [nvarchar](20) NULL,
	[SUBSIDIES] [nvarchar](20) NULL,
	[APPTYPE] [nvarchar](340) NULL,
	[APPACCEPTANCEDATE] [nvarchar](30) NULL,
	[APPREJECTIONDATE] [nvarchar](30) NULL,
	[NOTEONNEGATIVERESOLUTION] [nvarchar](2000) NULL,
	[REJECTIONREASON] [nvarchar](1000) NULL,
	[IP_APPLICANT] [nvarchar](20) NULL,
	[IP_WITHDRAW] [nvarchar](20) NULL,
	[IP_OF_ACCEPTANCE] [nvarchar](20) NULL,
	[IP_OF_REJECTION ] [nvarchar](20) NULL
) ON [PRIMARY]
GO


