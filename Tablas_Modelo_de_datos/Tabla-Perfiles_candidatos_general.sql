USE [tesisrh]
GO

/****** Object:  Table [dbo].[Perfiles_candidatos_general]    Script Date: 6/26/2017 2:08:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Perfiles_candidatos_general](
	[Id_candidato] [char](10) NOT NULL,
	[Id_perfil_idoneo] [int] NOT NULL,
	[Distancia_hamming] [numeric](4, 2) NOT NULL,
	[Distancia_euclidiana] [numeric](4, 2) NOT NULL,
	[Distancia_russelrao] [numeric](4, 2) NOT NULL,
	[Distancia_jaccard] [numeric](4, 2) NOT NULL,
	[Fecha_alta] [date] NOT NULL,
	[Fecha_vigencia] [date] NOT NULL,
	[Estatus_perfil] [char](1) NOT NULL,
 CONSTRAINT [PK_Perfiles_candidatos_general] PRIMARY KEY CLUSTERED 
(
	[Id_candidato] ASC,
	[Id_perfil_idoneo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Perfiles_candidatos_general]  WITH CHECK ADD  CONSTRAINT [FK_Perfiles_candidatos_general_Perfiles_idoneos_general] FOREIGN KEY([Id_perfil_idoneo])
REFERENCES [dbo].[Perfiles_idoneos_general] ([Id_perfil_idoneo])
GO

ALTER TABLE [dbo].[Perfiles_candidatos_general] CHECK CONSTRAINT [FK_Perfiles_candidatos_general_Perfiles_idoneos_general]
GO

