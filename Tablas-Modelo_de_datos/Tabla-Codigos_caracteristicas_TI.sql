USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_caracteristicas_TI]    Script Date: 6/26/2017 1:53:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_caracteristicas_TI](
	[Id_tipo_carac_it] [char](3) NOT NULL,
	[Descrip_tipo_carac_it] [char](100) NOT NULL,
 CONSTRAINT [PK_Codigos_caracteristicas_TI] PRIMARY KEY CLUSTERED 
(
	[Id_tipo_carac_it] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

