USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_preferencia]    Script Date: 6/26/2017 2:02:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_preferencia](
	[Id_preferencia] [int] NOT NULL,
	[Descrip_preferencia] [char](100) NOT NULL,
 CONSTRAINT [PK_Codigos_preferencia] PRIMARY KEY CLUSTERED 
(
	[Id_preferencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

