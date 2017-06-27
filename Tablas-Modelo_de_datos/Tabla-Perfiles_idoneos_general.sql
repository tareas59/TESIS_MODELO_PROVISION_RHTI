USE [tesisrh]
GO

/****** Object:  Table [dbo].[Perfiles_idoneos_general]    Script Date: 6/26/2017 2:09:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Perfiles_idoneos_general](
	[Id_perfil_idoneo] [int] NOT NULL,
	[Id_puesto] [char](5) NOT NULL,
	[Descrip_perfil_idoneo] [char](100) NOT NULL,
	[Fecha_alta] [date] NOT NULL,
	[Fecha_vigencia] [date] NOT NULL,
	[Estatus_perfil] [char](1) NOT NULL,
 CONSTRAINT [PK_Perfiles_idoneos_general] PRIMARY KEY CLUSTERED 
(
	[Id_perfil_idoneo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Perfiles_idoneos_general]  WITH CHECK ADD  CONSTRAINT [FK_Perfiles_idoneos_general_Codigos_puestos_TI] FOREIGN KEY([Id_puesto])
REFERENCES [dbo].[Codigos_puestos_TI] ([Id_puesto])
GO

ALTER TABLE [dbo].[Perfiles_idoneos_general] CHECK CONSTRAINT [FK_Perfiles_idoneos_general_Codigos_puestos_TI]
GO

