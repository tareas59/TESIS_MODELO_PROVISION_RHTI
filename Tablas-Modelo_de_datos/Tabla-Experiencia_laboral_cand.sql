USE [tesisrh]
GO

/****** Object:  Table [dbo].[Experiencia_laboral_cand]    Script Date: 6/26/2017 2:07:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Experiencia_laboral_cand](
	[Id_candidato] [char](10) NOT NULL,
	[Exper_laboral] [int] NOT NULL,
	[Total_empleos] [int] NOT NULL,
	[Antig_max_empleo] [int] NOT NULL,
	[Antig_min_empleo] [int] NOT NULL,
	[Tiempo_max_inac] [int] NOT NULL,
 CONSTRAINT [PK_Experiencia_laboral] PRIMARY KEY CLUSTERED 
(
	[Id_candidato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Experiencia_laboral_cand]  WITH CHECK ADD  CONSTRAINT [FK_Experiencia_laboral_Candidatos] FOREIGN KEY([Id_candidato])
REFERENCES [dbo].[Candidatos] ([Id_candidato])
GO

ALTER TABLE [dbo].[Experiencia_laboral_cand] CHECK CONSTRAINT [FK_Experiencia_laboral_Candidatos]
GO

