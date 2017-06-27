USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_niveles_educ]    Script Date: 6/26/2017 2:01:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_niveles_educ](
	[Id_nivel] [int] NOT NULL,
	[Descrip_nivel] [char](100) NOT NULL,
 CONSTRAINT [PK_Codigos_niveles_educ] PRIMARY KEY CLUSTERED 
(
	[Id_nivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

