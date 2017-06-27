USE [tesisrh]
GO

/****** Object:  Table [dbo].[Puestos_TI_cand]    Script Date: 6/26/2017 2:10:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Puestos_TI_cand](
	[Id_candidato] [char](10) NOT NULL,
	[Id_puesto] [char](5) NOT NULL,
	[Ind_puesto_act] [char](1) NOT NULL,
	[Sueldo] [decimal](15, 2) NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Puestos_TI_cand]  WITH CHECK ADD  CONSTRAINT [FK_Puestos_TI_cand_Candidatos] FOREIGN KEY([Id_candidato])
REFERENCES [dbo].[Candidatos] ([Id_candidato])
GO

ALTER TABLE [dbo].[Puestos_TI_cand] CHECK CONSTRAINT [FK_Puestos_TI_cand_Candidatos]
GO

ALTER TABLE [dbo].[Puestos_TI_cand]  WITH CHECK ADD  CONSTRAINT [FK_Puestos_TI_cand_Codigos_puestos_TI] FOREIGN KEY([Id_puesto])
REFERENCES [dbo].[Codigos_puestos_TI] ([Id_puesto])
GO

ALTER TABLE [dbo].[Puestos_TI_cand] CHECK CONSTRAINT [FK_Puestos_TI_cand_Codigos_puestos_TI]
GO

