USE [tesisrh]
GO

/****** Object:  Table [dbo].[Perfiles_candidatos_detalle]    Script Date: 6/26/2017 2:08:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Perfiles_candidatos_detalle](
	[Id_candidato] [char](10) NOT NULL,
	[Id_perfil_idoneo] [int] NOT NULL,
	[Id_tipo_carac_perfil] [char](3) NOT NULL,
	[Id_carac_perfil] [int] NOT NULL,
	[Ind_carac] [char](1) NOT NULL,
	[Tipo_valor] [char](1) NOT NULL,
	[Valor_num] [int] NOT NULL,
	[Valor_text] [char](50) NOT NULL,
	[Valor_binario_perfil] [int] NOT NULL,
 CONSTRAINT [PK_Perfiles_candidatos_detalle] PRIMARY KEY CLUSTERED 
(
	[Id_candidato] ASC,
	[Id_perfil_idoneo] ASC,
	[Id_tipo_carac_perfil] ASC,
	[Id_carac_perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Perfiles_candidatos_detalle]  WITH CHECK ADD  CONSTRAINT [FK_Perfiles_candidatos_detalle_Perfiles_candidatos_general] FOREIGN KEY([Id_candidato], [Id_perfil_idoneo])
REFERENCES [dbo].[Perfiles_candidatos_general] ([Id_candidato], [Id_perfil_idoneo])
GO

ALTER TABLE [dbo].[Perfiles_candidatos_detalle] CHECK CONSTRAINT [FK_Perfiles_candidatos_detalle_Perfiles_candidatos_general]
GO

