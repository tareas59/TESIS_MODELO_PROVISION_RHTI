USE [tesisrh]
GO

/****** Object:  Table [dbo].[Conocimientos_cand]    Script Date: 6/26/2017 2:04:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Conocimientos_cand](
	[Id_candidato] [char](10) NOT NULL,
	[Id_puesto] [char](5) NOT NULL,
	[Id_conoc_it] [int] NOT NULL,
	[Anios_conoc] [int] NOT NULL,
	[Ind_certificacion] [char](1) NOT NULL,
 CONSTRAINT [PK_Conocimientos] PRIMARY KEY CLUSTERED 
(
	[Id_candidato] ASC,
	[Id_puesto] ASC,
	[Id_conoc_it] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Conocimientos_cand]  WITH CHECK ADD  CONSTRAINT [FK_Conocimientos_Candidatos] FOREIGN KEY([Id_candidato])
REFERENCES [dbo].[Candidatos] ([Id_candidato])
GO

ALTER TABLE [dbo].[Conocimientos_cand] CHECK CONSTRAINT [FK_Conocimientos_Candidatos]
GO

ALTER TABLE [dbo].[Conocimientos_cand]  WITH CHECK ADD  CONSTRAINT [FK_Conocimientos_Perfiles_puestos_TI] FOREIGN KEY([Id_puesto], [Id_conoc_it])
REFERENCES [dbo].[Codigos_perfiles_TI] ([Id_puesto], [Id_conoc_it])
GO

ALTER TABLE [dbo].[Conocimientos_cand] CHECK CONSTRAINT [FK_Conocimientos_Perfiles_puestos_TI]
GO

