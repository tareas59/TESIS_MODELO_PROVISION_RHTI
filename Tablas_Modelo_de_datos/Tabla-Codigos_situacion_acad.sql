USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_situacion_acad]    Script Date: 6/26/2017 2:03:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_situacion_acad](
	[Id_situacion] [int] NOT NULL,
	[Descrip_situacion] [char](100) NOT NULL,
 CONSTRAINT [PK_Codigos_situacion_acad] PRIMARY KEY CLUSTERED 
(
	[Id_situacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

