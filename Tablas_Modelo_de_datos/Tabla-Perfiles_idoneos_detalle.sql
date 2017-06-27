USE [tesisrh]
GO

/****** Object:  Table [dbo].[Perfiles_idoneos_detalle]    Script Date: 6/26/2017 2:08:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Perfiles_idoneos_detalle](
	[Id_perfil_idoneo] [int] NOT NULL,
	[Id_tipo_carac_perfil] [char](3) NOT NULL,
	[Id_carac_perfil] [int] NOT NULL,
	[Ind_carac] [char](1) NOT NULL,
	[Tipo_valor] [char](1) NOT NULL,
	[Valor_rango_ini] [int] NOT NULL,
	[Valor_rango_fin] [int] NOT NULL,
	[Valor_variable] [char](50) NOT NULL,
	[Valor_binario_perfil] [int] NOT NULL,
 CONSTRAINT [PK_Perfiles_idoneos_detalle] PRIMARY KEY CLUSTERED 
(
	[Id_perfil_idoneo] ASC,
	[Id_carac_perfil] ASC,
	[Id_tipo_carac_perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Perfiles_idoneos_detalle]  WITH CHECK ADD  CONSTRAINT [FK_Perfiles_idoneos_detalle_Perfiles_idoneos_general] FOREIGN KEY([Id_perfil_idoneo])
REFERENCES [dbo].[Perfiles_idoneos_general] ([Id_perfil_idoneo])
GO

ALTER TABLE [dbo].[Perfiles_idoneos_detalle] CHECK CONSTRAINT [FK_Perfiles_idoneos_detalle_Perfiles_idoneos_general]
GO

