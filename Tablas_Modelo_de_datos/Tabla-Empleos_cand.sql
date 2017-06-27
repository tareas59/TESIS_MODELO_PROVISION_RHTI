USE [tesisrh]
GO

/****** Object:  Table [dbo].[Empleos_cand]    Script Date: 6/26/2017 2:05:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Empleos_cand](
	[Id_candidato] [char](10) NOT NULL,
	[Id_tipo_empleo] [int] NOT NULL,
	[Antiguedad] [int] NOT NULL,
	[Anio_ini] [int] NOT NULL,
	[Anio_fin] [int] NOT NULL,
	[Sector] [char](3) NOT NULL,
	[Nombre_empresa] [char](100) NOT NULL,
	[Puesto] [char](50) NOT NULL,
	[Antig_ult_puesto] [int] NOT NULL,
	[Sueldo] [decimal](15, 2) NOT NULL,
 CONSTRAINT [PK_Empleos] PRIMARY KEY CLUSTERED 
(
	[Id_candidato] ASC,
	[Id_tipo_empleo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Empleos_cand]  WITH CHECK ADD  CONSTRAINT [FK_Empleos_Candidatos] FOREIGN KEY([Id_candidato])
REFERENCES [dbo].[Candidatos] ([Id_candidato])
GO

ALTER TABLE [dbo].[Empleos_cand] CHECK CONSTRAINT [FK_Empleos_Candidatos]
GO

ALTER TABLE [dbo].[Empleos_cand]  WITH CHECK ADD  CONSTRAINT [FK_Empleos_Codigos_empleo] FOREIGN KEY([Id_tipo_empleo])
REFERENCES [dbo].[Codigos_empleo] ([Id_tipo_empleo])
GO

ALTER TABLE [dbo].[Empleos_cand] CHECK CONSTRAINT [FK_Empleos_Codigos_empleo]
GO

