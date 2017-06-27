USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_idiomas]    Script Date: 6/26/2017 2:00:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_idiomas](
	[Id_Idioma] [char](3) NOT NULL,
	[Descrip_Idioma] [char](50) NOT NULL,
 CONSTRAINT [PK_Codigos_idiomas] PRIMARY KEY CLUSTERED 
(
	[Id_Idioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

