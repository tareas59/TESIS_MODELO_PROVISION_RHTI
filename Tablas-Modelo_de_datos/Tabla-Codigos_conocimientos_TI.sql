USE [tesisrh]
GO

/****** Object:  Table [dbo].[Codigos_conocimientos_TI]    Script Date: 6/26/2017 1:58:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Codigos_conocimientos_TI](
	[Id_conoc_it] [int] NOT NULL,
	[Id_tipo_conoc_it] [char](3) NOT NULL,
	[Descrip_conoc_it] [char](100) NOT NULL,
 CONSTRAINT [PK_Conocimientos_TI] PRIMARY KEY CLUSTERED 
(
	[Id_conoc_it] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Codigos_conocimientos_TI]  WITH CHECK ADD  CONSTRAINT [FK_Conocimientos_TI_Codigos_tipos_conoc_TI] FOREIGN KEY([Id_tipo_conoc_it])
REFERENCES [dbo].[Codigos_tipos_conoc_TI] ([Id_tipo_conoc_it])
GO

ALTER TABLE [dbo].[Codigos_conocimientos_TI] CHECK CONSTRAINT [FK_Conocimientos_TI_Codigos_tipos_conoc_TI]
GO

