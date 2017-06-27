USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_empleo]    Script Date: 6/26/2017 1:58:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_empleo](
	[Id_tipo_empleo] [int] NOT NULL,
	[Descrip_Tipo] [char](100) NOT NULL,
 CONSTRAINT [PK_Codigos_empleo] PRIMARY KEY CLUSTERED 
(
	[Id_tipo_empleo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

