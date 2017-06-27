USE [tesisrh]
GO

/****** Object:  Table [dbo].[Preferencias_cand]    Script Date: 6/26/2017 2:09:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Preferencias_cand](
	[Id_candidato] [char](10) NOT NULL,
	[Id_preferencia] [int] NOT NULL,
	[Id_estado_pref] [int] NOT NULL,
	[valor_estado_pref] [int] NOT NULL,
 CONSTRAINT [PK_Preferencias] PRIMARY KEY CLUSTERED 
(
	[Id_candidato] ASC,
	[Id_preferencia] ASC,
	[Id_estado_pref] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Preferencias_cand]  WITH CHECK ADD  CONSTRAINT [FK_Preferencias_Candidatos] FOREIGN KEY([Id_candidato])
REFERENCES [dbo].[Candidatos] ([Id_candidato])
GO

ALTER TABLE [dbo].[Preferencias_cand] CHECK CONSTRAINT [FK_Preferencias_Candidatos]
GO

ALTER TABLE [dbo].[Preferencias_cand]  WITH CHECK ADD  CONSTRAINT [FK_Preferencias_Codigos_estados_pref] FOREIGN KEY([Id_preferencia], [Id_estado_pref])
REFERENCES [dbo].[Codigos_estados_pref] ([Id_preferencia], [Id_estado_pref])
GO

ALTER TABLE [dbo].[Preferencias_cand] CHECK CONSTRAINT [FK_Preferencias_Codigos_estados_pref]
GO

