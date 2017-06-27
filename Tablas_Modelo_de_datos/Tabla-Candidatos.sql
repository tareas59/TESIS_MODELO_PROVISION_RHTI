USE [tesisrh]
GO

/****** Object:  Table [dbo].[Candidatos]    Script Date: 6/26/2017 1:51:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Candidatos](
	[Id_candidato] [char](10) NOT NULL,
	[Nombre] [char](50) NOT NULL,
	[Sexo] [char](1) NOT NULL,
	[Edad] [int] NOT NULL,
	[Estado_civil] [char](1) NOT NULL,
	[Fecha_encuesta] [datetime] NOT NULL,
 CONSTRAINT [PK_Candidatos] PRIMARY KEY CLUSTERED 
(
	[Id_candidato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

