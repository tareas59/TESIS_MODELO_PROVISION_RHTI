USE [tesisrh]
GO

/****** Object:  Table [dbo].[Educacion_academica_cand]    Script Date: 6/26/2017 2:05:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Educacion_academica_cand](
	[Id_candidato] [char](10) NOT NULL,
	[Id_nivel] [int] NOT NULL,
	[Id_situacion] [int] NOT NULL,
	[Anio_sit] [int] NOT NULL,
	[Institucion] [char](100) NOT NULL,
	[Carrera] [char](100) NOT NULL,
	[Relacion_ti] [char](1) NOT NULL,
 CONSTRAINT [PK_Educacion_academica] PRIMARY KEY CLUSTERED 
(
	[Id_candidato] ASC,
	[Id_nivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Educacion_academica_cand]  WITH CHECK ADD  CONSTRAINT [FK_Educacion_academica_Candidatos] FOREIGN KEY([Id_candidato])
REFERENCES [dbo].[Candidatos] ([Id_candidato])
GO

ALTER TABLE [dbo].[Educacion_academica_cand] CHECK CONSTRAINT [FK_Educacion_academica_Candidatos]
GO

ALTER TABLE [dbo].[Educacion_academica_cand]  WITH CHECK ADD  CONSTRAINT [FK_Educacion_academica_Codigos_niveles_educ] FOREIGN KEY([Id_nivel])
REFERENCES [dbo].[Codigos_niveles_educ] ([Id_nivel])
GO

ALTER TABLE [dbo].[Educacion_academica_cand] CHECK CONSTRAINT [FK_Educacion_academica_Codigos_niveles_educ]
GO

ALTER TABLE [dbo].[Educacion_academica_cand]  WITH CHECK ADD  CONSTRAINT [FK_Educacion_academica_Codigos_situacion_acad] FOREIGN KEY([Id_situacion])
REFERENCES [dbo].[Codigos_situacion_acad] ([Id_situacion])
GO

ALTER TABLE [dbo].[Educacion_academica_cand] CHECK CONSTRAINT [FK_Educacion_academica_Codigos_situacion_acad]
GO

