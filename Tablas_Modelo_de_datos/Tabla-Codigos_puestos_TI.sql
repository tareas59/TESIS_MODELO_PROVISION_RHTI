USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_puestos_TI]    Script Date: 6/26/2017 2:03:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_puestos_TI](
	[Id_puesto] [char](5) NOT NULL,
	[Descrip_puesto] [char](100) NOT NULL,
 CONSTRAINT [PK_Puestos_TI] PRIMARY KEY CLUSTERED 
(
	[Id_puesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

