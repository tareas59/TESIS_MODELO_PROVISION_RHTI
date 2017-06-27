USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_perfiles_TI]    Script Date: 6/26/2017 2:02:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_perfiles_TI](
	[Id_puesto] [char](5) NOT NULL,
	[Id_conoc_it] [int] NOT NULL,
 CONSTRAINT [PK_Perfiles_puestos_TI] PRIMARY KEY CLUSTERED 
(
	[Id_puesto] ASC,
	[Id_conoc_it] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Codigos_perfiles_TI]  WITH CHECK ADD  CONSTRAINT [FK_Perfiles_puestos_TI_Conocimientos_TI] FOREIGN KEY([Id_conoc_it])
REFERENCES [dbo].[Codigos_conocimientos_TI] ([Id_conoc_it])
GO

ALTER TABLE [dbo].[Codigos_perfiles_TI] CHECK CONSTRAINT [FK_Perfiles_puestos_TI_Conocimientos_TI]
GO

ALTER TABLE [dbo].[Codigos_perfiles_TI]  WITH CHECK ADD  CONSTRAINT [FK_Perfiles_puestos_TI_Puestos_TI] FOREIGN KEY([Id_puesto])
REFERENCES [dbo].[Codigos_puestos_TI] ([Id_puesto])
GO

ALTER TABLE [dbo].[Codigos_perfiles_TI] CHECK CONSTRAINT [FK_Perfiles_puestos_TI_Puestos_TI]
GO

