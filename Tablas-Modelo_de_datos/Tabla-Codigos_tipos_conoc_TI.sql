USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_tipos_conoc_TI]    Script Date: 6/26/2017 2:04:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_tipos_conoc_TI](
	[Id_tipo_conoc_it] [char](3) NOT NULL,
	[Descrip_tipo_conoc_it] [char](100) NOT NULL,
 CONSTRAINT [PK_Codigos_tipo_conoc] PRIMARY KEY CLUSTERED 
(
	[Id_tipo_conoc_it] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

