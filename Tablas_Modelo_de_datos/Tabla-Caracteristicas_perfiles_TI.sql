USE [tesisrh]
GO

/****** Object:  Table [dbo].[Caracteristicas_perfiles_TI]    Script Date: 6/26/2017 1:52:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Caracteristicas_perfiles_TI](
	[Id_caracteristica_it] [int] NOT NULL,
	[Id_tipo_carac_it] [char](3) NOT NULL,
	[Tipo_valor] [char](1) NOT NULL,
	[Descrip_carac_it] [char](100) NOT NULL,
 CONSTRAINT [PK_Caracteristicas_perfiles_TI] PRIMARY KEY CLUSTERED 
(
	[Id_caracteristica_it] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Caracteristicas_perfiles_TI]  WITH CHECK ADD  CONSTRAINT [FK_Caracteristicas_perfiles_TI_Codigos_caracteristicas_TI] FOREIGN KEY([Id_tipo_carac_it])
REFERENCES [dbo].[Codigos_caracteristicas_TI] ([Id_tipo_carac_it])
GO

ALTER TABLE [dbo].[Caracteristicas_perfiles_TI] CHECK CONSTRAINT [FK_Caracteristicas_perfiles_TI_Codigos_caracteristicas_TI]
GO

