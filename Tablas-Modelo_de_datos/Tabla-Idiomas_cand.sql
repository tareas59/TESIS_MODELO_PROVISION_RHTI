USE [tesisrh]
GO

/****** Object:  Table [dbo].[Idiomas_cand]    Script Date: 6/26/2017 2:07:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Idiomas_cand](
	[Id_candidato] [char](10) NOT NULL,
	[Id_Idioma] [char](3) NOT NULL,
	[Id_valor_Idioma] [int] NOT NULL,
 CONSTRAINT [PK_Idiomas] PRIMARY KEY CLUSTERED 
(
	[Id_candidato] ASC,
	[Id_Idioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Idiomas_cand]  WITH CHECK ADD  CONSTRAINT [FK_Idiomas_Candidatos] FOREIGN KEY([Id_candidato])
REFERENCES [dbo].[Candidatos] ([Id_candidato])
GO

ALTER TABLE [dbo].[Idiomas_cand] CHECK CONSTRAINT [FK_Idiomas_Candidatos]
GO

ALTER TABLE [dbo].[Idiomas_cand]  WITH CHECK ADD  CONSTRAINT [FK_Idiomas_Codigos_idiomas] FOREIGN KEY([Id_Idioma])
REFERENCES [dbo].[Codigos_idiomas] ([Id_Idioma])
GO

ALTER TABLE [dbo].[Idiomas_cand] CHECK CONSTRAINT [FK_Idiomas_Codigos_idiomas]
GO

